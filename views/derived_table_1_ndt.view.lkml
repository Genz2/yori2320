# If necessary, uncomment the line below to include explore_source.
# include: "yori.model.lkml"

view: derived_table_1_ndt {
  derived_table: {
    explore_source: order_items {
      column: count { field: orders.count }
      column: count { field: users.count }
      column: id { field: users.id }
    }
  }
  measure: total_users_count {
    type: count
    label: "Total Users Count"
  }
  dimension: orders_count {
    description: ""
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: users_count {
    description: ""
    type: number
    sql: ${TABLE}.count0 ;;
  }
  dimension: id {
    description: ""
    type: number
  }
}
