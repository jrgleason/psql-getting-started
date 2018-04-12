#Transactions#

##Introduction##
This lab requires 2 Windows, from here out those will be refered to as Window 1 and Window 2. Window 1, will be the main window while Window 2 aill be the auxillary window.
###### TODO ######

##Terminal##
1. Open terminal and run `psql -U postgres`
2. Connect to the chinook db `\c chinook`
3. Type `BEGIN;`
4. Enter the following query `INSERT INTO TOUR (TOURNAME, ARTISTID) VALUES ('Buddy's Other Tour', 15);`
5. Now let's see the record we added with the following query `SELECT * FROM TOUR WHERE ARTISTID = 15;` Notice we see the record

        chinook=# select * from TOUR WHERE ARTISTID = 15;
         tourid |               tourname               | artistid | albumid 
        --------+--------------------------------------+----------+---------
              1 | Buddy Guy: Institutional Genius Tour |       15 |        
              4 | Buddy's Other Tour                   |       15 |        
        (2 rows)

6. Open a second terminal and connect via `psql -U postgres` and `\c chinook`
7. Enter the following query `SELECT * FROM TOUR WHERE ARTISTID = 15;`. Notice there is no other tour

        chinook=# select * from TOUR WHERE ARTISTID = 15;
         tourid |               tourname               | artistid | albumid 
        --------+--------------------------------------+----------+---------
              1 | Buddy Guy: Institutional Genius Tour |       15 |        
        (1 row)

8. Now let's commit, in the first terminal type `COMMIT;`
9. In the second terminal try the query again, notice the record now appears...

        chinook=# select * from TOUR WHERE ARTISTID = 15;
         tourid |               tourname               | artistid | albumid 
        --------+--------------------------------------+----------+---------
              1 | Buddy Guy: Institutional Genius Tour |       15 |        
              4 | Buddy Other Tour                     |       15 |        
        (2 rows)

10. There is also the rollback command, again type `BEGIN;` in the first window
11. Enter the following query `INSERT INTO TOUR (TOURNAME, ARTISTID) VALUES ('Buddy's Bad Tour', 15);`
12. Enter `ROLLBACK;`
13. Notice we only see 2 records when we execute the following query `SELECT * FROM TOUR WHERE ARTISTID = 15;`
14. In Window 1 enter the following `BEGIN;LOCK TABLE TOUR;`
15. In Window 2 enter the following query `INSERT INTO TOUR (TOURNAME, ARTISTID) VALUES ('Buddy's Locking Tour', 15);` notice there is no confirmation the terminal is just waiting. 
16. In Window 1 enter `COMMIT;` or `ROLLBACK;`
17. Notice that Window 2 finish the query, we can check this with `SELECT * FROM TOUR WHERE ARTISTID = 15;` we should see the new tour.

##GUI##
###### TODO #######

##Extra Credit##

1. Demonstrate save points :TODO