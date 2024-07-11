SHOW DATABASES;

CREATE DATABASE nailsdb;
USE nailsdb;

CREATE TABLE Role (
    roleID INT PRIMARY KEY,
    roleName VARCHAR(255) NOT NULL
);

CREATE TABLE User (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    roleID INT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (roleID) REFERENCES Role(roleID)
);

ALTER TABLE User AUTO_INCREMENT = 1001;

ALTER TABLE User
ADD CONSTRAINT username UNIQUE (username);

CREATE TABLE ApptCount (
    userID INT PRIMARY KEY,
    failedApptCount INT DEFAULT 0,
    totalApptCount INT DEFAULT 0,
    FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Booking (
    bookingID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    name VARCHAR(255) NOT NULL,
    contactNum VARCHAR(50) NOT NULL,
    dateAndTime DATETIME NOT NULL,
    apptType ENUM('Soft BIAB', 'Gel Overlay', 'Softgel Extensions','Removal') NOT NULL,
    modeOfPay ENUM('Cash', 'GCash') NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES User(userID)
);

ALTER TABLE Booking AUTO_INCREMENT = 101;

CREATE TABLE Appointment (
    apptID INT PRIMARY KEY AUTO_INCREMENT,
    bookingID INT,
    tipAmount INT,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID)
);

ALTER TABLE Appointment AUTO_INCREMENT= 201;

CREATE TABLE Transaction (
    transactionID INT PRIMARY KEY AUTO_INCREMENT,
    apptID INT,
    bookingID INT,
    status ENUM('Success','Failed') NOT NULL,
    subtotal INT NOT NULL,
    comment VARCHAR(255),
    FOREIGN KEY (apptID) REFERENCES Appointment(apptID),
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID)
);

ALTER TABLE Transaction AUTO_INCREMENT= 301;

CREATE TABLE RejectedBooking (
	rejectedID INT PRIMARY KEY AUTO_INCREMENT,
	bookingID INT,
	comment VARCHAR(255),
	FOREIGN KEY (bookingID) REFERENCES Booking(bookingID)
);   

ALTER TABLE RejectedBooking AUTO_INCREMENT= 401;
