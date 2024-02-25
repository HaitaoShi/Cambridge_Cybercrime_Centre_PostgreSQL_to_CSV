#!/bin/bash
echo "Please enter the password for the postgres user:"
read -s PGPASSWORD  # read password silently
export PGPASSWORD  # export the password as an environment variable
FILES=/Users/shihaitao/Downloads/For_Haitao/*
for f in $FILES
do
  DB_NAME=$(basename "$f" .sql)  # get file name without extension
  createdb -U postgres -h localhost $DB_NAME
  echo "Processing $f file..."
  psql -U postgres -h localhost -d $DB_NAME -f "$f"
done