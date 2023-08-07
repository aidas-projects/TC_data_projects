SELECT
    oi.seller_id, 
    SUM(oi.price + oi.freight_value) AS total_price_freight 
FROM
    olist_db.olist_order_items_dataset AS oi ataset
GROUP BY
    oi.seller_id; 
