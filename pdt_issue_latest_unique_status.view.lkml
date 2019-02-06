view: pdt_issue_latest_unique_status {
  derived_table: {
    sql: select
    glob."issue_all_fields.key" as issue_key,
    glob."status.name" as status_name,
    to_char(glob."issue_status_history.max_date", 'YYYY-MM-DD') as most_recent_status_change
    from (SELECT
    issue_all_fields."KEY"  AS "issue_all_fields.key",
    status.name as "status.name"  ,
    MAX(issue_status_history.TIME)  AS "issue_status_history.max_date"
    FROM connectors.jira.issue  AS issue_all_fields
    LEFT JOIN connectors.JIRA.ISSUE_STATUS_HISTORY  AS issue_status_history ON (issue_all_fields."ID") = issue_status_history.ISSUE_ID
    LEFT JOIN connectors.JIRA.STATUS  AS status ON (ISSUE_STATUS_HISTORY."STATUS_ID") = status.ID
    GROUP BY 1,2
    ) as glob
    ;;
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

    dimension: most_recent_status_change {
      type: string
      sql: ${TABLE}.most_recent_status_change ;;
    }

    measure: count {
      type: count_distinct
      sql: ${TABLE}.issue_key ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, issue_all_fields.target_complete_date, sprint.name, status.name]
    }

    measure: running_total {
      type: number
      sql: count(${most_recent_status_change}) over (partition by ${most_recent_status_change} order by ${most_recent_status_change} rows between unbounded preceding and current row) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, issue_all_fields.target_complete_date, sprint.name, status.name]
    }

    dimension: days_to_complete {
      type: number
      sql: DATEDIFF(d,${most_recent_status_change},${issue_all_fields.target_complete_date} ) ;;
      value_format_name: decimal_0
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

    measure: due_in_7_days {
      type: count
      filters: {
        field: days_to_complete
        value: ">0 AND <7"
      }
      filters: {
        field: status.name
        value: "-7 - Completed"
      }
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, issue_all_fields.target_complete_date, sprint.name, status.name]
    }

    measure: past_due {
      type: count
      filters: {
        field: days_to_complete
        value: "<-3"
      }
      filters: {
        field: status.name
        value: "-7 - Completed"
      }
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, issue_all_fields.target_complete_date, sprint.name, status.name]
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

# view: pdt_issue_latest_unique_status {
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
