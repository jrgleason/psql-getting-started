# Transaction Lab

## Lab

1. Connect to RDS // TODO: Add link
1. Create the following tables

        CREATE TABLE OUR_ACCOUNT (AMOUNT INTEGER);
        CREATE TABLE THEIR_ACCOUNT (AMOUNT INTEGER);

1. Add the initial balance

        INSERT INTO OUR_ACCOUNT VALUES (2000);
        INSERT INTO THEIR_ACCOUNT VALUES (1000);

1. Create a view to show the balances;

        CREATE VIEW BALANCES AS 
            WITH OUR_BALANCE AS (
                SELECT SUM(AMOUNT) AS BALANCE 
                FROM OUR_ACCOUNT
            ), 
            THEIR_BALANCE AS (
                SELECT SUM(AMOUNT) AS BALANCE 
                FROM THEIR_ACCOUNT
            )          
            SELECT * FROM OUR_BALANCE UNION ALL SELECT * FROM THEIR_BALANCE;        

1. Now we should be able to query this view like `SELECT * FROM BALANCES;`
1. As you can see the balance on our account is $2000, while the balance on their account is $1000. This means the total amount of money in the system is $3000. This means the total system value should be 3000 unless external money is added.
1. Now lets say they have made a purchase from us and give us $500. To do this lets do an insert into OUR_BALANCE...

   INSERT INTO OUR_ACCOUNT VALUES (500);
   
1. But **WAIT**, if we do `SELECT SUM(BALANCE) FROM BALANCES;`

         sum  
        ------
         3500
        (1 row)
        
    Uh oh, this is bad the total value of they system has increased even though no external value was added. This means our system is no longer auditable. Lets drop that transaction.
    
        DELETE FROM OUR_ACCOUNT WHERE AMOUNT = 500;
        
1. Our account should be back to even again, now lets try this with a transaction.

        BEGIN;
        INSERT INTO OUR_ACCOUNT VALUES (500);
        INSERT INTO THEIR_ACCOUNT VALUES (-500);
        COMMIT;
        SELECT SUM(BALANCE) FROM BALANCES;
        SELECT BALANCE FROM BALANCES;
        
    Notice the sum is correct and the accounts have been debited appropriately
    
         sum  
        ------
         3000
        (1 row)
    
         balance 
        ---------
            2500
             500
        (2 rows)
        
1. Next lets create a problem, our regulations provide we shouldn't handle transactions over $5000 so we create a constraint...

        ALTER TABLE OUR_ACCOUNT ADD CONSTRAINT LARGE_TRANSACTIONS CHECK(AMOUNT < 5000);
       
1. Next the client deposits $4500 to his account

        INSERT INTO THEIR_ACCOUNT VALUES (4500);
        
    The total system balance should now be `SELECT SUM(BALANCE) FROM BALANCES;`
    
         sum  
        ------
         7500
        (1 row)
        
    This is correct since the customer deposited from an external source.
    
1. Now the customer would like to buy a high ticket item for $5000    
    
        BEGIN;
        INSERT INTO THEIR_ACCOUNT VALUES (-5000);
        INSERT INTO OUR_ACCOUNT VALUES (5000);
        COMMIT;
        
    Notice the error
    
    >ERROR:  new row for relation "our_account" violates check constraint "large_transactions"
    
    And notice the response was rollback
    
        coffeeshop=>         COMMIT;
        ROLLBACK
        
    This is because it violated the constraint. Notice that although the first insert was successful, it was never added to the table.

         amount 
        --------
           1000
           -500
           4500
        (3 rows)
        
    This is because the transaction did its job and prevented the state to change until all items in the transactions have completed (Atomicity)