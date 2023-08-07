SELECT DISTINCT
    o.order_id,
    TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY) AS click_to_delivery_time_days,
    r.review_score
FROM
    olist_db.olist_orders_dataset AS o
JOIN
    olist_db.olist_order_reviews_dataset AS r ON o.order_id = r.order_id;
