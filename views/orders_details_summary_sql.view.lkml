
view: orders_details_summary_sql {
  derived_table: {
    sql: SELECT
          `order_items`.`order_id` AS `order_items.order_id`,
          `orders`.`user_id` AS `orders.user_id`,
          COUNT(*) AS `order_items.count`,
          COALESCE(SUM(`order_items`.`sale_price`), 0) AS `order_items.total_revenue`
      FROM
          `demo_db`.`order_items` AS `order_items`
          LEFT JOIN `demo_db`.`orders` AS `orders` ON `order_items`.`order_id` = `orders`.`id`
      GROUP BY
          1,
          2
      ORDER BY
          3 DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_order_id {
    type: number
    sql: ${TABLE}.`order_items.order_id` ;;
  }

  dimension: orders_user_id {
    type: number
    sql: ${TABLE}.`orders.user_id` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  dimension: order_items_total_revenue {
    type: number
    sql: ${TABLE}.`order_items.total_revenue` ;;
  }

  set: detail {
    fields: [
        order_items_order_id,
  orders_user_id,
  order_items_count,
  order_items_total_revenue
    ]
  }
}
