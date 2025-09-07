

  create or replace view `project-github-471211`.`wide_world_importers_dwh`.`dim_customer`
  OPTIONS()
  as WITH dim_customer__source AS(  
  SELECT *  
  FROM `vit-lam-data.wide_world_importers.sales__customers`  
),  

dim_customer__renamed AS(  
  SELECT  
    customer_id AS customer_key,  
    customer_name,  
    is_statement_sent,  
    is_on_credit_hold,  
    payment_days,  
    credit_limit,  
    account_opened_date,  
    customer_category_id AS customer_category_key,  
    buying_group_id AS customer_buying_group_key,  
    delivery_method_id AS delivery_method_key,  
    delivery_city_id AS delivery_city_key,  
    postal_city_id AS postal_city_key,  
    primary_contact_person_id AS primary_contact_person_key,  
    bill_to_customer_id AS bill_to_customer_key  
  FROM dim_customer__source  
),  

dim_customer__convert AS (  
  SELECT  
    CAST(customer_key AS INT64) AS customer_key,  
    CAST(customer_name AS STRING) AS customer_name,  
    CAST(is_statement_sent AS BOOL) AS is_statement_sent,  
    CAST(is_on_credit_hold AS BOOL) AS is_on_credit_hold,  
    CAST(payment_days AS INT64) AS payment_days,  
    CAST(credit_limit AS FLOAT64) AS credit_limit,  
    CAST(account_opened_date AS DATE) AS account_opened_date,  
    CAST(customer_category_key AS INT64) AS customer_category_key,  
    CAST(customer_buying_group_key AS INT64) AS customer_buying_group_key,  
    CAST(delivery_method_key AS INT64) AS delivery_method_key,  
    CAST(delivery_city_key AS INT64) AS delivery_city_key,  
    CAST(postal_city_key AS INT64) AS postal_city_key,  
    CAST(primary_contact_person_key AS INT64) AS primary_contact_person_key,  
    CAST(bill_to_customer_key AS INT64) AS bill_to_customer_key  
  FROM dim_customer__renamed  
),  

dim_customer_convert__boolean AS (  
  SELECT  
    *,  
    CASE  
      WHEN is_statement_sent IS TRUE THEN 'on_is_statement_sent'  
      WHEN is_statement_sent IS FALSE THEN 'off_is_statement_sent'  
      ELSE 'unknown_is_statement_sent'  
    END AS is_statement_sent_flag,  
    CASE  
      WHEN is_on_credit_hold IS TRUE THEN 'on_is_on_credit_hold'  
      WHEN is_on_credit_hold IS FALSE THEN 'off_is_on_credit_hold'  
      ELSE 'unknown_is_on_credit_hold'  
    END AS is_on_credit_hold_flag  
  FROM dim_customer__convert  
),  

dim_customer_undefined__record AS (  
  SELECT   
    customer_key,  
    customer_name,  
    is_statement_sent_flag,
    is_on_credit_hold_flag,
    account_opened_date,  
    payment_days,  
    credit_limit,  
    customer_category_key,  
    customer_buying_group_key,  
    delivery_method_key,  
    delivery_city_key,  
    postal_city_key,  
    primary_contact_person_key,  
    bill_to_customer_key  
  FROM dim_customer_convert__boolean  

  UNION ALL  

  SELECT  
    0 AS customer_key,  
    'undefined' AS customer_name,  
    'unknown_is_statement_sent' AS is_statement_sent_flag,  
    'unknown_is_on_credit_hold' AS is_on_credit_hold_flag,  
    DATE '1970-01-01' AS account_opened_date,  
    0 AS payment_days,  
    0.0 AS credit_limit,  
    0 AS customer_category_key,  
    0 AS customer_buying_group_key,  
    0 AS delivery_method_key,  
    0 AS delivery_city_key,  
    0 AS postal_city_key,  
    0 AS primary_contact_person_key,  
    0 AS bill_to_customer_key  

  UNION ALL  

  SELECT  
    -1 AS customer_key,  
    'invalid' AS customer_name,  
    'unknown_is_statement_sent' AS is_statement_sent_flag,  
    'unknown_is_on_credit_hold' AS is_on_credit_hold_flag,  
    DATE '1970-01-01' AS account_opened_date,  
    -1 AS payment_days,  
    -1.0 AS credit_limit,  
    -1 AS customer_category_key,  
    -1 AS customer_buying_group_key,  
    -1 AS delivery_method_key,  
    -1 AS delivery_city_key,  
    -1 AS postal_city_key,  
    -1 AS primary_contact_person_key,  
    -1 AS bill_to_customer_key  
),  

dim_customer__join AS (  
  SELECT  
    customer.customer_key,
    customer.customer_name,
    customer.is_statement_sent_flag AS is_statement_send,
    customer.is_on_credit_hold_flag AS is_on_credit_holds,
    customer.payment_days,
    customer.credit_limit,
    customer.account_opened_date,
    customer.customer_category_key,
    category.customer_category_name,
    customer.customer_buying_group_key,
    buying_group.buying_group_name,
    customer.delivery_method_key,
    customer.delivery_city_key,
    city.city_name AS delivery_city_name,
    city.state_province_key AS delivery_state_province_key,
    city.state_province_name AS delivery_state_province_name,
    customer.postal_city_key,
    city.city_name AS postal_city_name,
    customer.primary_contact_person_key,
    person.full_name ,
    person.preferred_name ,
    person.search_name 
FROM dim_customer_undefined__record AS customer
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_category` AS category
ON customer.customer_category_key = category.customer_category_key
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_buying_group` AS buying_group
ON customer.customer_buying_group_key = buying_group.buying_group_key
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`dim_city` AS city
ON customer.delivery_city_key = city.city_key
LEFT JOIN `project-github-471211`.`wide_world_importers_dwh`.`stg_dim_person` AS person
ON customer.primary_contact_person_key = person.person_key
)
SELECT 
  customer_key,
  customer_name,
  is_statement_send,
  is_on_credit_holds,
  payment_days,
  credit_limit,
  account_opened_date,
  customer_category_key,
  customer_category_name,
  customer_buying_group_key,
  buying_group_name,
  delivery_method_key,
  delivery_city_key,
  delivery_city_name,
  postal_city_key,
  postal_city_name,
  primary_contact_person_key,
  full_name ,
  preferred_name ,
  search_name 
FROM dim_customer__join;

