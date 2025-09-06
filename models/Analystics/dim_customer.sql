WITH dim_customer__source AS(
  SELECT
    *
  FROM vit-lam-data.wide_world_importers.sales__customers
), dim_customer__renamed AS(
  SELECT
    customer_id AS customer_key,
    customer_name,
    is_statement_sent,
    is_on_credit_hold,
    payment_days,
    credit_limit,
    account_opened_date,
    customer_category_id as customer_category_key,
    buying_group_id as customer_buying_group_key,
    delivery_method_id as delivery_method_key,
    delivery_city_id as delivery_city_key,
    postal_city_id as postal_city_key,
    primary_contact_person_id as primary_contact_person_key,
    bill_to_customer_id as bill_to_customer_key
  

  FROM dim_customer__source
)
SELECT
  *
FROM dim_customer__renamed