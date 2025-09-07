with dim_province_state__source AS(
SELECT *
FROM vit-lam-data.wide_world_importers.application__state_provinces
), dim_province_state__renamed AS(
SELECT
  state_province_id AS state_province_key,
  state_province_name AS state_province_name
FROM dim_province_state__source
), dim_province_state__convert AS(
SELECT
  CAST(state_province_key AS INTEGER) AS state_province_key,
  CAST(state_province_name AS STRING) AS state_province_name
FROM dim_province_state__renamed
),
dim_province_state_undefined__record AS(
  SELECT
    state_province_key,
    state_province_name
  FROM dim_province_state__convert

  UNION ALL
  SELECT
    0 AS state_province_key,
    'Undefined' AS state_province_name

  UNION ALL
  SELECT
    -1 AS state_province_key,
    'Invalid' AS state_province_name
)
SELECT
  state_province_key,
  state_province_name
FROM dim_province_state_undefined__record