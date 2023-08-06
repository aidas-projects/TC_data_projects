SELECT 
  salesreason.name AS sale_reason,
  ROUND(AVG(TotalDue), 0) average_totaldue
  
FROM  
  tc-da-1.adwentureworks_db.salesorderheader AS sales

JOIN tc-da-1.adwentureworks_db.salesorderheadersalesreason AS sales_reason_id
ON sales.SalesOrderID = sales_reason_id.salesOrderID
 
JOIN tc-da-1.adwentureworks_db.salesreason 
ON  sales_reason_id.salesreasonid = salesreason.salesreasonid

GROUP BY sale_reason;
