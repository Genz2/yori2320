view: orders_derived_example {
  derived_table: {
    sql:
 SELECT
    `users`.`city` AS `users.city`,
        (DATE(CONVERT_TZ(`users`.`created_at`,'UTC','America/Los_Angeles'))) AS `users.created_date`,
    COUNT(DISTINCT orders.id ) AS `orders.count`
FROM
    demo_db.order_items AS order_items
    LEFT JOIN demo_db.orders AS orders ON order_items.order_id = orders.id
    LEFT JOIN demo_db.users AS users ON orders.user_id = users.id
GROUP BY
    users.city
ORDER BY
    `orders.count` DESC;;
  }
  dimension: city {
    type: string
    sql: WHERE ${TABLE}.`users.created_date` ;;
  }
  dimension_group: created_at {
    type: time
    sql: ${TABLE}.`users.created_date` ;;
  }
  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }
  measure: average_count {
    type: average
    sql: ${orders_count} ;;
  }
}
