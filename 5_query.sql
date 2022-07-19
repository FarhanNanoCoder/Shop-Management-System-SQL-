
-------------ALTER TABLE-----------
DESCRIBE PAYMENT;
ALTER TABLE PAYMENT 
MODIFY P_DATE NUMBER(20);
DESCRIBE PAYMENT;

-------------ALTER TABLE CONSTRAINTS-----------
DESCRIBE SHOP;
ALTER TABLE SHOP 
ADD CONSTRAINT UK_CONTACT_SHOP
UNIQUE(CONTACT);
DESCRIBE SHOP;

ALTER TABLE SHOP 
DROP CONSTRAINT UK_CONTACT_SHOP;



-----SIMPLE UPDATE OPERATIONS-------

SELECT F_NAME,L_NAME FROM CUSTOMER 
WHERE F_NAME  = 'Jami';

UPDATE CUSTOMER SET L_NAME = 'Haque'
WHERE F_NAME  = 'Jami';

SELECT F_NAME,L_NAME FROM CUSTOMER 
WHERE F_NAME  = 'Jami';

-----SIMPLE ORDER BY OPERATIONS-------

SELECT F_NAME,SALARY 
FROM EMPLOYE 
ORDER BY SALARY DESC;

-----SIMPLE RANGE CONDITIONAL OPERATIONS-------

SELECT F_NAME,SALARY 
FROM EMPLOYE 
WHERE SALARY>=8000 AND SALARY<=20000;

SELECT F_NAME,SALARY 
FROM EMPLOYE 
WHERE SALARY BETWEEN 8000 AND 20000;

SELECT F_NAME,SALARY 
FROM EMPLOYE 
WHERE SALARY IN (6000,11000);

SELECT F_NAME,SALARY 
FROM EMPLOYE 
WHERE SALARY NOT IN (6000,11000);

-----SIMPLE LIKE CONDITIONAL OPERATIONS-------

SELECT F_NAME as F_NAME_CONTAINS_sh
FROM CUSTOMER
WHERE F_NAME LIKE '%sh%';

------DISTINCT OPERATIONS--------

SELECT DISTINCT(C_ID) 
AS CUSTOMERS_WHO_HAVE_ORDER 
FROM PRODUCT ;

------NUMERIC OPERATIONS IN SELECT --------

SELECT (SALARY) AS ACTUAL_SALARY,
(SALARY*.4) AS BONUS_AMOUNT, F_NAME 
FROM EMPLOYE;


----------AGGREGATE  FUNCTIONS-------

SELECT SALARY FROM EMPLOYE;
SELECT MAX(SALARY) FROM EMPLOYE;
SELECT MIN(SALARY) FROM EMPLOYE;

SELECT SUM(SALARY) 
AS WAGES_TOTAL
FROM EMPLOYE;


SELECT P.C_ID,COUNT(P.ID) 
AS TOTAL_PRODUCTS
FROM PRODUCT P
GROUP BY P.C_ID;

SELECT P.C_ID,COUNT(P.ID) 
AS TOTAL_PRODUCTS
FROM PRODUCT P
GROUP BY P.C_ID
HAVING COUNT(P.ID)<4;



---------NESTED QUERY WITH RANGE--------

SELECT ID,S_ID,F_NAME,L_NAME,CONTACT
FROM EMPLOYE
WHERE S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH IN ('BD','US')
    ) AND E_ROLE=1;


-------- SET OPERATIONS ----------

SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE S_ID = 0
UNION ALL
SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE E_ROLE = 1 AND S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH IN ('US')
    );

SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE S_ID = 0
UNION 
SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE E_ROLE = 1 AND S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH IN ('US')
    );


SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE S_ID = 0
INTERSECT
SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE E_ROLE = 1 AND S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH IN ('US')
    );


SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE S_ID = 0
MINUS
SELECT ID,F_NAME,E_ROLE 
FROM EMPLOYE
WHERE E_ROLE = 1 AND S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH IN ('US')
    );


SELECT ID,F_NAME,E_ROLE,S_ID
FROM EMPLOYE
WHERE E_ROLE = 1
MINUS
SELECT ID,F_NAME,E_ROLE,S_ID
FROM EMPLOYE
WHERE E_ROLE = 1 AND S_ID IN (
    SELECT ID 
    FROM SHOP WHERE BRANCH NOT IN ('US')
    )
UNION 
SELECT ID,F_NAME,E_ROLE ,S_ID
FROM EMPLOYE
WHERE S_ID = 0;

------------JOIN OPERATIONS ---------------

SELECT PRO.ID,PRO.TITLE 
AS PRODUCT_NAME,CAT.TITLE AS CATEGORY_NAME
FROM PRODUCT PRO, CATEGORY CAT
WHERE PRO.C_ID = CAT.ID;

SELECT PRODUCT.TITLE,CATEGORY.TITLE 
FROM PRODUCT CROSS JOIN CATEGORY;

SELECT PRODUCT.TITLE,CATEGORY.TITLE 
FROM PRODUCT LEFT OUTER JOIN CATEGORY
ON PRODUCT.C_ID = CATEGORY.ID;

SELECT PRODUCT.TITLE,CATEGORY.TITLE 
FROM PRODUCT RIGHT OUTER JOIN CATEGORY
ON PRODUCT.C_ID = CATEGORY.ID;

SELECT E.F_NAME AS EMPLOYEE, M.F_NAME AS MANAGER,S.BRANCH AS BRANCH
FROM EMPLOYE E JOIN EMPLOYE M 
ON (E.S_ID = M.S_ID AND M.E_ROLE = 1 AND E.E_ROLE = 0)
JOIN SHOP S
ON E.S_ID = S.ID;

---------DATE & CASTING----------

SELECT F_NAME,CAST((SYSDATE-JOINED_AT)/365 AS INT) 
AS WORKING_YEARS
FROM EMPLOYE;

--------- CALLING PROCEDURE OF RECORD -------
SELECT * FROM RECORD;
BEGIN
  SET_RECORD_AMOUNT(5,8);
END;
/
SELECT * FROM PAYMENT;
SELECT * FROM RECORD;

--------- CHECKING INVENTORY TRIGGER ----------
SELECT * FROM INVENTORY;
INSERT INTO RECORD(PRO_ID,PAY_ID,QUANTITY)
VALUES (0,0,10);
SELECT * FROM INVENTORY;


----------INPUT-----------
SELECT F_NAME
FROM CUSTOMER
WHERE F_NAME LIKE '%&t%';