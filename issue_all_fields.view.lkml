#explore: issue_all_fields {}
view: issue_all_fields {
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

  dimension: due {
    group_label: "Dates"
    type: date
    sql: ${TABLE}."DUE_DATE" ;;
  }

  dimension_group: last_viewed {
    group_label: "Dates"
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

  dimension: start {
    group_label: "Dates"
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

  dimension: breaking_changes {
    type: number
    sql: ${TABLE}."BREAKING_CHANGES_" ;;
  }

  dimension_group: created {
    group_label: "Dates"
    type: time
    timeframes: [raw,date,week,month,year]
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
    link: {
      label: "Click to go to the doc"
      url: "{{value}}"
    }
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
    link: {
      label: "Go to JIRA"
      icon_url: "https://discoverorg.atlassian.net/favicon-software.ico"
      url: "https://discoverorg.atlassian.net/browse/{{issue_all_fields.key._value}}"
    }
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
    group_label: "Dates"
    type: time
    timeframes: [date,week,month,year]
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

  dimension_group: change_start {
    group_label: "Dates"
    type: time
    timeframes: [date,week,month,year]
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

  dimension: punch_list {
    type: string
    sql:
           Case when ${target_complete_date} < current_date + 7 then 'True'
                when ${target_complete_date} >= current_date + 7 then 'False'
                when ${target_complete_date} is null then 'No input provided'
            else null
            end
    ;;
  }

  dimension: time_bucket {
    type: string
    sql:
           Case when ${target_complete_date} <= current_date then '1. As of Today'
                when ${target_complete_date} <= current_date + 14 then '2. Next 2 Weeks'
                when ${target_complete_date} <= current_date + 28 then  '3. 2-4 weeks out'
                when ${target_complete_date}  > current_date + 28 then  '4. 4+ weeks out'
                when ${target_complete_date} is null then '5. No input provided'
            else null
            end
    ;;
  }



  dimension: authorized_by {
    type: string
    sql: ${TABLE}."AUTHORIZED_BY" ;;
  }

  dimension_group: deployment {
    group_label: "Dates"
    timeframes: [date,week,month,year]
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

  dimension_group: satisfaction {
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
      url: "https://discoverorg.atlassian.net/browse/{{issue_all_fields.key._value}}"
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

  ############## Special Dimension to sort the summary field ########

  dimension: is_epic {
    type: yesno
    sql: ${issue_type} = 6 ;;
  }

  dimension: is_task {
    type: yesno
     sql: ${issue_type} = 12355  ;; ##Logic here
  }

  dimension: is_task_w_epic {
    type: yesno
    sql: ${issue_type} = 12355 AND ${epic_link} > 0 ;; ##Logic here
  }

  dimension: no_epic {
    type: number
    sql: CASE
            when ${epic_link} > 0 THEN 1
            ELSE 0
            END;;
  }

  dimension: is_task_wo_epic {
    type: yesno
    sql: ${issue_type} = 12355 AND ${no_epic} = 0 ;; ##Logic here
  }
  dimension: is_sub_task {
    type: yesno
    #sql:  ;;
    sql: ${issue_type} = 12356 ;;
  }

  dimension: new_summ {
    type: string
    sql:
        Case when ${is_epic}  then ${summary}
            when ${is_task_w_epic} then concat('. . . .',${summary})
            when ${is_task_wo_epic} then concat('.ne. . .',${summary})
            when ${is_sub_task} then concat('. . . . . .--.',${summary})
        else ''
        end
    ;;



    }


    dimension: new_summ_size {
      type: string
      sql:  ${TABLE}."ISSUE_TYPE" ;;

      html:
      {% if value == 6 %}
      <p style="font-size: 175%">{{ new_summ }}</p>
      {% elsif value == 12355 %}
      <p style="font-size: 125%">{{ new_summ }}</p>
      {% else %}
      <p style="font-size: 85%">{{ new_summ }}</p>
      {% endif %}
      ;;

      }


  ############## Building Sort Key ########

  dimension: sort_key_1 {
    type: string
    sql:

       Case  when ${issue_type} = 6  then ${key}
             when ${issue_Link_1.epic_link} > 0 then ${issue_Link_2.key}
             when ${epic_link} > 0 then ${issue_Link_3.key}
            else ''
       end

        ;;
        }

  dimension: sort_key_2 {
    type: string
    sql:

       Case when ${issue_type} = 12355 then ${key}
            when ${issue_type} = 12356 then ${issue_Link_1.key}
            else ''
       end

        ;;
  }

    dimension: sort_key_3 {
    type: string
    sql:

        Case when ${issue_type} = 12356 then ${key}
        else ''
        end

    ;;
  }

  dimension: sort_key {
    type: string
    sql:

        concat(
           concat(${sort_key_1}, ${sort_key_2})
          , ${sort_key_3})

    ;;
  }

#   dimension: sort_key {
#     type: string
#     #sql:  ;;
#   }



  ############### Measures ####################
  measure: count_issue {
    type: count
    drill_fields: [detail*]
  }

  measure: count_issue_pbi {
    type:  count
    drill_fields: [id, key, assignee]
  }

# Additional field for a simple way to determine
  # if an issue is resolved
  dimension: is_issue_resolved {
    group_label: "Resolution"
    type: yesno
    sql: ${resolved_date} IS NOT NULL ;;
  }

  # Custom dimensions for time to resolve issue
  dimension: hours_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Hours)"
    type: number
    sql: DATEDIFF(h,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  dimension: minutes_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Minutes)"
    type: number
    sql: DATEDIFF(m,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  dimension: days_to_resolve_issue {
    group_label: "Resolution"
    label: "Time to Resolve (Days)"
    type: number
    sql: DATEDIFF(d,${created_raw},${resolved_raw}) ;;
    value_format_name: decimal_0
  }

  measure: total_time_to_resolve_issues_hours {
    group_label: "Resolution"
    label: "Total Time to Resolve Issues per Grouping"
    description: "The total hours required to resolve all issues in the chosen dimension grouping"
    type: sum
    sql: ${days_to_resolve_issue} ;;
    value_format_name: decimal_0
  }

  measure: avg_time_to_resolve_issues_hours {
    group_label: "Resolution"
    label: "Avg Time to Resolve Issues per Grouping"
    description: "The average hours required to resolve all issues in the chosen dimension grouping"
    type: average
    sql: ${days_to_resolve_issue} ;;
    value_format_name: decimal_0
  }

  measure: total_story_points {
    type: sum
    sql: ${story_points} ;;
  }

  measure: summary_list {
    description: "Use Time Bucket Dimension"
    type: string
    sql: listagg(${summary}, '  ||  ') ;;
  }

  dimension: days_to_complete {
    type: number
    sql: DATEDIFF(d,${current_date},${target_complete_date} ) ;;
    value_format_name: decimal_0
    drill_fields: [issue_all_fields.key, issue_all_fields.assignee, sprint.name]
  }

  measure: due_in_7_days {
    type: count
    filters: {
      field: days_to_complete
      value: ">0 AND <7"
    }
    drill_fields: [issue_all_fields.key, issue_all_fields.assignee, target_complete_date, sprint.name]
  }

  measure: past_due {
    type: count
    filters: {
      field: days_to_complete
      value: "<-3"
    }
    drill_fields: [issue_all_fields.key, issue_all_fields.assignee, target_complete_date, sprint.name]
  }

  dimension: current_date {
    type: date
    sql: select current_date ;;
  }

  set: detail {
    fields: [
      key,target_complete_date,status, resolution, days_to_resolve_issue
    ]
  }

  set: details_2 {
    fields: [id]
  }


  }
