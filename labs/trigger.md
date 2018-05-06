# Trigger Lab

## Goal

Create a trigger that prevents users from adding more than 5 employees per store.

## Lab

1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [initial db](./loading_sample_data_lab.md#loading-initial-db)
1. Load the [first round of data](./CreateReciepts.md#first-insert)
1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. Add the following function to prevent more than 5 users being added

        DROP FUNCTION IF EXISTS MAIN.EMPLOYEE_COUNT();
        CREATE OR REPLACE FUNCTION MAIN.EMPLOYEE_COUNT()
          RETURNS TRIGGER AS 
        $$
        declare
           USER_COUNT INTEGER;
        BEGIN
           SELECT COUNT(*) INTO USER_COUNT 
             FROM MAIN.EMPLOYEE 
             WHERE MAIN.EMPLOYEE.STORE_ID = NEW.STORE_ID;
           IF USER_COUNT >= 5 THEN
             RAISE EXCEPTION 'Store Already has 5 Employees';
           END IF;  
           RETURN NEW;    
        END;
        $$ LANGUAGE plpgsql;

1. We now need the actual trigger to be declared

        CREATE TRIGGER EMP_COUNT BEFORE INSERT OR UPDATE ON MAIN.EMPLOYEE
            FOR EACH ROW EXECUTE PROCEDURE MAIN.EMPLOYEE_COUNT();        

1. Now let's insert 4 more employees to get to the limit

        WITH STORE_1 AS (
          SELECT ID FROM MAIN.STORE WHERE STORE_NUMBER = 121
        ), PEOPLE AS (
          SELECT ID FROM MAIN.PERSON 
          WHERE NAME='Jesse Adams' 
            OR NAME='John Doe'
            OR NAME='Bill Jones'
            OR NAME='Jane Roe'
        )
        INSERT INTO MAIN.EMPLOYEE (PAYRATE, IS_ACTIVE, STORE_ID, PERSON_ID)
        SELECT 10,
               TRUE,
               STORE_1.ID,
               PEOPLE.ID
        FROM STORE_1 CROSS JOIN PEOPLE;

1. Finally let us try to insert the last employee. This should fail since a store is required to have, at most, 5 Employees.

        WITH STORE_1 AS (
          SELECT ID FROM MAIN.STORE WHERE STORE_NUMBER = 121
        ), PEOPLE AS (
          SELECT ID FROM MAIN.PERSON 
          WHERE NAME='Will Smith'
        )
        INSERT INTO MAIN.EMPLOYEE (PAYRATE, IS_ACTIVE, STORE_ID, PERSON_ID)
        SELECT 10,
               TRUE,
               STORE_1.ID,
               PEOPLE.ID
        FROM STORE_1 CROSS JOIN PEOPLE;

    You should see the following error...
    >ERROR:  Store Already has 5 Employees