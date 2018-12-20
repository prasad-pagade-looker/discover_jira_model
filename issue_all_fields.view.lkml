#explore: issue_all_fields {}
view: issue {
  sql_table_name: connectors.jira.issue ;;

  ####### Dimensions ##################

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: mbo_ {
    type: number
    sql: ${TABLE}."MBO_" ;;
  }

  dimension: routine_change {
    type: number
    sql: ${TABLE}."ROUTINE_CHANGE" ;;
  }

  dimension: termination_checklist_finance {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_FINANCE" ;;
  }

  dimension: ro_request_origin {
    type: number
    sql: ${TABLE}."RO_REQUEST_ORIGIN" ;;
  }

  dimension: requires_properties_changes_prop_ {
    type: number
    sql: ${TABLE}."REQUIRES_PROPERTIES_CHANGES_PROP_" ;;
  }

  dimension: epic_link {
    type: number
    sql: ${TABLE}."EPIC_LINK" ;;
  }

  dimension: current_branch_name {
    type: string
    sql: ${TABLE}."CURRENT_BRANCH_NAME" ;;
  }

  dimension: termination_checklist_tech_team {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_TECH_TEAM" ;;
  }

  dimension: development {
    type: string
    sql: ${TABLE}."DEVELOPMENT" ;;
  }

  dimension: customer_organization {
    type: number
    sql: ${TABLE}."CUSTOMER_ORGANIZATION" ;;
  }

  dimension: time_spent {
    type: number
    sql: ${TABLE}."TIME_SPENT" ;;
  }

  dimension: epic_theme {
    type: string
    sql: ${TABLE}."EPIC_THEME" ;;
  }

  dimension: _time_spent {
    type: number
    sql: ${TABLE}."_TIME_SPENT" ;;
  }

  dimension: workaround {
    type: string
    sql: ${TABLE}."WORKAROUND" ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: termination_checklist_research {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_RESEARCH" ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}."ASSIGNEE" ;;
  }

  dimension: feature_set {
    type: number
    sql: ${TABLE}."FEATURE_SET" ;;
  }

  dimension: qa_priority {
    type: number
    sql: ${TABLE}."QA_PRIORITY" ;;
  }

  dimension: est_hours_required {
    type: number
    sql: ${TABLE}."EST_HOURS_REQUIRED" ;;
  }

  dimension: due_date {
    type: date
    sql: ${TABLE}."DUE_DATE" ;;
  }

  dimension_group: last_viewed {
    type: time
    sql: ${TABLE}."LAST_VIEWED" ;;
  }

  dimension: project {
    type: number
    sql: ${TABLE}."PROJECT" ;;
  }

  dimension: issue_type {
    type: number
    sql: ${TABLE}."ISSUE_TYPE" ;;
  }

  dimension: self_service_code {
    type: number
    sql: ${TABLE}."SELF_SERVICE_CODE" ;;
  }

  dimension: termination_checklist_hr {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_HR" ;;
  }

  dimension: original_requester {
    type: string
    sql: ${TABLE}."ORIGINAL_REQUESTER" ;;
  }

  dimension: re_index_required {
    type: number
    sql: ${TABLE}."RE_INDEX_REQUIRED" ;;
  }

  dimension: high_level_estimate_weeks_ {
    type: number
    sql: ${TABLE}."HIGH_LEVEL_ESTIMATE_WEEKS_" ;;
  }

  dimension: value_add_ {
    type: number
    sql: ${TABLE}."VALUE_ADD_" ;;
  }

  dimension: task_type {
    type: number
    sql: ${TABLE}."TASK_TYPE" ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}."START_DATE" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }

  dimension: change_risk {
    type: number
    sql: ${TABLE}."CHANGE_RISK" ;;
  }

  dimension: breaking_changes_ {
    type: number
    sql: ${TABLE}."BREAKING_CHANGES_" ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}."CREATED" ;;
  }

  dimension_group: change_completion_date {
    type: time
    sql: ${TABLE}."CHANGE_COMPLETION_DATE" ;;
  }

  dimension: technical_specs {
    type: string
    sql: ${TABLE}."TECHNICAL_SPECS" ;;
  }

  dimension: work_ratio {
    type: number
    sql: ${TABLE}."WORK_RATIO" ;;
  }

  dimension: doc_url {
    type: string
    sql: ${TABLE}."DOC_URL" ;;
  }

  dimension: rollback_plan {
    type: string
    sql: ${TABLE}."ROLLBACK_PLAN" ;;
  }

  dimension: approvers {
    type: string
    sql: ${TABLE}."APPROVERS" ;;
  }

  dimension: radar {
    type: number
    sql: ${TABLE}."RADAR" ;;
  }

  dimension: mbo_points {
    type: number
    sql: ${TABLE}."MBO_POINTS" ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}."KEY" ;;
  }

  dimension: desk_com_case_url {
    type: string
    sql: ${TABLE}."DESK_COM_CASE_URL" ;;
  }

  dimension: termination_checklist_marketing {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_MARKETING" ;;
  }

  dimension: aha_reference {
    type: string
    sql: ${TABLE}."AHA_REFERENCE" ;;
  }

  dimension: emergency_change {
    type: number
    sql: ${TABLE}."EMERGENCY_CHANGE" ;;
  }

  dimension: reporter {
    type: string
    sql: ${TABLE}."REPORTER" ;;
  }

  dimension: new_hire_checklist_marketing {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_MARKETING" ;;
  }

  dimension: applications_to_modify {
    type: string
    sql: ${TABLE}."APPLICATIONS_TO_MODIFY" ;;
  }

  dimension: notify_when_fixed {
    type: string
    sql: ${TABLE}."NOTIFY_WHEN_FIXED" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: test_plan {
    type: string
    sql: ${TABLE}."TEST_PLAN" ;;
  }

  dimension: qa_approval {
    type: string
    sql: ${TABLE}."QA_APPROVAL" ;;
  }

  dimension: dev_approval {
    type: string
    sql: ${TABLE}."DEV_APPROVAL" ;;
  }

  dimension: original_estimate {
    type: number
    sql: ${TABLE}."ORIGINAL_ESTIMATE" ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: benefit {
    type: string
    sql: ${TABLE}."BENEFIT" ;;
  }

  dimension: acceptance_criteria {
    type: string
    sql: ${TABLE}."ACCEPTANCE_CRITERIA" ;;
  }

  dimension: investigation_reason {
    type: number
    sql: ${TABLE}."INVESTIGATION_REASON" ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}."CREATOR" ;;
  }

  dimension: projected_release_date {
    type: date
    sql: ${TABLE}."PROJECTED_RELEASE_DATE" ;;
  }

  dimension: change_reason {
    type: number
    sql: ${TABLE}."CHANGE_REASON" ;;
  }

  dimension: _remaining_estimate {
    type: number
    sql: ${TABLE}."_REMAINING_ESTIMATE" ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}."ACCOUNT_NAME" ;;
  }

  dimension: story_point_estimate {
    type: number
    sql: ${TABLE}."STORY_POINT_ESTIMATE" ;;
  }

  dimension: new_hire_checklist_research {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_RESEARCH" ;;
  }

  dimension_group: resolved {
    type: time
    sql: ${TABLE}."RESOLVED" ;;
  }

  dimension: _original_estimate {
    type: number
    sql: ${TABLE}."_ORIGINAL_ESTIMATE" ;;
  }

  dimension: impact {
    type: number
    sql: ${TABLE}."IMPACT" ;;
  }

  dimension: high_level_estimate {
    type: number
    sql: ${TABLE}."HIGH_LEVEL_ESTIMATE" ;;
  }

  dimension: new_hire_checklist_sales_sdr_ {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_SALES_SDR_" ;;
  }

  dimension: development_considerations {
    type: number
    sql: ${TABLE}."DEVELOPMENT_CONSIDERATIONS" ;;
  }

  dimension_group: updated {
    type: time
    sql: ${TABLE}."UPDATED" ;;
  }

  dimension: cab {
    type: string
    sql: ${TABLE}."CAB" ;;
  }

  dimension: priority {
    type: number
    sql: ${TABLE}."PRIORITY" ;;
  }

  dimension: new_hire_checklist_hr {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_HR" ;;
  }

  dimension: root_cause {
    type: string
    sql: ${TABLE}."ROOT_CAUSE" ;;
  }

  dimension: number_of_users_affected {
    type: number
    sql: ${TABLE}."NUMBER_OF_USERS_AFFECTED" ;;
  }

  dimension: corporate_initiative {
    type: number
    sql: ${TABLE}."CORPORATE_INITIATIVE" ;;
  }

  dimension: new_hire_checklist_customer_success_cdr_ {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_CUSTOMER_SUCCESS_CDR_" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: product_category {
    type: number
    sql: ${TABLE}."PRODUCT_CATEGORY" ;;
  }

  dimension: qa_testing_class {
    type: number
    sql: ${TABLE}."QA_TESTING_CLASS" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."ENVIRONMENT" ;;
  }

  dimension_group: change_start_date {
    type: time
    sql: ${TABLE}."CHANGE_START_DATE" ;;
  }

  dimension: ro_requested_action {
    type: number
    sql: ${TABLE}."RO_REQUESTED_ACTION" ;;
  }

  dimension: resolution {
    type: number
    sql: ${TABLE}."RESOLUTION" ;;
  }

  dimension: requires_database_changes_ {
    type: number
    sql: ${TABLE}."REQUIRES_DATABASE_CHANGES_" ;;
  }

  dimension: reviewed_by {
    type: string
    sql: ${TABLE}."REVIEWED_BY"  ;;
  }

  dimension: target_complete_date {
    type: date
    sql: ${TABLE}."TARGET_COMPLETE_DATE" ;;
  }

  dimension: is_past_due {
    type: string
    sql:
           Case when ${target_complete_date} < current_date then 'Past Due'
                when ${target_complete_date} >= current_date then 'Not Past Due'
                when ${target_complete_date} is null then 'No input provided'
            else null
            end
    ;;
  }

  dimension: authorized_by {
    type: string
    sql: ${TABLE}."AUTHORIZED_BY" ;;
  }

  dimension_group: deployment_date_time {
    type: time
    sql: ${TABLE}."DEPLOYMENT_DATE_TIME" ;;
  }

  dimension: viewers {
    type: string
    sql: ${TABLE}."VIEWERS" ;;
  }

  dimension: corporate_objectives {
    type: number
    sql: ${TABLE}."CORPORATE_OBJECTIVES" ;;
  }

  dimension: project_milestones {
    type: number
    sql: ${TABLE}."PROJECT_MILESTONES" ;;
  }

  dimension: source {
    type: number
    sql: ${TABLE}."SOURCE" ;;
  }

  dimension: system {
    type: number
    sql: ${TABLE}."SYSTEM" ;;
  }

  dimension: issue_color {
    type: string
    sql: ${TABLE}."ISSUE_COLOR" ;;
  }

  dimension: function {
    type: string
    sql: ${TABLE}."FUNCTION" ;;
  }

  dimension: parent_link {
    type: number
    sql: ${TABLE}."PARENT_LINK" ;;
  }

  dimension: change_managers {
    type: string
    sql: ${TABLE}."CHANGE_MANAGERS" ;;
  }

  dimension: pending_reason {
    type: number
    sql: ${TABLE}."PENDING_REASON" ;;
  }

  dimension: account_revenue {
    type: number
    sql: ${TABLE}."ACCOUNT_REVENUE" ;;
  }

  dimension: remaining_estimate {
    type: number
    sql: ${TABLE}."REMAINING_ESTIMATE" ;;
  }

  dimension: new_hire_checklist_research_ops {
    type: number
    sql: ${TABLE}."NEW_HIRE_CHECKLIST_RESEARCH_OPS" ;;
  }

  dimension: csm {
    type: string
    sql: ${TABLE}."CSM" ;;
  }

  dimension: change_type {
    type: number
    sql: ${TABLE}."CHANGE_TYPE" ;;
  }

  dimension: database_changes_backwards_compatible_ {
    type: number
    sql: ${TABLE}."DATABASE_CHANGES_BACKWARDS_COMPATIBLE_" ;;
  }

  dimension: dev_outcome_notes {
    type: string
    sql: ${TABLE}."DEV_OUTCOME_NOTES" ;;
  }

  dimension_group: satisfaction_date {
    type: time
    sql: ${TABLE}."SATISFACTION_DATE" ;;
  }

  dimension: actual_release_date {
    type: date
    sql: ${TABLE}."ACTUAL_RELEASE_DATE" ;;
  }

  dimension: originated_in_dev_beta {
    type: number
    sql: ${TABLE}."ORIGINATED_IN_DEV_BETA" ;;
  }

  dimension: severity {
    type: number
    sql: ${TABLE}."SEVERITY" ;;
  }

  dimension: product_owner_approval {
    type: string
    sql: ${TABLE}."PRODUCT_OWNER_APPROVAL" ;;
  }

  dimension: qa_status {
    type: number
    sql: ${TABLE}."QA_STATUS" ;;
  }

  dimension: termination_checklist_sales_cs {
    type: number
    sql: ${TABLE}."TERMINATION_CHECKLIST_SALES_CS" ;;
  }

  dimension: testing_priority {
    type: number
    sql: ${TABLE}."TESTING_PRIORITY" ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}."SUMMARY" ;;
    link: {
      label: "Go to JIRA"
      icon_url: "https://discoverorg.atlassian.net/favicon-software.ico"
      url: "https://discoverorg.atlassian.net/browse/{{issue.id._value}}"
    }
  }

  dimension: urgency {
    type: number
    sql: ${TABLE}."URGENCY" ;;
  }

  dimension: flagged {
    type: number
    sql: ${TABLE}."FLAGGED" ;;
  }

  dimension: business_impact {
    type: string
    sql: ${TABLE}."BUSINESS_IMPACT" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    sql: ${TABLE}."_FIVETRAN_SYNCED" ;;
  }

  dimension: metrics_impacted {
    type: number
    sql: ${TABLE}."METRICS_IMPACTED" ;;
  }

  dimension: epic_status {
    type: number
    sql: ${TABLE}."EPIC_STATUS" ;;
  }

  dimension: product_owner {
    type: string
    sql: ${TABLE}."PRODUCT_OWNER" ;;
  }

  dimension: epic_colour {
    type: string
    sql: ${TABLE}."EPIC_COLOUR" ;;
  }

  dimension: story_points {
    type: number
    sql: ${TABLE}."STORY_POINTS" ;;
  }

  dimension: epic_name {
    type: string
    sql: ${TABLE}."EPIC_NAME" ;;
  }

  dimension: team_owning {
    type: number
    sql: ${TABLE}."TEAM_OWNING" ;;
  }

  dimension: acceptance_testing {
    type: number
    sql: ${TABLE}."ACCEPTANCE_TESTING" ;;
  }

  dimension: business_value {
    type: number
    sql: ${TABLE}."BUSINESS_VALUE" ;;
  }

  dimension: epic_work_type {
    type: number
    sql: ${TABLE}."EPIC_WORK_TYPE" ;;
  }

  dimension: customer_impacting_ {
    type: number
    sql: ${TABLE}."CUSTOMER_IMPACTING_" ;;
  }

  dimension: deployment_priority_ {
    type: number
    sql: ${TABLE}."DEPLOYMENT_PRIORITY_" ;;
  }

  dimension: phase {
    type: number
    sql: ${TABLE}."PHASE" ;;
  }

  dimension: tag_created_ {
    type: number
    sql: ${TABLE}."TAG_CREATED_" ;;
  }

  ############### Measures ####################
  measure: count_issue {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      mbo_,
      routine_change,
      termination_checklist_finance,
      ro_request_origin,
      requires_properties_changes_prop_,
      epic_link,
      current_branch_name,
      termination_checklist_tech_team,
      development,
      customer_organization,
      time_spent,
      epic_theme,
      _time_spent,
      workaround,
      status,
      termination_checklist_research,
      assignee,
      feature_set,
      qa_priority,
      est_hours_required,
      due_date,
      last_viewed_time,
      project,
      issue_type,
      self_service_code,
      termination_checklist_hr,
      original_requester,
      re_index_required,
      high_level_estimate_weeks_,
      value_add_,
      task_type,
      start_date,
      description,
      change_risk,
      breaking_changes_,
      created_time,
      change_completion_date_time,
      technical_specs,
      work_ratio,
      doc_url,
      rollback_plan,
      approvers,
      radar,
      mbo_points,
      key,
      desk_com_case_url,
      termination_checklist_marketing,
      aha_reference,
      emergency_change,
      reporter,
      new_hire_checklist_marketing,
      applications_to_modify,
      notify_when_fixed,
      year,
      test_plan,
      qa_approval,
      dev_approval,
      original_estimate,
      quarter,
      benefit,
      acceptance_criteria,
      investigation_reason,
      creator,
      projected_release_date,
      change_reason,
      _remaining_estimate,
      account_name,
      story_point_estimate,
      new_hire_checklist_research,
      resolved_time,
      _original_estimate,
      impact,
      high_level_estimate,
      new_hire_checklist_sales_sdr_,
      development_considerations,
      updated_time,
      cab,
      priority,
      new_hire_checklist_hr,
      root_cause,
      number_of_users_affected,
      corporate_initiative,
      new_hire_checklist_customer_success_cdr_,
      parent_id,
      product_category,
      qa_testing_class,
      environment,
      change_start_date_time,
      ro_requested_action,
      resolution,
      requires_database_changes_,
      reviewed_by,
      target_complete_date,
      authorized_by,
      deployment_date_time_time,
      viewers,
      corporate_objectives,
      project_milestones,
      source,
      system,
      issue_color,
      function,
      parent_link,
      change_managers,
      pending_reason,
      account_revenue,
      remaining_estimate,
      new_hire_checklist_research_ops,
      csm,
      change_type,
      database_changes_backwards_compatible_,
      dev_outcome_notes,
      satisfaction_date_time,
      actual_release_date,
      originated_in_dev_beta,
      severity,
      product_owner_approval,
      qa_status,
      termination_checklist_sales_cs,
      testing_priority,
      summary,
      urgency,
      flagged,
      business_impact,
      _fivetran_synced_time,
      metrics_impacted,
      epic_status,
      product_owner,
      epic_colour,
      story_points,
      epic_name,
      team_owning,
      acceptance_testing,
      business_value,
      epic_work_type,
      customer_impacting_,
      deployment_priority_,
      phase,
      tag_created_
    ]
  }

  set: details_2 {
    fields: [id]
  }


  }
