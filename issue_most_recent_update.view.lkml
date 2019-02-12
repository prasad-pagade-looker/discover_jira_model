view: issue_most_recent_update {
  derived_table: {
    sql: select tbl."ID",tbl."KEY",tbl."SUMMARY",tbl.create_time,tbl.most_recent_status_time,tbl."NAME"
      from (
      select
      i."ID",
      i."KEY",
      i."SUMMARY",
      i."CREATED" as create_time,
      ish."TIME" as most_recent_status_time,
      s."NAME",
      row_number() over (partition by ish."ISSUE_ID" order by ish."TIME" desc) as row_number
      from CONNECTORS.JIRA.ISSUE_STATUS_HISTORY as ish
      LEFT OUTER JOIN CONNECTORS.JIRA.ISSUE as i on ish."ISSUE_ID" = i."ID"
      LEFT OUTER JOIN CONNECTORS.JIRA.STATUS as s on ish."STATUS_ID" = s."ID"
      LEFT OUTER join CONNECTORS.JIRA.PROJECT as p on i."PROJECT" = p."ID"
      ) as tbl
      where tbl."ROW_NUMBER" = 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}."KEY" ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}."SUMMARY" ;;
  }


  dimension_group: completed {
    type: time
    timeframes: [raw, time, date, hour, week]
    sql: ${TABLE}."MOST_RECENT_STATUS_TIME" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, hour, week]
    sql: ${TABLE}."CREATE_TIME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

dimension: is_completed_ticket {
  type: yesno
  sql: ${name} = 'Done' ;;
}

measure: completed_ticket_count {
  type:  count
  filters: {
    field: is_completed_ticket
    value: "Yes"
  }
}

measure: avg_turn_around_time_hours {
  type: median
  sql:  TIMESTAMPDIFF(h,${created_raw},${completed_raw}) ;;
  value_format_name: decimal_0
}

  measure: avg_turn_around_time_days {
    type: median
    sql:  (TIMESTAMPDIFF(h,${created_raw},${completed_raw})) / 24 ;;
    value_format_name: decimal_2
  }


  set: detail {
    fields: [
      id,
      key,
      summary,
      name
    ]
  }
}
