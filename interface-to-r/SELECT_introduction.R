
## Section I: Databases: SQL and Querying ##

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

# List fields in table Pitching
dbListFields(con, "Pitching")

# Reading tables into R
batting <- dbReadTable(con, "Batting") 
class(batting) 
dim(batting)

######################
## SELECT Structure ##
######################

# key words:
#   SELECT columns or computations  (with comma between them)
#     FROM table                    (no comma between sentence)
#     WHERE condition
#     GROUP BY columns
#     HAVING condition
#     ORDER BY column [ASC | DESC]
#     LIMIT offset, count;
#  AND, OR, IN, BETWEEN ... AND ..., NOT,

# Query 1 (select some fields)
# Find playerID, yearID, AB, H, HR from Batting, list the head 
query1 <- 'SELECT playerID, yearID, AB, H,HR
            FROM batting
            LIMIT 5'
dbGetQuery(con, query1)

# Query2 (find distinct record)
# Find distinct (unique) rows from Batting, list the head
query2 <- 'SELECT DISTINCT playerID
            FROM batting
            LIMIT 5'
dbGetQuery(con, query2)

# Query3 (order records)
# Find playerID, yearID and order the playerID descent, list the head
# (must state whether descent or ascent)
query3 <- 'SELECT playerID, yearID
            FROM batting
            ORDER BY playerID DESC
            LIMIT 5'
dbGetQuery(con, query3)

# Query4 (aggregate)
# Use aggregation function
# AVG, COUNT, FIRST, LAST, MAX, MIN, SUM
# we can use ID, COUNT(*) to count the occurence of ID
# calculate the year that player plays
query4 <- 'SELECT playerID, COUNT(*)
            FROM batting
            GROUP BY playerID
            LIMIT 5'
dbGetQuery(con, query4)

# Query5 (aggregate & computing)
# Use aggregation function
# Compute the average HR and H in batting
query5 <- 'SELECT AVG(HR), AVG(H), MIN(yearID), MAX(yearID)
            FROM batting'
dbGetQuery(con, query5)

# Query6 (aggregate & group & order)
# Compute the average HR of each player, from top to low
query6 <- 'SELECT playerID, AVG(HR)
            FROM batting
            GROUP BY playerID
            ORDER BY AVG(HR) DESC
            LIMIT 5'
dbGetQuery(con, query6)

# Query7 (filtering)
# logical operations:
# AND, OR, NOT, BETWEEN AND, IS NULL, IN    (note the "(",")", add them is always readable and good)
# LIKE operation:
# %: any characters with any time
# _: any one character
# []: one character at certain posistion
# Filtering, find the records after 1990 
# (careful about the order, WHERE should be call before GROUP BY)
query7 <- 'SELECT playerID, yearID, AVG(HR)
            FROM batting
            WHERE yearID > 1990
            GROUP BY playerID
            ORDER BY AVG(HR) DESC
            LIMIT 5'
dbGetQuery(con, query7)

query8 <- 'SELECT playerID, yearID, HR
            FROM batting
            WHERE yearID BETWEEN 1990 AND 2000
            LIMIT 5'
dbGetQuery(con, query8)

# search pattern with some characters: playerID with 'abbot...'
query9 <- "SELECT playerID, yearID, HR
            FROM batting
            WHERE (playerID LIKE 'abbotgl%') OR (playerID LIKE '_bbotje01')"
dbGetQuery(con, query9)

# searcch: playerID with 'abbot' but are not 'abbotji01' and 'abbotpa01'
query10 <- "SELECT playerID, yearID, HR
            FROM batting
            WHERE (playerID LIKE 'abbot%') AND NOT (playerID IN ('abbotji01','abbotpa01'))"
dbGetQuery(con, query10)

# Query11 (rename & add new column)
# Find the maximum record (HR) in each year and call it maxHR
query11 <- 'SELECT yearID, MAX(HR) as maxHR
              FROM batting
              GROUP BY yearID
              LIMIT 5'
dbGetQuery(con, query11)

# Query12 (filtering post-calculation & post aggregate)
# Compute the average HR and find them greater than 3.5
query12 <- 'SELECT playerID, AVG(HR) as avgHR
              FROM batting
              GROUP BY playerID
              HAVING avgHR > 3.5
              LIMIT 5'
dbGetQuery(con, query12)

