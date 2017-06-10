setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

###################
## INSERT values ##
###################

# key words:
# INSERT INTO ... ( ... ) VALUES ( ... ),
# CREATE TABLE ... AS SELECT ... FROM ...,

# INSERT
query1 <- "INSERT INTO Batting(
              playerID,
              yearID,
              teamID
            )
            VALUES(
              'bangdasun',
              '2016',
              'Columbia'
            )"
dbGetQuery(con, query1)

# INSERT from another query
query2 <- "INSERT INTO Batting(
              playerID,
              teamID
            )
            SELECT playerID, teamID
              FROM Salaries"

# copy a table (SELECT * INTO ... in some DBMS)
query3 <- "CREATE TABLE BattingCopy AS
            SELECT *
            FROM Batting"
dbGetQuery(con, query3)

