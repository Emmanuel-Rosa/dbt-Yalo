SELECT
  invoice_and_item_number
  ,FORMAT_DATE('(%Y)%Q', DATE(date))                                        AS quarter
  ,county
  ,sale_dollars
FROM {{ source('yalo', 'iowa_liquor_sale')}}
WHERE 1=1
  AND county IS NOT NULL
  AND sale_dollars > 100000
  ORDER BY 2,3