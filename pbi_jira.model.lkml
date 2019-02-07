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
    epic.name, epic.key,epic.summary,

    #Issue Type Table
    issue_type.name,

    #Project Table
    project.name,

    #Sprint Table
    sprint.name,

    #Status Table
    status.name,
    status.pbi_percent_backlog, status.pbi_percent_newly_assigned, status.pbi_percent_not_started,status.pbi_percent_not_started_behind,
    status.pbi_percent_in_progress_on_time, status.pbi_percent_in_progress_behind, status.pbi_percent_ready_for_sign_off, status.pbi_percent_completed,
    status.pbi_percent_not_needed, status.pbi_percent_on_going,

    #Field Option Table
    field_option.name,

    #Issue Status History Table
    issue_status_history.time_date,

  #Measures
   epic.count, epic.count_epic_pbi,
   issue_all_fields.count_issue, issue_all_fields.count_issue_pbi,
   issue_type.count,
   project.count,
   sprint.count,
   status.count
  ]


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

  join: issue_status_history {
    type:  left_outer
    sql_on:  ${issue_all_fields.id} = ${issue_status_history.issue_id};;
    relationship: one_to_many
  }

#this is a filter that cannot be viewed or removed from the explore menu
  sql_always_where: ${project.name} like 'PBI';;

}

explore: issue_data_services {
  from:  issue_all_fields
  label: "Data Services - JIRA"
  #view_label: "Issues - Main"
  fields: [

    #Issue Table
    issue_data_services.key, issue_data_services.summary, issue_data_services.assignee, issue_data_services.original_requester,
    issue_data_services.projected_date_of_completion, issue_data_services.number_of_lists, issue_data_services.time_spent,
    issue_data_services.created_date,issue_data_services.created_week, issue_data_services.created_month,

    #Project Table
    project.name,

    #Status Table
    status.name,

    #Field Option Table
    field_option.name,

    #Issue Status History Table
    #issue_status_history.time_date,

    #Measures
    issue_data_services.count_issue, issue_data_services.count_issue_pbi,issue_data_services.total_time_spent,issue_data_services.total_requesters,
    project.count,
    status.count
  ]

  join: project {
    type: left_outer
    sql_on: ${issue_data_services.project} = ${project.id} ;;
    relationship: many_to_one
  }

  join: status {
    type: left_outer
    sql_on: ${issue_data_services.status} = ${status.id} ;;
    relationship: many_to_one
  }

  join: field_option {
    type: left_outer
    sql_on: ${issue_data_services.ticket_type} = ${field_option.id} ;;
    relationship: many_to_one
  }

  join: issue_status_history {
    type:  left_outer
    sql_on:  ${issue_data_services.id} = ${issue_status_history.issue_id};;
    relationship: one_to_many
  }

#this is a filter that cannot be viewed or removed from the explore menu
  sql_always_where: ${project.name} like 'DS';;

}
