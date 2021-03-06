view: pdt_snapshot {
  derived_table: {
    sql_trigger_value: SELECT HOUR(CURTIME());;
    sql:
       -- the purpose of this query is to provide looker with the necessary data in an appropriately digested format to show the current count of issues in all statuses for a selection of projects as a continuous function of time and as a weekly snapshot. the query uses several
       -- common table expressions (CTEs) to perform iterative processing on a given dataset. for the first desired result, the data is pivoted on status to allow for a SUM OVER to give cumulative, current (at each row) counts of issues in all statuses. for the second desired
       -- result, an effectively variable length table with dates of all fridays in the selected projects is generated and unioned to the first result to allow for a weekly snapshot of cumulative counts. due to a few limitations (noted below), the creation of this friday table
       -- was unothodox.
WITH data_pull AS (
    SELECT
        project.name AS project_name,
        issue_all_fields.created AS null_max_date,
        IFNULL(MAX(issue_status_history.TIME), null_max_date) AS max_date,
        issue_all_fields."KEY"  AS issue_key,
        IFNULL(status.name, '0 - Backlog') AS status_name,
        lag(status_name) OVER (partition by issue_key ORDER BY max_date ASC) AS last_status
    FROM connectors.jira.issue  AS issue_all_fields
    LEFT JOIN connectors.JIRA.ISSUE_STATUS_HISTORY  AS issue_status_history ON (issue_all_fields."ID") = issue_status_history.ISSUE_ID
    LEFT JOIN connectors.JIRA.STATUS  AS status ON (ISSUE_STATUS_HISTORY."STATUS_ID") = status.ID
    LEFT JOIN connectors.jira.project AS project on (ISSUE_ALL_FIELDS.project) = project.id
    GROUP BY 1,2,4,5
    ), -- brings in all necessary columns from the appropriate tables. this includes the project creation date for when the issue status change date is null (any issue that has been created but not changed will not be included in the query without this - EPICs usually
       -- fall into this). the lag on status name gives the last status which is integral for the query to function (see second pivot below). partitioning by issue_key (instead of project_name) returns a null when an issue is created rather than the current status of
       -- the issue preceding.
status_piv AS (
    SELECT
    * FROM data_pull
        PIVOT
        (
                COUNT(issue_key)
                FOR status_name IN
                ('0 - Backlog', '1 - Newly Assigned', '2 - Not Started', '3 - Not Started Behind', '4 - In Progress On Time', '5 - In Progress Behind', '6 - Ready for Sign Off', '7 - Completed',  '8 - Not Needed', '9 - On Going Work')
        )
    ), -- pivots on current status and counts issues. it does not count when an issue leaves a status and a SUM OVER this table would only increase, showing the count of all issues that have had a given status (not a current count).
lstat_piv AS (
    SELECT
    * FROM data_pull
        PIVOT
        (
                COUNT(issue_key)
                FOR last_status IN
                ('0 - Backlog', '1 - Newly Assigned', '2 - Not Started', '3 - Not Started Behind', '4 - In Progress On Time', '5 - In Progress Behind', '6 - Ready for Sign Off', '7 - Completed',  '8 - Not Needed', '9 - On Going Work')
        )
    ), -- pivots on last status and counts issues. it only counts when an issue leaves a status and a SUM OVER this table would only increase, showing the count of all issues that have left a given status (not a current count).
matrix_sum AS (
    SELECT
        project_name, max_date, SUM("'0 - Backlog'") AS backlog_move, SUM("'1 - Newly Assigned'") AS newly_move, SUM("'2 - Not Started'") AS not_started_move, SUM("'3 - Not Started Behind'") AS not_started_behind_move, SUM("'4 - In Progress On Time'") AS in_progress_move,
        SUM("'5 - In Progress Behind'") AS in_progress_behind_move, SUM("'6 - Ready for Sign Off'") AS ready_for_sign_move, SUM("'7 - Completed'") AS completed_move, SUM("'8 - Not Needed'") AS not_needed_move, SUM("'9 - On Going Work'") AS on_going_move
    FROM
        (
        SELECT
            project_name,  max_date, "'0 - Backlog'", "'1 - Newly Assigned'", "'2 - Not Started'", "'3 - Not Started Behind'", "'4 - In Progress On Time'", "'5 - In Progress Behind'", "'6 - Ready for Sign Off'", "'7 - Completed'", "'8 - Not Needed'", "'9 - On Going Work'"
        FROM status_piv
        UNION all
        SELECT
            project_name,  max_date, ZEROIFNULL(("'0 - Backlog'")*(-1)), ZEROIFNULL(("'1 - Newly Assigned'")*(-1)), ZEROIFNULL(("'2 - Not Started'")*(-1)), ZEROIFNULL(("'3 - Not Started Behind'")*(-1)), ZEROIFNULL(("'4 - In Progress On Time'")*(-1)),
            ZEROIFNULL(("'5 - In Progress Behind'")*(-1)), ZEROIFNULL(("'6 - Ready for Sign Off'")*(-1)), ZEROIFNULL(("'7 - Completed'")*(-1)), ZEROIFNULL(("'8 - Not Needed'")*(-1)), ZEROIFNULL(("'9 - On Going Work'")*(-1))
        FROM lstat_piv
        )
    GROUP BY 1,2
    ), -- this is where the magic happens. by summing corresponding cells in both matrices (and multiplying the latter pivot by a negative unit scalar), the resulting table is a changelog of activity for each status. A SUM OVER this table returns only a count of issues
       -- currently in a given status. now that's algebraic!
issue_join AS (
    SELECT
        max_date AS join_date, issue_key
    FROM data_pull
    Group BY 1,2
    ), -- prepares the issue key to be joined back into the table as it was lost during the pivots' aggregation over it.
timespan AS (
    SELECT
        project_name, MIN(max_date) AS start_date, DATEDIFF(week, start_date, CURRENT_DATE()) AS total_weeks,
        DATE_TRUNC('DAY',DATEADD('day', (5 - extract('dayofweek_iso', start_date)) , start_date)) AS first_friday
    FROM data_pull
    WHERE project_name like 'INF%'
    GROUP BY 1
    ), -- returns the earliest date of an issue change of the selected projects, the number of weeks elapsed to date, and the first friday in that timeframe.
       --  the WHERE clause is an unfortunate, non-parameterized solution to a rather paradoxical side effect of this query:
       --    in order for the fridays to show up in the query and allow us the weekly snapshot (half of the query's very purpose), it must contain 'INF' in the project name (filter A). ok but we assign 'INFWEEKLY' to project name of every friday date generated (keyword B) so that
       --    they are included in the query and those fridays are seeded by the earliest issue change in the projects that meet the filter's criterion (seed date C). With only a global filter, the query returns 156 fridays (total length of static_gen table) from the first status
       --    change of any issue in any project in the database. this happens because:
       --    1. the first friday in all_fridays, by definition, becomes the first friday of any project that meets selection criteria (intentional)
       --    2. the global filter is applied after the seed is selected so the seed becomes the earliest possible friday in the database (unintentional)
       --    3. that friday and the following 155 are given the project name 'INFWEEKLY', so they are included in the query which breaks the filter (not desired)
       --  in other words; because of filter A, keyword B is necessary but B changes seed date C such that it invalidates A. to sidestep this paradox at the cost of scalability, a static filter was placed in this CTE (before seed date is selected) so that B does not alter C and
       --  A functions as intended (when global and static filters are compatible).
static_gen AS (
    SELECT seq4() AS weeks FROM table(generator(rowcount => 156))
    ), -- the desired result is a table of n length where n is the number of weeks elapsed in timespan. due to limitations of the read-only database and snowflake's lack of recursion support, tables can't be created directly. instead, a simple, static sequence can be
       -- generated with a fixed length (of 3 years). Step 1/3.
all_fridays AS (
    SELECT
        MIN(first_friday) AS earliest_friday, weeks, DATEADD('week', weeks, earliest_friday) AS every_friday, DATEADD('hour', 19, every_friday) AS friday_evenings
    FROM timespan
    CROSS JOIN static_gen
    GROUP BY 2
    ORDER BY weeks ASC
    ), -- uses static table and the first friday to generate dates for the 155 fridays following first. as every_friday is an aggregate function, it can't be used in a WHERE clause to truncate to just fridays in timespan (see mega_union for said truncation). Step 2/3.
mega_join AS (
    SELECT
        project_name, issue_key, max_date, backlog_move, newly_move, not_started_move, not_started_behind_move,  in_progress_move, in_progress_behind_move, ready_for_sign_move, completed_move, not_needed_move, on_going_move
    FROM matrix_sum
    LEFT JOIN issue_join AS issue_join ON (issue_join.join_date) = max_date
    ), -- joins issue key into matrix_sum.
mega_union AS (
    SELECT * FROM
        (
        SELECT * FROM mega_join
        UNION
        SELECT
            'INFWEEKLY' AS project_name, 'WEEKLY' AS issue_key, friday_evenings AS max_date, 0 AS backlog_move, 0 AS newly_move, 0 AS not_started_move, 0 AS not_started_behind_move,  0 AS in_progress_move, 0 AS in_progress_behind_move, 0 AS ready_for_sign_move,
            0 AS completed_move, 0 AS not_needed_move, 0 AS on_going_move
        FROM all_fridays
        )
    WHERE max_date <= CURRENT_DATE()+1
    ) -- unions the generated friday dates (and dummy values for remaining columns) with the current status table. an union was used to sidestep the inability to use INSERTs. Step 3/3.
    SELECT
        project_name, issue_key, max_date, backlog_move AS current_backlog, newly_move AS current_newly, not_started_move AS current_not_started, not_started_behind_move AS current_not_started_behind,  in_progress_move AS current_in_progress,
        in_progress_behind_move AS current_in_progress_behind, ready_for_sign_move AS current_ready_for_sign_off, completed_move AS current_completed, not_needed_move AS current_not_needed, on_going_move AS current_on_going_work
    FROM mega_union
    ORDER BY max_date ASC
;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: issue_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.issue_key ;;
  }

  dimension_group: status_change {
    type: time
    timeframes: [
      raw,
      millisecond,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.max_date ;;
  }

  dimension: 0_backlog {
    type: number
    sql: ${TABLE}.current_backlog ;;
  }

  dimension: 1_newly_assigned {
    type: number
    sql: ${TABLE}.current_newly ;;
  }

  dimension: 2_not_started {
    type: number
    sql: ${TABLE}.current_not_started ;;
  }

  dimension: 3_not_started_behind {
    type: number
    sql: ${TABLE}.current_not_started_behind ;;
  }

  dimension: 4_in_progress_on_time {
    type: number
    sql: ${TABLE}.current_in_progress ;;
  }

  dimension: 5_in_progress_behind {
    type: number
    sql: ${TABLE}.current_in_progress_behind ;;
  }

  dimension: 6_ready_for_sign_off {
    type: number
    sql: ${TABLE}.current_ready_for_sign_off ;;
  }

  dimension: 7_completed {
    type: number
    sql: ${TABLE}.current_completed ;;
  }

  dimension: 8_not_needed {
    type: number
    sql: ${TABLE}.current_not_needed ;;
  }

  dimension: 9_on_going_work {
    type: number
    sql: ${TABLE}.current_on_going_work ;;
  }

  measure: 0_backlog_snap {
    type: running_total
    sql: ${0_backlog} ;;
  }

  measure: 1_newly_assigned_snap {
    type: running_total
    sql: ${1_newly_assigned} ;;
  }

  measure: 2_not_started_snap {
    type: running_total
    sql: ${2_not_started}  ;;
  }

  measure: 3_not_started_behind_snap {
    type: running_total
    sql: ${3_not_started_behind} ;;
  }

  measure: 4_in_progress_on_time_snap {
    type: running_total
    sql: ${4_in_progress_on_time} ;;
  }

  measure: 5_in_progress_behind_snap {
    type: running_total
    sql: ${5_in_progress_behind} ;;
  }

  measure: 6_ready_for_sign_off_snap {
    type: running_total
    sql: ${6_ready_for_sign_off} ;;
  }

  measure: 7_completed_snap {
    type: running_total
    sql: ${7_completed} ;;
  }

  measure: 8_not_needed_snap {
    type: running_total
    sql: ${8_not_needed} ;;
  }

  measure: 9_on_going_work_snap {
    type: running_total
    sql: ${9_on_going_work} ;;
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: pdt_snapshot {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
