# Working with Complex String Matching

## Lab

1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the World Dataset<a name="load-world"></a>

        psql -h <AWS_URL> -p <PORT> -U <USER_NAME> <DB_NAME> -a -f ./labs/resources/sql/world.sql

1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. Let's start off by using what we have learned to select all cities that begin with the letter J

        SELECT * FROM WORLD.CITY WHERE NAME LIKE 'J%';

    Notice the `'J%'` this is telling us that we are looking for records with J and then any number of letters (characters) after that J.
1. **Question**: Now let's calculate the number of cities that begin with `J`. The ouput should look like this...

         count 
        -------
           104
        (1 row)      

    **Extra Credit**: Is there an easier way to do this so that we can calculate for all letters?
1. Next let's see what Regular Expressions can do for us. Without going into too much detail, Regex expressions provide us a quick way to search and capture text based on patterns. Here is an example query...

        SELECT regexp_matches(NAME, '(A)(.+)(l)(.+)(a)') FROM WORLD.CITY;

    You should see a result like this...

                  regexp_matches       
                ---------------------------
                 {A,"ndorra la Ve",l,l,a}
                 {A,vel,l,aned,a}
                 {A,"licante [A",l,ac,a}
                 {A,lca,l,"á de Hen",a}
                 {A,l,l,ahab,a}
                 {A,l,l,appuzh,a}
                 {A,shoknagar-Ka,l,yang,a}
                 {A,mba,l,"a Sad",a}
                 {A,lmo,l,oy,a}
                 {A,nta,l,y,a}
                 {A,t,l,ant,a}
                (11 rows)
    
    Notice the result has been split up. This is the result of the regex groupings (`(...)`).

1. **Question**: Now lets find and return everything after new for each city that starts with new. The results should be like this...

         regexp_matches 
        ----------------
         {Kowloon}
         {Bombay}
         {Delhi}
         {York}
         {Orleans}
         {Haven}
         {Bedford}
        (7 rows)

1. **Question**: Finally count all the cities with a population between 100000 and 500000. The result should look like this...

         count 
        -------
          3023
        (1 row)

        