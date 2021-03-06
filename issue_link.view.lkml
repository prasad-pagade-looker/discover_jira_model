view: issue_link {
  sql_table_name: connectors.JIRA.ISSUE_LINK ;;

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

  dimension: related_issue_id {
    type: number
    sql: ${TABLE}.RELATED_ISSUE_ID ;;
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}.RELATIONSHIP ;;
  }

  measure: count {
    type: count
    drill_fields: [issue.id, issue.epic_name]
  }
}
