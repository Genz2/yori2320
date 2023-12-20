# This is a native derived table equivalent to the one used in the "subquery" view. This derived table is derived from two
# dimensions from two different explores with the function of obtaining a count of both and thus declaring it as a dimension
view: subquery_ndt {
    derived_table: {
      explore_source: order_items {
        column: city { field: users.city }
        column: count {field: orders.count}
      }
    }
    dimension: city {
      description: ""
    }
    dimension: count {
      description: ""
      type: number
      sql: ${TABLE}.count;;
    }

    measure: total_count {
    type:  sum
    sql: ${count}  ;;
      html: {% if value > 100 %}
      <p style="color:purple">({{rendered_value}})</p>
      {% else %}
      <p>{{rendered_value}}</p>
      {% endif %};;
      value_format_name:  usd
    }

# In this measure we are calculating the average of a count, in order to do so we had to dimensionalize the measure
  measure: average_count {
    type: average
    sql: ${count} ;;
    }
  }
