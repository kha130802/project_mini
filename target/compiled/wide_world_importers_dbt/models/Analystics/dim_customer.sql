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
), dim_customer__convert as(
SELECT
  CAST(customer_key AS INTEGER) AS customer_key,
  CAST(customer_name AS STRING) AS customer_name,
  CAST(is_statement_sent AS BOOL) AS is_statement_sent,
  CAST(is_on_credit_hold AS BOOL) AS is_on_credit_hold,
  CAST(payment_days AS INTEGER) AS payment_days,
  CAST(credit_limit AS FLOAT64) AS credit_limit,
  CAST(account_opened_date AS DATE) AS account_opened_date,
  CAST(customer_category_key AS INTEGER) AS customer_category_key,
  CAST(customer_buying_group_key AS INTEGER) AS customer_buying_group_key,
  CAST(delivery_method_key AS INTEGER) AS delivery_method_key,
  CAST(delivery_city_key AS INTEGER) AS delivery_city_key,
  CAST(postal_city_key AS INTEGER) AS postal_city_key,
  CAST(primary_contact_person_key AS INTEGER) AS primary_contact_person_key,
  CAST(bill_to_customer_key AS INTEGER) AS bill_to_customer_key
FROM dim_customer__renamed
), dim_customer__join AS (
SELECT
  customer.customer_key,
  customer.customer_name,
  customer.is_statement_sent,
  customer.is_on_credit_hold,
  customer.payment_days,
  customer.credit_limit,
  customer.account_opened_date,
  customer.customer_category_key,
  category.customer_category_name,
  customer.customer_buying_group_key,
  buying_group.buying_group_name,
  customer.delivery_method_key,
  customer.delivery_city_key,
  customer.postal_city_key,
  customer.primary_contact_person_key,
  customer.bill_to_customer_key
FROM dim_customer__convert AS customer
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_category` AS category
ON customer.customer_category_key = category.customer_category_key
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_buying_group` AS buying_group
ON customer.customer_buying_group_key = buying_group.buying_group_key
)
SELECT 
  customer_key,
  customer_name,
  is_statement_sent,
  is_on_credit_hold,
  payment_days,
  credit_limit,
  account_opened_date,
  customer_category_key,
  customer_category_name,
  customer_buying_group_key,
  buying_group_name,
  delivery_method_key,
  delivery_city_key,
  postal_city_key,
  primary_contact_person_key,
  bill_to_customer_key
FROM dim_customer__join