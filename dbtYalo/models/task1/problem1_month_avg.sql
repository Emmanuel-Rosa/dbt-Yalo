WITH revenue_summary AS (
  SELECT 
    FORMAT_DATE('%Y%m', DATE(date))                                           AS yr_mo
    ,FORMAT_DATE('(%Y)%Q', DATE(date))                                        AS quarter
    ,SUM(bottles_sold)                                                        AS total_bottles
    ,ROUND(SUM(sale_dollars), 2)                                              AS revenue
  FROM {{ source('yalo', 'iowa_liquor_sale')}}
  GROUP BY 1, 2
    ORDER BY 2, 1 ASC
), averages AS (
  SELECT
    *
    ,ROUND(AVG(revenue) OVER(PARTITION BY quarter),2)                         AS qtr_avg
    ,(SELECT ROUND(AVG(revenue),2) FROM revenue_summary)                      AS avg
  FROM revenue_summary
)
SELECT
  *
  ,CASE
    WHEN revenue <= qtr_avg * 1.1 THEN 'No'
    ELSE 'Yes'
  END                                                                         AS above_10pcent_qtr_avg
  ,CASE
    WHEN revenue <= avg * 1.1 THEN 'No'
    ELSE 'Yes'
  END                                                                         AS above_10pcent_total_avg
FROM averages
  ORDER BY 1 ASC
