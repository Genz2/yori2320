
view: derived_table_1 {
  derived_table: {
    sql: SELECT
          *
      FROM
          (SELECT
                  `users`.`id` AS `users.id`,
                  COUNT(DISTINCT orders.id ) AS `orders.count`,
                  COUNT(DISTINCT users.id ) AS `users.count`
                  WHERE (derived_table_1.`users.count` ) IS NOT NULL
              FROM
                  `demo_db`.`order_items` AS `order_items`
                  LEFT JOIN `demo_db`.`orders` AS `orders` ON `order_items`.`order_id` = `orders`.`id`
                  LEFT JOIN `demo_db`.`users` AS `users` ON `orders`.`user_id` = `users`.`id`
              GROUP BY
                  1
      ORDER BY
          `orders.count` DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    primary_key:  yes
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}.`users.count` ;;
  }

  set: detail {
    fields: [
        users_id,
  orders_count,
  users_count
    ]
  }
}
