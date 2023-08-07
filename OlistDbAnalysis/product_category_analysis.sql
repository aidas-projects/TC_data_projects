SELECT
    t.string_field_1 AS translated_category_name, -- Select the translated category name
    COUNT(DISTINCT oi.order_id) AS order_count, 
    AVG(oi.freight_value) AS average_shipping_price, 
    AVG(p.product_length_cm * p.product_height_cm * p.product_width_cm) / 1000000 AS average_volume, -- Calculate the average product volume in cubic meters
    AVG(p.product_weight_g) / 1000 AS average_product_weight, -- Calculate the average product weight in kilograms
    AVG(r.review_score) AS average_review_score, 
    COUNT(DISTINCT r.order_id) AS review_count 
FROM
    olist_db.olist_order_items_dataset AS oi 
JOIN
    olist_db.olist_products_dataset AS p ON oi.product_id = p.product_id 
JOIN
    olist_db.product_category_name_translation AS t ON p.product_category_name = t.string_field_0 
JOIN
    olist_db.olist_order_reviews_dataset AS r ON oi.order_id = r.order_id 
GROUP BY
    t.string_field_1 
ORDER BY
    average_review_score DESC;
