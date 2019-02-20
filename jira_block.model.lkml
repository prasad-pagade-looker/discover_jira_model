connection: "snowflakedb"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

label: "Jira"

datagroup: fivetran_datagroup {
  sql_trigger: SELECT max(date_trunc('minute', done)) FROM jira.fivetran_audit ;;
  max_cache_age: "24 hours"
}

persist_with: fivetran_datagroup


explore: issue_all_fields {
  label: "Issues - Main"
  #view_label: "Issues - Main"

  join: issue_Link_1 {
    type: left_outer
    sql_on: ${issue_all_fields.parent_id} = ${issue_Link_1.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_2 {
    type: left_outer
    sql_on: ${issue_Link_1.epic_link} = ${issue_Link_2.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_3 {
    type: left_outer
    sql_on: ${issue_all_fields.epic_link} = ${issue_Link_3.id} ;;
    relationship: many_to_one
  }

  join: epic {
    type: left_outer
    sql_on: ${issue_all_fields.epic_link} = ${epic.id} ;;
    relationship: many_to_one
  }
  join: issue_labels {
    type: left_outer
    sql_on: ${issue_all_fields.id} = ${issue_labels.issue_id} ;;
    relationship: one_to_many
  }
  join: issue_link {
    type: left_outer
    sql_on: ${issue_all_fields.id} = ${issue_link.issue_id} ;;
    relationship: one_to_many
  }
  join: issue_type {
    type: left_outer
    sql_on: ${issue_all_fields.issue_type} = ${issue_type.id} ;;
    relationship: many_to_one
  }
  join: project {
    type: left_outer
    sql_on: ${issue_all_fields.project} = ${project.id} ;;
    relationship: many_to_one
  }

  join: project_category{
    type: left_outer
    sql_on: ${project.project_category_id} = ${project_category.id} ;;
    relationship: many_to_one
  }
  join: status {
    type: left_outer
    sql_on: ${issue_all_fields.status} = ${status.id} ;;
    relationship: many_to_one
  }
  join: issue_sprint {
    type: left_outer
    sql_on: ${issue_all_fields.id} = ${issue_sprint.issue_id} ;;
    relationship: one_to_many
  }
  join: sprint {
    type: left_outer
    sql_on: ${issue_sprint.sprint_id} = ${sprint.id} ;;
    relationship: many_to_one
  }
  join: issue_corporate_objectives {
    type: left_outer
    sql_on: ${issue_all_fields.id} = ${issue_corporate_objectives.issue_id} ;;
    relationship: one_to_many
  }
  join: field_option {
    type: left_outer
    sql_on: ${issue_corporate_objectives.field_option_id} = ${field_option.id} ;;
    relationship: many_to_one
  }

  join: pdt_issue_latest_unique_status {
    type: left_outer
    sql_on: ${issue_all_fields.key} = ${pdt_issue_latest_unique_status.issue_key} ;;
    relationship: one_to_many
  }

  join: pdt_liquid_status_change {
    type: left_outer
    sql_on: ${issue_all_fields.key} = ${pdt_liquid_status_change.issue_key} ;;
    relationship: one_to_many
  }

  join: pdt_snapshot {
    type: full_outer
    sql_on: ${issue_all_fields.key} = ${pdt_snapshot.issue_key} ;;
    relationship: one_to_many
  }

  join: issue_viewers {
    type: left_outer
    sql_on: ${issue_all_fields.id} = ${issue_viewers.issue_id} ;;
    relationship: one_to_many
  }

}




##### Everything below is just for future reference ##############################

# explore: sprint {
#   join: issue_sprint {
#     type:  left_outer
#     sql_on: ${sprint.id} = ${issue_sprint.sprint_id} ;;
#     relationship: one_to_many
#   }
#   join: issue {
#     type:  left_outer
#     sql_on: ${issue_sprint.issue_id} = ${issue.id} ;;
#     relationship: one_to_many
#   }
#
# }

# Update based on how you are associating versions to
# explore: version {
#   hidden: yes
#   join: issue_fix_version {
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${version.id} = ${issue_fix_version.version_id} ;;
#   }
#   # join: issue {
#   #   type: left_outer
#   #   relationship: one_to_one
#   #   sql_on: ${issue_fix_version.issue_id} = ${issue.id} ;;
#   # }
#   join: issue_extended_jira {
#     view_label: "Issues"
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${issue_fix_version.issue_id} = ${issue_extended_jira.id} ;;
#   }
# }

# explore: issue_history_2 {
#   label: "Issue History"
# #  fields: [ALL_FIELDS*, -issue.total_open_story_points,-issue.total_closed_story_points]
#   view_name: issue
#
#   join: issue_history_all {
#     type:  left_outer
#     sql_on: ${issue.id} = ${issue_history_all.issue_id} ;;
#     relationship: many_to_one
#   }
# }

### CURRENT OVERVIEW OF STATUS OF PROJECTS, ISSUES, AND ISSUE FACTS (E.G. # OF COMMENTS)

# explore: project {
#   join: issue {
#     type:  left_outer
#     sql_on: ${project.id} = ${issue.project} ;;
#     relationship: many_to_one
#   }
#   join: issue_extended_jira {
#     view_label: "Issue All Fields"
#     type:  left_outer
#     sql_on: ${project.id} = ${issue.project} ;;
#     relationship: many_to_one
#   }
#   join:  issue_type {
#     type:  left_outer
#     sql_on: ${issue.issue_type} = ${issue_type.id} ;;
#     relationship: many_to_one
#   }
#   join: issue_sprint {
#     type: left_outer
#     sql_on: ${issue_sprint.issue_id} = ${issue.id} ;;
#     relationship: many_to_one
#   }
#   join: sprint {
#     from: sprint_details
#     type: left_outer
#     sql_on: ${issue_sprint.sprint_id} = ${sprint.id} ;;
#     relationship: many_to_one
#   }
#   join:  priority {
#     type:  left_outer
#     sql_on: ${issue.priority} = ${priority.id} ;;
#     relationship: many_to_one
#   }
#   join:  status {
#     type:  left_outer
#     sql_on: ${issue.status} = ${status.id} ;;
#     relationship: many_to_one
#   }
#   join:  status_category {
#     type:  left_outer
#     sql_on: ${status.status_category_id} = ${status_category.id} ;;
#     relationship: many_to_one
#   }
#
#   ### AS OF NOW, FACT TABLE ONLY INCLUDES COMMENT INFORMATION - SHOULD MAKE THIS A GIANT DERIVED TABLE
#   ### WITH FACTS FROM ALL ISSUE-RELATED TABLES SUCH AS PRIORITY, TYPE, ETC.
#
#   join:  issue_comment_facts {
#     type:  left_outer
#     sql_on: ${issue.id} = ${issue_comment_facts.issue_id} ;;
#     relationship: many_to_one
#   }
#


### HISTORICAL OVERVIEWS

# explore: sprint_by_date {
#   label: "Sprint History"
#
#   join: issue {
#     view_label: "Issue"
#     type: left_outer
#     sql_on: ${sprint_by_date.issue_id} = ${issue.id} ;;
#     relationship: many_to_one
#   }
#
#   ### JOIN SINGULAR TABLES WITH NO ASSOCIATED HISTORY TABLES
#
#   join: issue_type {
#     type: left_outer
#     sql_on: ${issue.issue_type} = ${issue_type.id} ;;
#     relationship: many_to_one
#   }
#
#   join: priority {
#     view_label: "Issue Priority"
#     type: left_outer
#     sql_on: ${issue.priority} = ${priority.id} ;;
#     relationship: many_to_one
#   }
#
#   join: sprint {
#     type: left_outer
#     sql_on: ${sprint.id} = ${sprint_by_date.sprint_id} ;;
#     relationship: many_to_one
#   }
#
#   join: sprint_details {
#     type: left_outer
#     sql_on: ${sprint_details.id} = ${sprint_by_date.sprint_id} ;;
#     relationship: many_to_one
#   }
#
#   join: status {
#     view_label: "Issue Status"
#     type: left_outer
#     sql_on: ${status.id} = ${issue.status} ;;
#     relationship: many_to_one
#   }
#
#   join: status_category {
#     view_label: "Issue Status"
#     type: left_outer
#     sql_on: ${status.status_category_id} = ${status_category.id} ;;
#     relationship: many_to_one
#   }
# }


# explore: sprint_burndown {
#   view_name: looker_calendar
#   join: issue {
#     type: left_outer
#     sql_on:
#     ${looker_calendar.series_date_raw} >= ${issue.created_raw}
#     AND ${looker_calendar.series_date_raw} <= NVL(${issue.resolved_raw},current_date)
#     ;;
#     relationship: one_to_many
#   }
#   join: issue_sprint {
#     type: left_outer
#     sql_on: ${issue.id} = ${issue_sprint.issue_id} ;;
#     relationship: one_to_many
#   }
#   join: sprint {
#     type: left_outer
#     sql_on: ${issue_sprint.sprint_id} = ${sprint.id} ;;
#     relationship: many_to_one
#   }
#   join: sprint_start_points {
#     type: left_outer
#     sql_on: ${sprint.id} = ${sprint_start_points.id} ;;
#     relationship: one_to_one
#   }

#   join:  status {
#     type:  left_outer
#     sql_on: ${issue.status} = ${status.id} ;;
#     relationship: many_to_one
#   }

#   sql_always_where:
#   ${looker_calendar.series_date_raw} >= ${sprint.start_raw}
#   AND ${looker_calendar.series_date_raw} <= ${sprint.end_raw}
#   ;;
#   #always_filter: {
#   #  filters: {
#   #    field: sprint.name
#   #    value: "Data Sprint 5"
#   #  }
#   #}

# }
