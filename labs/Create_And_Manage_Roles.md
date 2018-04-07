# Creating and Managing Roles

## Introduction 

This lab is meant to introduce the managing of access based on roles.

## Lab

1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [inital db](./loading_sample_data_lab.md#loading-initial-db)
1. Load the [initial dataset](./loading_sample_data_lab.md#loading-first)
1. Connect to the [AWS Instance](./creating_rds_instance.md#connect-psql) 
1. Run `CREATE ROLE MANAGER;`, a manager should have access to user information. 
1. Run `ALTER ROLE MANAGER LOGIN;`, this should allow new manager users to login.
1. Run `GRANT USAGE ON SCHEMA MAIN TO MANAGER;`
1. Run `GRANT INSERT ON TABLE MAIN.PRODUCT TO MANAGER;`, this should allow a Manager to Insert a transaction.
1. Run `CREATE ROLE CSR;`, a CSR should be able to create transactions.
1. Run `ALTER ROLE CSR LOGIN;`, this should allow new CSR users to login.
1. Run `GRANT USAGE ON SCHEMA MAIN TO CSR;`
1. Run `CREATE USER CSR_EMPLOYEE WITH PASSWORD 'password';`, this should create a user with a password of password.
1. Run `GRANT CSR TO CSR_EMPLOYEE;`, this will allow the employee to be a CSR.
1. Run `CREATE USER MANAGER_EMPLOYEE WITH PASSWORD 'password';` , this should create a manager employee.
1. Run `GRANT MANAGER TO MANAGER_EMPLOYEE;`, this will allow the employee to be a Manager. 
1. Now logout of AWS and reconnect using the new credentials for the MANAGER_EMPLOYEE
1. Try to query Address with `SELECT * FROM MAIN.ADDRESS;` notice there are no items (even though we know there are some in the DB). This is because we only have write permission to the PRODUCT DB.
1. Now try to add a new product with the following query.

    INSERT INTO MAIN.PRODUCT (DESCRIPTION, CURRENT_ITEM_PRICE) VALUES ('Jamaican Dark Roast', 12.99);

1. Notice the insert works, then logout and log back in as CSR_EMPLOYEE.
1. Try to insert a new product like the following...

    INSERT INTO MAIN.PRODUCT (DESCRIPTION, CURRENT_ITEM_PRICE) VALUES ('Doughnut Blend', 12.99);

1. Notice we see an error

>ERROR:  permission denied for relation product

## Review

This shows us how we can limit the ability of users to access certain tables and certain permissions.
