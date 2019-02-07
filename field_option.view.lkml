      view: field_option {
        sql_table_name: connectors.JIRA.FIELD_OPTION ;;

        dimension: id {
          primary_key: yes
          type: number
          sql: ${TABLE}.ID ;;
        }

        dimension_group: _fivetran_synced {
          type: time
          timeframes: [
            raw,
            time,
            date,
            week,
            month,
            quarter,
            year
          ]
          sql: ${TABLE}._FIVETRAN_SYNCED ;;
        }

        dimension: name {
          type: string
          sql: ${TABLE}.NAME ;;
        }

        measure: count {
          type: count
          drill_fields: [detail*]
        }

        measure: cx_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Customer Experience') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: cs_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Customer Success') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: finance_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Finance') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: multi_org_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Multi-Org') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: product_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Product') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: research_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Research') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }

        measure: sales_count {
          type: number
          sql: COUNT(CASE WHEN (field_option.NAME = 'Sales') THEN field_option.ID  ELSE NULL END);;
          value_format: "0"
        }


        measure: total_cust_org_count {
          type: number
          sql: ${cx_count}+${cs_count}+${finance_count}+${multi_org_count}+${product_count}+${research_count}+${sales_count};;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: cx_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${cx_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: cs_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${cs_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: finance_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${finance_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: multi_org_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${multi_org_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: product_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${product_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: research_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${research_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        measure: sales_percent {
          type: number
          value_format_name: percent_0
          sql: 1.0*${sales_count} / NULLIF(${total_cust_org_count},0) ;;
          drill_fields: [issue_all_fields.key, issue_all_fields.assignee]
        }

        # ----- Sets of fields for drilling ------
        set: detail {
          fields: [
            id,
            name,
          ]
        }
      }
