view: summary {
  sql_table_name: Looker_Dashboard.Summary ;;

  dimension: application {
    type: string
    sql: ${TABLE}.Application ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.End_Time ;;
  }

  dimension: failed_in_last_7_day {
    type: string
    hidden: yes
    sql: ${TABLE}.Failed_in_Last_7_days ;;
  }

  dimension: date_diff {
    type: number
    sql: DATE_DIFF(CURRENT_DATE(),${detail.failed_on_date},day) ;;
  }

  dimension: failed_in_last_7_days {
    type: string
    sql: case when ${date_diff}<7 then 'Yes' else 'No' end ;;
  }

  dimension: file_name {
    type: string
    sql: ${TABLE}.File_name ;;
  }

  dimension: job_id {
    type: number
    sql: ${TABLE}.Job_ID ;;
  }

  dimension: job_name {
    type: string
    sql: ${TABLE}.Job_Name ;;
  }

  dimension: job_type {
    type: string
    sql: ${TABLE}.Job_Type ;;
  }

  dimension: last_ran {
    type: string
    sql: ${TABLE}.Last_Ran ;;
  }

  dimension_group: next_run {
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
    sql: ${TABLE}.Next_Run ;;
  }

  dimension: project {
    type: string
    sql: ${TABLE}.Project ;;
  }

  dimension: rows_processed {
    type: number
    sql: ${TABLE}.Rows_processed ;;
  }

  dimension: run_id {
    type: string
    sql: ${TABLE}.Run_id ;;
  }

  dimension_group: run {
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
    sql: ${TABLE}.Run_time ;;
  }

  dimension: server_name {
    type: string
    sql: ${TABLE}.Server_name ;;
  }

  dimension: sla_me {
    type: string
    hidden: yes
    sql: ${TABLE}.SLA_Met ;;
  }

  dimension: sla_met {
    type: string
    sql: case when ${run_raw}<${static.sla_raw} then 'SLA Met' else 'SLA Not Met' end ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.Start_Time ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: sub_application {
    type: string
    sql: ${TABLE}.Sub_Application ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension: unusal_activty {
    type: string
    hidden: yes
    sql: ${TABLE}.Unusal_activity ;;
  }

  dimension: unusal_activity {
    type: string
    sql: case when ${rows_processed}>${static.rows_processed_threshold} then 'Y'
          when ${start_raw}>${static.usual_start_time} then 'Y'
          else 'N' end;;
  }

  measure: count {
    type: count
    drill_fields: [job_name, server_name, application,project,type,job_type]
  }
}
