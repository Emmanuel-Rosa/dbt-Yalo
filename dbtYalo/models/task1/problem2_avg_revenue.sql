WITH total_revenues AS (  
  SELECT DISTINCT
    FORMAT_DATE('(%Y)%Q', DATE(date))                                        AS quarter
    ,county
    ,ROUND(SUM(sale_dollars),2) AS total_revenue
  FROM {{ source('yalo', 'iowa_liquor_sale')}}
  WHERE 1=1
    AND county IS NOT NULL
  GROUP BY 1,2
    ORDER BY 1,2
)
SELECT
  *
  ,CASE
    WHEN total_revenue > 100000 THEN 'Yes'
    ELSE 'No'
  END AS over_100k_avg_revenue
FROM total_revenues