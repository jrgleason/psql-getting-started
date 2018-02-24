WITH STORE_MANAGER_ADDRESS AS(
  INSERT INTO MAIN.ADDRESS (
    ADDRESS_LINE1, 
    CITY, 
    STATE, 
    ZIP
  ) 
  VALUES (
    '4321 Hubbard Ave', 
    'Columbus', 
    'OH', 
    '43217'
  )
  RETURNING ID AS STORE_MANAGER_ADDRESS_ID
),
STORE_MANAGER AS(
  INSERT INTO MAIN.PERSON (
    NAME, 
    PHONE, 
    EMAIL, 
    ADDRESS_ID
  )
  SELECT 'John Doe',
         '15555555555',
         'jd@gmail.com', 
         STORE_MANAGER_ADDRESS_ID

  FROM STORE_MANAGER_ADDRESS         
  RETURNING ID AS STORE_MANAGER_PERSON_ID
),
STORE_ADDRESS AS(
  INSERT INTO MAIN.ADDRESS (ADDRESS_LINE1, CITY, STATE, ZIP) 
  VALUES ('1234 Main St', 'Columbus', 'OH', '43201')
  RETURNING ID AS STORE_ADDRESS_ID
),
STORE_TAX_AREA AS(
  INSERT INTO MAIN.TAX_AREA (ZIP_CODE, TAX_RATE)
  VALUES ('43201', 0.075)
  RETURNING ID AS TAX_AREA_ID
)
INSERT INTO MAIN.STORE (
  NAME, 
  PHONE, 
  EMAIL, 
  MANAGER_ID, 
  ADDRESS_ID,
  TAX_AREA_ID
)
SELECT 'Store 1',
       '1231231234',
       'a@b.com',
       STORE_MANAGER.STORE_MANAGER_PERSON_ID,
       STORE_ADDRESS.STORE_ADDRESS_ID,
       STORE_TAX_AREA.TAX_AREA_ID
FROM STORE_MANAGER 
CROSS JOIN STORE_ADDRESS 
CROSS JOIN STORE_TAX_AREA;
-- TODO: Should we have a store to tax area mapping? I think this would be a good change for the student to make
-- TODO Add Store and Manager 2
WITH STORE_MANAGER_ADDRESS AS(
  INSERT INTO MAIN.ADDRESS (ADDRESS_LINE1, CITY, STATE, ZIP) 
  VALUES ('201 N. High St', 'Columbus', 'OH', '43201')
  RETURNING ID AS STORE_MANAGER_ADDRESS_ID
),
STORE_MANAGER AS(
  INSERT INTO MAIN.PERSON (NAME, PHONE, EMAIL, ADDRESS_ID)
  SELECT 'Jane Roe',
         '15555555550',
         'jr@gmail.com', 
         STORE_MANAGER_ADDRESS_ID
  FROM STORE_MANAGER_ADDRESS         
  RETURNING ID AS STORE_MANAGER_PERSON_ID
),
STORE_ADDRESS AS(
  INSERT INTO MAIN.ADDRESS (ADDRESS_LINE1, CITY, STATE, ZIP) 
  VALUES (
    '5391 Richlanne Dr', 
    'Columbus', 
    'OH', 
    '43206'
  )
  RETURNING ID AS STORE_ADDRESS_ID
),
STORE_TAX_AREA AS(
  INSERT INTO MAIN.TAX_AREA (ZIP_CODE, TAX_RATE)
  VALUES ('43201', 0.075)
  RETURNING ID AS TAX_AREA_ID
)
INSERT INTO MAIN.STORE (
  NAME, 
  PHONE, 
  EMAIL, 
  MANAGER_ID, 
  ADDRESS_ID,
  TAX_AREA_ID
)
SELECT 'Store 2',
       '1231231230',
       'a@b.com',
       STORE_MANAGER.STORE_MANAGER_PERSON_ID,
       STORE_ADDRESS.STORE_ADDRESS_ID,
       STORE_TAX_AREA.TAX_AREA_ID
FROM STORE_MANAGER 
CROSS JOIN STORE_ADDRESS 
CROSS JOIN STORE_TAX_AREA;