# Create Reciepts

## Introduction

As an accountant you need to provide a list of transactions organized by customer. The output should be the customers name, and the sum of the price of the items purchased. There should be one like per transaction.

## Lab
1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [inital db](./loading_sample_data_lab.md#loading-initial-db)
1. Load the FirstInsert script<a name="first-insert"></a>...

        psql -h <url> -p 5432 -U <username> <db name> -a -f ./labs/resources/sql/FirstInsert.sql 

1. First let's select all of the people

        SELECT * FROM MAIN.PERSON;

    Notice we see 5 rows

            name     
        -------------
         John Doe
         Jane Roe
         Jesse Adams
         Bill Jones
         JIM_WILSON
        (5 rows)        

1. Next we want the customer profile for these people so let's use an inner join...

        SELECT * FROM MAIN.PERSON
        INNER JOIN MAIN.CUSTOMER ON MAIN.PERSON.ID = MAIN.CUSTOMER.PERSON_ID;

    Notice now we only see 2 rows...

            name     
        -------------
         Jesse Adams
         Bill Jones
        (2 rows)
    
    This is because these are the only 2 with customer profiles.

1. Now lets finish wiring everything up...

        SELECT MAIN.TRANSACTION.ID, MAIN.PERSON.NAME, SUM(MAIN.TRANSACTION_PRODUCT.QUANTITY*MAIN.PRODUCT.CURRENT_ITEM_PRICE)
        FROM MAIN.TRANSACTION
        INNER JOIN MAIN.TRANSACTION_PRODUCT
                ON MAIN.TRANSACTION_PRODUCT.TRANSACTION_ID = MAIN.TRANSACTION.ID 
        INNER JOIN MAIN.PRODUCT 
                ON MAIN.PRODUCT.ID = MAIN.TRANSACTION_PRODUCT.PRODUCT_ID       
        INNER JOIN MAIN.CUSTOMER         
                ON MAIN.TRANSACTION.CUSTOMER_ID = MAIN.CUSTOMER.ID
        INNER JOIN MAIN.PERSON 
                ON MAIN.PERSON.ID = MAIN.CUSTOMER.PERSON_ID       
        GROUP BY MAIN.PERSON.NAME, MAIN.TRANSACTION.ID;  

                          id                  |    name     | sum  
        --------------------------------------+-------------+------
         4c23ca9b-db70-4764-b96e-0b71c0011092 | Bill Jones  | 9.97
         2ca6290a-653a-4618-b5ad-a07589baa10d | Jesse Adams | 5.99

## Takehome

Can you now create itemized reciepts?              
