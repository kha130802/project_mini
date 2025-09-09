WITH dim_color__resource AS (
SELECT
  *
FROM vit-lam-data.wide_world_importers.warehouse__colors
),
dim_color__renamed AS(
  SELECT
    color_id AS color_key,
    color_name 
  FROM dim_color__resource
),
dim_color__convert AS(
  SELECT
    CAST(color_key AS INTEGER) AS color_key,
    CAST(color_name AS STRING) AS color_name
  FROM dim_color__renamed
),
dim_color_add_undefined__record AS(
  SELECT
    color_key,
    color_name
  FROM dim_color__convert

  UNION ALL
  SELECT
    0 AS color_key,
    'Undefined' AS color_name

  UNION ALL
  SELECT
    -1 AS color_key,
    'Invalid' AS color_name
)
SELECT
  color_key,
  color_name
FROM dim_color_add_undefined__record