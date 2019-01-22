connection: "snowflakedb"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

label: "TEST_JIRA"

datagroup: fivetran_datagroup {
  sql_trigger: SELECT max(date_trunc('minute', done)) FROM jira.fivetran_audit ;;
  max_cache_age: "24 hours"
}

persist_with: fivetran_datagroup


explore: issue {
  label: "Project - Infinity"
  #view_label: "Issues - Main"

  join: issue_Link_1 {
    type: left_outer
    sql_on: ${issue.parent_id} = ${issue_Link_1.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_2 {
    type: left_outer
    sql_on: ${issue_Link_1.epic_link} = ${issue_Link_2.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_3 {
    type: left_outer
    sql_on: ${issue.epic_link} = ${issue_Link_3.id} ;;
    relationship: many_to_one
  }

  join: epic {
    type: left_outer
    sql_on: ${issue.epic_link} = ${epic.id} ;;
    relationship: many_to_one
  }
  join: issue_labels {
    type: left_outer
    sql_on: ${issue.id} = ${issue_labels.issue_id} ;;
    relationship: one_to_many
  }
  join: issue_link {
    type: left_outer
    sql_on: ${issue.id} = ${issue_link.issue_id} ;;
    relationship: one_to_many
  }
  join: issue_type {
    type: left_outer
    sql_on: ${issue.issue_type} = ${issue_type.id} ;;
    relationship: many_to_one
  }
  join: project {
    type: left_outer
    sql_on: ${issue.project} = ${project.id} ;;
    relationship: many_to_one
  }

  join: project_category{
    type: left_outer
    sql_on: ${project.project_category_id} = ${project_category.id} ;;
    relationship: many_to_one
  }
  join: status {
    type: left_outer
    sql_on: ${issue.status} = ${status.id} ;;
    relationship: many_to_one
  }
  join: issue_sprint {
    type: left_outer
    sql_on: ${issue.id} = ${issue_sprint.issue_id} ;;
    relationship: one_to_many
  }
  join: sprint {
    type: left_outer
    sql_on: ${issue_sprint.sprint_id} = ${sprint.id} ;;
    relationship: many_to_one
  }
  join: issue_corporate_objectives {
    type: left_outer
    sql_on: ${issue.id} = ${issue_corporate_objectives.issue_id} ;;
    relationship: one_to_many
  }
  join: field_option {
    type: left_outer
    sql_on: ${issue_corporate_objectives.field_option_id} = ${field_option.id} ;;
    relationship: many_to_one
  }

}
