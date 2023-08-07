SELECT DISTINCT
    r.order_id,
    r.review_score,
    r.review_comment_message_length
FROM
    olist_db.olist_order_reviews_dataset AS r;
