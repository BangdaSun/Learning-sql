library(RODBC)

### Connect
#   need set the connection to database first
#   control panel --> administrative tools --> data sources
db_connect <- odbcConnect('')

### Query
query <- paste0(
  'selet top 1000 * ',
  'from my_tbl '
)

sqlQuery(db_connect, query)