explore: infinity {label:"Infinity"}

view: infinity {
  derived_table: {
    sql: Select
      i."KEY",
      i."SUMMARY",
      i."DESCRIPTION",
      i."STATUS",
      i."ASSIGNEE",
      i."REPORTER",
      i."TARGET_COMPLETE_DATE",
      i."CORPORATE_INITIATIVE",
      i."QUARTER",
      i."YEAR",
      i."CUSTOMER_ORGANIZATION",
      fo."NAME" as corporate_objectives,
      i."HIGH_LEVEL_ESTIMATE_WEEKS_",
      i."PRIORITY",
      e."SUMMARY" as epic_summary,
      e."NAME" as epic_name,
      e."DONE",
      e."KEY" as epic_key,
      i_link."RELATED_ISSUE_ID",
      i_link."RELATIONSHIP",
      i_type."NAME" as issue_type,
      p."NAME" as project_name,
      s."NAME" as status_name,
      sprint."NAME" as sprint_name
      from CONNECTORS.JIRA.ISSUE as i
      LEFT OUTER join CONNECTORS.JIRA.EPIC as e on i."EPIC_LINK" = e."ID"
      LEFT OUTER join CONNECTORS.JIRA.ISSUE_LABELS as i_label on i."ID" = i_label."ISSUE_ID"
      LEFT OUTER join CONNECTORS.JIRA.ISSUE_LINK as i_link on i."ID" = i_link."ISSUE_ID"
      LEFT OUTER join CONNECTORS.JIRA.ISSUE_TYPE as i_type on i."ISSUE_TYPE" = i_type."ID"
      LEFT OUTER join CONNECTORS.JIRA.PROJECT as p on i."PROJECT" = p."ID"
      LEFT OUTER join CONNECTORS.JIRA.STATUS as s on i."STATUS" = s."ID"
      LEFT OUTER join CONNECTORS.JIRA.ISSUE_SPRINT as i_sprint on i."ID"=i_sprint."ISSUE_ID"
      LEFT OUTER join CONNECTORS.JIRA.SPRINT as sprint on i_sprint."SPRINT_ID" = sprint."ID"
      LEFT OUTER JOIN CONNECTORS.JIRA.ISSUE_CORPORATE_OBJECTIVES as ico on i."ID" = ico."ISSUE_ID"
      LEFT OUTER JOIN CONNECTORS.JIRA.FIELD_OPTION as fo on ico."FIELD_OPTION_ID" = fo."ID"
      WHERE P."NAME" LIKE 'INF%'

      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
                ,21,22,23,24


       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: key {
    type: string
    sql: ${TABLE}."KEY" ;;
  }

  dimension: summary {
    type: string
    link: {
      label: "Go to JIRA"
      url: "https://discoverorg.atlassian.net/browse/{{infinity.key.value}}"
        }
    sql: ${TABLE}."SUMMARY" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}."ASSIGNEE" ;;
  }

  dimension: reporter {
    type: string
    sql: ${TABLE}."REPORTER" ;;
  }

  dimension: target_complete_date {
    type: date
    sql: ${TABLE}."TARGET_COMPLETE_DATE" ;;
  }

  dimension: corporate_initiative {
    type: number
    sql: ${TABLE}."CORPORATE_INITIATIVE" ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: customer_organization {
    type: number
    sql: ${TABLE}."CUSTOMER_ORGANIZATION" ;;
  }

  dimension: corporate_objectives {
    type: string
    sql: ${TABLE}."CORPORATE_OBJECTIVES" ;;
  }

  dimension: high_level_estimate_weeks_ {
    type: number
    sql: ${TABLE}."HIGH_LEVEL_ESTIMATE_WEEKS_" ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}."PRIORITY" ;;
  }

  dimension: epic_summary {
    type: string
    sql: ${TABLE}."EPIC_SUMMARY" ;;
  }

  dimension: epic_name {
    type: string
    sql: ${TABLE}."EPIC_NAME" ;;
  }

  dimension: done {
    type: string
    sql: ${TABLE}."DONE" ;;
  }

  dimension: epic_key {
    type: string
    sql: ${TABLE}."EPIC_KEY" ;;
  }

  dimension: related_issue_id {
    type: number
    sql: ${TABLE}."RELATED_ISSUE_ID" ;;
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}."RELATIONSHIP" ;;
  }

  dimension: issue_type {
    type: string
    sql: ${TABLE}."ISSUE_TYPE" ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}."PROJECT_NAME" ;;
  }

  dimension: status_name {
    type: string
    sql: ${TABLE}."STATUS_NAME" ;;
  }

  dimension: sprint_name {
    type: string
    sql: ${TABLE}."SPRINT_NAME" ;;
  }

  set: detail {
    fields: [
      key,
      summary,
      description,
      status,
      assignee,
      reporter,
      target_complete_date,
      corporate_initiative,
      quarter,
      year,
      customer_organization,
      corporate_objectives,
      high_level_estimate_weeks_,
      priority,
      epic_summary,
      epic_name,
      done,
      epic_key,
      related_issue_id,
      relationship,
      issue_type,
      project_name,
      status_name,
      sprint_name
    ]
  }
}
