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
      sql: COUNT(CASE WHEN (status.NAME = '0 - Backlog') THEN status.ID  ELSE NULL END);;
    }

    measure: 1_newly_assigned {
      sql: COUNT(CASE WHEN (status.NAME = '1 - Newly Assigned') THEN status.ID  ELSE NULL END);;
    }

    measure: 2_not_started {
      sql: COUNT(CASE WHEN (status.NAME = '2 - Not Started') THEN status.ID  ELSE NULL END);;
    }

    measure: 3_not_started_behind {
      sql: COUNT(CASE WHEN (status.NAME = '3 - Not Started Behind') THEN status.ID  ELSE NULL END);;
    }

    measure: 4_in_progress_on_time {
      sql: COUNT(CASE WHEN (status.NAME = '4 - In Progress On Time') THEN status.ID  ELSE NULL END);;
    }

    measure: 5_in_progress_behind {
      sql: COUNT(CASE WHEN (status.NAME = '5 - In Progress Behind') THEN status.ID  ELSE NULL END);;
    }

    measure: 6_ready_for_sign_off {
      sql: COUNT(CASE WHEN (status.NAME = '6 - Ready for Sign Off') THEN status.ID  ELSE NULL END);;
    }

    measure: 7_completed {
      sql: COUNT(CASE WHEN (status.NAME = '7 - Completed') THEN status.ID  ELSE NULL END);;
    }

    measure: 8_not_needed {
      sql: COUNT(CASE WHEN (status.NAME = '8 - Not Needed') THEN status.ID  ELSE NULL END);;
    }

    measure: 9_on_going_work {
      sql: COUNT(CASE WHEN (status.NAME = '9 - On Going Work') THEN status.ID  ELSE NULL END);;
    }


}
