WITH dim_city__source AS( 
SELECT  
  *
FROM vit-lam-data.wide_world_importers.application__cities
), dim_city__renamed AS(
SELECT
  city_id AS city_key,
  city_name,
  state_province_id AS state_province_key
FROM dim_city__source
), dim_city__convert AS(
SELECT
  CAST(city_key AS INTEGER) AS city_key,
  CAST(city_name AS STRING) AS city_name,
  CAST(state_province_key AS INTEGER) AS state_province_key
FROM dim_city__renamed
)
SELECT
  city_key,
  city_name,
  state_province_key
FROM dim_city__convert