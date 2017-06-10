
setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

################
## Sub SELECT ##
################

# now we know how to execute single query from single table
dbListFields(con, "Salaries")
dbListFields(con, "Batting")
dbListFields(con, "Fielding")

# 1st: we need to the player whose id begin with rod
query1 <- "SELECT playerID
              FROM Salaries
              WHERE playerID LIKE 'rod%'"
dbGetQuery(con, query1)

# we want to find their total HR
# based on the results from query1
query2 <- "SELECT playerID, SUM(HR) AS total_HR
            FROM Batting
            WHERE playerID IN (
              SELECT playerID
              FROM Salaries
              WHERE playerID LIKE 'rod%')
            GROUP BY playerID"
dbGetQuery(con, query2)

# note: sub SELECT can only query single field!!!

# in usual case, 
# the WHERE in sub SELECT should be
# tableA.id = tableB.id
