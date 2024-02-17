---¿Cuál es el producto más vendido durante el último trimestre del año 2023?

WITH SalesSummary AS (
    SELECT 
        S.id_product,
        P.product_name,
        SUM(S.quantity) AS total_quantity,
        ROUND(SUM(S.quantity * P.unit_price), 2) AS total_sales_price
    FROM Sales AS S
    LEFT JOIN Products AS P ON P.id_product = S.id_product
    WHERE strftime('%Y', S.formatted_date) = '2023'
    AND (strftime('%m', S.formatted_date) = '10'
    OR strftime('%m', S.formatted_date) = '11' 
    OR strftime('%m', S.formatted_date) = '12')
    GROUP BY S.id_product,P.product_name
)
SELECT 
    id_product,
	product_name,
    total_quantity,
    total_sales_price
FROM SalesSummary
ORDER BY total_sales_price DESC
LIMIT 1
