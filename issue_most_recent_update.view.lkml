view: issue_most_recent_update {
  derived_table: {
    sql: select tbl."ID",tbl."KEY",tbl."SUMMARY",tbl.most_recent_status_date,tbl.most_recent_status_time,tbl."NAME"
      from (
      select
      i."ID",
      i."KEY",
      i."SUMMARY",
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

  dimension: most_recent_status_date {
    type: date
    sql: ${TABLE}."MOST_RECENT_STATUS_DATE" ;;
  }

  dimension_group: most_recent_status_time {
    type: time
    sql: ${TABLE}."MOST_RECENT_STATUS_TIME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: complete_date {
    type: date
    sql:  ${name} = 'Done' ;;
  }

  dimension: complete_time {
    type: date_time
    sql:  ${name} = 'Done' ;;
  }



  set: detail {
    fields: [
      id,
      key,
      summary,
      most_recent_status_date,
      most_recent_status_time_time,
      name
    ]
  }
}
