connection: "snowflakedb"

include: "epic.view.lkml"
include: "issue_Link_1.view.lkml"
include: "issue_Link_2.view.lkml"
include: "issue_Link_3.view.lkml"
include: "issue_type.view.lkml"
include: "project.view.lkml"
include: "status.view.lkml"
include: "issue_sprint.view.lkml"
include: "sprint.view.lkml"
include: "issue_all_fields.view.lkml"


datagroup: fivetran_datagroup {
  sql_trigger: SELECT max(date_trunc('minute', done)) FROM jira.fivetran_audit ;;
  max_cache_age: "24 hours"
}

persist_with: fivetran_datagroup


explore: issue {
  view_name: issue
  label: "Issues - Main"
  #view_label: "Issues - Main"

  join: epic {
    type: left_outer
    sql_on: ${issue.epic_link} = ${epic.id} ;;
    relationship: many_to_one
  }

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
    relationship: one_to_many
  }
  }
