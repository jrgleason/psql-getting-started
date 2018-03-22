# Lab: Simple Create Table and Delete #
## With Command Line/Terminal ##
1. Open Terminal (or Command Prompt on Windows)
2. Connect to [the RDS instance](./creating_rds_instance.md#connect-psql)
3. Ensure you have connected to the database `\c`, you should see something like `You are now connected to database "coffeeshop" as user "jgleason".`
5. We first create the schema, this is like a container for all the tables we will create...

        DROP SCHEMA IF EXISTS MAIN;
        CREATE SCHEMA MAIN;

5. Create a simple relation for the address

        CREATE TABLE MAIN.ADDRESS(
          ADDRESS_LINE1 VARCHAR(100) NOT NULL
        );

6. Type in `\d MAIN.*` to ensure that the new table has been created.

                        Table "test.address"
            Column     |          Type          | Modifiers 
        ---------------+------------------------+-----------
         address_line1 | character varying(100) | not null

7. Lets make sure there are no records currently in the table using the following SQL query

        SELECT * FROM MAIN.ADDRESS;

    Notice there are no records

         address_line1 
        ---------------
        (0 rows)


8. Try to add a good record by using the following

        INSERT INTO MAIN.ADDRESS VALUES ('400 W. Broad St Columbus, OH 43217');

    a. In PostGres `"` is different than `'`. Please make sure to use `'` when defining strings. This is similar in some other environments such as Microsoft SQLServer.

9. Now lets try querying the table again

        SELECT * FROM MAIN.ADDRESS;

    we should see our new record

        coffeeshop=> SELECT * FROM MAIN.ADDRESS;
         id |               address_line1                
        ----+--------------------------------------------
          1 | 400 W. Broad Columbus, OH 43217


10. Now lets reverse everything we just did. To start with lets remove the record we added

        DELETE FROM MAIN.ADDRESS;

11. Check to make sure it was deleted

        SELECT * FROM MAIN.ADDRESS;

    Notice there are no records

         address_line1 
        ---------------
        (0 rows)    

12. Next lets delete the table we created

        DROP TABLE MAIN.ADDRESS;

13. Check to make sure it was deleted with `\d MAIN2.*`
    
        Did not find any relation named "MAIN.*".

## With GUI ##

1. Open SQLectron
2. Select to connect to the database configured in the previous lab
3. In the main text area type

        CREATE TABLE MAIN.ADDRESS(
          ADDRESS_LINE1 VARCHAR(100) NOT NULL
        );

    ![sqlectron create class](https://jrgleason.github.io/psql-getting-started/labs/resources/sqlectron_create_class.png "sqlectron create class")

4. You should now see the table listed on the left nav

    ![sqlectron table created](https://jrgleason.github.io/psql-getting-started/labs/resources/sqlectron_table_created.png "sqlectron table created")

    Notice that instead of `address` it shows `main.address`. The main represents the schema of the table.

5. Enter the following query into the text area `SELECT * FROM MAIN.ADDRESS;`. Click execute and notice that the application tells you there is no data in that table.

6. Now lets go ahead and add a record. Enter the following query in the text area and hit execute `INSERT INTO MAIN.ADDRESS VALUES ('400 W. Broad St Columbus, OH 43217');`. You should see the message...
    
    > Query executed successfully. Affected rows: 1.

7. Now lets try querying it again. Again type in `SELECT * FROM MAIN.ADDRESS;` and hit execute. You should now see a result.

    ![sqlectron with data](https://jrgleason.github.io/psql-getting-started/labs/resources/sqlectron_record_shown_3 "")

8. Ok now that we have everything in there lets learn how to clean up. First enter the following query in the text area to delete the record we just created `DELETE FROM MAIN.ADDRESS;`. This removes all records from the ADDRESS table, if we wanted to we could be more specific with `DELETE FROM MAIN.ADDRESS WHERE ADDRESS_LINE1 = '400 W. Broad St Columbus, OH 43217';`. Either way you should see this message...

    > Query executed successfully. Affected rows: 1.

9. Now lets confirm it was deleted, again type `SELECT * FROM MAIN.ADDRESS;` in the text area. Notice this time no results are returned again.
10. Now lets delete the table we created. To do this add the following to the text area `DROP TABLE MAIN.ADDRESS;` and execute. You should see the following message...

    > Query executed successfully.

    You should also see the table disappear in the GUI

12. Disconnect and close down Sqlectron.  

## Review ##

In this lab we learned the basics for adding and removing data inside Postgres. We created a table, and an entry in that table. Next we removed both the entry and the table. Finally we learned how to remove the entire database. After completing this lab you should be able to create, add, and query data on a given table. 

## Takehome Work

1. Create a Product table with the following details (each letter does not have to be its own column)

    1. An identifier
    1. A readable name
    1. A short description
    1. A price
    1. Flag to indicate if actively sold product 
    1. Discount Level

    Type decisions are up to the student, also feel free to add additional properties you think might be nessacary.
