---¿Qué porcentaje de las ventas se ve afectado por aquellas órdenes devueltas y canceladas?


WITH TotalSales AS (
    SELECT COUNT(*) AS total_sales
    FROM Sales
),
ReturnedOrCancelled AS (
    SELECT COUNT(*) AS total_returned_or_cancelled
    FROM Sales
    WHERE id_status IN (
        SELECT id_status FROM Order_status WHERE description IN ('Returned', 'Cancelled')
    )
)
SELECT 
    (CAST(roc.total_returned_or_cancelled AS REAL) / ts.total_sales) * 100 AS percentage_affected
FROM TotalSales ts, ReturnedOrCancelled roc;
