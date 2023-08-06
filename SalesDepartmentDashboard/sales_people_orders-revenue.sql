SELECT 
  contact.firstname AS sales_person,
  COUNT(sales_table.orderdate) AS total_orders,
  SUM(sales_table.totaldue) AS total_revenue,
  TIMESTAMP_DIFF(TIMESTAMP(employee.ModifiedDate), TIMESTAMP(employee.hiredate), DAY)/7*5*8 - employee.VacationHours - employee.SickLeaveHours
  AS total_working_hours,
  
FROM 
  tc-da-1.adwentureworks_db.salesperson
  JOIN tc-da-1.adwentureworks_db.employee ON salesperson.salespersonid = employee.employeeid
  JOIN tc-da-1.adwentureworks_db.contact ON employee.contactid = contact.contactid
  JOIN tc-da-1.adwentureworks_db.salesorderheader sales_table ON salesperson.salespersonid = sales_table.salespersonid
GROUP BY 
  sales_person,
  total_working_hours
  
