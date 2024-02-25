#install DBI package
install.packages("DBI")
install.packages("RPostgreSQL")
install.packages("RPostgres")

library(RPostgreSQL)
library(DBI)
library(RPostgres)

#connect to the database
conn <- dbConnect(RPostgres::Postgres(),
                  dbname = "CrimeData",
                  host = "localhost",
                  port = "5432",
                  user = "postgres",
                  password = "HaitaoShi")

#see the table names
dbListTables(conn)

#read the table one by one and convert to csv with header
tables <- dbListTables(conn)
for (i in 1:length(tables)){
  query <- paste('SELECT * FROM public."', tables[i], '"', sep = "")
  data <- dbGetQuery(conn, query)
  write.csv(data, file = paste(tables[i], ".csv", sep = ""), row.names = FALSE)
}


#close the connection
dbDisconnect(conn)

