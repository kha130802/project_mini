with dim_province_state__source AS(
SELECT *
FROM vit-lam-data.wide_world_importers.application__state_provinces
), dim_province_state__renamed AS(
SELECT
  state_province_id AS delivier_state_province_key,
  state_province_name AS delivier_state_province_name
FROM dim_province_state__source
), dim_province_state__convert AS(
SELECT
  CAST(delivier_state_province_key AS INTEGER) AS delivier_state_province_key,
  CAST(delivier_state_province_name AS STRING) AS delivier_state_province_name
FROM dim_province_state__renamed
)
SELECT
  delivier_state_province_key,
  delivier_state_province_name
FROM dim_province_state__convert