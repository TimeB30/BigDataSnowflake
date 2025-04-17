INSERT INTO snowflake.suppliers(name,contact,email,phone,address,city_id,country_id)
SELECT md.supplier_name, md.supplier_contact, md.supplier_email,
md.supplier_phone, md.supplier_address, dc.id, dcr.id
FROM source.mock_data md
         LEFT JOIN snowflake.countries dcr ON dcr.country = md.supplier_country
         LEFT JOIN snowflake.cities dc ON dc.city = md.supplier_city AND dc.country_id = dcr.id
