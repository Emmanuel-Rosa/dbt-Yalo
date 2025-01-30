view: item_dim {
  sql_table_name: `yalo-ae-case.yalo_task2.silver_item_dim` ;;

  dimension: item_number {
    sql: ${TABLE}.item_number ;;
    primary_key: yes
  }

  dimension: item_description {
    sql: ${TABLE}.item_description ;;
  }

  dimension: pack {
    sql: ${TABLE}.pack ;;
  }

  dimension: bottle_volume_ml {
    sql: ${TABLE}.bottle_volume_ml ;;
  }

  measure: state_bottle_cost {
    sql: ${TABLE}.state_bottle_cost ;;
    type: sum
  }

  measure: state_bottle_retail {
    sql: ${TABLE}.state_bottle_retail ;;
    type: sum
  }
}