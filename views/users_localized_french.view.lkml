view: users_localized {
  sql_table_name: demodb.users ;;

  dimension: id {
    label: "id"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    label: "age"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    label: "city"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    label: "country"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    label: "email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    label: "first_name"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    label: "gender"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    label: "last_name"
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    label: "state"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    label: "zip"
    type: number
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }
}
