

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_delivier_method`
  OPTIONS()
  as WITH dim_delivery_method__resource AS (
  SELECT
    *
  FROM 
    vit-lam-data.wide_world_importers.application__delivery_methods
),
dim_delivery_method__renamed AS(
  SELECT
    delivery_method_id AS delivery_method_key,
    delivery_method_name AS delivery_method_name
  FROM dim_delivery_method__resource
),
dim_delivery_method__convert AS(
  SELECT
    CAST(delivery_method_key AS INTEGER) AS delivery_method_key,
    CAST(delivery_method_name AS STRING) AS delivery_method_name
  FROM dim_delivery_method__renamed
),
dim_deliviery_method_add_undefined__record AS(
  SELECT
    delivery_method_key,
    delivery_method_name
  FROM dim_delivery_method__convert

  UNION ALL
  SELECT
    0 AS delivery_method_key,
    'Undefined' AS delivery_method_name

  UNION ALL
  SELECT
    -1 AS delivery_method_key,
    'Invalid' AS delivery_method_name
)
SELECT
  delivery_method_key,
  delivery_method_name
FROM dim_deliviery_method_add_undefined__record;

