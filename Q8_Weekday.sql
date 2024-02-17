------¿Existe alguna tendencia de ventas en función del día de la semana?

SELECT 
    STRFTIME('%w', S.formatted_date) AS weekday,
    CASE 
        WHEN STRFTIME('%w', S.formatted_date) = '1' THEN 'Lun'
        WHEN STRFTIME('%w', S.formatted_date) = '2' THEN 'Mar'
        WHEN STRFTIME('%w', S.formatted_date) = '3' THEN 'Mie'
        WHEN STRFTIME('%w', S.formatted_date) = '4' THEN 'Jue'
        WHEN STRFTIME('%w', S.formatted_date) = '5' THEN 'Vie'
        WHEN STRFTIME('%w', S.formatted_date) = '6' THEN 'Sab'
        WHEN STRFTIME('%w', S.formatted_date) = '0' THEN 'Dom'
    END AS day_of_week,
    AVG(S.quantity) AS average_quantity_sold
FROM Sales AS S
GROUP BY weekday
ORDER BY average_quantity_sold desc;

