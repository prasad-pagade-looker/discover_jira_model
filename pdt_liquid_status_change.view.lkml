view: pdt_liquid_status_change {
  derived_table: {
    sql: with cte1 as (
    SELECT
        issue_all_fields."KEY"  AS "issue_all_fields.key",
        status.name as "status.name"  ,
        project.name as "project.name",
        MAX(issue_status_history.TIME)  AS "issue_status_history.max_date"
        FROM connectors.jira.issue  AS issue_all_fields
        LEFT JOIN connectors.JIRA.ISSUE_STATUS_HISTORY  AS issue_status_history ON (issue_all_fields."ID") = issue_status_history.ISSUE_ID
        LEFT JOIN connectors.JIRA.STATUS  AS status ON (ISSUE_STATUS_HISTORY."STATUS_ID") = status.ID
        LEFT JOIN connectors.jira.project as project on (ISSUE_ALL_FIELDS.project) = project.id
      GROUP BY 1,2,3
      ),
    cte2 as (
    SELECT  "issue_all_fields.key" as issue_key,"project.name" as project_name,  "status.name" as status_name, "issue_status_history.max_date" as max_date, count("issue_all_fields.key") over (partition by "project.name", "status.name" order by "status.name"  asc ) as "issue_count" from cte1
    )
    SELECT pivot_table.status_name FROM cte2
    PIVOT
    (
            COUNT("issue_all_fields.key")
            FOR max_date IN
            --(status_name)
            (status_name."0 - Backlog", status_name."4 - In Progress On Time", status_name."7 - Completed")
    ) AS pivot_table;;
  }

  dimension: issue_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.issue_key ;;
  }

  dimension: status_name {
    type: string
    sql: ${TABLE}.status_name ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension_group: status_change {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.max_date ;;
  }

  measure: count {
    type: count
    drill_fields: [issue_all_fields.id, project.name, component.count, issue_project_history.count, version.count]
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: pdt_liquid_status_change {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
