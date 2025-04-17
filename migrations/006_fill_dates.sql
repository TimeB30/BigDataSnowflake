INSERT INTO snowflake.days(id)
SELECT extract(DAY FROM product_release_date)
FROM source.mock_data
UNION
SELECT extract(DAY FROM product_expiry_date)
FROM source.mock_data
UNION
SELECT extract(DAY FROM sale_date)
FROM source.mock_data;


INSERT INTO snowflake.months(id)
SELECT extract(MONTH FROM product_release_date)
FROM source.mock_data
UNION
SELECT extract(MONTH FROM product_expiry_date)
FROM source.mock_data
UNION
SELECT extract(MONTH FROM sale_date)
FROM source.mock_data;

INSERT INTO snowflake.years(id)
SELECT extract(YEAR FROM product_release_date)
FROM source.mock_data
UNION
SELECT extract(YEAR FROM product_expiry_date)
FROM source.mock_data
UNION
SELECT extract(YEAR FROM sale_date)
FROM source.mock_data;


INSERT INTO snowflake.d_date(date, day_id, month_id, year_id)
SELECT product_release_date, dd.id, dm.id, dy.id
FROM source.mock_data
         LEFT JOIN snowflake.days dd ON dd.id = extract(DAY FROM product_release_date)
         LEFT JOIN snowflake.months dm ON dm.id = extract(MONTH FROM product_release_date)
         LEFT JOIN snowflake.years dy on dy.id = extract(YEAR FROM product_release_date)
UNION
SELECT mock_data.product_expiry_date, dd.id, dm.id, dy.id
FROM source.mock_data
         LEFT JOIN snowflake.days dd ON dd.id = extract(DAY FROM product_expiry_date)
         LEFT JOIN snowflake.months dm ON dm.id = extract(MONTH FROM product_expiry_date)
         LEFT JOIN snowflake.years dy on dy.id = extract(YEAR FROM product_expiry_date)
UNION
SELECT sale_date, dd.id, dm.id, dy.id
FROM source.mock_data
         LEFT JOIN snowflake.days dd ON dd.id = extract(DAY FROM sale_date)
         LEFT JOIN snowflake.months dm ON dm.id = extract(MONTH FROM sale_date)
         LEFT JOIN snowflake.years dy on dy.id = extract(YEAR FROM sale_date)
