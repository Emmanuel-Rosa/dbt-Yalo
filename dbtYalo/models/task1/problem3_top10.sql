WITH ranked_sales AS (  
  SELECT 
    CAST(CAST(vendor_number AS FLOAT64) AS INTEGER)                               AS vendor_number
    ,MAX(vendor_name)                                                             AS vendor_name
    ,ROUND(SUM(sale_dollars),2)                                                   AS total_sales
    ,DENSE_RANK() OVER(ORDER BY ROUND(SUM(sale_dollars),2) DESC)                  AS rank
  FROM {{ source('yalo', 'iowa_liquor_sale')}}
  WHERE 1=1
    AND vendor_number IS NOT NULL
  GROUP BY 1
    ORDER BY 4 ASC
)
SELECT
  *
FROM ranked_sales
WHERE 1=1
  AND rank <= 10