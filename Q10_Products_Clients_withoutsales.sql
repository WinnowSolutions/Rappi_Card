----¿Cuántos productos y clientes no han tenido durante el último trimestre del año 2023?

WITH Total_products AS (
    SELECT 
        COUNT(DISTINCT id_product) AS total_products,
        2023 AS Year
    FROM products
), 
Total_clients AS (
    SELECT 
        COUNT(DISTINCT id_customer) AS total_clients,
        2023 AS Year
    FROM customers
)
SELECT 
    (SELECT total_products FROM Total_products) - (SELECT COUNT(DISTINCT id_product) FROM Sales) AS Products_without_sale,
    (SELECT total_clients FROM Total_clients) - (SELECT COUNT(DISTINCT id_customer) FROM Sales) AS Clients_without_sale;
