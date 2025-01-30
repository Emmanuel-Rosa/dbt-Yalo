SELECT DISTINCT
  -- invoice_and_item_number
  -- ,date
  store_number
  -- ,store_name
  ,address
  ,cln_city                                                     AS city
  ,zip_code
  ,store_location
  ,cln_county_number                                            AS county_number
  ,cln_county                                                   AS county
  -- ,category_id
  -- ,category_name
  -- ,flag_category
  -- ,cln_vendor_number
  -- ,cln_vendor_name
  -- ,cln_item_number
  -- ,item_description
  -- ,pack
  -- ,bottle_volume_ml
  -- ,cln_state_bottle_cost
  -- ,cln_state_bottle_retail
  -- ,bottles_sold
  -- ,cln_sale_dollars
  -- ,volume_sold_liters
  -- ,volume_sold_gallons
FROM {{ ref('bronze_sales') }}