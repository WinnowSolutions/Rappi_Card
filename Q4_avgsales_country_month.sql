---¿Cuál es el promedio de ventas por región o país durante el último trimestre del año 2023?

WITH SalesSummary AS (
    SELECT 
        R.continent,
        strftime('%Y-%m', S.formatted_date) AS year_month,
        SUM(S.quantity) AS total_quantity,
		ROUND(SUM(S.quantity) * P.unit_price, 2) AS total_Value
    FROM Sales AS S
   LEFT JOIN Products AS P ON P.id_product = S.id_product
    LEFT JOIN Customers AS C ON C.id_customer = S.id_customer
    LEFT JOIN Countries AS CN ON CN.id_country = C.id_country
    LEFT JOIN Order_status AS O ON O.id_status = S.id_status
    LEFT JOIN Regions AS R ON R.id_region = C.id_region
    WHERE O.description = 'Fulfilled'
    AND (strftime('%m', S.formatted_date) BETWEEN '10' AND '12')
    GROUP BY R.continent, strftime('%Y-%m', S.formatted_date)
)
SELECT 
    continent,
    Round(AVG(total_Value),2) AS average_sales_quantity
FROM SalesSummary
GROUP BY continent;