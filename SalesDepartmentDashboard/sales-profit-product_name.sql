SELECT
  OrderDate,
  CASE 
  WHEN  SalesPersonID IS NULL
  THEN 'Online'
  ELSE 'Offline'
  END AS order_type,
  reason.Name AS sales_reason,
  sales.salesorderid,
  salesorderdetail.orderqty,
  sales.TotalDue,
  sales.SubTotal,
  salesorderdetail.linetotal,
  salesorderdetail.unitprice,
  product.standardcost,
  (salesorderdetail.linetotal - product.standardcost*salesorderdetail.orderqty) AS profit,
  REGEXP_REPLACE(product.name, ',.*', '') AS product_name
  
FROM
tc-da-1.adwentureworks_db.salesorderheader AS sales
  
LEFT JOIN
tc-da-1.adwentureworks_db.salesorderheadersalesreason AS sales_reason
ON sales.SalesOrderID = sales_reason.salesOrderID
  
LEFT JOIN
tc-da-1.adwentureworks_db.salesreason AS reason
ON sales_reason.SalesReasonID = reason.SalesReasonID

LEFT JOIN
tc-da-1.adwentureworks_db.salesorderdetail
ON sales.salesorderid = salesorderdetail.salesorderid

LEFT JOIN tc-da-1.adwentureworks_db.product
ON salesorderdetail.productid = product.productid

LEFT JOIN tc-da-1.adwentureworks_db.specialoffer
ON salesorderdetail.specialofferid = specialoffer.specialofferid

ORDER BY OrderDate, salesorderid

