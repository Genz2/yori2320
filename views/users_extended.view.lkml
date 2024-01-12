
view: users_extended {
  derived_table: {
    sql: SELECT
          email,
          created_at, id,
          @row_number := @row_number + 1 AS row_number
      FROM
          demo_db.users,
          (SELECT @row_number := 0) AS r  -- Initialize row number variable
      ORDER BY
          created_at ASC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: ID {
    primary_key: yes
    type:  number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: row_number {
    type: number
    sql: ${TABLE}.row_number ;;
  }

  set: detail {
    fields: [
        email,
  created_at_time,
  row_number
    ]
  }
}
