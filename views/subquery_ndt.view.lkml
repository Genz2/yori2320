# This is a native derived table equivalent to the one used in the "subquery" view. This derived table is derived from two
# dimensions from two different explores with the function of obtaining a count of both and thus declaring it as a dimension
view: subquery_ndt {
    derived_table: {
      explore_source: order_items {
        column: city { field: users.city }
        column: count {field: orders.count}
      }
      datagroup_trigger: yori_default_datagroup
      indexes: ["user_id"]

    }
    dimension: city {
      description: ""
    }
    dimension: count {
      description: ""
      type: number
      sql: ${TABLE}.count;;
    }

    # In this measure we obtain the total sum of the dimension count, later with liquid using the conditional format we .
    #established that numbers greater than 100 will be marked with purple color
    measure: total_count {
    type:  sum
    sql: ${count}  ;;
      html: {% if value >= 100 %}
      <p style="color:purple">({{rendered_value}})</p>
      {% else %}
      <p>{{rendered_value}}</p>
      {% endif %};;
    }

# In this measure we are calculating the average of a count, in order to do so we had to dimensionalize the measure
  measure: average_count {
    type: average
    sql: ${count} ;;
    }
  }
