SELECT
OrderDate,
CASE 
  WHEN  SalesPersonID IS NULL
  THEN 'Online'
  ELSE 'Offline'
  END AS order_type,
TotalDue

FROM adwentureworks_db.salesorderheader

ORDER BY OrderDate
