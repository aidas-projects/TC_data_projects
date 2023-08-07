WITH cte AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    user_pseudo_id,
    COALESCE(MAX(CASE WHEN event_name = 'session_start' THEN event_timestamp END) 
      OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp ASC), 
      MIN(event_timestamp) OVER (PARTITION BY user_pseudo_id)) 
      AS session_start,
    campaign
  FROM
    turing_data_analytics.raw_events
     WHERE
    user_pseudo_id IN ('4493164.4370079942')
)
SELECT
  PARSE_DATE('%Y%m%d', event_date) AS event_date,
  user_pseudo_id,
  session_start,
  MAX(event_timestamp) AS session_end,
  (MAX(event_timestamp) - session_start) / 1000000 AS session_duration_in_sec,
  MAX(campaign) AS campaign,
  COUNT(DISTINCT event_timestamp) AS events_count
FROM cte
GROUP BY
  event_date,
  user_pseudo_id,
  session_start
ORDER BY
  event_date,
  user_pseudo_id;
