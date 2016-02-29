
SET ECHO ON

SPOOL C:\Users\Deric\workspace\COMP2714_ASN02\Asn02_MccaddenD.txt
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
--  LOAD DATABASE
--  START C:\Users\Deric\workspace\COMP2714_ASN02\Asn2SetupHotels.sql
--  ASSIGNMENT
--  START C:\Users\Deric\workspace\COMP2714_ASN02\Asn02_MccaddenD.sql
-- ---------------------------------------------------------
--
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
SELECT SYSDATE
FROM DUAL;
--
--Q1--------------------------------------------------------
--
SELECT DISTINCT h.hotelName, h.hotelAddress, r.type, r.price
  FROM Hotel h
    JOIN Room r ON h.hotelNo = r.hotelNo
  WHERE h.hotelAddress LIKE '%London%'
    AND (r.type IN('Single', 'Double', 'Family'))
    AND r.price < 100
  ORDER BY h.hotelName DESC, r.price ASC, r.type DESC
;
--
--Q2--------------------------------------------------------
--
SELECT h.hotelName, h.hotelAddress, b.roomNo, b.dateFrom, b.dateTo
  FROM Booking b
    JOIN Hotel h ON b.hotelNo = h.hotelNo
  WHERE h.hotelAddress LIKE '%Vancouver%'
    AND h.hotelAddress NOT LIKE '%North Vancouver%'
    AND h.hotelAddress NOT LIKE '%West Vancouver%'
    AND b.dateTo IS NULL
;
--
--Q3--------------------------------------------------------
--
SELECT h.hotelName, AVG(r.price) AS Average
  FROM Hotel h
    JOIN Room r ON h.hotelNo = r.hotelNo
  GROUP BY h.hotelName
  ORDER BY h.hotelName
;
--
--Q4--------------------------------------------------------
--6.14 What is the total revenue per night from all double rooms?
--(6.14 - 5 marks) Do this for each hotel. 
--List the total revenue with the hotelName, and only if the 
--total revenue is between $500 to $1000. List in hotelName order.
SELECT h.hotelName, SUM(r.price) AS Revenue 
  FROM Booking b
    INNER JOIN Hotel h ON h.hotelNo = b.hotelNo
    INNER JOIN Room r ON r.hotelNo = b.hotelNo
                      AND r.roomNo = b.roomNo
  WHERE type = 'Double'
  GROUP BY h.hotelName
  ORDER BY h.hotelName
;
--
--Q5--------------------------------------------------------
--
SELECT h.hotelName, r.type, r.price, COUNT(*) Available
  FROM Hotel h
    JOIN Room r ON r.hotelNo = h.hotelNo
  WHERE h.hotelName LIKE '%Grosvenor%'
  GROUP BY h.hotelName, r.type, price
  HAVING COUNT(r.type) > 3
  ORDER BY h.hotelName
;
--
--Q6--------------------------------------------------------
--6.17 List all guests currently staying at the Grosvenor Hotel.
--(6.17 - 5 marks) Include the roomNo in the output. 
--Use 2016-02-01 as the current date.
SELECT g.guestName, b.roomNo
  FROM Hotel h
    JOIN Booking b ON b.hotelNo = h.hotelNo
    JOIN Guest g ON g.guestNo = b.guestNo
  WHERE b.dateFrom <= DATE '2016-02-01'
    AND (b.dateTo IS NULL OR dateTo >= Date'2016-02-01')
    AND h.hotelName = 'Grosvenor Hotel'
;
--
--Q7--------------------------------------------------------
--6.19 What is the total income from bookings for the Grosvenor Hotel today?
--(6.19 - 5 marks) Do this question for each of the hotels with 'Grosvenor' in name. 
--Use 2016-02-01 as today's date.
SELECT h.hotelName, SUM(r.price) TotalIncome
  FROM Booking b
    JOIN Hotel h ON h.hotelNo = b.hotelNo
    JOIN Room r ON r.hotelNo = h.hotelNo
                AND r.roomNo = b.roomNo
    WHERE h.hotelName LIKE '%Grosvenor%'
      AND b.datefrom <= DATE'2016-02-01'
      AND (b.dateTo IS NULL OR dateTo >= Date'2016-02-01')
    GROUP BY h.hotelName
;
--
--Q8--------------------------------------------------------
--
SELECT h.hotelName, r.type, SUM(r.price)
  FROM Booking b
    JOIN Hotel h ON h.hotelNo = b.hotelNo
    JOIN Room r ON h.hotelNo = r.hotelNo
                AND r.roomNo = b.roomNo
  WHERE b.datefrom <= DATE'2016-02-01'
    AND (b.dateTo IS NULL OR dateTo >= Date'2016-02-01')
  GROUP BY  h.hotelName, r.type
  ORDER BY  h.hotelName ASC, r.type ASC
;
--
--Q9--------------------------------------------------------
--
SELECT h.hotelName
  FROM Hotel h 
    LEFT JOIN Room r ON h.hotelNo = r.hotelNo
  WHERE r.hotelNo IS NULL
  GROUP BY h.hotelName
;
--
--Q10--------------------------------------------------------
--


SELECT COUNT(DISTINCT h.hotelNo) AS NumberOfHotels,
       COUNT(DISTINCT r.hotelNo) AS CompletedHotels, 
       ((COUNT  (DISTINCT h.hotelNo)) 
        -(COUNT (DISTINCT r.hotelNo))
       ) AS Construction, 
       (((COUNT(DISTINCT h.hotelNo)) 
        -(COUNT (DISTINCT r.hotelNo))) 
          /(COUNT (DISTINCT h.hotelNo)) 
          * 100 
       ) AS PercentConst
  FROM Hotel h
    LEFT JOIN Room r ON h.hotelNo = r.hotelNo
;

CREATE VIEW NumberOfHotels AS
  SELECT COUNT(DISTINCT h.hotelNo) AS NumberOfHotels
    FROM Hotel h
;
CREATE VIEW CompletedHotels AS
  SELECT COUNT(DISTINCT r.hotelNo) AS CompletedHotels
    FROM Hotel h
    LEFT JOIN Room r ON h.hotelNo = r.hotelNo;
;
CREATE VIEW UnderConstruction AS
  SELECT (NumberOfHotels - CompletedHotels) AS UnderConstruction
    FROM NumberOfHotels, CompletedHotels
;
CREATE VIEW PercentConstruction AS
  SELECT (UnderConstruction / NumberOfHotels * 100) AS PercentConstruction
    FROM NumberOfHotels, UnderConstruction
;
SELECT NumberOfHotels, CompletedHotels, UnderConstruction, PercentConstruction
  FROM NumberOfHotels, CompletedHotels, UnderConstruction, PercentConstruction
;


DROP VIEW NumberOfHotels;
DROP VIEW CompletedHotels;
DROP VIEW UnderConstruction;
DROP VIEW PercentConstruction;

--
-------------------------------------------------------------
--
SPOOL OFF