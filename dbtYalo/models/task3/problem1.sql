
WITH sold_table AS (
  SELECT 
    customer_id
    ,purchase_timestamp
    ,CAST(REGEXP_REPLACE(CAST(purchase_timestamp AS STRING), ':| ', '') AS INTEGER)       AS time_int
    ,ROUND(SUM(number_items * purchase_price),2)                                          AS real_revenue
  FROM {{ source('yalo', 'test_order_details')}}
  WHERE item_status LIKE 'sold'
  GROUP BY 1,2
), orders_table AS (
  SELECT  
    customer_id                                                                          AS ord_customer_id
    ,purchase_date
    ,CAST(REGEXP_REPLACE(CAST(purchase_date AS STRING), ':|T|-| ', '') AS INTEGER)       AS ord_time_int
    ,purchase_revenue
  FROM {{ source('yalo', 'test_orders')}}
  ORDER BY 1,2
)
SELECT
  s.customer_id
  ,s.purchase_timestamp
  -- ,s.time_int
  ,s.real_revenue
  ,o.purchase_revenue
  ,CASE
    WHEN s.real_revenue - o.purchase_revenue <> 0 THEN 'wrong'
    ELSE 'ok'
  END                                                                                     AS valid_flag
  ,CASE
    WHEN s.real_revenue - o.purchase_revenue <> 0 THEN s.real_revenue - o.purchase_revenue
    ELSE NULL
  END                                                                                     AS diff_if_any
FROM sold_table s
LEFT JOIN orders_table o
  ON s.customer_id = o.ord_customer_id
  AND s.time_int = o.ord_time_int