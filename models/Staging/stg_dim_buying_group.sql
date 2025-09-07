WITH stg_dim_buying_group__source AS (
  SELECT *
  FROM vit-lam-data.wide_world_importers.sales__buying_groups
), stg_dim_buying_group__renamed AS (
  SELECT
    buying_group_id AS buying_group_key,
    buying_group_name
  FROM stg_dim_buying_group__source
), stg_dim_buying_group__convert AS (
  SELECT
    CAST(buying_group_key AS INTEGER) AS buying_group_key,
    CAST(buying_group_name AS STRING) AS buying_group_name
  FROM stg_dim_buying_group__renamed
), stg_dim_buying_group_undefined AS (
  SELECT
    buying_group_key,
    buying_group_name
  FROM stg_dim_buying_group__convert

  UNION ALL
  SELECT
    0 AS buying_group_key,
    'Undefined' AS buying_group_name

  UNION ALL
  SELECT
    -1 AS buying_group_key,
    'Invalid' AS buying_group_name
)
SELECT
  buying_group_key,
  buying_group_name
FROM stg_dim_buying_group_undefined