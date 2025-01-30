view: store_dim {
  sql_table_name: `yalo-ae-case.yalo_task2.silver_store_dim` ;;

  dimension: store_number {
    sql: ${TABLE}.store_number ;;
    primary_key: yes
  }

  dimension: store_name {
    sql: ${TABLE}.store_name ;;
  }
}