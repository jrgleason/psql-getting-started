# Basic Constraints Lab

1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. Load the lab schema

    psql -h <AWS_URL> -p <PORT> -U <USER_NAME> <DB_NAME> -a -f ./labs/resources/sql/basicConstraintsSetup.sql

1. We will create the first table, this table shows us the `Check` Constraint

    CREATE TABLE CONSTRAINTS.TEST_CHECK(
        NOPE SMALLINT,
        CHECK (NOPE > 0)
    );

1. Now lets see what the constraint does. First try a valid query

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (5);

    Notice we see a valid transaction `INSERT 0 1`

1. What happens if we try to add an invalid record

        INSERT INTO CONSTRAINTS.TEST_CHECK VALUES (-5);

    Notice we see the following error...    

    >ERROR:  new row for relation "test_check" violates check constraint "test_check_nope_check"

1. This error doesn't tell us too much detail. What if we had multiple checks on the same table or even attribute. Lets Remove the old constraint.

        ALTER TABLE CONSTRAINTS.TEST_CHECK DROP CONSTRAINT TEST_CHECK_NOPE_CHECK;

    And add a new one that has a better name    

        ALTER TABLE CONSTRAINTS.TEST_CHECK ADD CONSTRAINT BETTER_NAME CHECK (NOPE > 0);

    Notice the ADD/DROP CONSTRAINT. This is pretty consistent with other SQL conventions.    
