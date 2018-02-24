# Lab 1: Getting Started #

1. Go to [the download page](https://www.postgresql.org/download)
2. Find the download for your operating system in the list. 

    ![postgres site](https://bitbucket.org/jgleason/cbus-state-sql/raw/HEAD/labs/resources/lab1/postgres_site.png "Site List")

3. Download and run the package
4. Follow prompts, make sure to write down the password you create for postgres user
5. Note the folder you install the application into
6. Once installation is finished go to the folder you installed it to and open PSQL

    ![postgres folder](https://bitbucket.org/jgleason/cbus-state-sql/raw/HEAD/labs/resources/lab1/postgres_folder.png "Postgress Folder")

7. You should see the following prompts. Assuming you selected the defaults when you were installing, you should just be able to hit enter to accept the defaults (i.e. [localhost] the default value is localhost)

    ![postgres init](https://bitbucket.org/jgleason/cbus-state-sql/raw/HEAD/labs/resources/lab1/postgres_config.png "Postgres Config")

8. Input the password you created above
9. Now you should see a prompt like this…

    ![postgres prompt](https://bitbucket.org/jgleason/cbus-state-sql/raw/HEAD/labs/resources/lab1/postgres_prompt.png "Postgres Prompt")

10. Although postgres is setup and working, we have not mapped some properties we need to access it through the command line. We will use this for functionality such as importing SQL scripts in later labs.
  a. OSX

      1. Open a terminal 
      2. Edit your `.bash_profile` file with `vi ~/.bash_profile`
          a. There is an existing .bash_profile
              1. Type `shift+g` to get to the bottom
              2. Type `o` to start a new cursor on the last line
          b. There is no existing file
              1. Type `i` this should provide you with a cursor to type
      5. Type `export PATH=$PATH:/Library/PostgreSQL/10/bin`
      6. Hit `esc` then `:wq` this should close you out of vi
      7. Close and reopen terminal
      8. Make sure it worked by typing in `psql` it should now be able to find the command.
  
  b. Windows

      1. Open the windows menu
      2. Right click on Computer and select properties
      3. Choose environmental variables
      4. Under the user section 
      
          a. If there is a PATH variable select that one for editing. Append the following `c:\Program Files\PostGres\bin`  **TODO: Double check install location**

          b. If there isn't an existing PATH variable add a new one and input the following `%PATH%;c:\Program Files\PostGres\bin`

      5. Open a command prompt
      6. type `psql` and make sure that the application has been configured properly.    

  c. Linux **TODO**

11. Now you are ready to create your database from this class type `create database class;`. This creates a table in the database called class. The semicolon is EXTREMELY important, otherwise it may be waiting for more commands and not actually creating the entry.
12. Now you should be able to type `\list` and see your new database named class

    ![postgres result](https://bitbucket.org/jgleason/cbus-state-sql/raw/HEAD/labs/resources/lab1/postgres_result_add_class.png "Postgres Class")

13. This database will be the first database we use in the next section on Querying

## Review ##

In this lab we installed the PostGres DBMS and we created a new database and table. You should walk away from this lab understanding how to install and configure the Postgres DBMS.

## Takehome Work

1. Try to figure out how to configure the server. To accomplish this change the port from the default port used and connect using the new port. 
