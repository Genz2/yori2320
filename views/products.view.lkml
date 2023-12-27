view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: brand_linked {
    type: string
    sql: ${TABLE}.brand ;;
    html: <a href="https://www.google.com/search?q={{value | url_encode }}">{{value}}</a> ;;
  }
  dimension:  brand_linked_parameter {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: negritas {
    type: string
    sql: ${TABLE}.category ;;
    html: <p style="text-align: center; font-weight: bold;">{{value}}</p>;;
    }


  # END OF THIS EXAMPLE
  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }
  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }
  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }
  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }
  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
# CATEGORY FIELD FOR LINKING EXAMPLE WITH FILTERS AND URL ENCODE
  dimension: category_parameter_6 {
    label: "Category Linked to Dashboard parameter"
    description: "When we drill into this field, we will be navigated to dashboard 16. Best if used to drill from dashboard 15."
    type: string
    sql: ${TABLE}.category ;;
#     html:  <a href="/dashboards/16?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}">{{ value }}</a> ;;
    link: {
      label: "Category & Brand Info"
      url: "/dashboards/232?Brand={{ _filters['products.brand'] | url_encode }}&Category+Linked+to+Dashboard+parameter={{ value | url_encode }}"
    }
  }
  # /dashboards/232?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}
  # END OF THIS EXAMPLE
# CATEGORY FIELD FOR LINKING EXAMPLE WITH FILTERS AND URL ENCODE WITH HTML PARAMETER
  dimension: category_example_html {
    label: "Category example html"
    description: "When we drill into this field, we will be navigated to dashboard 16. Best if used to drill from dashboard 15."
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="/dashboards/232?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}">{{ value }}</a> ;;
  }
}
