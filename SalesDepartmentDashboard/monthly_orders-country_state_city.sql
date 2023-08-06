SELECT 
  DATE_TRUNC(OrderDate, MONTH) AS year_month,
  COUNT(OrderDate) total_orders,
  SUM(totaldue) total_revenue,
  province.name AS country_state_name,
  address.City,
  country.name country_name,
  
FROM `tc-da-1.adwentureworks_db.salesorderheader` as salesorderheader

JOIN `tc-da-1.adwentureworks_db.address` AS address
ON salesorderheader.ShipToAddressID = address.AddressID

JOIN `tc-da-1.adwentureworks_db.stateprovince` AS province
ON address.stateprovinceid = province.stateprovinceid

JOIN `tc-da-1.adwentureworks_db.countryregion` AS country
ON province.countryregioncode = country.countryregioncode

GROUP BY year_month, country_state_name, address.City, country_name;
