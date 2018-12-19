
 view: project_infinity {
  derived_table: {
  sql: SELECT
    i."CUSTOMER_ORGANIZATION",
    fo."NAME" as corporate_objectives,
    i."HIGH_LEVEL_ESTIMATE_WEEKS_",
    i."PRIORITY",
    e."SUMMARY" as epic_summary,
    e."NAME" as epic_name,
    e."DONE",
    e."KEY" as epic_key,
    i_link."RELATED_ISSUE_ID",
    i_link."RELATIONSHIP",
    i_type."NAME" as issue_type,
    p."NAME" as project_name,
    s."NAME" as status_name,
    sprint."NAME" as sprint_name
  from CONNECTORS.JIRA.ISSUE as i
  LEFT OUTER join CONNECTORS.JIRA.EPIC as e on i."EPIC_LINK" = e."ID"
  LEFT OUTER join CONNECTORS.JIRA.ISSUE_LABELS as i_label on i."ID" = i_label."ISSUE_ID"
  LEFT OUTER join CONNECTORS.JIRA.ISSUE_LINK as i_link on i."ID" = i_link."ISSUE_ID"
  LEFT OUTER join CONNECTORS.JIRA.ISSUE_TYPE as i_type on i."ISSUE_TYPE" = i_type."ID"
  LEFT OUTER join CONNECTORS.JIRA.PROJECT as p on i."PROJECT" = p."ID"
  LEFT OUTER join CONNECTORS.JIRA.STATUS as s on i."STATUS" = s."ID"
  LEFT OUTER join CONNECTORS.JIRA.ISSUE_SPRINT as i_sprint on i."ID"=i_sprint."ISSUE_ID"
  LEFT OUTER join CONNECTORS.JIRA.SPRINT as sprint on i_sprint."SPRINT_ID" = sprint."ID"
  LEFT OUTER JOIN CONNECTORS.JIRA.ISSUE_CORPORATE_OBJECTIVES as ico on i."ID" = ico."ISSUE_ID"
  LEFT OUTER JOIN CONNECTORS.JIRA.FIELD_OPTION as fo on ico."FIELD_OPTION_ID" = fo."ID";;
  }}
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
