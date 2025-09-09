WITH dim_product__resource AS (
  SELECT 
    *
  FROM vit-lam-data.wide_world_importers.warehouse__stock_items
), 

dim_product__renamed AS (
  SELECT 
    stock_item_id AS product_key,
    stock_item_name AS product_name,
    brand AS product_brand,
    size AS product_size,
    lead_time_days AS product_lead_time,
    quantity_per_outer AS product_quantity_per_outer,
    is_chiller_stock AS product_is_chiller_stock,
    tax_rate AS product_tax_rate,
    unit_price AS product_unit_price,
    recommended_retail_price AS product_recommended_retail_price,
    typical_weight_per_unit AS product_typical_weight_per_unit,
    marketing_comments AS product_marketing_comments,
    internal_comments AS product_internal_comments,
    custom_fields AS product_custom_fields,
    tags AS product_tags,
    search_details AS product_search_details,
    last_edited_by AS producT_last_edited_by,
    supplier_id AS supplier_key,
    color_id AS color_key,
    unit_price AS product_price,
    recommended_retail_price AS product_rrp,
    typical_weight_per_unit AS product_weight,
    marketing_comments AS product_description
  FROM dim_product__resource
),
dim_product_convert__boolean AS (
  SELECT 
    *, 
    CASE 
      WHEN product_is_chiller_stock IS TRUE THEN 'on_product_is_chiller_stock' 
      WHEN product_is_chiller_stock IS FALSE THEN 'off_product_is_chiller_stock' 
      ELSE 'undefined' 
    END AS product_is_chiller_stock_flag
  FROM dim_product__renamed
), 
dim_product_add_undefined__record AS (
  SELECT 
    product_key,
    product_name,
    product_brand,
    product_size,
    product_lead_time,
    product_quantity_per_outer,
    product_is_chiller_stock_flag,
    product_tax_rate,
    product_unit_price,
    product_recommended_retail_price,
    product_typical_weight_per_unit,
    product_marketing_comments,
    product_internal_comments,
    product_custom_fields,
    product_tags,
    product_search_details,
    producT_last_edited_by,
    supplier_key,
    color_key,
    product_price,
    product_rrp,
    product_weight,
    product_description
    FROM dim_product_convert__boolean

    UNION ALL
    SELECT
    0 AS product_key,
    'undefined' AS product_name,
    'undefined' AS product_brand,
    'undefined' AS product_size,
    0 AS product_lead_time,
    0 AS product_quantity_per_outer,
    'undefined' AS product_is_chiller_stock_flag,
    0 AS product_tax_rate,
    0 AS product_unit_price,
    0 AS product_recommended_retail_price,
    0 AS product_typical_weight_per_unit,
    'undefined' AS product_marketing_comments,
    'undefined' AS product_internal_comments,
    'undefined' AS product_custom_fields,
    'undefined' AS product_tags,
    'undefined' AS product_search_details,
    0 AS producT_last_edited_by,
    0 AS supplier_key,
    0 AS color_key,
    0 AS product_price,
    0 AS product_rrp,
    0 AS product_weight,
    'undefined' AS product_description

  UNION ALL
    SELECT
    -1 AS product_key,
    'Invalid' AS product_name,
    'Invalid' AS product_brand,
    'Invalid' AS product_size,
    -1 AS product_lead_time,
    -1 AS product_quantity_per_outer,
    'undefined' AS product_is_chiller_stock_flag,
    -1 AS product_tax_rate,
    -1 AS product_unit_price,
    -1 AS product_recommended_retail_price,
    -1 AS product_typical_weight_per_unit,
    'Invalid' AS product_marketing_comments,
    'Invalid' AS product_internal_comments,
    'Invalid' AS product_custom_fields,
    'Invalid' AS product_tags,
    'Invalid' AS product_search_details,
    -1 AS product_last_edited_by,
    -1 AS supplier_key,
    -1 AS color_key,
    -1 AS product_price,
    -1 AS product_rrp,
    -1 AS product_weight,
    'Invalid' AS product_description
  FROM dim_product_convert__boolean
)
SELECT 
  * 
FROM 
  dim_product_add_undefined__record