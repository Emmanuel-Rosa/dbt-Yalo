SELECT
  invoice_and_item_number
  ,date
  ,store_number
  -- ,store_name
  -- ,address
  -- ,cln_city
  -- ,zip_code
  -- ,store_location
  -- ,cln_county_number
  -- ,cln_county
  ,category_pk
  -- ,category_name
  -- ,flag_category
  ,cln_vendor_number                                                    AS vendor_number
  -- ,cln_vendor_name
  ,cln_item_number                                                      AS item_number  
  -- ,item_description
  -- ,pack
  -- ,bottle_volume_ml
  -- ,cln_state_bottle_cost
  ,MAX(cln_state_bottle_retail) OVER(PARTITION BY cln_item_number)      AS state_bottle_retail
  ,bottles_sold
  ,cln_sale_dollars                                                     AS sale_dollars
  ,volume_sold_liters
  ,volume_sold_gallons
FROM {{ ref('bronze_sales') }}