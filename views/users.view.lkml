view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year, hour]
    drill_fields: [
      created_time,
      created_date,
      created_month,
      created_quarter,
      created_raw,
      created_week,
      created_year,
      created_hour
    ]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
    value_format: "0"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }
  dimension: is_m {
    type: yesno
    sql: ${TABLE}.gender = 'm' ;;
  }
# This is correct
  measure: total_m {
    type: number
    sql: SUM(CASE WHEN ${is_male} THEN 2 ELSE 1 END) ;;
  }
# This is NOT correct
  measure: total_female {
    type: number
    sql: SUM(CASE WHEN ${is_male} = 'Yes' THEN 2 ELSE 1 END) ;;
  }
  dimension: is_male {
    type: yesno
    sql: ${TABLE}.gender = 'male' ;;
  }
# This is correct
  measure: total_male {
    type: number
    sql: SUM(CASE WHEN ${is_male} THEN 2 ELSE 1 END) ;;
  }
# This is NOT correct
  measure: total_not_male {
    type: number
    sql: SUM(CASE WHEN ${is_male} = 'Yes' THEN 2 ELSE 1 END) ;;
  }

}
