WITH dim_category__source AS(
SELECT
  *
FROM vit-lam-data.wide_world_importers.sales__customer_categories
), dim_category__renamed AS(
SELECT
  customer_category_id AS customer_category_key,
  customer_category_name
FROM dim_category__source
), dim_category__convert AS(
SELECT
  CAST(customer_category_key AS INTEGER) AS customer_category_key,
  CAST(customer_category_name AS STRING) AS customer_category_name
FROM dim_category__renamed
), dim_category_undifined__recored AS(
  SELECT
    customer_category_key,
    customer_category_name
  FROM dim_category__convert

  UNION ALL
  SELECT
    0 AS customer_category_key,
    'Undefined' AS customer_category_name

  UNION ALL
  SELECT
    -1 AS customer_category_key,
    'Invalid' AS customer_category_name
)
SELECT 
  customer_category_key,
  customer_category_name
FROM dim_category_undifined__recored