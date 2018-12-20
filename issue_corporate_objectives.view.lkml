view: issue_corporate_objectives {
  sql_table_name: CONNECTORS.JIRA.ISSUE_CORPORATE_OBJECTIVES ;;


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}."ISSUE_ID" ;;
  }

  dimension: _fivetran_id {
    type: string
    sql: ${TABLE}."_FIVETRAN_ID" ;;
  }

  dimension: field_option_id {
    type: number
    sql: ${TABLE}."FIELD_OPTION_ID" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
  }

  set: detail {
    fields: [issue_id, _fivetran_id, field_option_id, _fivetran_synced_time]
  }

}
