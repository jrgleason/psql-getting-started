# Create View Lab

# Lab

1. Reset [the coffeeshop schema](./ddl_dml_lab.md#reset-psql)
1. Load the [inital db](./loading_sample_data_lab.md#loading-initial-db)
1. Load the [first round of data](./CreateReciepts.md#first-insert)
1. Connect to [the RDS instance and coffeeshop db](./creating_rds_instance.md#connect-psql)
1. Our boss wants us to create a table of Columbus residents. We know this is overkill because we have that data and our awesome teacher told us about the concept of views. So we create the following view... 

        CREATE VIEW MAIN.CBUS_RESIDENTS AS 
          SELECT P.NAME, 
                 A.ADDRESS_LINE1, 
                 CITY, 
                 STATE 
                 FROM MAIN.PERSON as P                                                                                     
                 INNER JOIN MAIN.ADDRESS as A 
                     ON P.ADDRESS_ID = A.ID WHERE A.CITY='Columbus';


1. Now act as if you are the manager trying to access this information and use the query `SELECT * FROM MAIN.CBUS_RESIDENTS` notice that you see the residents like this...

           name   |  address_line1   |   city   | state 
        ----------+------------------+----------+-------
         John Doe | 4321 Hubbard Ave | Columbus | OH
         Jane Roe | 201 N. High St   | Columbus | OH
        (2 rows)

1. Now add a new person with a new address like this...

        WITH NEW_RESIDENT_ADDRESS AS(
          INSERT INTO MAIN.ADDRESS (
            ADDRESS_LINE1, 
            CITY, 
            STATE, 
            ZIP
          ) 
          VALUES (
            '201 N. 4th St', 
            'Columbus', 
            'OH', 
            '43201'
          )
          RETURNING ID AS ID
        )
        INSERT INTO MAIN.PERSON (
            NAME, 
            PHONE, 
            EMAIL, 
            ADDRESS_ID
          )
          SELECT 'New Resident',
                 '15555555555',
                 'jd@gmail.com', 
                 NEW_RESIDENT_ADDRESS.ID
          FROM NEW_RESIDENT_ADDRESS ;   

1. Now run the query again `SELECT * FROM MAIN.CBUS_RESIDENTS` you should now see the new resident even though nothing was inserted into that relation. This is because a view is a virtual sub-table of the original Address and Person tables.    