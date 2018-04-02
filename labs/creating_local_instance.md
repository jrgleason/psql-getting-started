# Install Postgres Locally

1. Go to [the download page](https://www.postgresql.org/download)
2. Find the download for your operating system in the list. 
    ![postgres site](./resources/lab1/postgres_site.png "Site List")
3. Download and run the package provided by the link.
4. Follow prompts, make sure to write down the password you create for postgres user.<a name="password"></a>
    1. Note the folder into which you install the application.
6. Once installation has finished go to the folder you installed the application to and open PSQL.
    ![postgres folder](./resources/lab1/postgres_folder.png "Postgress Folder")
7. You should see a series of prompts in the console. Assuming you selected the defaults when you were installing, you should just be able to hit enter to accept the defaults (i.e. [localhost] the default value is localhost).
    ![postgres init](./resources/lab1/postgres_config.png "Postgres Config")
8. Input the password you created in the step above.
9. Now you should see the following prompt.
    ![postgres prompt](./resources/lab1/postgres_prompt.png "Postgres Prompt")
10. Although Postgres is setup and working, we have not mapped some necessary properties to access the application through the command line. We will use this for functionality such as importing SQL scripts in later labs.
    1. Instruction for OSX
        2. Open a terminal 
        2. Edit your `.bash_profile` file with `vi ~/.bash_profile`
        2. Type `shift+g` to get to the bottom
        2. Type `o` to start a new cursor on the last line    
        2. Type `i` this should provide you with a cursor to type
        2. Type `export PATH=$PATH:/Library/PostgreSQL/10/bin`
        2. Hit `esc` then `:wq` this should close you out of vi
        2. Close and reopen terminal
        2. Make sure it worked by typing in `psql` it should now be able to find the command.
    1. Windows
        2. Open the Windows menu
        2. Right click on My Computer and select properties
        2. Choose environmental variables
        2. Under the user section 
            3.If there is a PATH variable select that one for editing. Append the following `c:\Program Files\PostGres\bin`
            3. If there isn't an existing PATH variable add a new one and input the following `%PATH%;c:\Program Files\PostGres\bin`
        2. Open a command prompt
        2. type `psql` and make sure that the application has been configured properly.    

11. Now you are ready to create your database from this class type `create database class;`. This creates a table in the database called class. The semicolon is EXTREMELY important, otherwise it may be waiting for more commands and not actually creating the entry.
12. Now you should be able to type `\list` and see your new database named class
    ![postgres result](./resources/lab1/postgres_result_add_class.png "Postgres Class")
13. Now try connecting to the DB by issuing the following command `\c class`. You should see the following...

        You are now connected to database "postgres" as user "jgleason".

14. Now let's quit by issuing the `\q` command        

## Review ##

In this lab we installed the PostGres DBMS and we created a new database and table. You should walk away from this lab understanding how to install and configure the Postgres DBMS.

## Takehome Work

1. Try to figure out how to configure the server. To accomplish this change the port from the default port used and connect using the new port. 
