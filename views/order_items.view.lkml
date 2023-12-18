view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension: transaction_date {
    label: "Transaction Date"
    description: "Date when users viewed content"
    type: date
    convert_tz: no
    allow_fill: no
    sql: ${TABLE}."transaction date";;
  }

  measure: total_revenue_formatted {
    type: sum
    sql: ${sale_price} - 0.5;;
    html: {% if value < 0 %}
          <p style="color:red">({{rendered_value}})</p>
          {% else %}
          <p>{{rendered_value}}</p>
          {% endif %}

      ;;
    value_format_name: usd
  }

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
