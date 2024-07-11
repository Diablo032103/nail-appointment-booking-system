USE nailsdb;


#------------------------------------------------------------------------
#Create Account | Sign In
#1
DELIMITER //

CREATE PROCEDURE NewAccount(
	IN roleID INT,
    IN username VARCHAR(255),
    IN password VARCHAR(255)
)
    
BEGIN
    INSERT INTO User (roleID, username, password)
    VALUES (roleID, username, password);
END //

DELIMITER;

CALL NewAccount(11,'bayanij','pass');

#------------------------------------------------------------------------
#Login | Account

DELIMITER //

CREATE PROCEDURE verifyLogin(
    IN input_username VARCHAR(255)
)
BEGIN
    SELECT userID, username, password
    FROM User
    WHERE username = input_username;
END //

DELIMITER;

CALL verifyLogin('judiem');

#------------------------------------------------------------------------
#APPOINTMENT | Client View
#1.1 Booked Dates | Overall Calendar

SELECT DATE(b.dateAndTime) AS 'Booked Dates', COUNT(*) AS 'booking_count'
FROM Appointment a
JOIN Booking b ON a.bookingID = b.bookingID
WHERE b.dateAndTime < CURDATE()
AND MONTH(b.dateAndTime) = MONTH(CURDATE())
AND YEAR(b.dateAndTime) = YEAR(CURDATE())
GROUP BY DATE(b.dateAndTime)

UNION

SELECT DATE(b.dateAndTime) AS 'Booked Dates', COUNT(*) AS 'booking_count'
FROM Appointment a
JOIN Booking b ON a.bookingID = b.bookingID
WHERE b.dateAndTime >= CURDATE()
AND MONTH(b.dateAndTime) = MONTH(CURDATE())
AND YEAR(b.dateAndTime) = YEAR(CURDATE())
GROUP BY DATE(b.dateAndTime)
HAVING booking_count > 1
ORDER BY 'Booked Dates';

#2 Show All Dates in Appointment TABLE (DATE TODAY – JUNE 25) that record < 2;. 
WITH RECURSIVE DateRange AS (
    SELECT CURDATE() AS date
    UNION ALL
    SELECT date + INTERVAL 1 DAY
    FROM DateRange
    WHERE date + INTERVAL 1 DAY <= LAST_DAY(CURDATE())
)

SELECT DISTINCT(dr.date) 'Available Dates'
FROM DateRange dr
LEFT JOIN Booking b ON DATE(b.dateAndTime) = dr.date
LEFT JOIN Appointment a ON a.bookingID = b.bookingID
WHERE a.bookingID IS NULL
AND MONTH(dr.date) = MONTH(CURDATE())
AND YEAR(dr.date) = YEAR(CURDATE())
ORDER BY dr.date;

#3 Insert Client Info in booking
DELIMITER //

CREATE PROCEDURE InsertBooking(
    IN userID INT,
    IN name VARCHAR(255),
    IN contactNum VARCHAR(50),
    IN dateAndTime DATETIME,
    IN apptType ENUM('Soft BIAB', 'Gel Overlay', 'Softgel Extensions','Removal'),
    IN modeOfPay ENUM('Cash', 'GCash'),
    IN price INT
)
BEGIN
    INSERT INTO Booking (userID, name, contactNum, dateAndTime, apptType, modeOfPay, price)
    VALUES (userID, name, contactNum, dateAndTime, apptType, modeOfPay, price);
END //

DELIMITER;


CALL InsertBooking(1004, 'Judie Michelle','0912 333 3636','2024-06-27 10:00:00','Removal','Cash',150);
SELECT * FROM Booking;

#------------------------------------------------------------------------
#Account | Client View
#1. Show client appointment count details by their username.
DELIMITER //

CREATE PROCEDURE GetApptCountsByUsername(
    IN input_username VARCHAR(255)
)
BEGIN
    SELECT u.username, ac.failedApptCount 'Failed Appointment', 
	(SUM(ac.totalApptCount) - SUM(ac.failedApptCount)) 'Successful Appointment', ac.totalApptCount

	FROM User u
	JOIN ApptCount ac ON ac.userID = u.userID
    WHERE u.username = input_username
	GROUP BY u.username;
END //

DELIMITER ;

CALL GetApptCountsByUsername('judiem');



#2. Get Recent Booking Details by username
DELIMITER //

CREATE PROCEDURE GetRecentBookingDetailsByUserID(
    IN p_userID INT
)
BEGIN
    SELECT b.bookingID, b.name, b.contactNum, b.dateAndTime, b.apptType, b.modeOfPay, b.price
    FROM Booking b
    WHERE b.userID = p_userID
    ORDER BY b.dateAndTime DESC
    LIMIT 1;
END //

DELIMITER ;

CALL GetRecentBookingDetailsByUserID(1004);
SELECT * FROM Booking;


#3. Update Contact and ModeofPayment by bookingID
DELIMITER //

