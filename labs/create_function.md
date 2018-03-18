# Using existing and creating new functions

## Introduction

This lab will focus on both Postgres declared functions, as well as those that we will create ourselves.

## Terminal
1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
2. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
3. Take a look back at our [first attempt to create a customer](./ddl_dml_lab.md#connect-psql), we are going to improve on this
4. First, because we deal with a lot of business a Serial would not be sustainable (there are only so many number!). Also if items are deleted it is difficult to keep track of IDs that can be reused. To get around this we will use a function provided by Postgres called `GEN_RANDOM_UUID`

    a. Run the following SQL command

        CREATE TABLE MAIN.CUSTOMER(
            ID UUID NOT NULL PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
            DISCOUNT INT
        );
        CREATE TABLE MAIN.PERSON(
            ID UUID NOT NULL PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
            NAME VARCHAR(20) NOT NULL,
            EMAIL VARCHAR(20) NOT NULL,
            CUSTOMER_ID INT REFERENCES MAIN.CUSTOMER(ID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
        );