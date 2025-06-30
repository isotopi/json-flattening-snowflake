CREATE OR REPLACE PROCEDURE flatten_json_proc("TABLE_NAME" VARCHAR)
RETURNS TABLE ("QUERY" VARCHAR)
LANGUAGE SQL
EXECUTE AS OWNER
AS 
DECLARE
                                                                     
    query varchar;
    res resultset;

BEGIN

query := '
WITH json_data AS (
    SELECT DISTINCT
        f.key AS column_name, -- The name of the JSON key (column)
        f.path, -- Full path to the key in the JSON document
        REPLACE(SPLIT(f.path, ''].'')[ARRAY_SIZE(SPLIT(f.path, ''].'')) - 1]::STRING, ''.'', '':'') AS relative_path,
        CASE
            WHEN TYPEOF(f.value) = ''NULL_VALUE'' THEN ''VARCHAR''
            WHEN TYPEOF(f.value) = ''INTEGER'' THEN ''INTEGER''
            WHEN TYPEOF(f.value) = ''DECIMAL'' THEN ''FLOAT''
            WHEN TRY_TO_TIMESTAMP(f.value::VARCHAR) IS NOT NULL THEN ''DATETIME''
            WHEN TRY_TO_DATE(f.value::VARCHAR) IS NOT NULL THEN ''DATE''
            ELSE TYPEOF(f.value)
        END AS column_type, -- Infers SQL data type based on the JSON value
        REGEXP_COUNT(f.path, ''\\\\.'') + 1 AS level, -- Indicates how deeply nested the field is (dot-separated hierarchy count)
        REGEXP_REPLACE(SPLIT(f.path, ''.'')[ARRAY_SIZE(SPLIT(f.path, ''.'')) - 2], ''\\\\[\\\\d+\\\\]'', '''') AS parent, -- parent of the current field
        REGEXP_REPLACE(SPLIT(f.path, ''.'')[ARRAY_SIZE(SPLIT(f.path, ''.'')) - 3], ''\\\\[\\\\d+\\\\]'', '''') AS grandpa, -- grandpa of the current field
        SPLIT_PART(REGEXP_REPLACE(SPLIT(path, ''['')[ARRAY_SIZE(SPLIT(path, ''['')) - 2], ''.*\\\\].'', ''''), ''.'', -1) AS last_flatten_field, -- last flattened field for the current field
        REPLACE(REGEXP_REPLACE(SPLIT(path, ''['')[ARRAY_SIZE(SPLIT(path, ''['')) - 2], ''.*\\\\].'', ''''), ''.'', '':'') AS parent_flatten_path, -- path for the parent of the last flattened field
        REPLACE(REGEXP_REPLACE(SPLIT(path, ''['')[ARRAY_SIZE(SPLIT(path, ''['')) - 3], ''.*\\\\].'', ''''), ''.'', '':'') AS grandpa_flatten_path, -- path for the grandpa of the last flattened field
        REGEXP_COUNT(f.path, ''\\\\['') AS level_flatten, -- level of flattens for the current field
    FROM '||:TABLE_NAME||',
    LATERAL FLATTEN(INPUT => json, RECURSIVE => TRUE, OUTER => TRUE) f -- flatten the column named json (contains the json data)
    WHERE column_type != ''OBJECT'' AND column_name IS NOT NULL // exlude object parent-level types
)

, ranked_types AS (
    SELECT
        column_name,
        path,
        relative_path,
        column_type,
        level,
        parent,
        grandpa,
        last_flatten_field,
        parent_flatten_path,
        grandpa_flatten_path,
        level_flatten
    FROM json_data
    QUALIFY ROW_NUMBER() OVER (
            PARTITION BY column_name, level, parent
            ORDER BY 
                CASE column_type     
                    WHEN ''VARCHAR'' THEN 1
                    WHEN ''DATETIME'' THEN 2
                    WHEN ''DATE'' THEN 3
                    WHEN ''FLOAT'' THEN 4
                    WHEN ''INTEGER'' THEN 5
                    WHEN ''ARRAY'' THEN 6
                    ELSE 7
                END -- Custom priority for data types
        ) = 1 -- Select only the highest-priority type per group
)

, columns_definition AS (
    SELECT DISTINCT
        level,
        -- Construct SELECT clause lines depending on whether flattening is needed
        CASE
            WHEN level_flatten = 0 THEN -- If the field isn''t in an array structure
                LISTAGG( DISTINCT
                    ''\tJSON:''||relative_path||''::''||column_type||'' AS ''||
                                                            CASE 
                                                                WHEN grandpa IS NOT NULL THEN grandpa||''_''||parent
                                                                ELSE parent
                                                            END ||''_''||column_name||'',\n''
                ) OVER (PARTITION BY level, parent)
            ELSE -- If the field comes from a flattened array (requires aliasing from LATERAL FLATTEN)
                LISTAGG( DISTINCT
                    ''\tflatten_''||REPLACE(parent_flatten_path, '':'', ''_'')||''.value:''||relative_path||''::''||column_type||'' AS ''||
                                                                                                                        CASE
                                                                                                                            WHEN grandpa IS NOT NULL THEN grandpa||''_''||parent
                                                                                                                            ELSE parent
                                                                                                                        END ||''_''||column_name||'',\n''
                ) OVER (PARTITION BY level, parent)
        END AS column_definition,
    FROM ranked_types r1
    -- Avoid including object type arrays. ([1, 2, 3] -> OK. [{1:1, 2:2}, {3:3}] -> KO; this last one will be flattened and the field mapped will one of the ones inside the array)
    WHERE column_type != ''ARRAY'' OR NOT EXISTS (
                                            SELECT 1
                                            FROM ranked_types r2
                                            WHERE r1.column_name = r2.last_flatten_field
                                        )
    ORDER BY level
)

, flatten_levels AS (
    SELECT DISTINCT
        level_flatten,
        -- Dynamically generate the FLATTEN clauses
        CASE
            WHEN level_flatten = 1 THEN -- no flatten before, path from root.
                LISTAGG( DISTINCT
                    ''\t,LATERAL FLATTEN(INPUT => json:''||parent_flatten_path||'', OUTER => TRUE) AS flatten_''||REPLACE(parent_flatten_path, '':'', ''_'')||''\n''
                ) OVER (PARTITION BY level_flatten, parent, grandpa)
            WHEN level_flatten > 1 THEN
                LISTAGG( DISTINCT
                    ''\t,LATERAL FLATTEN(INPUT => flatten_''||REPLACE(grandpa_flatten_path, '':'', ''_'')||''.value:''||parent_flatten_path||'', OUTER => TRUE) AS flatten_''||REPLACE(parent_flatten_path, '':'', ''_'')||''\n''
                ) OVER (PARTITION BY level_flatten, parent, grandpa)
        END AS flatten_definition
    FROM ranked_types r1
    -- Avoid including object type arrays. ([1, 2, 3] -> OK. [{1:1, 2:2}, {3:3}] -> KO; this last one will be flattened and the field mapped will one of the ones inside the array) -- revisar
    WHERE column_type != ''ARRAY'' OR NOT EXISTS (
                                            SELECT 1
                                            FROM ranked_types r2
                                            WHERE r1.column_name = r2.last_flatten_field
                                        )
    ORDER BY level_flatten
)

, ordered_columns_definition AS (
    SELECT
        -- Concatenates all column definitions into a single string,
        -- organized and labeled by nesting level
        LISTAGG(column_definition) AS column_definition
    FROM (
        SELECT DISTINCT
            level as level,
            -- Adds a header comment for each level and aggregates columns within that level
            LISTAGG( DISTINCT
                ''\t------- LEVEL ''||level||'' -------\n''
                ||column_definition
            ) column_definition,
        FROM columns_definition
        GROUP BY level
        ORDER BY level -- Ensures consistent top-down structure
    )
)
, ordered_flatten_definition AS (
    SELECT
        -- Combine all generated FLATTEN clauses into one formatted string
        LISTAGG(flatten_definition) AS flatten_definition
    FROM (
        SELECT DISTINCT
            level_flatten,
            -- Add a comment header per nesting level
            LISTAGG( DISTINCT
                ''\t------- LEVEL ''||level_flatten||'' -------\n''
                ||flatten_definition
            ) AS flatten_definition,
        FROM flatten_levels
        GROUP BY level_flatten
        ORDER BY level_flatten -- Ensures flattening happens from shallow to deep
        )
)
SELECT
    -- Concatenate the final query components into one big SQL string
    ''SELECT\n''||
        column_definition|| -- Dynamically built SELECT clause
    ''FROM '||:TABLE_NAME||'\n''||
        flatten_definition  -- Dynamically built FLATTEN clauses
    AS QUERY,
FROM ordered_columns_definition, ordered_flatten_definition


'
;

res := (execute immediate :query); 

return TABLE(res);

END;