WITH 
  user_first_visit AS (
    SELECT 
      user_pseudo_id, 
      DATE_TRUNC(PARSE_DATE('%Y%m%d', MIN(event_date)), WEEK) AS first_visit_week 
    FROM turing_data_analytics.raw_events 
    
    GROUP BY user_pseudo_id
  ), --identifying week of each user's first visit. Grouping by IDs to make sure only unique IDs left

  user_revenue_by_week AS (
    SELECT 
      user_pseudo_id,
      DATE_TRUNC(PARSE_DATE('%Y%m%d', event_date), WEEK) AS week,
      SUM(purchase_revenue_in_usd) AS revenue
    FROM 
      turing_data_analytics.raw_events
    WHERE 
      user_pseudo_id IN (
        SELECT user_pseudo_id 
        FROM user_first_visit
      )
    GROUP BY 
      user_pseudo_id, week
  ) --  aggregating revenue data for each user and week

SELECT 
  u.first_visit_week,
  COUNT(DISTINCT user_revenue_by_week.user_pseudo_id) AS ids_registered,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 0 THEN revenue ELSE 0 END) AS week0,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 1 THEN revenue ELSE 0 END) AS week1,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 2 THEN revenue ELSE 0 END) AS week2,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 3 THEN revenue ELSE 0 END) AS week3,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 4 THEN revenue ELSE 0 END) AS week4,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 5 THEN revenue ELSE 0 END) AS week5,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 6 THEN revenue ELSE 0 END) AS week6,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 7 THEN revenue ELSE 0 END) AS week7,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 8 THEN revenue ELSE 0 END) AS week8,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 9 THEN revenue ELSE 0 END) AS week9,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 10 THEN revenue ELSE 0 END) AS week10,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 11 THEN revenue ELSE 0 END) AS week11,
  SUM(CASE WHEN DATE_DIFF(week, u.first_visit_week, WEEK) = 12 THEN revenue ELSE 0 END) AS week12
  -- revenue data broken down by the week since user's first visit
FROM 
  user_first_visit u 
JOIN 
  user_revenue_by_week 
  ON user_revenue_by_week.user_pseudo_id = u.user_pseudo_id
GROUP BY 
  u.first_visit_week
ORDER BY 
  u.first_visit_week
