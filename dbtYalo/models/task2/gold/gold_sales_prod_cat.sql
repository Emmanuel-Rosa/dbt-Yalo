SELECT 
  f.invoice_and_item_number
  ,store_name
  ,flag_category
  ,item_description
  ,i.state_bottle_retail
  ,bottles_sold
  ,sale_dollars                                               AS wrong_sale
  ,ROUND(i.state_bottle_retail * bottles_sold, 2)             AS correct_sale 
FROM {{ ref('silver_sales_fact') }} f
LEFT JOIN {{ ref('silver_item_dim') }} i
  ON f.item_number = i.item_number
LEFT JOIN {{ ref('silver_store_dim') }} s
  ON f.store_number = s.store_number
LEFT JOIN {{ ref('silver_category_dim') }} c
  ON f.category_pk = c.category_pk

 
 
 
 