connection: "snowflakedb"

include: "*.view.lkml"                       # include all views in this project
include: "cumulative_flow.dashboard.lookml"   # include a LookML dashboard called my_dashboard
