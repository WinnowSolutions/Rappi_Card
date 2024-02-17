--Date corrections for Sales and Customers:

-- Sales corrections:
SELECT 
    SUBSTR(date_sale,-4) AS year_part,
    SUBSTR(date_sale,1,2) AS day,
    SUBSTR(SUBSTR(date_sale,1,5),-2) AS month,
    Date(SUBSTR(date_sale,-4) || "-" || SUBSTR(SUBSTR(date_sale,1,5),-2) || "-" || SUBSTR(date_sale,1,2)) AS formatted_date
FROM Sales
order by formatted_date;


ALTER TABLE Sales ADD COLUMN formatted_date DATE;
UPDATE Sales 
SET formatted_date = Date(
    SUBSTR(date_sale,-4) || "-" || 
    SUBSTR(SUBSTR(date_sale,1,5),-2) || "-" || 
    SUBSTR(date_sale,1,2)
);

-- Customers Date Correction:

ALTER TABLE Customers ADD COLUMN formatted_date_creation DATE;
WITH A AS (
    SELECT     
        SUBSTR(date_creation, 1, 4) AS year_part,
        CASE
            WHEN SUBSTR(SUBSTR(date_creation, -2),1,1) = "-" THEN '0' || SUBSTR(date_creation, -1)
            ELSE SUBSTR(date_creation, -2)
        END AS day,
        CASE
            WHEN SUBSTR(SUBSTR(SUBSTR(date_creation, -5),1, 2),1,1) = "-" THEN SUBSTR(SUBSTR(date_creation, -5),2,2)
            ELSE SUBSTR(SUBSTR(date_creation, -5),1, 2)
        END AS MONTH,
        *
    FROM Customers
)
UPDATE Customers 
SET formatted_date_creation = (
    SELECT date(year_part || '-' || month || '-' || day)
    FROM A
    WHERE Customers.id_customer = A.id_customer
);



Select *
from Customers