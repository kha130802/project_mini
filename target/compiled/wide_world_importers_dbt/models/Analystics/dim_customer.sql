WITH dim_customer AS(
  SELECT
    *
  FROM vit-lam-data.wide_world_importers.sales__customers
)
SELECT
  *
FROM dim_customer