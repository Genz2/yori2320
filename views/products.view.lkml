view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]
  view_label: "products"

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: brand {
    type: string
    group_label: "item_details"
    label: "brand"
    description: "brand_of_item"
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
    group_label: "item_details"
    label: "category"
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
    group_label: "store_details"
    label: "department"
    sql: ${TABLE}.department ;;
  }

  # HTML Tests
  dimension: department_1 {
    type: string
    label: "Paragraph"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <p style="color:gray;
              text-align:center;
              background-color: powderblue;
              font-family:arial;
              font-size:120%">
              This is a paragraph! </p>;;
  }
  dimension: department_2 {
    type: string
    label: "Unordered List"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <ul>
      <li> list_item_1 </li> <li> list_item_2 </li> </ul>;;
  }
  dimension: department_3 {
    type: string
    label: "Ordered List"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <ol>
      <li> list_item_1 </li> <li> list_item_2 </li> </ol>;;
  }
  dimension: department_4 {
    type: string
    label: "Anchor"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <a href="https://google.com">
      Click this link to go to Google!</a>;;
  }
  dimension: department_5 {
    type: string
    label: "Image"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <img src="https://gfnc1kn6pi-flywheel.netdna-ssl.com/wp-content/uploads/2017/10/goldie.jpg" alt="Golden Retriever puppy" style="width:100%">;;
  }

  dimension: department_6 {
    type: string
    label: "Paragraph with Value"
    group_label: "HTML Tests"
    sql: ${TABLE}.department ;;
    html: <p style="color:gray;
              text-align:center;
              background-color: powderblue;
              font-family:arial;
              font-size:120%">
              This is a paragraph that also shows the department name: {{value}} </p>;;
  }

  dimension: linked_brand {
    type: string
    group_label: "HTML Tests"
    link: {
      label: "Google search"
      url: "https://www.google.com/search?q={{value | url_encode }}"
    }
    sql: ${brand} ;;
  }

  dimension: highlighted_brand {
    type: string
    sql: ${brand} ;;
    group_label: "HTML Tests"
    # Multi value use case
    html: <p
    {% assign words = _user_attributes['brand'] | split: ',' %}
    {% for word in words %}
      {% if value == word %}
         style= "background-color: yellow;"
         {% else %}
     {% endif %}
    {% endfor %}
    >{{value}}</p>
    ;;
  }

# Single value use case
# html: <p
# {% if _user_attributes['brand'] == value %}
# style= "background-color: yellow;"
# {% else %}
# {% endif %}
# >{{value}}</p>
# ;;

# Alternate single value use case (maybe more readable?)
# html:
# {% if _user_attributes['brand'] == value %}
# <p style= "background-color: yellow;">
# {{value}}</p>
# {% else %}
#   <p> {{value}}</p>
# {% endif %}
# ;;

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



  measure: count_conditional_correct {
    type: count
    html:
    {% if orders.status._value == "COMPLETED" %}
    <p style= "color:green">{{ rendered_value }}</p>
    {% elsif orders.status._value == "CANCELLED" %}
    <p style="color:red">{{ rendered_value }}</p>
    {% else %}
    <p style="color:blue">{{ rendered_value }}</p>
    {% endif %}
    ;;
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
