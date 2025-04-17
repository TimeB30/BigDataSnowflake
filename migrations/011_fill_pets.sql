with breeds as (select distinct m.customer_pet_breed, m.customer_pet_type from source.mock_data m)

INSERT INTO snowflake.pet_breeds(pet_type_id, breed)
SELECT dpt.id, breeds.customer_pet_breed
FROM breeds
         LEFT JOIN snowflake.pet_types dpt ON dpt.type = breeds.customer_pet_type;

INSERT INTO snowflake.pets(name, type_id, breed_id)
SELECT md.customer_pet_name, dpt.id, dpb.id FROM source.mock_data md
    LEFT JOIN snowflake.pet_types dpt ON dpt.type = md.customer_pet_type
    LEFT JOIN snowflake.pet_breeds dpb ON dpb.breed = md.customer_pet_breed AND dpb.pet_type_id = dpt.id;


INSERT INTO snowflake.customers_pets(customer_id, pet_id)
SELECT cs.id, pt.id
FROM source.mock_data md
INNER JOIN snowflake.pets pt ON pt.name = md.customer_pet_name
INNER JOIN snowflake.customers cs ON md.customer_first_name = cs.first_name AND
                                  md.customer_last_name = cs.last_name;