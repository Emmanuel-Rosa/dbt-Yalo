WITH sold_value AS (  
  SELECT DISTINCT
    customer_id
    ,ROUND(SUM(number_items * purchase_price) OVER(PARTITION BY customer_id, item_status), 2)     AS sold
  FROM {{ source('yalo', 'test_order_details')}}
  WHERE item_status = 'sold'
), returned_value AS (  
  SELECT DISTINCT
    customer_id
    ,ROUND(SUM(number_items * purchase_price) OVER(PARTITION BY customer_id, item_status), 2)     AS returned
  FROM {{ source('yalo', 'test_order_details')}}
  WHERE item_status = 'returned'
)
SELECT
  s.customer_id
  ,r.returned
  ,s.sold                                             AS original_revenue
  ,ROUND(returned + sold, 2)                          AS would_make_revenue
  ,ROUND((returned/sold) * 100, 2)                    AS percent_increase
FROM sold_value s
LEFT JOIN returned_value r
  ON s.customer_id = r.customer_id
  ORDER BY 1
