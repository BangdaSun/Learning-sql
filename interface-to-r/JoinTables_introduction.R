
setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

# List tables in our database 
dbListTables(con)

# List fields in table Batting
dbListFields(con, "Batting") 

# List fields in table Salaries
dbListFields(con, "Salaries")

# Reading tables into R
batting <- dbReadTable(con, "Batting") 
class(batting) 
dim(batting)

###################
## Join the data ##
###################

# key words:
#　... JOIN ... USING ( ... )

# relational database:
# divide the information into several tables
# tables use some values to relate with each other

# scale of relational database is better than non-relational database:
# save time and space;
# update one table when some information changed;
# data is consistent, more easier to process


# same as merge() in R
# we have one variable (field) as key or identifier
# use JOIN options in SELECT

# 4 types of JOIN
# INNER JOIN or just JOIN: retrain table in common
# LEFT JOIN or just LEFT JOIN: retain the 1st table
# RIGHT JOIN or just RIGHT JOIN: retain the 2nd table
# FULL JOIN or just FULL JOIN: retain all the table

# example
# find the average salaries of players with top 10 highest homerun average
query1 <- 'SELECT *
            FROM Salaries
            ORDER BY playerID
            LIMIT 10'
dbGetQuery(con, query1)

query2 <- 'SELECT yearID, playerID, lgID, teamID, HR
            FROM Batting
            ORDER BY playerID
            LIMIT 10'
dbGetQuery(con, query2)
# identifier: yearID and playerID
query3 <- 'SELECT yearID, playerID, salary, HR
            FROM Batting JOIN Salaries
                  USING(yearID, playerID)
            ORDER BY playerID
            LIMIT 10'
dbGetQuery(con, query3)

# LEFT JOIN
query4 <- 'SELECT yearID, playerID, salary, HR
            FROM Batting LEFT JOIN Salaries
                USING(yearID, playerID)
            ORDER BY playerID
            LIMIT 10'
dbGetQuery(con, query4)

# RIGHT JOIN and FULL JOIN are not implemented in RSQLite

# back to the example
query5 <- 'SELECT playerID, AVG(salary), AVG(HR)
            FROM Batting JOIN Salaries
                USING(yearID, playerID)
            GROUP BY playerID
            ORDER BY AVG(HR) DESC
            LIMIT 10'
dbGetQuery(con, query5)

# task
# use Fielding table, list the 10 worst (highest) number of error (E)
# commited by a player in one season, only consider years 1990 and later
# also list the salaries, year and player ID for each record
dbListFields(con, "Fielding")
query6 <- 'SELECT playerID, yearID, E, salary
            FROM Fielding JOIN Salaries
                USING(yearID, playerID)
            WHERE yearID >= 1990
            ORDER BY E DESC
            LIMIT 10'
dbGetQuery(con, query6)

# other ways to create JOIN
query7 <- 'SELECT Batting.playerID, salary, HR
            FROM Batting, Salaries
            WHERE Batting.playerID = Salaries.playerID
            GROUP BY Batting.playerID
            ORDER BY HR DESC
            LIMIT 10'
dbGetQuery(con, query7)

query8 <- 'SELECT Batting.playerID, salary, HR
            FROM Batting INNER JOIN Salaries
              ON Batting.playerID = Salaries.playerID
            GROUP BY Batting.playerID
            ORDER BY HR DESC
            LIMIT 10'
dbGetQuery(con, query8)

# compare with sub SELECT
# sometimes is always a better choice

###################
## Advanced JOIN ##
###################

# rename the table in SELECT: for simplifier
query9 <- 'SELECT B.playerID, salary, HR
            FROM Batting AS B, Salaries AS S
              ON B.playerID = S.playerID
            GROUP BY B.playerID
            ORDER BY HR DESC
            LIMIT 10'
dbGetQuery(con, query9)

dbListFields(con, "Batting")
dbListFields(con, "Salaries")
dbListFields(con, "Fielding")

# JOIN we discussed above is inner join (equi join)
# there are three other joins: 

# 1) self JOIN
# find the team member where aardsda01 at 2004

# use sub-SELECT way
query10 <- "SELECT playerID, yearID, teamID
              FROM Batting
              WHERE teamID = (SELECT teamID
                  FROM Batting
                  WHERE playerID = 'aardsda01' AND yearID = 2004) AND yearID = 2004" 
dbGetQuery(con, query10)

# use self-JOIN
query11 <- "SELECT b1.playerID, b1.yearID, b1.teamID
              FROM Batting AS b1, Batting AS b2
              WHERE b1.teamID = b2.teamID
                AND b2.playerID = 'aardsda01'
                AND b1.yearID = 2004
                AND b2.yearID = 2004"
dbGetQuery(con, query11)

# 2) natural JOIN
# every inner JOIN is a natural JOIN

# 3) out JOIN
# left out join, right out join





