SELECT
  DATE_TRUNC(OrderDate, MONTH) AS year_month,
  REPLACE(reason.Name, 'Television  Advertisement', 'TV ads') AS sales_reason,
  SUM(sales.TotalDue) AS sales_amount

FROM
tc-da-1.adwentureworks_db.salesorderheader AS sales
JOIN
tc-da-1.adwentureworks_db.salesorderheadersalesreason AS sales_reason
ON
sales.SalesOrderID = sales_reason.salesOrderID
LEFT JOIN
tc-da-1.adwentureworks_db.salesreason AS reason
ON
sales_reason.SalesReasonID = reason.SalesReasonID

GROUP BY year_month, sales_reason
