
SET ECHO ON

SPOOL C:\Users\Deric\workspace\COMP2714_ASS02\Ass02_MccaddenD.txt
--
-- ---------------------------------------------------------
--
--  COMP 2714 
--  SET 2D
--  Assignment Asn02
--  Mccadden, Deric    A00751277
--  email: dmccadden@my.bcit.ca
--
-- ---------------------------------------------------------
--  ASSIGNMENT
--  START C:\Users\Deric\workspace\COMP2714_ASS02\Ass02_MccaddenD.sql
--  LOAD DATABASE
--  START C:\Users\Deric\workspace\COMP2714_ASS02\Asn2SetupHotels.sql
-- ---------------------------------------------------------
--
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--
SELECT SYSDATE
FROM DUAL;
--
--Q1--------------------------------------------------------
--
SELECT    DISTINCT h.hotelName, h.hotelAddress, r.type, r.price
FROM      Hotel h, Room r
WHERE     h.hotelNo = r.hotelNo
AND       h.hotelAddress LIKE '%London%'
AND       (r.type = 'Single' OR r.type = 'Double' OR r.type = 'Family')
AND       r.price < 100
ORDER BY  h.hotelName DESC, r.price ASC, r.type DESC;
--
--Q2--------------------------------------------------------
--
SELECT    h.hotelName, h.hotelAddress, b.roomNo, b.dateFrom, b.dateTo
FROM      Booking b, Hotel h
WHERE     b.hotelNo = h.hotelNo
AND       h.hotelAddress LIKE '%Vancouver%'
AND       h.hotelAddress NOT LIKE '%North Vancouver%'
AND       h.hotelAddress NOT LIKE '%West Vancouver%';
--AND       b.dateTo = NULL;                                   ----------------------**error
--
--Q3--------------------------------------------------------
--
SELECT    h.hotelName, AVG(r.price) AS Average
FROM      Hotel h, Room r
WHERE     h.hotelNo = r.hotelNo
GROUP BY  h.hotelName
ORDER BY  h.hotelName;
--
--Q4--------------------------------------------------------
--
SELECT    h.hotelName, SUM(r.price) AS Revenue ----------------------****how do you make my sum 500 to 1000
FROM      Booking b, Hotel h, Room r
WHERE     b.hotelNo = h.hotelNo
AND       h.hotelNo = r.hotelNo
AND       b.roomNo = r.roomNo
GROUP BY  h.hotelName
ORDER BY  h.hotelName;
--
--Q5--------------------------------------------------------
--
SELECT    h.hotelName, h.hotelAddress, r.type, r.price
FROM      Hotel h, Room r
WHERE     h.hotelNo = r.hotelNo
AND       h.hotelAddress LIKE '%London%'
AND       (r.type = 'Single' OR r.type = 'Double' OR r.type = 'Family')
AND       r.price < 100
ORDER BY  h.hotelName DESC, r.price ASC, r.type DESC;
--
--Q6--------------------------------------------------------
--
--
--Q7--------------------------------------------------------
--
--
--Q8--------------------------------------------------------
--
--
--Q9--------------------------------------------------------
--
--
--Q10--------------------------------------------------------
--
--
-------------------------------------------------------------
--
SPOOL OFF