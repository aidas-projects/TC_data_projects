-- there were few orders with 2 review ratings instead of 1. This is obvious glich/mistake in my opinion. So I decided to solve this by choosing the first review for each order.
WITH first_review AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_creation_date) AS row_num
  FROM olist_db.olist_order_reviews_dataset
)

SELECT DISTINCT o.order_id,
  /* Without the PARTITION BY clause, the COUNT() function would calculate the total count of oi.order_id across all rows, instead of calculating it separately for each order_id. This would result in the same count for all rows, rather than reflecting the actual count per order_id */
  COUNT(oi.order_id) OVER (PARTITION BY oi.order_id) AS item_count,
  r.review_score
FROM olist_db.olist_orders_dataset AS o
JOIN olist_db.olist_order_items_dataset AS oi ON o.order_id = oi.order_id
JOIN first_review AS r ON o.order_id = r.order_id
WHERE r.row_num = 1 
ORDER BY o.order_id, item_count DESC;
