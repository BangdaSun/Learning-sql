
setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")


######################
## Calculate fields ##
######################

# key words:
# SELECT ... AS ... FROM ... 


# Concatenate fields (|| or +, depend on the DBMS, CONCAT() in MySQL)
# list year, player and their HR follow just behind the ID,
query1 <- "SELECT yearID, playerID || '(' || HR || ')' AS playerHR
            FROM batting
            GROUP BY playerID
            ORDER BY HR DESC, yearID
            LIMIT 5"
dbGetQuery(con, query1)

# Calculate with some formula (+, -, *, /)
# ABS(), COS(), EXP(), PI(), SIN(), SQRT(), TAN(), etc
# G / InnOuts ratio: gin_ratio
query2 <- "SELECT playerID || '(' || yearID || ')' AS player,
           G / InnOuts AS gin_ratio
            FROM Fielding
            ORDER BY gin_ratio DESC
            LIMIT 5"
dbGetQuery(con, query2)

# Text manipulation
# LEFT(), RIGHT()
# LENGTH()
# LOWER(), UPPER()
# LTRIM(), RTRIM()    get rid of the space

# convert playerID to upper case
query3 <- 'SELECT playerID, UPPER(playerID) AS playerID_UPPER
            FROM batting
            LIMIT 5'
dbGetQuery(con, query3)

# calculate the length of playerID
query4 <- 'SELECT playerID, LENGTH(playerID) AS playerID_UPPER
            FROM batting
            LIMIT 5'
dbGetQuery(con, query4)
