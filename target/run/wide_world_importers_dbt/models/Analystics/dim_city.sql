

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`dim_city`
  OPTIONS()
  as WITH dim_city__source AS( 
SELECT  
  *
FROM vit-lam-data.wide_world_importers.application__cities
), 

dim_city__renamed AS(
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
), 

dim_city__join AS (
SELECT
  city.city_key,
  city.city_name,
  city.state_province_key,
  state.state_province_name
FROM dim_city__convert as city
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_province_state` AS state
ON city.state_province_key = state.state_province_key
), dim_city_undefined__record AS(
  SELECT
    city_key,
    city_name,
    state_province_key,
    state_province_name
  FROM dim_city__join

  UNION ALL
  SELECT
    0 AS city_key,
    'Undefined' AS city_name,
    0 AS state_province_key,
    'Undefined' AS state_province_name

  UNION ALL
  SELECT
    -1 AS city_key,
    'Invalid' AS city_name,
    -1 AS state_province_key,
    'Invalid' AS state_province_name
)

SELECT
  city_key,
  city_name,
  state_province_key,
  state_province_name
FROM dim_city_undefined__record AS city;

