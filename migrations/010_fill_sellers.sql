
INSERT INTO snowflake.sellers(first_name, last_name, email, store_id, country_id, postal_code)
SELECT  seller_first_name, seller_last_name, seller_email, str.id, dcr.id, seller_postal_code
FROM source.mock_data md
    LEFT JOIN snowflake.countries dcr ON md.seller_country = dcr.country
        LEFT JOIN snowflake.stores str ON str.name = md.store_name AND
                                          md.store_location = str.location AND
                                          md.store_email = str.email AND
                                          md.store_phone = str.phone;





