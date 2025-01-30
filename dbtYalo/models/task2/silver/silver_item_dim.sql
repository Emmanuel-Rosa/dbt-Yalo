SELECT DISTINCT
  -- invoice_and_item_number
  -- ,date
  -- ,store_number
  -- ,store_name
  -- ,address
  -- ,cln_city
  -- ,zip_code
  -- ,store_location
  -- ,cln_county_number
  -- ,cln_county
  -- ,category_id
  -- ,category_name
  -- ,flag_category
  -- ,cln_vendor_number
  -- ,cln_vendor_name
  cln_item_number                           AS item_number
  ,MAX(item_description)                    AS item_description
  ,MAX(pack)                                AS pack
  ,MAX(bottle_volume_ml)                    AS bottle_volume_ml
  ,MAX(cln_state_bottle_cost)               AS state_bottle_cost
  ,MAX(cln_state_bottle_retail)             AS state_bottle_retail
  -- ,bottles_sold
  -- ,cln_sale_dollars
  -- ,volume_sold_liters
  -- ,volume_sold_gallons
FROM {{ ref('bronze_sales') }}
GROUP BY 1