INSERT INTO snowflake.product_categories(name)
SELECT DISTINCT product_category from source.mock_data;

INSERT INTO snowflake.pet_types(type)
SELECT DISTINCT customer_pet_type FROM source.mock_data;

INSERT INTO snowflake.pet_categories(category)
SELECT DISTINCT pet_category FROM source.mock_data;


