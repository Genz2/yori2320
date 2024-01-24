# If necessary, uncomment the line below to include explore_source.
# include: "yori.model.lkml"

view: orders_details_summary {
  derived_table: {
    explore_source: order_items {
      column: order_id {}
      column: total_revenue {}
      column: count {}
      column: user_id { field: orders.user_id }
    }
    datagroup_trigger: training_ecommerce_default_datagroup
    indexes: ["order_id"]
  }
  dimension: order_id {
    description: ""
    type: number
  }
  dimension: total_revenue {
    description: ""
    value_format: "$#,##0.00"
    type: number
  }
  dimension: count {
    description: ""
    type: number
  }
  dimension: user_id {
    description: ""
    type: number
  }
}
