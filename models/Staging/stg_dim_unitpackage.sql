WITH stg_dim_unitpackage__source AS (
  SELECT
    *
  FROM vit-lam-data.wide_world_importers.warehouse__package_types
), 

stg_dim_unitpackage_rename AS (
  SELECT
    package_type_id AS unit_package_key,
    package_type_name AS unit_package_name,
    package_type_name AS outer_package_name
  FROM stg_dim_unitpackage__source
), 

stg_dim_unitpackage__convert AS (
  SELECT
    CAST(unit_package_key AS INTEGER) AS unit_package_key,
    CAST(unit_package_name AS STRING) AS unit_package_name,
    CAST(outer_package_name AS STRING) AS outer_package_name
  FROM stg_dim_unitpackage_rename
), 

stg_dim_unitpackage_add_undefined__record AS (
  SELECT
    unit_package_key,
    unit_package_name,
    outer_package_name
  FROM 
    stg_dim_unitpackage__convert

  UNION ALL
  SELECT
    0 AS unit_package_key,
    'Undefined' AS unit_package_name,
    'Undefined' AS outer_package_name

  UNION ALL
  SELECT
    -1 AS unit_package_key,
    'Invalid' AS unit_package_name,
    'Invalid' AS outer_package_name
)
SELECT
  unit_package_key,
  unit_package_name,
  outer_package_name
FROM 
  stg_dim_unitpackage_add_undefined__record