CREATE PROCEDURE UpdateBookingDetails(
    IN p_bookingID INT,
    IN p_contactNum VARCHAR(50),
    IN p_modeOfPay ENUM('Cash', 'GCash')
)
BEGIN
    UPDATE Booking
    SET contactNum = p_contactNum,
        modeOfPay = p_modeOfPay
    WHERE bookingID = p_bookingID;
END //

DELIMITER ;

CALL UpdateBookingDetails(125, '0987 654 3210', 'GCash');

#4. Check pending appointments
DELIMITER //

CREATE PROCEDURE GetUpcomingAppointmentDetailsByUserID(
    IN p_userID INT
)
BEGIN
    SELECT b.bookingID, b.name, b.contactNum, b.dateAndTime, b.apptType, b.modeOfPay, b.price, a.tipAmount
    FROM Booking b
    INNER JOIN Appointment a ON b.bookingID = a.bookingID
    WHERE b.userID = p_userID
        AND b.dateAndTime > NOW()
    ORDER BY b.dateAndTime ASC;
END //

DELIMITER ;

CALL GetUpcomingAppointmentDetailsByUserID(1004);
CALL GetUpcomingAppointmentDetailsByUserID(1013);

#------------------------------------------------------------------------
#INCOME
#1.1 DAILY
SELECT SUM(subtotal) 'Daily Income' FROM Transaction T
JOIN Booking B ON B.bookingID = T.bookingID
WHERE DATE(b.dateAndTime) = CURDATE();

#1.2 Monthly
SELECT SUM(subtotal) 'Monthly Income' FROM Transaction T
JOIN Booking B ON B.bookingID = T.bookingID
WHERE MONTH(B.dateAndTime) = MONTH(CURDATE())
AND YEAR(B.dateAndTime) = YEAR(CURDATE());

#1.3 Yearly
SELECT SUM(subtotal) 'Yearly Income' FROM Transaction T
JOIN Booking B ON B.bookingID = T.bookingID
WHERE YEAR(B.dateAndTime) = YEAR(CURDATE());

#------------------------------------------------------------------------
# SEARCH USER
DELIMITER //

CREATE PROCEDURE GetApptCountsByUsername(
    IN input_username VARCHAR(255)
)
BEGIN
    SELECT u.username, ac.failedApptCount 'Failed Appointment', 
	(SUM(ac.totalApptCount) - SUM(ac.failedApptCount)) 'Successful Appointment', ac.totalApptCount

	FROM User u
	JOIN ApptCount ac ON ac.userID = u.userID
    WHERE u.username = input_username
	GROUP BY u.username;
END //

DELIMITER ;


CALL GetApptCountsByUsername('krishlatub');
   
#------------------------------------------------------------------------
#BOOKING

#1. show all booking from current date - end of month
SELECT bookingID, name, apptType, dateAndTime, price
FROM Booking
WHERE dateAndTime >= (SELECT CURDATE())
ORDER BY dateAndTime;

#2. all pending (June only) 
SELECT B.bookingID, B.name, B.apptType, B.dateAndTime, B.price
FROM Booking B
LEFT JOIN Appointment A ON B.bookingID = A.bookingID
LEFT JOIN RejectedBooking R ON B.bookingID = R.bookingID
WHERE A.bookingID IS NULL
  AND R.bookingID IS NULL
  AND MONTH(B.dateAndTime) = MONTH(CURDATE())
ORDER BY B.dateAndTime;

#3. [Accept Button] 
DELIMITER //
CREATE PROCEDURE AcceptedBookingToAppointment(
	IN bookingID INT)
    
BEGIN
    INSERT INTO Appointment (bookingID)
    VALUES (bookingID);
END //

DELIMITER ;

CALL AcceptedBookingToAppointment(117);


#4. [Decline Button]
DELIMITER //
CREATE PROCEDURE InsertRejectedBooking(
	IN bookingID INT,
    IN comment VARCHAR(255))
    
BEGIN
    INSERT INTO rejectedBooking (bookingID, comment)
    VALUES (bookingID, comment);
END //

DELIMITER ;

CALL InsertRejectedBooking(122, 'Bogus Buyer');


#5. ALL Confirmed (June Only) 
SELECT B.bookingID, B.name, B.apptType, B.dateAndTime, B.price
FROM Booking B
JOIN Appointment A ON B.bookingID = A.bookingID
WHERE B.dateAndTime BETWEEN CURDATE() AND CONCAT(LAST_DAY(CURDATE()), ' 23:59:59') 
ORDER BY B.dateAndTime;

 #6 ALL Rejected / Cancelled (June Only) 
SELECT R.bookingID, B.name, B.apptType, B.dateAndTime, B.price
FROM Booking B
LEFT JOIN RejectedBooking R ON R.bookingID = B.bookingID
WHERE B.dateAndTime BETWEEN CURDATE() AND CONCAT(LAST_DAY(CURDATE()), ' 23:59:59') 
AND R.bookingID IS NOT NULL
ORDER BY B.dateAndTime;



