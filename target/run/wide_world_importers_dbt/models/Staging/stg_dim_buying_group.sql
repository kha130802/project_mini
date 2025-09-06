

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_buying_group`
  OPTIONS()
  as WITH stg_dim_buying_group__source AS (
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
)
  SELECT
    buying_group_key,
    buying_group_name
  FROM stg_dim_buying_group__convert;

