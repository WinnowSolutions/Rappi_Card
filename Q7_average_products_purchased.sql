----¿Cuál es el promedio de cantidad de productos comprados por cliente?

SELECT 
    Round(AVG(total_quantity),2) AS average_products_purchased_per_customer
FROM (
    SELECT 
        C.id_customer,
        COUNT(S.id_sale) AS total_quantity
    FROM Sales AS S
    LEFT JOIN Customers AS C ON C.id_customer = S.id_customer
    GROUP BY C.id_customer
) AS PurchasesSummary;
---------------------------------------------------------------------
---Each customer
SELECT 
    C.id_customer,
    AVG(total_quantity) AS average_products_purchased
FROM (
    SELECT 
        S.id_customer,
        COUNT(S.id_sale) AS total_quantity
    FROM Sales AS S
    GROUP BY S.id_customer
) AS PurchasesSummary
LEFT JOIN Customers AS C ON C.id_customer = PurchasesSummary.id_customer
GROUP BY C.id_customer;
