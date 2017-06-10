setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

###########################
# UPDATE and DELETE data ##
###########################

# key words:
# UPDATE ... SET ... = ... WHERE ... = ...,
# DELETE FROM ... WHERE ... = ...,

# UPDATE
query1 <- "UPDATE Batting
            SET yearID = 2017
            WHERE playerID = 'bangdasun'"
dbGetQuery(con, query1)

# DELETE
query2 <- "DELETE FROM Batting
            WHERE playerID = 'bangdasun'"
dbGetQuery(con, query2)

