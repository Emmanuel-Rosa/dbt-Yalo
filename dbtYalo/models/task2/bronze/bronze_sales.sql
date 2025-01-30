WITH sales AS (
  WITH fixed_columns AS (
    SELECT
      * EXCEPT(city)
      ,CASE 
        WHEN TRIM(UPPER(city)) LIKE 'ARNOLDS PARK' THEN "ARNOLD'S PARK"
        WHEN TRIM(UPPER(city)) LIKE 'CLEARLAKE' THEN 'CLEAR LAKE'
        WHEN TRIM(UPPER(city)) LIKE 'GRAND MOUNDS' THEN 'GRAND MOUND'
        WHEN TRIM(UPPER(city)) LIKE 'GUTTENBURG' THEN 'GUTTENBERG'
        WHEN TRIM(UPPER(city)) LIKE 'LONETREE' THEN 'LONE TREE'
        WHEN TRIM(UPPER(city)) LIKE 'OTTUWMA' THEN 'OTTUMWA'
        WHEN TRIM(UPPER(city)) LIKE 'OTUMWA' THEN 'OTTUMWA'
        WHEN TRIM(UPPER(city)) LIKE 'PLEASANT VALLEY' THEN 'PLEASANTVILLE'
        ELSE TRIM(UPPER(city))
      END                                                                                                                      AS fixed_city
      ,COALESCE(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER)), 'UNDEFINED')                 AS fixed_category_name
      ,CASE
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%vodka%' THEN 'VODKA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%belvedere%' THEN 'VODKA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%stolichnaya%' THEN 'VODKA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%schnapps%' THEN 'SCHNAPPS'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE 'rum %' THEN 'RUM'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '% rum' THEN 'RUM'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%tequila%' THEN 'TEQUILA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%mezcal%' THEN 'TEQUILA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%cuervo%' THEN 'TEQUILA'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE 'gin %' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '% gin' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE 'gins %' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '% gins' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%bombay%' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%beefeater%' THEN 'GIN'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%whisk%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%chivas regal%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%single malt%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%glenlivet%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%white dog%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%jack daniel%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%craigellachie%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%black velvet%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE 'ha %' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%scotch%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%bourbon%' THEN 'WHISKY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%brandy%' THEN 'BRANDY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%brandies%' THEN 'BRANDY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%liqueur%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%cordial%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%creme%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%triple%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%anisette%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%amaretto%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE 'spirit %' THEN 'SPIRIT'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE ' spirit%' THEN 'SPIRIT'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%cocktail%' THEN 'COCKTAIL'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%rock%' THEN 'COCKTAIL'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%beer%' THEN 'BEER'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%bacardi%' THEN 'RUM'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%dark rum%' THEN 'RUM'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%hennessy%' THEN 'BRANDY'
        WHEN LOWER(MAX(category_name) OVER(PARTITION BY CAST(CAST(category AS FLOAT64) AS INTEGER))) LIKE '%cocoyac%' THEN 'LIQUEUR'
        ELSE CASE 
          WHEN LOWER(item_description) LIKE '%vodka%' THEN 'VODKA'
          WHEN LOWER(item_description) LIKE '%belvedere%' THEN 'VODKA'
          WHEN LOWER(item_description) LIKE '%stolichnaya%' THEN 'VODKA'
          WHEN LOWER(item_description) LIKE '%schnapps%' THEN 'SCHNAPPS'
          WHEN LOWER(item_description) LIKE 'rum %' THEN 'RUM'
          WHEN LOWER(item_description) LIKE '% rum' THEN 'RUM'
          WHEN LOWER(item_description) LIKE '%tequila%' AND LOWER(item_description) NOT LIKE '%tequila cask%' THEN 'TEQUILA'
          WHEN LOWER(item_description) LIKE '%mezcal%' THEN 'TEQUILA'
          WHEN LOWER(item_description) LIKE '%cuervo%' THEN 'TEQUILA'
          WHEN LOWER(item_description) LIKE 'gin %' THEN 'GIN'
          WHEN LOWER(item_description) LIKE '% gin' THEN 'GIN'
          WHEN LOWER(item_description) LIKE 'gins %' THEN 'GIN'
          WHEN LOWER(item_description) LIKE '% gins' THEN 'GIN'
          WHEN LOWER(item_description) LIKE '%bombay%' THEN 'GIN'
          WHEN LOWER(item_description) LIKE '%beefeater%' THEN 'GIN'
          WHEN LOWER(item_description) LIKE '%whisk%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%chivas regal%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%single malt%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%glenlivet%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%white dog%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%jack daniel%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%craigellachie%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%black velvet%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE 'ha %' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%scotch%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%bourbon%' THEN 'WHISKY'
          WHEN LOWER(item_description) LIKE '%brandy%' THEN 'BRANDY'
          WHEN LOWER(item_description) LIKE '%brandies%' THEN 'BRANDY'
          WHEN LOWER(item_description) LIKE '%liqueur%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE '%cordial%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE '%creme%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE '%triple%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE '%anisette%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE '%amaretto%' THEN 'LIQUEUR'
          WHEN LOWER(item_description) LIKE 'spirit %' THEN 'SPIRIT'
          WHEN LOWER(item_description) LIKE ' spirit%' THEN 'SPIRIT'
          WHEN LOWER(item_description) LIKE '%cocktail%' THEN 'COCKTAIL'
          WHEN LOWER(item_description) LIKE '%rock%' THEN 'COCKTAIL'
          WHEN LOWER(item_description) LIKE '%beer%' THEN 'BEER'
          WHEN LOWER(item_description) LIKE '%bacardi%' THEN 'RUM'
          WHEN LOWER(item_description) LIKE '%dark rum%' THEN 'RUM'
          WHEN LOWER(item_description) LIKE '%hennessy%' THEN 'BRANDY'
          WHEN LOWER(item_description) LIKE '%cocoyac%' THEN 'LIQUEUR'
          ELSE 'OTHER'
        END                                                                                                         
      END                                                                                                                 AS new_category_name

    FROM `yalo-ae-case.yalo_raw.iowa_liquor_sale`
    WHERE city NOT LIKE '%COLORADO SPRINGS%'
  ), cln_columns AS (
    SELECT
      * EXCEPT(fixed_city, category)                                                             
      ,CASE 
        WHEN fixed_city IS NULL THEN CASE
          WHEN store_name LIKE '%/%' THEN CASE
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%ANITIA%' THEN 'ANITA'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE 'DENV' THEN 'DENVER'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%HUMBOLT%' THEN 'HUMBOLDT'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE 'HUMEST' THEN 'HUMESTON'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE 'MARSHA' THEN 'MARSHALLTOWN'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%MISSOURI VALEY%' THEN 'MISSOURI VALLEY'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%URBAND%' THEN 'URBANDALE'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%WDS%' THEN 'WEST DES MOINES'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%WEST DSM%' THEN 'WEST DES MOINES'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%WEST U%' THEN 'WEST UNION'
            WHEN TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)])) LIKE '%LAFAYETTE%' THEN 'FAYETTE'
            ELSE TRIM(UPPER(SPLIT(store_name, '/')[OFFSET(1)]))
          END
          ELSE NULL
        END
        ELSE fixed_city
      END                                                                                                               AS cln_city
      ,CAST(CAST(category AS FLOAT64) AS INTEGER)                                                                       AS category_id
      ,CASE
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%vodka%' THEN 'VODKA'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%schnapps%' THEN 'SCHNAPPS'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%rum%' THEN 'RUM'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%tequila%' 
          AND LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) NOT LIKE '%tequila cask%'  THEN 'TEQUILA'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%mezcal%' THEN 'TEQUILA'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%gin%' THEN 'GIN'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%whisk%' THEN 'WHISKY'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%scotch%' THEN 'WHISKY'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%bourbon%' THEN 'WHISKY'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%brand%' THEN 'BRANDY'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%brandy%' THEN 'BRANDY'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%liqueur%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%cordial%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%creme%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%triple%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%anisette%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%amaretto%' THEN 'LIQUEUR'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%spirit%' THEN 'SPIRIT'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%cocktail%' THEN 'COCKTAIL'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%rock%' THEN 'COCKTAIL'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%beer%' THEN 'BEER'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%special%' THEN 'MISC'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%american alcohol%' THEN 'MISC'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%delisted%' THEN 'MISC'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%holiday%' THEN 'MISC'
        WHEN LOWER(MAX(new_category_name) OVER(PARTITION BY item_description)) LIKE '%iowa%' THEN 'MISC'
        ELSE UPPER(MAX(new_category_name) OVER(PARTITION BY item_description))
      END                                                                                                               AS flag_category
    FROM fixed_columns
    
  )
  SELECT
    * EXCEPT(county, vendor_number, vendor_name, item_number)
    ,MAX(county) OVER(PARTITION BY cln_city)                                                                            AS cln_county  
    ,CASE
        WHEN vendor_name IS NULL THEN MAX(vendor_name) OVER(PARTITION BY item_description)
        ELSE vendor_name
      END                                                                                                               AS cln_vendor_name
    ,CAST(CAST(CASE
      WHEN vendor_name LIKE '%RESERVOIR DISTILLERY%' THEN '9999'
      WHEN vendor_number IS NULL THEN MAX(vendor_number) OVER(PARTITION BY item_description)
      ELSE vendor_number
    END AS FLOAT64) AS INTEGER)                                                                                         AS cln_vendor_number
    ,CAST(CAST(REPLACE(item_number, 'x', '') AS FLOAT64) AS INTEGER)                                                    AS cln_item_number
  FROM cln_columns
)
SELECT
  invoice_and_item_number
  ,date
  ,store_number
  ,store_name
  ,COALESCE(address, 'UNDEFINED')                                                                                                         AS address
  ,COALESCE(cln_city, 'UNDEFINED')                                                                                                        AS cln_city
  ,COALESCE(zip_code, '0')                                                                                                                AS zip_code
  ,ST_AsText(COALESCE(store_location, ST_GEOGPOINT(0.0, 0.0)))                                                                            AS store_location 
  ,COALESCE(CAST(CAST(MAX(county_number) OVER(PARTITION BY cln_county) AS FLOAT64) AS INTEGER), 0)                                        AS cln_county_number
  ,COALESCE(cln_county, 'UNDEFINED')                                                                                                      AS cln_county
  ,CONCAT(CAST(COALESCE(category_id, 9) AS STRING), '-', CAST(fixed_category_name AS STRING), '-', CAST(flag_category AS STRING))         AS category_pk
  ,COALESCE(category_id, 9)                                                                                                               AS category_id
  ,fixed_category_name                                                                                                                    AS category_name                                                                                                         
  ,flag_category                  
  ,COALESCE(cln_vendor_number, 0)                                                                                                         AS cln_vendor_number
  ,COALESCE(cln_vendor_name, 'UNDEFINED')                                                                                                 AS cln_vendor_name
  ,cln_item_number
  ,item_description
  ,pack
  ,bottle_volume_ml
  ,CASE 
    WHEN item_description LIKE '%TITOS HANDMADE MINI%' THEN 12.8
    WHEN item_description LIKE '%PEARL WEDDING CAKE VODKA MINI%' THEN 5.0
    ELSE state_bottle_cost
  END                                                                                                                    AS cln_state_bottle_cost
  ,CASE 
    WHEN item_description LIKE '%TITOS HANDMADE MINI%' THEN 19.2
    WHEN item_description LIKE '%PEARL WEDDING CAKE VODKA MINI%' THEN 7.5
    ELSE state_bottle_retail
  END                                                                                                                    AS cln_state_bottle_retail
  ,bottles_sold
  ,CASE 
    WHEN item_description LIKE '%TITOS HANDMADE MINI%' THEN 19.2 * bottles_sold
    WHEN item_description LIKE '%PEARL WEDDING CAKE VODKA MINI%' THEN 7.5 * bottles_sold
    ELSE sale_dollars
  END                                                                                                                    AS cln_sale_dollars
  ,volume_sold_liters
  ,volume_sold_gallons
  
FROM sales