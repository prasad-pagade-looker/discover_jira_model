  view: status {
    sql_table_name: connectors.JIRA.STATUS ;;

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.ID ;;
    }

    dimension_group: _FIVETRAN_SYNCED {
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
      sql: ${TABLE}._fivetran_synced ;;
    }

    dimension: description {
      type: string
      sql: ${TABLE}.DESCRIPTION ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.NAME ;;
    }

    dimension: status_category_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.STATUS_CATEGORY_ID ;;
    }

    measure: count {
      type: count
      drill_fields: [id, name, status_category.id, status_category.name, issue_status_history.count]
    }

    measure: 0_backlog_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '0 - Backlog') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 1_newly_assigned_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '1 - Newly Assigned') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 2_not_started_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '2 - Not Started') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 3_not_started_behind_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '3 - Not Started Behind') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 4_in_progress_on_time_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '4 - In Progress On Time') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 5_in_progress_behind_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '5 - In Progress Behind') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 6_ready_for_sign_off_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '6 - Ready for Sign Off') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 7_completed_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '7 - Completed') THEN status.ID  ELSE NULL END);;
      value_format: "0"
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

    measure: 8_not_needed_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '8 - Not Needed') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: 9_on_going_work_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = '9 - On Going Work') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: data_services_backlog_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = 'Backlog') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: data_services_in_progress_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = 'In Progress') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: data_services_done_count {
      type: number
      sql: COUNT(CASE WHEN (status.NAME = 'Done') THEN status.ID  ELSE NULL END);;
      value_format: "0"
    }

    measure: total_task_count {
      type: number
      sql: ${0_backlog_count}+${1_newly_assigned_count}+${2_not_started_count}+${3_not_started_behind_count}+${4_in_progress_on_time_count}+${5_in_progress_behind_count}+${6_ready_for_sign_off_count}+${7_completed_count}+${9_on_going_work_count} ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

    measure: data_services_total_task_count {
      type: number
      sql: ${data_services_backlog_count}+${data_services_in_progress_count}+${data_services_done_count} ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: percent_complete {
      type: number
      sql: (${7_completed_count})/NULLIF(${0_backlog_count}+${1_newly_assigned_count}+${2_not_started_count}+${3_not_started_behind_count}+${4_in_progress_on_time_count}+${5_in_progress_behind_count}+${6_ready_for_sign_off_count}+${7_completed_count}+${9_on_going_work_count}, 0) ;;
      value_format: "0%"
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

    measure: data_services_percent_backlog {
      type: number
      value_format_name: percent_1
      sql: 1.0*${data_services_backlog_count} / NULLIF(${data_services_total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: data_services_percent_in_progress {
      type: number
      value_format_name: percent_1
      sql: 1.0*${data_services_in_progress_count} / NULLIF(${data_services_total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: data_services_percent_done {
      type: number
      value_format_name: percent_1
      sql: 1.0*${data_services_done_count} / NULLIF(${data_services_total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_backlog {
      type: number
      value_format_name: percent_0
      sql: 1.0*${0_backlog_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_newly_assigned {
      type: number
      value_format_name: percent_0
      sql: 1.0*${1_newly_assigned_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_not_started {
      type: number
      value_format_name: percent_0
      sql: 1.0*${2_not_started_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_not_started_behind {
      type: number
      value_format_name: percent_0
      sql: 1.0*${3_not_started_behind_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_in_progress_on_time {
      type: number
      value_format_name: percent_0
      sql: 1.0*${4_in_progress_on_time_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_in_progress_behind {
      type: number
      value_format_name: percent_0
      sql: 1.0*${5_in_progress_behind_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_ready_for_sign_off {
      type: number
      value_format_name: percent_0
      sql: 1.0*${6_ready_for_sign_off_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_completed {
      type: number
      value_format_name: percent_0
      sql: 1.0*${7_completed_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_not_needed {
      type: number
      value_format_name: percent_0
      sql: 1.0*${8_not_needed_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }

    measure: pbi_percent_on_going {
      type: number
      value_format_name: percent_0
      sql: 1.0*${9_on_going_work_count} / NULLIF(${total_task_count},0) ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
    }



}
