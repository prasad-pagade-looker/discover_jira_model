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

    measure: total_task_count {
      type: number
      sql: ${0_backlog_count}+${1_newly_assigned_count}+${2_not_started_count}+${3_not_started_behind_count}+${4_in_progress_on_time_count}+${5_in_progress_behind_count}+${6_ready_for_sign_off_count}+${7_completed_count}+${9_on_going_work_count} ;;
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

    measure: percent_complete {
      type: number
      sql: (${7_completed_count})/(${0_backlog_count}+${1_newly_assigned_count}+${2_not_started_count}+${3_not_started_behind_count}+${4_in_progress_on_time_count}+${5_in_progress_behind_count}+${6_ready_for_sign_off_count}+${7_completed_count}+${9_on_going_work_count}) ;;
      value_format: "0%"
      drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
    }

}
