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
  parameter: timeframe_param {
    label: "Date Granularity"
    type: unquoted
    allowed_value: {
      label: "Visualize by Month"
      value: "month"
    }
    allowed_value: {
      label: "Visualize by Week"
      value: "week"
    }
    allowed_value: {
      label: "Visualize by Day"
      value: "day"
    }
  }

  dimension: dynamic_timeframe {
    label: "Dynamic Order Created Date"
    type: date
    sql:
      {% if timeframe_param._parameter_value == 'month' %}
        date_trunc('month', ${returned_date} :: date)
      {% elsif timeframe_param._parameter_value == 'week' %}
        date_trunc('week', ${returned_date} :: date)
      {% elsif timeframe_param._parameter_value == 'day' %}
       ${returned_date}
      {% endif %};;
    convert_tz: no
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
