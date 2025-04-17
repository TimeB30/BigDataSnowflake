INSERT INTO snowflake.colors(color)
SELECT DISTINCT product_color FROM source.mock_data;

INSERT INTO snowflake.sizes(size)
SELECT DISTINCT product_size FROM source.mock_data;


INSERT INTO snowflake.brands(brand)
SELECT DISTINCT product_brand FROM source.mock_data;

INSERT INTO snowflake.materials( material)
SELECT DISTINCT product_material FROM source.mock_data;