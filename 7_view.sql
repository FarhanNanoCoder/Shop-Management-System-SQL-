CREATE VIEW EMPLOYE_VIEW AS
SELECT F_NAME,L_NAME,JOINED_AT
FROM EMPLOYE;

SELECT * FROM EMPLOYE_VIEW;

DELETE FROM EMPLOYE_VIEW
WHERE F_NAME ='Uday';

DROP VIEW EMPLOYE_VIEW;