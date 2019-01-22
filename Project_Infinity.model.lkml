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
  view_name: issue_test
  label: "Issues - Main"
  from:  issue
  #view_label: "Issues - Main"
  fields: [epic.done, epic.key, epic.name, epic.summary, #Epic Table
    issue_test.assignee, due, description, epic_link, epic_status, id, is_epic, is_past_due, is_sub_task, is_task, is_task_w_epic, is_task_wo_epic, #Issue Table 1
    issue_type, key, new_summ, new_summ_size, no_epic, parent_id, parent_link, project, sort_key, sort_key_1, sort_key_2, sort_key_3, status, summary, #Issue Table 2
    issue_type.description, issue_type.is_bug, issue_type.name, #Issue Type Table
    project.description, project.name, project.project_category_id, #Project Table
    sprint.complete_date, sprint.name, sprint.start_date, #Sprint Table
    status.description, status.name, status.status_category_id] #Status Table


  join: epic {
    type: left_outer
    sql_on: ${issue_test.epic_link} = ${epic.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_1 {
    type: left_outer
    sql_on: ${issue_test.parent_id} = ${issue_Link_1.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_2 {
    type: left_outer
    sql_on: ${issue_Link_1.epic_link} = ${issue_Link_2.id} ;;
    relationship: many_to_one
  }

  join: issue_Link_3 {
    type: left_outer
    sql_on: ${issue_test.epic_link} = ${issue_Link_3.id} ;;
    relationship: many_to_one
  }

  join: issue_type {
    type: left_outer
    sql_on: ${issue_test.issue_type} = ${issue_type.id} ;;
    relationship: many_to_one
  }

  join: project {
    type: left_outer
    sql_on: ${issue_test.project} = ${project.id} ;;
    relationship: many_to_one
  }

  join: status {
    type: left_outer
    sql_on: ${issue_test.status} = ${status.id} ;;
    relationship: many_to_one
  }

  join: issue_sprint {
    type: left_outer
    sql_on: ${issue_test.id} = ${issue_sprint.issue_id} ;;
    relationship: one_to_many
  }

  join: sprint {
    type: left_outer
    sql_on: ${issue_sprint.sprint_id} = ${sprint.id} ;;
    relationship: one_to_many
  }
  }
