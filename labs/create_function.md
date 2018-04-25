# Create Function To Calculate Average Receipt

## Introduction

This lab will focus on both Postgres declared functions, as well as those that we will create ourselves.

## Terminal
1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [initial db](./loading_sample_data_lab.md#loading-initial-db)
2. Load the [first round of data](./CreateReciepts.md#first-insert)
1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql).
2. Run the following query and take note of the response...

        WITH ORDERS AS (
            SELECT SUM(MAIN.TRANSACTION_PRODUCT.QUANTITY*MAIN.PRODUCT.CURRENT_ITEM_PRICE) AS ORDER_PRICE
                FROM MAIN.TRANSACTION
                INNER JOIN MAIN.TRANSACTION_PRODUCT
                    ON MAIN.TRANSACTION_PRODUCT.TRANSACTION_ID =     MAIN.TRANSACTION.ID 
                INNER JOIN MAIN.PRODUCT 
                ON MAIN.PRODUCT.ID = MAIN.TRANSACTION_PRODUCT.PRODUCT_ID 
            GROUP BY MAIN.TRANSACTION.ID
        )
        SELECT AVG(ORDER_PRICE) FROM ORDERS;

1. Now lets create a function to calculate the average of these transactions...

        CREATE FUNCTION MEAN_ORDER() RETURNS NUMERIC
          AS 'WITH ORDERS (ORDER_PRICE) as (
            SELECT SUM(MAIN.TRANSACTION_PRODUCT.QUANTITY*MAIN.PRODUCT.CURRENT_ITEM_PRICE) AS ORDER_PRICE
                FROM MAIN.TRANSACTION
                INNER JOIN MAIN.TRANSACTION_PRODUCT
                ON MAIN.TRANSACTION_PRODUCT.TRANSACTION_ID = MAIN.TRANSACTION.ID 
                INNER JOIN MAIN.PRODUCT 
                ON MAIN.PRODUCT.ID = MAIN.TRANSACTION_PRODUCT.PRODUCT_ID 
            GROUP BY MAIN.TRANSACTION.ID
          )
          SELECT AVG(ORDER_PRICE) FROM ORDERS'
          LANGUAGE SQL
          IMMUTABLE
          RETURNS NULL ON NULL INPUT; 

1. Finally lets test is out with `SELECT MEAN_ORDER()`
