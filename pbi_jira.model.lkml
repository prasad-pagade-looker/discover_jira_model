connection: "snowflakedb"

#travis test

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: issue_all_fields {
  label: "PBI - JIRA"
  #view_label: "Issues - Main"
  fields: [

    #Issue Table
    issue_all_fields.key, issue_all_fields.summary, issue_all_fields.status, issue_all_fields.assignee, issue_all_fields.target_complete_date,

    #Epic table
    epic.name, epic.key,

    #Issue Type Table
    issue_type.name,

    #Project Table
    project.name,

    #Sprint Table
    sprint.name,

    #Status Table
    status.name,

    #Field Option Table
    field_option.name,

  #Measures
   epic.count, issue_all_fields.count_issue, issue_all_fields.total_time_to_resolve_issues_hours, issue_all_fields.avg_time_to_resolve_issues_hours,
   issue_all_fields.total_story_points, issue_type.count, project.count, sprint.count, status.count, issue_all_fields.summary_list]


  join: epic {
    type: left_outer
    sql_on: ${issue_all_fields.epic_link} = ${epic.id} ;;
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
    relationship: many_to_one
  }

  join: field_option {
    type: left_outer
    sql_on: ${issue_all_fields.customer_organization} = ${field_option.id} ;;
    relationship: many_to_one
  }

#this is a filter that cannot be viewed or removed from the explore menu
  sql_always_where: ${project.name} like 'PBI' ;;

}
