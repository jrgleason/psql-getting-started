# Basic Constraints Lab

1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. Load the lab schema with the following command...

        psql -h <AWS_URL> -p <PORT> -U <USER_NAME> <DB_NAME> -a -f ./labs/resources/sql/basicConstraintsSetup.sql

1. We will create the first table, this table shows us the `Check` constraint.

        CREATE TABLE CONSTRAINTS.TEST_CHECK(
            NOPE SMALLINT,
            CHECK (NOPE > 0)
        );

1. By default types have some limitations. We can see that by trying to add too big of an integer 

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (5000000000000);

    Notice we see

    >ERROR:  smallint out of range

    This is because most types have native constraints.    

1. Now let's see what the custom constraint does. Let's try a valid query

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (5);

    Notice we see a valid transaction `INSERT 0 1`

1. What happens if we try to add an invalid record

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (-5);

    Notice we see the following error...    

    >ERROR:  new row for relation "test_check" violates check constraint "test_check_nope_check"

1. This error doesn't tell us too much detail. What if we had multiple checks on the same table or even attribute. Let's Remove the old constraint.

        ALTER TABLE CONSTRAINTS.TEST_CHECK DROP CONSTRAINT TEST_CHECK_NOPE_CHECK;

    And add a couple new ones that have better names    

        ALTER TABLE CONSTRAINTS.TEST_CHECK 
        ADD CONSTRAINT TOO_LOW CHECK (NOPE > 0),
        ADD CONSTRAINT TOO_HIGH CHECK (NOPE < 10);

    Notice the ADD/DROP CONSTRAINT. This is pretty consistent with other SQL conventions.    

1. Now let's try adding a couple more test cases...

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (-5);

    Should now return

    >ERROR:  new row for relation "test_check" violates check constraint "too_low"
    >DETAIL:  Failing row contains (-5).

    Notice the `too_low`. Now let's try too high...

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (15);

    >ERROR:  new row for relation "test_check" violates check constraint "too_high"
    >DETAIL:  Failing row contains (15).    

    Names are an extremely important part of writing maintainable code.

1. Now let's add another attribute and create a NOT NULL constraint on that attribute.

        ALTER TABLE CONSTRAINTS.TEST_CHECK
        ADD COLUMN YUP SMALLINT NOT NULL;

    but...
    
    >ERROR:  column "yup" contains null values

    Thats because of the leftover value in the table, we can see this by issuing a select query.

        SELECT * FROM CONSTRAINTS.TEST_CHECK;

    > nope 
    >------
    >    5
    >(1 row)

    In the real world we would have to jump through a bunch of hoops to make this fit without losing data, however, since we are in a dev environment let's just blow the data away.

        DELETE FROM CONSTRAINTS.TEST_CHECK;

    >DELETE 1
    
    Then try running it again, this time you should see `ALTER TABLE`

1. Now let's try adding an both an invalid and a valid entry.

        INSERT INTO CONSTRAINTS.TEST_CHECK (NOPE) VALUES (5);

    >ERROR:  null value in column "yup" violates not-null constraint
    >DETAIL:  Failing row contains (15, null).

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (5, 5);

    >INSERT 0 1
    
1. Finally we will look at the `UNIQUE` constraint. This constraint ensures that the value is only in the table once. 

        ALTER TABLE CONSTRAINTS.TEST_CHECK ADD CONSTRAINT MUST_BE_UNIQUE UNIQUE (NOPE, YUP);

    Now let's try adding a second record with the same values
    
        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (5, 5);

    > ERROR:  duplicate key value violates unique constraint "must_be_unique"
    > DETAIL:  Key (nope, yup)=(5, 5) already exists.

1. Since we are done with this lab let's clean up

        DROP SCHEMA IF EXISTS CONSTRAINTS CASCADE;
