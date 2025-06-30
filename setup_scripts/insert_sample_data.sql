-- Replace the following line with your sample JSON data.
-- For example: SELECT PARSE_JSON('{"key": "value"}') AS JSON

INSERT INTO DEMO_TABLE (JSON)
SELECT PARSE_JSON('
// Your JSON data Here
') AS JSON
;