SELECT CUS_GENDER, COUNT(CUS_GENDER) FROM CUSTOMER
WHERE CUS_ID IN
(select distinct CUS_ID from `ORDER`
where ORD_AMOUNT >= 3000)
GROUP BY CUS_GENDER;

select distinct CUS_ID from `ORDER`
where ORD_AMOUNT >= 3000;

select * from `order`
where ord_amount >= 3000;

SELECT ORD.*,P.PRO_NAME  FROM `ORDER` ORD
JOIN SUPPLIER_PRICING SP
ON  ORD.PRICING_ID = SP.PRICING_ID
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
WHERE ORD.CUS_ID = 2;

SELECT SUPP_ID, COUNT(SUPP_ID) 
FROM SUPPLIER_PRICING
GROUP BY SUPP_ID
HAVING COUNT(SUPP_ID) > 1;

SELECT * FROM SUPPLIER 
WHERE SUPP_ID IN
(SELECT SUPP_ID 
FROM SUPPLIER_PRICING
GROUP BY SUPP_ID
HAVING COUNT(SUPP_ID) > 1);


SELECT C.CAT_ID,C.CAT_NAME,P.PRO_NAME, MIN(SUPP_PRICE)
FROM SUPPLIER_PRICING SP
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
JOIN CATEGORY C 
ON P.CAT_ID = C.CAT_ID
GROUP BY C.CAT_ID;

SELECT ORD.*, P.PRO_ID,P.PRO_NAME FROM `ORDER` ORD
JOIN SUPPLIER_PRICING SP
ON ORD.PRICING_ID = SP.PRICING_ID
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
WHERE ORD.ORD_DATE > '2021-10-05';

SELECT CUS_NAME, CUS_GENDER
FROM CUSTOMER
WHERE CUS_NAME LIKE 'A%' or CUS_NAME LIKE '%A';

DELIMITER $
CREATE PROCEDURE ServiceQuality ()
begin
SELECT  SUPP.SUPP_ID,SUPP.SUPP_NAME,R.RAT_RATSTARS,
CASE 
	WHEN R.RAT_RATSTARS = 5 THEN 'Excellent Service'
    WHEN R.RAT_RATSTARS >= 4 THEN 'Good Service'
     WHEN R.RAT_RATSTARS > 2 THEN 'Average Service'
    ELSE 'Poor Service'
END AS Type_Of_Service
from RATING R
JOIN `ORDER` ORD
ON R.ORD_ID = ORD.ORD_ID
JOIN SUPPLIER_PRICING SP
ON ORD.PRICING_ID = SP.PRICING_ID
JOIN SUPPLIER SUPP
ON SP.SUPP_ID = SUPP.SUPP_ID;
end$

DELIMITER ;
call ServiceQuality();

