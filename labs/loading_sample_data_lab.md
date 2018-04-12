# Loading a SQL file #
1. Connect to [the RDS instance and the coffeeshop db](./creating_rds_instance.md#connect-psql)
1. To use UUIDs we need to add the pgcrypto extension with the following command.
        create extension "pgcrypto";   
4. Type `\l` and make sure the new DB is listed.
5. Type `\q` to quit psql and return to the terminal    
6. Navigate to the folder in which the class git project was checked out.
9. Import the Class dataset using psql with the following command `psql -U <username> -d coffeeshop -a -f labs\resources\sql\initialDb.sql`<a name="loading-initial-db"></a>
  a. `-U` This declares the username to use 
  b. `-d` This declares the database to use
  c. `-a` (TODO)
  d. `-f` This is the name of the file used to import

      ![postgre import script](https://jrgleason.github.io/psql-getting-started/labs/resources/postgres_import_sql_script.png "postgres import script")  

10. When prompted enter your password
11. Notice all of the queries running. These are exactly like the queries we ran in the last lab. You can take a look at them by opening the `.sql` file in a normal text editor.
12. Run the query to insert the user data `psql -U <username> -d coffeeshop -a -f labs\resources\sql\FirstInsert.sql`<a href="loading-first"></a>
12. Once completed connect to the database again using `psql -U <Username>`
13. Connect to the database using `\c coffeeshop`
14. Try querying the data using `select * from ADDRESS;`. If everything worked right you should see data

## Review ##

In this lab we looked at loading data from a SQL script file. We also used this data to query an item.