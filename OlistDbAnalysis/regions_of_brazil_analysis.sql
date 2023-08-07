SELECT
    CASE c.customer_state
        WHEN 'AP' THEN 'Amapá'
        WHEN 'AM' THEN 'Amazonas'
        WHEN 'PR' THEN 'Paraná'
        WHEN 'SP' THEN 'São Paulo'
        WHEN 'MG' THEN 'Minas Gerais'
        WHEN 'RS' THEN 'Rio Grande do Sul'
        WHEN 'MS' THEN 'Mato Grosso do Sul'
        WHEN 'RN' THEN 'Rio Grande do Norte'
        WHEN 'MT' THEN 'Mato Grosso'
        WHEN 'TO' THEN 'Tocantins'
        WHEN 'SC' THEN 'Santa Catarina'
        WHEN 'DF' THEN 'Federal District (Distrito Federal)'
        WHEN 'RO' THEN 'Rondônia'
        WHEN 'AC' THEN 'Acre'
        WHEN 'GO' THEN 'Goiás'
        WHEN 'ES' THEN 'Espírito Santo'
        WHEN 'PB' THEN 'Paraíba'
        WHEN 'PE' THEN 'Pernambuco'
        WHEN 'PI' THEN 'Piauí'
        WHEN 'RJ' THEN 'Rio de Janeiro'
        WHEN 'BA' THEN 'Bahia'
        WHEN 'CE' THEN 'Ceará'
        WHEN 'PA' THEN 'Pará'
        WHEN 'SE' THEN 'Sergipe'
        WHEN 'MA' THEN 'Maranhão'
        WHEN 'AL' THEN 'Alagoas'
        WHEN 'RR' THEN 'Roraima'
    END AS state, -- Rename customer_state values to corresponding state names
    AVG(r.review_score) AS average_review_score, -- Calculate average review score
    COUNT(CASE WHEN r.review_score >= 4 THEN 1 END) AS positive_review_count, -- Count positive reviews (4 or 5 ratings)
    COUNT(CASE WHEN r.review_score <= 3 THEN 1 END) AS negative_review_count, -- Count negative reviews (1 to 3 ratings)
    COUNT(CASE WHEN r.review_score >= 4 THEN 1 END) / COUNT(*) * 100 AS percentage_positive_reviews, -- Calculate percentage of positive reviews
    COUNT(CASE WHEN r.review_score <= 3 THEN 1 END) / COUNT(*) * 100 AS percentage_negative_reviews, -- Calculate percentage of negative reviews
    SUM(op.payment_value) AS total_revenue -- Calculate total revenue
FROM
    olist_db.olist_customesr_dataset AS c
JOIN
    olist_db.olist_orders_dataset AS o ON c.customer_id = o.customer_id
JOIN
    olist_db.olist_order_reviews_dataset AS r ON o.order_id = r.order_id
JOIN
    olist_db.olist_order_payments_dataset AS op ON o.order_id = op.order_id
WHERE
    r.review_score IS NOT NULL 
GROUP BY
    c.customer_state 
ORDER BY
    average_review_score DESC; 
