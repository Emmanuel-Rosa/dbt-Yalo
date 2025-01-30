view: sales_fact {
  sql_table_name: `yalo-ae-case.yalo_task2.silver_sales_fact` ;;

  dimension: invoice_and_item_number {
    sql: ${TABLE}.invoice_and_item_number ;;
    description: "Primary Key: Unique identifier for invoices"
    primary_key: yes
  }

  dimension: date {
    sql: ${TABLE}.date ;;
    description: "Natural Key: Unique identifier for dates"
  }

  dimension: store_name {
    sql: ${TABLE}.store_name ;;
    description: "Natural Key: Unique identifier for stores"
  }

  dimension: category_pk {
    sql: ${TABLE}.category_pk ;;
    description: "Natural Key: Unique identifier for categories"
  }

  dimension: vendor_number {
    sql: ${TABLE}.vendor_number ;;
    description: "Natural Key: Unique identifier for vendors"
  }

  dimension: item_number {
    sql: ${TABLE}.item_number ;;
    description: "Natural Key: Unique identifier for items"
  }

  measure: state_bottle_retail {
    sql: ${TABLE}.state_bottle_retail ;;
    type: sum
  }

  measure: bottles_sold {
    sql: ${TABLE}.bottles_sold ;;
    type: sum
  }

  measure: sale_dollars {
    sql: ${TABLE}.sale_dollars ;;
    type: sum
  }

  measure: volume_sold_liters {
    sql: ${TABLE}.volume_sold_liters ;;
    type: sum
  }

  measure: volume_sold_gallons {
    sql: ${TABLE}.volume_sold_gallons ;;
    type: sum
  }

  measure: correct_sale {
    sql: ROUND(${TABLE}.state_bottle_retail * ${TABLE}.bottles_sold, 2) ;;
    type: sum
  }

  measure: average_correct_sale {
    sql: ROUND(AVG(ROUND(${TABLE}.state_bottle_retail * ${TABLE}.bottles_sold, 2)), 2) ;;
    type: average
  }
}