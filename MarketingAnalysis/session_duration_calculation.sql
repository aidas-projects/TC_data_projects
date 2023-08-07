WITH cte AS (
  SELECT
    event_date,
    event_timestamp,
    event_name,
    user_pseudo_id,
    /* Calculates the session start time for each user_pseudo_id. 
    It checks if there is a specific event called 'session_start', and if not, it uses the earliest event timestamp within the user's events as the session start time. */
    COALESCE(MAX(CASE WHEN event_name = 'session_start' THEN event_timestamp END) 
      OVER (PARTITION BY user_pseudo_id ORDER BY event_timestamp ASC), 
      MIN(event_timestamp) OVER (PARTITION BY user_pseudo_id)) 
      AS session_start,
    campaign
  FROM
    turing_data_analytics.raw_events
)
SELECT
  -- converting the event_date to a proper date format
  PARSE_DATE('%Y%m%d', event_date) AS event_date,
  user_pseudo_id,
  session_start,
  -- Find the maximum event_timestamp as session_end
  MAX(event_timestamp) AS session_end,
  -- Calculate session duration in seconds
  (MAX(event_timestamp) - session_start) / 1000000 AS session_duration_in_sec,
  /* assigning campaign value to session. Results in final table are not displayed correctly if MAX function is not used. 
  because null values treated as separate campaign. MAX in text pick acording to lexicographic order */
  MAX(campaign) AS campaign,
  -- counting distinct event_timestamp values. Used to evaluate how much activity was happening during session.
  COUNT(DISTINCT event_timestamp) AS events_count,
  -- events per minute calculation + DIV 0 solution.
  CASE
    WHEN ((MAX(event_timestamp) - session_start)) = 0 THEN 0
    ELSE COUNT(DISTINCT event_timestamp) / ((MAX(event_timestamp) - session_start) / 1000000 / 60)
  END AS events_per_min
FROM cte
GROUP BY
  event_date,
  user_pseudo_id,
  session_start
ORDER BY
  events_per_min DESC,
  event_date,
  user_pseudo_id;
