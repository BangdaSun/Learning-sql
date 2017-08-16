library(RMySQL)

### Connection
#   need user name, password, database name and host name
db_connect <- dbConnect(MySQL(), users = '', password = '', dbname = '', host = '')

### Query
query <- paste0(
  'select * ',
  'from my_tbl ',
  'limit 1000'
)

query_result_obj <- dbSendQuery(db_connect, query)
query_result <- fetch(query_result_obj, 1000)