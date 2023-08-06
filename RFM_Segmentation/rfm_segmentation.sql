WITH rfm_values AS (
   SELECT CustomerID,
         TIMESTAMP_DIFF(TIMESTAMP('2011-12-02'), MAX(InvoiceDate), DAY) AS recency,
         COUNT(DISTINCT InvoiceNo) AS frequency,
         SUM(Quantity * UnitPrice) AS monetary
  FROM turing_data_analytics.rfm
  WHERE InvoiceDate BETWEEN '2010-11-30' AND '2011-12-02'
  AND REGEXP_CONTAINS(InvoiceNo, r'^[0-9]')

  GROUP BY CustomerID
),

rfm_quantiles AS (
SELECT
    a.*,
    --All percentiles for MONETARY
    b.percentiles[offset(25)] AS m25,
    b.percentiles[offset(50)] AS m50,
    b.percentiles[offset(75)] AS m75,
    b.percentiles[offset(100)] AS m100,
    --All percentiles for FREQUENCY
    c.percentiles[offset(25)] AS f25,
    c.percentiles[offset(50)] AS f50,
    c.percentiles[offset(75)] AS f75,
    c.percentiles[offset(100)] AS f100,
    --All percentiles for RECENCY
    d.percentiles[offset(25)] AS r25,
    d.percentiles[offset(50)] AS r50,
    d.percentiles[offset(75)] AS r75,
    d.percentiles[offset(100)] AS r100
FROM
    rfm_values a,
    (SELECT APPROX_QUANTILES(monetary, 100) percentiles FROM
    rfm_values) b,
    (SELECT APPROX_QUANTILES(frequency, 100) percentiles FROM
    rfm_values) c,
    (SELECT APPROX_QUANTILES(recency, 100) percentiles FROM
    rfm_values) d
),


rfm_scores AS (
    SELECT *,

    CONCAT(r_score, f_score, m_score) rfm_stnd_score,
    CAST(ROUND((r_score * 7.3 + f_score * 8.3  + m_score * 9.3), 0) AS INT) AS rfm_custom_score
    -- calculating custom RFM score. Score mix and max 25 - 100. Importance M > F > R
    FROM (
        SELECT *,
        CASE WHEN monetary <= m25 THEN 1
            WHEN monetary <= m50 AND monetary > m25 THEN 2
            WHEN monetary <= m75 AND monetary > m50 THEN 3
            WHEN monetary <= m100 AND monetary > m75 THEN 4
        END AS m_score,
        CASE WHEN frequency <= f25 THEN 1
            WHEN frequency <= f50 AND frequency > f25 THEN 2
            WHEN frequency <= f75 AND frequency > f50 THEN 3
            WHEN frequency <= f100 AND frequency > f75 THEN 4
        END AS f_score,
        --Recency scoring is reversed
        CASE WHEN recency <= r25 THEN 4
            WHEN recency <= r50 AND recency > r25 THEN 3
            WHEN recency <= r75 AND recency > r50 THEN 2
            WHEN recency <= r100 AND recency > r75 THEN 1
        END AS r_score,
        FROM rfm_quantiles
        )
),

customer_segments AS (
    SELECT
        CustomerID,
        recency,
        frequency,
        monetary,
        r_score,
        f_score,
        m_score,
        rfm_stnd_score,
        rfm_custom_score,
        CASE 

        WHEN r_score = 4 AND f_score = 4 AND m_score = 4         
        THEN 'Best Customers'
        WHEN r_score BETWEEN 2 AND 3 AND f_score BETWEEN 2 AND 4 AND m_score = 4
        THEN 'Big Spenders'
        WHEN r_score BETWEEN 3 AND 4 AND f_score BETWEEN 3 AND 4 AND m_score BETWEEN 1 AND 4 
        THEN 'Loyal Customers'
        WHEN (r_score = 2 AND f_score BETWEEN 1 AND 2 AND m_score BETWEEN 1 AND 3) OR rfm_stnd_score = '214'
        THEN 'Need Attention'
        WHEN (r_score = 4 AND f_score BETWEEN 1 AND 2 AND m_score BETWEEN 1 AND 4) OR rfm_stnd_score = '314'
        THEN 'New Customers'  
        WHEN r_score BETWEEN 2 AND 3 AND f_score BETWEEN 2 AND 3 AND m_score BETWEEN 2 AND 3 
        THEN 'Potential Loyalists'
        WHEN r_score = 1 AND f_score = 1 AND m_score BETWEEN 1 AND 4
        THEN 'Lost'
        WHEN r_score BETWEEN 1 AND 2 AND f_score BETWEEN 2 AND 4 AND m_score BETWEEN 1 AND 4
        THEN 'At Risk'
        WHEN (r_score = 3 AND f_score BETWEEN 1 AND 2 AND m_score BETWEEN 1 AND 2) OR rfm_stnd_score = '313'
        THEN 'Promising'

        END AS rfm_segment
    FROM rfm_scores
)

SELECT *
FROM customer_segments

ORDER BY r_score, f_score, m_score ASC
