SELECT 
  FORMAT_DATE('(%Y)%Q', DATE(date))                     AS quarter
  ,SUM(bottles_sold)                                    AS total_bottles
  ,ROUND(SUM(sale_dollars), 2)                          AS revenue
  ,ROUND((SUM(sale_dollars)/1000000), 2)                AS revenue_MM
FROM {{ source('yalo', 'iowa_liquor_sale')}}
GROUP BY 1
  ORDER BY 1 ASC