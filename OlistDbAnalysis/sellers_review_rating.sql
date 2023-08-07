SELECT
    oi.seller_id,
    AVG(r.review_score) AS average_review_score,
    COUNT(*) AS review_count
FROM
    (
    -- order_items_dataset has multiple rows with same order_id. It's messing up correct review count. Just creating the table where order_id is appears just once.
    SELECT
        order_id,
        seller_id,
        COUNT(*) AS item_count
    FROM
        olist_db.olist_order_items_dataset
    GROUP BY
        order_id, seller_id
    ) AS oi
JOIN
    olist_db.olist_order_reviews_dataset AS r ON oi.order_id = r.order_id
GROUP BY
    oi.seller_id
ORDER BY
    average_review_score DESC, review_count DESC;
