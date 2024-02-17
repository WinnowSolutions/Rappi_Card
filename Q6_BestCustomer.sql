----¿Cuál es el cliente con más compras durante el último trimestre del año 2023?

WITH PurchasesSummary AS (
    SELECT 
        C.id_customer,
        C.customer_name,
        COUNT(S.id_sale) AS total_purchases
    FROM Sales AS S
    LEFT JOIN Customers AS C ON C.id_customer = S.id_customer
    WHERE strftime('%Y', S.formatted_date) = '2023'
    AND (strftime('%m', S.formatted_date) = '10'
    OR strftime('%m', S.formatted_date) = '11' 
    OR strftime('%m', S.formatted_date) = '12')
    GROUP BY C.id_customer,C.customer_name
)
SELECT 
    id_customer,
    customer_name,
    total_purchases
FROM PurchasesSummary
ORDER BY total_purchases DESC
LIMIT 1;