#------------------------------------------------------------------------
#Appointment 

DELETE FROM Appointment WHERE bookingID = 117;

#1.1 ALL Sort by DESC
SELECT A.apptID, B.name, B.apptType, B.dateAndTime, B.price
FROM Appointment A
JOIN Booking B ON A.bookingID = B.bookingID
ORDER BY A.apptID DESC;

SELECT COUNT(*) 'Total Appointment'
FROM Appointment;

#1.2 ALL Sort by ASC
SELECT A.apptID, B.name, B.apptType, B.dateAndTime, B.price
FROM Appointment A
JOIN Booking B ON A.bookingID = B.bookingID
ORDER BY A.apptID;


#2.1 Mark as done / Show All Appointments Not in Transaction Table
SELECT A.bookingID, B.name, B.apptType, B.dateAndTime, B.price 
FROM Booking B
LEFT JOIN Appointment A ON A.bookingID = B.bookingID
LEFT JOIN Transaction T ON A.bookingID = T.bookingID
WHERE B.dateAndTime BETWEEN CURDATE() AND CONCAT(LAST_DAY(CURDATE()), ' 23:59:59')  AND T.transactionID IS NULL
AND A.bookingID IS NOT NULL
ORDER BY A.bookingID ASC;

#2.2 Mark as done / Show All Appointments Not in Transaction Table
SELECT A.bookingID, B.name, B.apptType, B.dateAndTime, B.price 
FROM Booking B
LEFT JOIN Appointment A ON A.bookingID = B.bookingID
LEFT JOIN Transaction T ON A.bookingID = T.bookingID
WHERE B.dateAndTime BETWEEN CURDATE() AND CONCAT(LAST_DAY(CURDATE()), ' 23:59:59')  AND T.transactionID IS NULL
AND A.bookingID IS NOT NULL
ORDER BY A.bookingID DESC;


# 3. UPDATE TIP AMOUNT 
DELIMITER //

CREATE PROCEDURE UpdateTipAmount(
	IN apptID INT, 
    IN tipAmount INT
)
BEGIN
    UPDATE Appointment
    SET tipAmount = tipAmount
    WHERE apptID = apptID;
END //

DELIMITER ;

CALL UpdateTipAmount(213, 0);

# 4. MARK AS DONE 
DELIMITER //

CREATE PROCEDURE DoneAppointment(
    IN apptID INT,
    IN bookingID INT,
    IN status ENUM('Success','Failed'),
    IN subtotal INT,
    comment VARCHAR(255)
)
BEGIN
    INSERT INTO Transaction (apptID, bookingID, status, subtotal, comment)
    VALUES (apptID, bookingID, status, subtotal, comment);
END //

DELIMITER ;


CALL DoneAppointment(213, 113, 'Success', 700, 'No issues');


#5.1 DONE. SHOW ALL TRANSACTIONS  
DELETE FROM Transaction WHERE transactionID = 313;

SELECT T.transactionID, B.name, T.status, B.apptType AS apptType, B.dateAndTime, B.price
FROM Transaction T
JOIN Booking B ON T.bookingID = B.bookingID
ORDER BY T.transactionID DESC;

#5.2 DONE.SHOW ALL TRANSACTIONS  
SELECT T.transactionID, B.name, T.status, B.apptType AS apptType, B.dateAndTime, B.price 
FROM Transaction T
JOIN Booking B ON T.bookingID = B.bookingID
ORDER BY T.transactionID ASC;

#------------------------------------------------------------------------
#TRANSACTION 

#1. ALL TRANSACTION 
SELECT T.transactionID, B.name, T.status, B.apptType AS apptType, B.dateAndTime, B.price
FROM Transaction T
JOIN Booking B ON T.bookingID = B.bookingID
ORDER BY T.transactionID DESC;

# 1.2 Transaction count 
SELECT COUNT(*) 'All Transaction'
FROM Transaction;

#2.1 Filter for Successful Transactions
SELECT T.transactionID, B.name, T.status, B.apptType AS apptType, B.dateAndTime, B.price
FROM Transaction T
JOIN Booking B ON T.bookingID = B.bookingID
WHERE T.status = 'SUCCESS'
ORDER BY T.transactionID DESC;

#2.2 Success Transaction Count
SELECT COUNT(*) 'Success Transaction'
FROM Transaction
WHERE status = 'SUCCESS';

#3.1  Filter for Failed Transactions
SELECT T.transactionID, B.name, T.status, B.apptType AS apptType, B.dateAndTime, B.price
FROM Transaction T
JOIN Booking B ON T.bookingID = B.bookingID
WHERE T.status = 'FAILED'
ORDER BY T.transactionID DESC;

#3.2  Failed Transaction Count
SELECT COUNT(*) 'Failed Transaction'
FROM Transaction
WHERE status = 'FAILED';


