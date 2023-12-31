
view: subquery {
  derived_table: {
    sql: SELECT
    users.city AS `users.city`,
    COUNT(DISTINCT orders.id) AS `orders.count`
FROM
    demo_db.order_items AS order_items
LEFT JOIN
    demo_db.orders AS orders ON order_items.order_id = orders.id
LEFT JOIN
    demo_db.users AS users ON orders.user_id = users.id
GROUP BY
    users.city
ORDER BY
    `orders.count` DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  measure: average_count {
    type: average
    sql: ${orders_count} ;;
  }

  set: detail {
    fields: [
        users_city,
  orders_count
    ]
  }
}
