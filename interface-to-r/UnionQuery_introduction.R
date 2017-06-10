setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

###############################
## Query Combination (UNION) ##
###############################

# key words:
# SELECT ...
#  UNION 
#  SELECT ...

# find team SFN, year 2004
query1 <- "SELECT playerID, teamID, yearID
            FROM Batting
            WHERE teamID = 'SFN' OR yearID = 2004
            LIMIT 10"
dbGetQuery(con, query1)

query2 <- "SELECT playerID, teamID, yearID
            FROM Batting
            WHERE teamID = 'SFN'
            UNION
            SELECT playerID, teamID, yearID
              FROM Batting
              WHERE yearID = 2004
              LIMIT 10"
dbGetQuery(con, query2)

# each query of UNION must have same columns, expressions or aggregate function
# it will fliter the duplicate records

# if need to ORDER BY, must be in the last query

