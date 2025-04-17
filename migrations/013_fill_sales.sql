INSERT INTO snowflake.sales (date_id, customer_id, seller_id, store_id, supplier_id,
                             product_id, quantity, total_price)
SELECT d.id,
       cs.id,
       slrs.id,
       strs.id,
       splrs.id,
       md.id,
       md.sale_quantity,
       md.sale_total_price
FROM source.mock_data md
        LEFT JOIN snowflake.customers cs ON
            cs.first_name = md.customer_first_name AND
            cs.last_name = md.customer_last_name AND
            cs.age = md.customer_age AND
            cs.email = md.customer_email
        LEFT JOIN snowflake.sellers slrs ON
            slrs.first_name  = md.seller_first_name AND
            slrs.last_name = md.seller_last_name AND
            slrs.email = md.seller_email
        LEFT JOIN snowflake.suppliers splrs ON
            splrs.name = md.supplier_name AND
            splrs.email = md.supplier_email
        LEFT JOIN snowflake.d_date d ON
            d.day_id = (SELECT id FROM snowflake.days WHERE id = EXTRACT(DAY FROM md.sale_date)) AND
            d.month_id = (SELECT id FROM snowflake.months WHERE id = EXTRACT(MONTH FROM md.sale_date)) AND
            d.year_id = (SELECT id FROM snowflake.years WHERE id = EXTRACT(YEAR FROM md.sale_date))

        LEFT JOIN snowflake.stores strs ON
            strs.name = md.store_name AND
            strs.phone = md.store_phone AND
            strs.email = md.store_email
