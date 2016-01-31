
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
AND       h.hotelAddress NOT LIKE '%West Vancouver%'
AND       b.dateTo IS NULL;
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
SELECT    h.hotelName, SUM(r.price) AS Revenue 
FROM      Booking b, Hotel h, Room r
WHERE     b.hotelNo = h.hotelNo
AND       h.hotelNo = r.hotelNo
AND       b.roomNo = r.roomNo
GROUP BY  h.hotelName
HAVING    SUM(r.price) >= 500
AND       SUM(r.price) <= 1000
ORDER BY  h.hotelName;
--
--Q5--------------------------------------------------------
--
SELECT    h.hotelName, r.type, r.price, COUNT(r.type) Available
FROM      Hotel h, Room r
WHERE     h.hotelNo = r.hotelNo
AND       h.hotelName LIKE '%Grosvenor%'
GROUP BY  h.hotelName, r.type, price
HAVING    COUNT(r.type) > 3
ORDER BY  h.hotelName;
--
--Q6--------------------------------------------------------
--
SELECT    g.guestName, b.roomNo
FROM      Booking b, Guest g
WHERE     b.guestNo = g.guestNo
AND       b.dateFrom < DATE '2016-02-01'
AND       (b.dateTo IS NULL OR dateTo >= Date'2016-02-01');
--
--Q7--------------------------------------------------------
--
SELECT    SUM(r.price) TotalIncome
FROM      Booking b, Hotel h, Room r    
WHERE     b.hotelNo = h.hotelNo
AND       h.hotelNo = r.hotelNo
AND       b.roomNo = r.roomNo
AND       h.hotelName LIKE '%Grosvenor%'
AND       b.datefrom <= DATE'2016-02-01'
AND       (b.dateTo IS NULL OR dateTo >= Date'2016-02-01');
--
--Q8--------------------------------------------------------
--
SELECT    h.hotelName, r.type, SUM(r.price)
FROM      Booking b, Hotel h, Room r
WHERE     b.hotelNo = h.hotelNo
AND       h.hotelNo = r.hotelNo
AND       b.roomNo = r.roomNo
AND       b.datefrom <= DATE'2016-02-01'
AND       (b.dateTo IS NULL OR dateTo >= Date'2016-02-01')
GROUP BY  h.hotelName, r.type
ORDER BY  h.hotelName ASC, r.type ASC;
--
--Q9--------------------------------------------------------
--
SELECT    h.hotelName
FROM      Hotel h 
          LEFT JOIN Room r
               ON h.hotelNo = r.hotelNo
GROUP BY  h.hotelName
HAVING    COUNT (r.hotelNo) = 0;
--
--Q10--------------------------------------------------------
--
SELECT     COUNT  (DISTINCT h.hotelNo)            NumberOfHotels,
           COUNT  (DISTINCT r.hotelNo)            CompletedHotels, 
          (COUNT  (DISTINCT h.hotelNo)) 
                  - (COUNT (DISTINCT r.hotelNo))  Construction, 
         ((COUNT  (DISTINCT h.hotelNo)) 
                  - (COUNT (DISTINCT r.hotelNo))) 
                  / (COUNT (DISTINCT h.hotelNo)) 
                  * 100                           PercentConst
FROM      Hotel h, Room r
WHERE     h.hotelNo = r.hotelNo(+);
--
-------------------------------------------------------------
--
SPOOL OFF