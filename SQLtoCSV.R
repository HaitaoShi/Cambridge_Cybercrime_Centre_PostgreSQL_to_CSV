#install DBI package
install.packages("DBI")
install.packages("RPostgreSQL")
install.packages("RPostgres")

library(RPostgreSQL)
library(DBI)
library(RPostgres)

#connect to the database

conn <- dbConnect(RPostgres::Postgres(),
                  host = "localhost",
                  port = "5432",
                  user = "postgres",
                  password = "HaitaoShi")


# Get the names of the databases
database_names <- dbGetQuery(conn, "SELECT datname FROM pg_database WHERE datistemplate = false;")$datname

# Database has a default database called "postgres", so we need to remove it
database_names <- database_names[database_names != "postgres"]

# Print the names of the databases
print(database_names)


#disconnect from the database
dbDisconnect(conn)


#connect to the database to read the table names

for (dbname in database_names){
  
  #Create a folder for each database 
  dir.create(dbname)
  # Create a new connection to a specific database 
  conn <- dbConnect(RPostgres::Postgres(),
                    dbname = dbname,
                    host = "localhost",
                    port = "5432",
                    user = "postgres",
                    password = "HaitaoShi")
  
  
  #read the table one by one and convert to csv with header
  tables <- dbListTables(conn)
  
  # Iterate through each table and convert them to a CSV file
  
  for (table in tables) {
    data <- dbGetQuery(conn, paste0('SELECT * FROM public."', table, '"'))
    write.csv(data, file = paste(dbname, "/", table, ".csv", sep = ""), row.names = FALSE)
  }
  
  
  #disconnect from the database
  dbDisconnect(conn)
  
}

 


