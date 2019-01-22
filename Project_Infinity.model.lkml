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


explore: issue_all_fields {

  label: "Issues - Main"
  from:  issue_all_fields
  #view_label: "Issues - Main"
  fields: [
    #Epic Table
    epic.done, epic.key, epic.name, epic.summary,

    #Issue Table 1
    issue_all_fields.assignee, issue_all_fields.due, issue_all_fields.description, issue_all_fields.is_epic, issue_all_fields.is_past_due,

    #Issue Table 2
    issue_all_fields.issue_type, issue_all_fields.key, issue_all_fields.no_epic, issue_all_fields.summary,

    #Issue Type Table
    issue_type.description, issue_type.is_bug, issue_type.name,

    #Project Table
    project.description, project.name,

    #Sprint Table
    sprint.complete_date, sprint.name, sprint.start_date,

    #Status Table
    status.description, status.name, status.status_category_id,

    #Measures (unfinished)
    epic.count, issue_all_fields.count_issue, issue_all_fields.resolution, issue_all_fields.total_story_points, issue_type.count, project.count, sprint.count, status.count, issue_all_fields.summary_list]


  join: epic {
    type: left_outer
    sql_on: ${issue_all_fields.epic_link} = ${epic.id} ;;
    relationship: many_to_one
  }

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
    relationship: one_to_many
  }
  }
