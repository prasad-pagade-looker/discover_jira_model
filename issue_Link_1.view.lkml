  #explore: issue_Link_1 {}
  view: issue_Link_1 {
    sql_table_name: connectors.jira.issue ;;

    ####### Dimensions ##################

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}."ID" ;;
    }


    dimension: epic_link {
      type: number
      sql: ${TABLE}."EPIC_LINK" ;;
    }


    dimension: project {
      type: number
      sql: ${TABLE}."PROJECT" ;;
    }

    dimension: issue_type {
      type: number
      sql: ${TABLE}."ISSUE_TYPE" ;;
    }


    dimension: description {
      type: string
      sql: ${TABLE}."DESCRIPTION" ;;
    }


    dimension: key {
      type: string
      sql: ${TABLE}."KEY" ;;
    }


    dimension: parent_id {
      type: number
      sql: ${TABLE}."PARENT_ID" ;;
    }


    dimension: parent_link {
      type: number
      sql: ${TABLE}."PARENT_LINK" ;;
    }


    dimension: epic_name {
      type: string
      sql: ${TABLE}."EPIC_NAME" ;;
    }


  }
