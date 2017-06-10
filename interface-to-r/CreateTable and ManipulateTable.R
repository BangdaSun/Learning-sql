setwd("C://Users//Bangda//Desktop//GR5206 Materials")

# install.packages("DBI")
# install.packages("RSQLite")
library(DBI)
library(RSQLite)

# Driver and Connect, to database: baseball
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "baseball.db")

dbListTables(con)

#################################
## CREATE and Manuiplate TABLE ##
#################################

# key words:
# CREATE TABLE ..., 
# INSERT INTO ... ( ... ) VALUES ( ... ),
# ALTER TABLE ... ADD ...,
# ALTER TABLE ... DROP COLUMN ...,
# DROP TABLE ...


# CREATE table
query1 <- "CREATE TABLE Products(
            prod_id    CHAR(10) NOT NULL,
            vend_id    CHAR(10) NOT NULL,
            prod_name  CHAR(10) NOT NULL,
            prod_num   INTEGER  ,
            prod_price DECIMAL(8, 2) NOT NULL DEFAULT 0
          )"
dbGetQuery(con, query1)

# INSERT some value here
query2 <- "INSERT INTO Products(
            prod_id,
            vend_id,
            prod_name,
            prod_num,
            prod_price
          ) VALUES (
            '00001',
            '01001',
            'computer',
            100,
            1200
          )"
dbGetQuery(con, query2)

# UPDATE the table
# in general, do not update the table when there are data in it
# all DBMS are allowed to ADD columns
# many DBMS are not allowed to delete columns

query3 <- "ALTER TABLE Products
            ADD vend_phone CHAR(20) DEFAULT '000-000-0000'"
dbGetQuery(con, query3)


query4 <- "ALTER TABLE Products
            DROP COLUMN vend_phone"
dbGetQuery(con, query4)     # not valid for all DBMS...

# DELETE the table
query5 <- "DROP TABLE Products"



