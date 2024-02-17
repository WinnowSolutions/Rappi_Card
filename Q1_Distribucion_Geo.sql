
--   ¿Cuál es la distribución geográfica de las ventas de productos Nike durante el último
--   trimestre del año 2023?




SELECT 
COUNT(DISTINCT S.id_sale) AS unique_sales_count
FROM Sales AS S 
WHERE strftime('%m', S.formatted_date) = '10' 
OR strftime('%m', S.formatted_date) = '11' 
OR strftime('%m', S.formatted_date) = '12'

------------------------------------------------

SELECT 
    CN.country,
    R.continent,
    COUNT(S.id_sale) AS total_sales,
    ROUND((COUNT(S.id_sale) / 300.0), 2) AS total_sales_percentage
FROM Sales AS S
LEFT JOIN Products AS P ON P.id_product = S.id_product
LEFT JOIN Customers AS C ON C.id_customer = S.id_customer
LEFT JOIN Countries AS CN ON CN.id_country = C.id_country
LEFT JOIN Order_status AS O ON O.id_status = S.id_status
LEFT JOIN Regions as R ON R.id_region = C.id_region
WHERE O.description = 'Fulfilled' 
AND (strftime('%m', S.formatted_date) = '10' 
OR strftime('%m', S.formatted_date) = '11' 
OR strftime('%m', S.formatted_date) = '12')
GROUP BY CN.country, R.continent;

---------------------------------------------------------------



