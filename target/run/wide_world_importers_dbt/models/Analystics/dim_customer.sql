

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`dim_customer`
  OPTIONS()
  as WITH dim_customer AS(
  SELECT
    *
  FROM vit-lam-data.wide_world_importers.sales__customers
)
SELECT
  *
FROM dim_customer;

