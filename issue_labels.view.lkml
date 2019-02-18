view: issue_labels {
  sql_table_name: connectors.JIRA.ISSUE_LABELS ;;

  dimension: _fivetran_synced {
    type: string
    sql: ${TABLE}._FIVETRAN_SYNCED ;;
  }

  dimension: issue_id {
    primary_key: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.ISSUE_ID ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.VALUE ;;
  }

  measure: value_list {
    type: string
    sql: LISTAGG(${TABLE}.VALUE, ', ') ;;
    drill_fields: [issue.id, issue.epic_name]
  }

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name]
  }
}
