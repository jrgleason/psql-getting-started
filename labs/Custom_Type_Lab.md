# Creating a Custom Data Type

## Lab

1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [initial db](./loading_sample_data_lab.md#loading-initial-db)
1. Load the [first round of data](./CreateReciepts.md#first-insert)
1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. We will now be add a Transaction_State attribute (column) to our Transaction relation (table). This attribute should be of a custom type with the possible values of `pending` and `closed`. Lets start by creating a Transaction_State `enumerated` type...

        CREATE TYPE MAIN.TRANSACTION_STATE AS ENUM ('pending', 'closed');

1. Now that we have that let's update the Transaction table to include an attribute with the new type. For our first try, let's try this...

        ALTER TABLE MAIN.TRANSACTION ADD COLUMN STATE MAIN.TRANSACTION_STATE NOT NULL DEFAULT 'test';

    But we get an error...

        > ERROR:  invalid input value for enum main.transaction_state: "test"

    This is because `test` was not an option in our state. Lets change this to a valid option, `pending`

        ALTER TABLE MAIN.TRANSACTION ADD COLUMN STATE MAIN.TRANSACTION_STATE NOT NULL DEFAULT 'pending';

    notice this time the transaction succeeds.
    
1. Lets see the updated table using `SELECT * FROM MAIN.TRANSACTION LIMIT 10;`    

                          id                  |             customer_id              |  state  
        --------------------------------------+--------------------------------------+---------
         141d1977-96c4-4875-a665-fe9b3cd4cdb7 | 0a99e197-3c0a-4bb4-8871-3a806140bbcc | pending
         0fd961d3-471e-4c3d-a510-48494644ee55 | 0a99e197-3c0a-4bb4-8871-3a806140bbcc | pending
         779b094d-a13f-45ae-bfe6-8392760af5e4 | 61bafba7-384c-42c1-a80c-f693dedc3e33 | pending

1. Now play around by trying to add an new transaction. Try it once with an invalid (or null) value for state. 
