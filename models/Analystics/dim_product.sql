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
    marketing_comments AS product_description,
    custom_fields AS product_custom_fields,
    tags AS product_tags,
    search_details AS product_search_details
  FROM dim_product__resource
)
SELECT 
  * 
FROM dim_product__renamed