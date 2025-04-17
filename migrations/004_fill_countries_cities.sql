INSERT INTO snowflake.countries(country)
SELECT customer_country FROM source.mock_data
UNION
SELECT store_country FROM source.mock_data
UNION
SELECT seller_country FROM source.mock_data
UNION
SELECT seller_country FROM source.mock_data;

INSERT INTO snowflake.cities(country_id, city)
SELECT c.id, m.supplier_city
FROM source.mock_data AS m
         INNER JOIN snowflake.countries c ON m.supplier_country = c.country
UNION
SELECT c.id, m.store_city
FROM source.mock_data AS m
         INNER JOIN snowflake.countries c ON m.store_country = c.country;
