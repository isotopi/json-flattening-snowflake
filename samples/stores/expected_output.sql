SELECT
	------- LEVEL 3 -------
	json:store:details:name::VARCHAR AS store_details_name,
	------- LEVEL 4 -------
	flatten_store_inventory_products.value:relatedProducts::ARRAY AS inventory_products_relatedProducts,
	flatten_store_inventory_products.value:id::INTEGER AS inventory_products_id,
	------- LEVEL 4 -------
	json:store:contact:info:phone::VARCHAR AS contact_info_phone,
	json:store:contact:info:email::VARCHAR AS contact_info_email,
	------- LEVEL 4 -------
	flatten_store_events_list.value:description::VARCHAR AS events_list_description,
	flatten_store_events_list.value:eventId::INTEGER AS events_list_eventId,
	flatten_store_events_list.value:location::VARCHAR AS events_list_location,
	flatten_store_events_list.value:name::VARCHAR AS events_list_name,
	flatten_store_events_list.value:date::DATETIME AS events_list_date,
	------- LEVEL 5 -------
	flatten_store_inventory_products.value:details:category::VARCHAR AS products_details_category,
	flatten_store_inventory_products.value:details:price::FLOAT AS products_details_price,
	flatten_store_inventory_products.value:details:name::VARCHAR AS products_details_name,
	------- LEVEL 5 -------
	json:store:details:location:address:city::VARCHAR AS location_address_city,
	json:store:details:location:address:country::VARCHAR AS location_address_country,
	json:store:details:location:address:state::VARCHAR AS location_address_state,
	json:store:details:location:address:street::VARCHAR AS location_address_street,
	json:store:details:location:address:zipCode::DATETIME AS location_address_zipCode,
	json:store:details:location:address:suite::VARCHAR AS location_address_suite,
	------- LEVEL 5 -------
	json:store:details:location:coordinates:latitude::FLOAT AS location_coordinates_latitude,
	json:store:details:location:coordinates:longitude::FLOAT AS location_coordinates_longitude,
	------- LEVEL 6 -------
	flatten_store_inventory_products.value:details:stock:quantity::INTEGER AS details_stock_quantity,
	------- LEVEL 6 -------
	json:store:contact:socialMedia:platforms:instagram:followers::INTEGER AS platforms_instagram_followers,
	json:store:contact:socialMedia:platforms:instagram:url::VARCHAR AS platforms_instagram_url,
	------- LEVEL 6 -------
	json:store:contact:socialMedia:platforms:facebook:followers::INTEGER AS platforms_facebook_followers,
	json:store:contact:socialMedia:platforms:facebook:url::VARCHAR AS platforms_facebook_url,
	------- LEVEL 6 -------
	json:store:details:location:coordinates:geoDetails:elevation::INTEGER AS coordinates_geoDetails_elevation,
	json:store:details:location:coordinates:geoDetails:utcOffset::VARCHAR AS coordinates_geoDetails_utcOffset,
	json:store:details:location:coordinates:geoDetails:timezone::VARCHAR AS coordinates_geoDetails_timezone,
	------- LEVEL 6 -------
	json:store:contact:socialMedia:platforms:youtube:channel::VARCHAR AS platforms_youtube_channel,
	json:store:contact:socialMedia:platforms:youtube:subscribers::INTEGER AS platforms_youtube_subscribers,
	------- LEVEL 6 -------
	json:store:contact:socialMedia:platforms:twitter:followers::INTEGER AS platforms_twitter_followers,
	json:store:contact:socialMedia:platforms:twitter:handle::VARCHAR AS platforms_twitter_handle,
	------- LEVEL 6 -------
	flatten_store_inventory_products.value:details:specifications:brand::VARCHAR AS details_specifications_brand,
	flatten_store_inventory_products.value:details:specifications:features::ARRAY AS details_specifications_features,
	------- LEVEL 6 -------
	flatten_store_inventory_products.value:details:ratings:average::FLOAT AS details_ratings_average,
	------- LEVEL 6 -------
	flatten_discounts_list.value:endDate::DATETIME AS discounts_list_endDate,
	flatten_discounts_list.value:startDate::DATETIME AS discounts_list_startDate,
	flatten_discounts_list.value:type::VARCHAR AS discounts_list_type,
	flatten_discounts_list.value:value::INTEGER AS discounts_list_value,
	------- LEVEL 7 -------
	json:store:contact:socialMedia:platforms:instagram:engagement:comments::INTEGER AS instagram_engagement_comments,
	json:store:contact:socialMedia:platforms:instagram:engagement:likes::INTEGER AS instagram_engagement_likes,
	json:store:contact:socialMedia:platforms:twitter:engagement:replies::INTEGER AS twitter_engagement_replies,
	json:store:contact:socialMedia:platforms:twitter:engagement:retweets::INTEGER AS twitter_engagement_retweets,
	json:store:contact:socialMedia:platforms:facebook:engagement:shares::INTEGER AS facebook_engagement_shares,
	------- LEVEL 7 -------
	flatten_store_inventory_products.value:details:specifications:dimensions:weight::VARCHAR AS specifications_dimensions_weight,
	------- LEVEL 7 -------
	flatten_store_inventory_products.value:details:specifications:warranty:period::VARCHAR AS specifications_warranty_period,
	flatten_store_inventory_products.value:details:specifications:warranty:type::VARCHAR AS specifications_warranty_type,
	------- LEVEL 7 -------
	flatten_store_inventory_products.value:details:specifications:battery:capacity::VARCHAR AS specifications_battery_capacity,
	flatten_store_inventory_products.value:details:specifications:battery:chargingTime::VARCHAR AS specifications_battery_chargingTime,
	flatten_store_inventory_products.value:details:specifications:battery:type::VARCHAR AS specifications_battery_type,
	------- LEVEL 7 -------
	flatten_store_inventory_products.value:details:ratings:reviews:total::INTEGER AS ratings_reviews_total,
	------- LEVEL 7 -------
	flatten_store_inventory_products.value:details:stock:warehouse:lastRestocked::DATETIME AS stock_warehouse_lastRestocked,
	flatten_store_inventory_products.value:details:stock:warehouse:location::VARCHAR AS stock_warehouse_location,
	------- LEVEL 8 -------
	json:store:details:location:coordinates:geoDetails:climate:averageTemperature:summer::INTEGER AS climate_averageTemperature_summer,
	json:store:details:location:coordinates:geoDetails:climate:averageTemperature:winter::INTEGER AS climate_averageTemperature_winter,
	------- LEVEL 8 -------
	flatten_store_inventory_products.value:details:specifications:warranty:conditions:coverage::VARCHAR AS warranty_conditions_coverage,
	flatten_store_inventory_products.value:details:specifications:warranty:conditions:exceptions::ARRAY AS warranty_conditions_exceptions,
	------- LEVEL 8 -------
	flatten_store_inventory_products.value:details:ratings:reviews:detailed:stars2::INTEGER AS reviews_detailed_stars2,
	flatten_store_inventory_products.value:details:ratings:reviews:detailed:stars5::INTEGER AS reviews_detailed_stars5,
	flatten_store_inventory_products.value:details:ratings:reviews:detailed:star1::INTEGER AS reviews_detailed_star1,
	flatten_store_inventory_products.value:details:ratings:reviews:detailed:stars4::INTEGER AS reviews_detailed_stars4,
	flatten_store_inventory_products.value:details:ratings:reviews:detailed:stars3::INTEGER AS reviews_detailed_stars3,
	------- LEVEL 8 -------
	flatten_store_inventory_products.value:details:stock:warehouse:manager:name::VARCHAR AS warehouse_manager_name,
	------- LEVEL 8 -------
	flatten_store_contact_socialMedia_platforms_youtube_videos_list.value:comments::INTEGER AS videos_list_comments,
	flatten_store_contact_socialMedia_platforms_youtube_videos_list.value:likes::INTEGER AS videos_list_likes,
	flatten_store_contact_socialMedia_platforms_youtube_videos_list.value:views::INTEGER AS videos_list_views,
	flatten_store_contact_socialMedia_platforms_youtube_videos_list.value:title::VARCHAR AS videos_list_title,
	------- LEVEL 8 -------
	flatten_store_inventory_products.value:details:specifications:dimensions:size:depth::VARCHAR AS dimensions_size_depth,
	flatten_store_inventory_products.value:details:specifications:dimensions:size:height::VARCHAR AS dimensions_size_height,
	flatten_store_inventory_products.value:details:specifications:dimensions:size:width::VARCHAR AS dimensions_size_width,
	------- LEVEL 8 -------
	json:store:details:location:coordinates:geoDetails:climate:precipitation:annual::INTEGER AS climate_precipitation_annual,
	------- LEVEL 9 -------
	flatten_store_inventory_products.value:details:stock:warehouse:manager:contact:phone::VARCHAR AS manager_contact_phone,
	flatten_store_inventory_products.value:details:stock:warehouse:manager:contact:email::VARCHAR AS manager_contact_email,
	------- LEVEL 9 -------
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:April::INTEGER AS precipitation_monthly_April,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:August::FLOAT AS precipitation_monthly_August,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:December::INTEGER AS precipitation_monthly_December,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:February::INTEGER AS precipitation_monthly_February,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:January::INTEGER AS precipitation_monthly_January,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:July::FLOAT AS precipitation_monthly_July,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:June::FLOAT AS precipitation_monthly_June,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:March::INTEGER AS precipitation_monthly_March,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:May::FLOAT AS precipitation_monthly_May,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:October::INTEGER AS precipitation_monthly_October,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:November::INTEGER AS precipitation_monthly_November,
	json:store:details:location:coordinates:geoDetails:climate:precipitation:monthly:September::FLOAT AS precipitation_monthly_September,
FROM DEMO_DB.DEMO_SCHEMA.DEMO_TABLE
	------- LEVEL 1 -------
	,LATERAL FLATTEN(INPUT => json:store:inventory:products, OUTER => TRUE) AS flatten_store_inventory_products
	------- LEVEL 1 -------
	,LATERAL FLATTEN(INPUT => json:store:contact:socialMedia:platforms:youtube:videos:list, OUTER => TRUE) AS flatten_store_contact_socialMedia_platforms_youtube_videos_list
	------- LEVEL 1 -------
	,LATERAL FLATTEN(INPUT => json:store:events:list, OUTER => TRUE) AS flatten_store_events_list
	------- LEVEL 2 -------
	,LATERAL FLATTEN(INPUT => flatten_store_inventory_products.value:discounts:list, OUTER => TRUE) AS flatten_discounts_list
