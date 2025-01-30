explore: sales {
  join: item_dim {
    sql_on: ${sales_fact.item_number} = ${item_dim.item_number} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: store_dim {
    sql_on: ${sales_fact.store_number} = ${store_dim.store_number} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: category_dim {
    sql_on: ${sales_fact.category_pk} = ${category_dim.category_pk} ;;
    type: left_outer
    relationship: many_to_one
  }
}