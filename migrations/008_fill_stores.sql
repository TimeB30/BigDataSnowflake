INSERT INTO snowflake.store_states(state)
SELECT DISTINCT md.store_state
FROM source.mock_data md
WHERE md.store_state IS NOT NULL;



INSERT INTO snowflake.stores(name, location, city_id, state_id, country_id,
                              phone, email)
SELECT DISTINCT md.store_name,
       md.store_location,
       dc.id,
       dss.id,
       dcr.id,
       md.store_phone,
       md.store_email
FROM source.mock_data md
         LEFT JOIN snowflake.countries dcr ON dcr.country = md.store_country
         LEFT JOIN snowflake.cities dc ON dc.city = md.store_city AND dc.country_id = dcr.id
         LEFT JOIN snowflake.store_states dss ON dss.state = md.store_state
