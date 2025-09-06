

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_category`
  OPTIONS()
  as WITH dim_category__source AS(
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
)
SELECT 
  customer_category_key,
  customer_category_name
FROM dim_category__convert;

