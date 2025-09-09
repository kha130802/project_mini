WITH dim_supplier__recored AS (
  SELECT
    *
  FROM vit-lam-data.wide_world_importers.purchasing__suppliers
), 
dim_supplier__renamed AS(
  SELECT
    supplier_id AS supplier_key,
    supplier_name,
    supplier_category_id AS supplier_category_key,
    primary_contact_person_id AS primary_contact_person_key,
    alternate_contact_person_id AS alternate_contact_person_key,
    delivery_method_id AS delivery_method_key,
    delivery_city_id AS delivery_city_key,
    postal_city_id AS postal_city_key
  FROM dim_supplier__recored
),
dim_supplier__convert AS(
  SELECT
    CAST(supplier_key AS INTEGER) AS supplier_key,
    CAST(supplier_name AS STRING) AS supplier_name,
    CAST(supplier_category_key AS INTEGER) AS supplier_category_key,
    CAST(primary_contact_person_key AS INTEGER) AS primary_contact_person_key,
    CAST(alternate_contact_person_key AS INTEGER) AS alternate_contact_person_key,
    CAST(delivery_method_key AS INTEGER) AS delivery_method_key,
    CAST(delivery_city_key AS INTEGER) AS delivery_city_key,
    CAST(postal_city_key AS INTEGER) AS postal_city_key
  FROM dim_supplier__renamed
),
dim_supplier_add_undifined__record AS(
  SELECT
    supplier_key,
    supplier_name,
    supplier_category_key,
    primary_contact_person_key,
    alternate_contact_person_key,
    delivery_method_key,
    delivery_city_key,
    postal_city_key
  FROM dim_supplier__convert
  UNION ALL
  SELECT
    0 AS supplier_key,
    'Undefined' AS supplier_name,
    0 AS supplier_category_key,
    0 AS primary_contact_person_key,
    0 AS alternate_contact_person_key,
    0 AS delivery_method_key,
    0 AS delivery_city_key,
    0 AS postal_city_key
  UNION ALL
  SELECT
    -1 AS supplier_key,
    'Invalid' AS supplier_name,
    -1 AS supplier_category_key,
    -1 AS primary_contact_person_key,
    -1 AS alternate_contact_person_key,
    -1 AS delivery_method_key,
    -1 AS delivery_city_key,
    -1 AS postal_city_key
), dim_supplier_join AS(
SELECT  
  dim_supplier.supplier_key,
  dim_supplier.supplier_name,
  dim_supplier.supplier_category_key,
  stg_supplier_category.supplier_category_name,
  dim_supplier.primary_contact_person_key,
  dim_supplier.alternate_contact_person_key,
  dim_supplier.delivery_method_key,
  stg_delivery_method.delivery_method_name,
  dim_supplier.delivery_city_key,
  dim_supplier.postal_city_key
FROM dim_supplier_add_undifined__record AS dim_supplier
LEFT JOIN {{ref('stg_supplier_category')}} AS stg_supplier_category
ON dim_supplier.supplier_category_key = stg_supplier_category.supplier_category_key
LEFT JOIN {{ref('stg_dim_delivier_method')}} AS stg_delivery_method
ON dim_supplier.delivery_method_key = stg_delivery_method.delivery_method_key
)
SELECT
  supplier_key,
  supplier_name,
  supplier_category_key,
  supplier_category_name,
  primary_contact_person_key,
  alternate_contact_person_key,
  delivery_method_key,
  delivery_method_name,
  delivery_city_key,
  postal_city_key
  FROM dim_supplier_join