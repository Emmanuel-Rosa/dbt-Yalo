view: category_dim {
  sql_table_name: `yalo-ae-case.yalo_task2.silver_category_dim` ;;

  dimension: category_pk {
    sql: ${TABLE}.category_pk ;;
    primary_key: yes
  }

  dimension: category_id {
    sql: ${TABLE}.category_id ;;
  }

  dimension: category_name {
    sql: ${TABLE}.category_name ;;
  }

  dimension: flag_category {
    sql: ${TABLE}.flag_category ;;
  }
}