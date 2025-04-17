
INSERT INTO snowflake.products(name, category_id, price, quantity,
                               release_date_id, expiry_date_id, rating,
                               reviews, weight, color_id, size_id, material_id,
                               brand_id, description)
SELECT  md.product_name, pr_cat.id, md.product_price,
       md.product_quantity, d_date.id, d_date.id,
       md.product_rating, md.product_reviews,
       md.product_weight, c.id, s.id,
       m.id, b.id, md.product_description
FROM source.mock_data md
LEFT JOIN snowflake.product_categories pr_cat ON pr_cat.name = md.product_category
LEFT JOIN snowflake.d_date d_date ON
    d_date.day_id = (SELECT id FROM snowflake.days WHERE id = EXTRACT(DAY FROM md.sale_date)) AND
    d_date.month_id = (SELECT id FROM snowflake.months WHERE id = EXTRACT(MONTH FROM md.sale_date)) AND
    d_date.year_id = (SELECT id FROM snowflake.years WHERE id = EXTRACT(YEAR FROM md.sale_date))
LEFT JOIN snowflake.colors c ON c.color = md.product_color
LEFT JOIN snowflake.materials m ON m.material = md.product_material
LEFT JOIN snowflake.sizes s ON s.size = md.product_size
LEFT JOIN snowflake.brands b ON b.brand = md.product_brand;