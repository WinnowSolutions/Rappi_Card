---¿Cuál es el cliente con más compras por país y por mes en el 2023?

WITH SalesSummary AS (
    SELECT 
        CAST(strftime('%m', S.formatted_date) AS INTEGER) AS month_number,
        CN.country,
        S.id_customer,
        ROUND(SUM(S.quantity) * P.unit_price, 2) AS total_Value,
        ROW_NUMBER() OVER (PARTITION BY CN.country, CAST(strftime('%m', S.formatted_date) AS INTEGER) ORDER BY ROUND(SUM(S.quantity) * P.unit_price, 2) DESC) AS product_rank
    FROM Sales AS S
    LEFT JOIN Products AS P ON P.id_product = S.id_product
    LEFT JOIN Customers AS C ON C.id_customer = S.id_customer
    LEFT JOIN Countries AS CN ON CN.id_country = C.id_country
    LEFT JOIN Order_status AS O ON O.id_status = S.id_status
    LEFT JOIN Regions AS R ON R.id_region = C.id_region
    WHERE O.description = 'Fulfilled' 
    AND (strftime('%m', S.formatted_date) = '10'
    OR strftime('%m', S.formatted_date) = '11' 
    OR strftime('%m', S.formatted_date) = '12')
    GROUP BY month_number, CN.country, S.id_customer
)
SELECT 
    month_number,
    country,
    id_customer,
    total_Value    
FROM SalesSummary
WHERE product_rank = 1
ORDER BY country, month_number;
