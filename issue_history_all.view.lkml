# This PDT is used to produce a single list of all historical changes in issues
# It is used for displaying a complete list of the history of an issue in
# the Issue Details Dashboard.
# It is made by Unioning together all of the history tables
# Each table has an additional hard coded value aliased as "changed"
# to indicate the value that was changed

# The examples below are to be used as a template and will not
# match the history tables in your installation

view: issue_history_all {
  derived_table: {
    #datagroup_trigger: fivetran_datagroup Currently there is no scratch schema
    sql: -- History tables for single value fields
      select ph.issue_id, ph.time, p.name, 'Project' as changed from connectors.jira.issue_project_history ph
      LEFT OUTER JOIN connectors.jira.project p on ph.project_id = p.id
      UNION
      select sh.issue_id, sh.time, fo.name, 'Severity' as changed from connectors.jira.issue_severity_history sh
      LEFT OUTER JOIN connectors.jira.field_option fo on sh.field_option_id = fo.id

       ;;
    #indexes: ["issue_id", "time"]
    # For Redshift only
    #distribution_style: all
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.issue_id ;;
  }

  dimension_group: time {
    type: time
    sql: ${TABLE}.time ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: changed {
    type: string
    sql: ${TABLE}.changed ;;
  }

  set: detail {
    fields: [issue_id, time_time, value, changed]
  }
}
