
WITH first_event AS (
  -- Query to get the first event timestamp for each user on each date
  SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    user_pseudo_id,
    MIN(event_timestamp) AS first_event_timestamp
  FROM
    turing_data_analytics.raw_events
  GROUP BY
    event_date, user_pseudo_id
),

ranked_purchases AS (
  -- Query to rank the purchases for each user on each date
  SELECT
    PARSE_DATE('%Y%m%d', event_date) AS event_date,
    user_pseudo_id,
    event_timestamp AS purchase_timestamp,
    category,
    mobile_model_name,
    mobile_brand_name,
    operating_system,
    browser,
    browser_version,
    country,
    total_item_quantity,
    purchase_revenue_in_usd,
    RANK() OVER (PARTITION BY event_date, user_pseudo_id ORDER BY event_timestamp) AS purchase_rank
  FROM
    turing_data_analytics.raw_events
  WHERE
    event_name = 'purchase'
),

earliest_purchase AS (
  -- Query to select the earliest purchase for each user on each date
  SELECT
    event_date,
    user_pseudo_id,
    purchase_timestamp,
    category,
    mobile_model_name,
    mobile_brand_name,
    operating_system,
    browser,
    browser_version,
    country,
    total_item_quantity,
    purchase_revenue_in_usd
  FROM
    ranked_purchases
  WHERE
    purchase_rank = 1
),

country_counts AS (
  -- Query to count the number of purchases in each country from earliest_purchase table. 
  -- Used these values to filter out countries in Looker Studio with only few data points.
  SELECT
    country,
    COUNT(*) AS country_total_count
  FROM
    earliest_purchase
  GROUP BY
    country
)

SELECT
  fe.event_date,
  fe.user_pseudo_id,
  fe.first_event_timestamp,
  ep.purchase_timestamp AS first_purchase_timestamp,
  -- Calculate the duration in seconds between first event and first purchase
  TIMESTAMP_DIFF(TIMESTAMP_MICROS(ep.purchase_timestamp), TIMESTAMP_MICROS(fe.first_event_timestamp), SECOND) AS duration_seconds,
  ep.category,
  ep.mobile_model_name,
  ep.mobile_brand_name,
  ep.operating_system,
  ep.browser,
  ep.browser_version,
  ep.country,
  ep.total_item_quantity,
  ep.purchase_revenue_in_usd,
  cc.country_total_count,
  -- Calculate revenue per minute, handle division by zero with NULLIF
  ep.purchase_revenue_in_usd / NULLIF(TIMESTAMP_DIFF(TIMESTAMP_MICROS(ep.purchase_timestamp), TIMESTAMP_MICROS(fe.first_event_timestamp), SECOND)/60, 0) AS revenue_per_min
FROM
  first_event fe
JOIN
  earliest_purchase ep ON fe.event_date = ep.event_date AND fe.user_pseudo_id = ep.user_pseudo_id
JOIN
  country_counts cc ON ep.country = cc.country
ORDER BY
  fe.event_date;
