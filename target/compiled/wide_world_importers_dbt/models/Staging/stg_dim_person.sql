WITH dim_person AS (
SELECT 
  *
FROM vit-lam-data.wide_world_importers.application__people
), 

dim_person__renamed AS (
SELECT
  person_id as person_key,
  full_name,
  preferred_name,
  search_name,
FROM dim_person
), 

dim_person__convert AS (
SELECT
  CAST(person_key AS INTEGER) AS person_key,
  CAST(full_name AS STRING) AS full_name,
  CAST(preferred_name AS STRING) AS preferred_name,
  CAST(search_name AS STRING) AS search_name
FROM dim_person__renamed
), dim_person_undefined__record AS (
  SELECT
    person_key,
    full_name,
    preferred_name,
    search_name
  FROM dim_person__convert

  UNION ALL
  SELECT
    0 AS person_key,
    'Undefined' AS full_name,
    'Undefined' AS preferred_name,
    'Undefined' AS search_name

  UNION ALL
  SELECT
    -1 AS person_key,
    'Invalid' AS full_name,
    'Invalid' AS preferred_name,
    'Invalid' AS search_name
)
SELECT
  person_key,
  full_name,
  preferred_name,
  search_name
FROM dim_person_undefined__record