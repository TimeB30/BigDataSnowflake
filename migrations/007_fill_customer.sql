INSERT INTO snowflake.customers(first_name, last_name, age, email,
                                 country_id, postal_code)
SELECT md.customer_first_name,
       md.customer_last_name,
       md.customer_age,
       md.customer_email,
       dc.id,
       md.customer_postal_code
FROM source.mock_data md
         LEFT JOIN snowflake.countries dc ON md.customer_country = dc.country
