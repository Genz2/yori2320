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
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  # We can use liquid to modify some visual aspects of Looker, this code block is to center the column results.
  dimension: category_example_0 {
    group_label: "Formatting Examples"
    label: "Category"
    type: string
    sql: ${TABLE}.category ;;
    html: <p style="text-align:center">{{value}}</p> ;;
  }
  # INTRO TO LINKING EXAMPLES
  dimension: category_example_2 {
    group_label: "Intro to Linking Examples"
    label: "1.a. Category Hyperlink HTML"
    description: "This example will make every value of the category field a hyperlink that links out to the Google search engine"
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="https://www.google.com/">{{ value }}</a> ;;
  }

  dimension: category_example_3 {
    group_label: "Intro to Linking Examples"
    label: "1.b. Category Dynamic Hyperlink HTML"
    description: "This example will make every value of the category field a hyperlink that links out to a Google search of the dynamically changing value selected"
    type: string
    sql: ${TABLE}.category ;;
    html:  <a href="https://www.google.com/search?q={{value}}">{{ value }}</a> ;;
  }

  dimension: category_example_4 {
    group_label: "Intro to Linking Examples"
    label: "2.a. Category with Google Link"
    description: "This method will result in Google Search appearing as an option in the dropdown menu prompted when we select a category value. When we select the option, we will be navigated to the standard Google search page"
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "Google Search"
      url: "https://www.google.com/"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    }
  }

  dimension: category_example_5 {
    group_label: "Intro to Linking Examples"
    label: "2.b. Category with Dynamic Google Link"
    description: "This method will result in Google Search appearing as an option in the dropdown menu prompted when we select a category value. When we select the option, we will be navigated to a Google search that dynamically changes as the field selected changes"
    type: string
    sql: ${TABLE}.category ;;
    link: {
      label: "Google Search"
      url: "https://www.google.com/search?q={{value}}"
      icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    }
  }

  # END OF INTRO TO LINKING EXAMPLES

  # CATEGORY FIELD FOR LINKING EXAMPLE WITH FILTERS AND URL ENCODE
  dimension: category_example_6 {
    label: "Category Linked to Dashboard"
    description: "When we drill into this field, we will be navigated to dashboard 16. Best if used to drill from dashboard 15."
    type: string
    sql: ${TABLE}.category ;;
#     html:  <a href="/dashboards/16?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}">{{ value }}</a> ;;
    link: {
      label: "Category & Brand Info"
      url: "/dashboards/16?Category={{ value | url_encode }}&Brand={{ _filters['products.brand'] | url_encode }}"
    }
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
}
