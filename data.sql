SHOW DATABASES
  
USE nailsdb;

INSERT INTO Role (roleID, roleName) VALUES
(10, 'admin'),
(11, 'guest');

SELECT * FROM Role;

INSERT INTO User (roleID, username, password) VALUES
(10, 'admin', 'admin'),
(11, 'krishlatub', 'pass'),
(11, 'paoalbertc', 'pass'),
(11, 'judiem', 'pass'),
(11, 'denise', 'pass'),
(11, 'olivia', 'pass'),
(11, 'sabrina', 'pass'),
(11, 'nico', 'pass'),
(11, 'anecka', 'pass'),
(11, 'maloi', 'pass'),
(11, 'stacey', 'pass'),
(11, 'aiahh', 'pass'),
(11, 'jhoanna', 'pass'),
(11, 'mikha', 'pass'),
(11, 'colet', 'pass'),
(11, 'gwen', 'pass'),
(11, 'sheena', 'pass'),
(11, 'laine', 'pass'),
(11, 'arabella', 'pass'),
(11, 'cherrybom', 'pass'),
(11, 'ashley', 'pass'),
(11, 'shairaa', 'pass'),
(11, 'tonitoni', 'pass'),
(11, 'joanna', 'pass'),
(11, 'hannah', 'pass'),
(11, 'adriana', 'pass'),
(11, 'riri', 'pass'),
(11, 'justine', 'pass'),
(11, 'rina', 'pass'),
(11, 'kenny', 'pass');

SELECT * FROM User;

INSERT INTO ApptCount (userID, failedApptCount, totalApptCount)VALUES
(1001, 0, 0),
(1002, 3, 3),
(1003, 3, 3),
(1004, 0, 1),
(1005, 0, 1),
(1006, 0, 1),
(1007, 0, 1),
(1008, 0, 1),
(1009, 0, 1),
(1010, 0, 1),
(1011, 0, 1),
(1012, 0, 1),
(1013, 0, 1),
(1014, 0, 0),
(1015, 0, 0),
(1016, 0, 0),
(1017, 0, 0),
(1018, 0, 0),
(1019, 0, 0),
(1020, 0, 0),
(1021, 0, 0),
(1022, 0, 0),
(1023, 0, 0),
(1024, 0, 0),
(1025, 0, 0),
(1026, 0, 0),
(1027, 0, 0),
(1028, 0, 0),
(1029, 0, 0),
(1030, 0, 0);

SELECT * FROM ApptCount;

INSERT INTO Booking (userID, name, contactNum, dateAndTime, apptType, modeOfPay, price) VALUES
(1002, 'Krishla Tuburan', '0963 633 3666', '2024-05-06 10:00:00', 'Removal', 'Cash', 150),
(1002, 'Krishla Tuburan', '0963 633 3666', '2024-05-10 14:00:00', 'Removal', 'Cash', 150),
(1002, 'Krishla Tuburan', '0963 633 3666', '2024-05-13 10:00:00', 'Softgel Extensions', 'Cash', 700),
(1003, 'Pao Alberto', '0912 121 1111', '2024-05-14 10:00:00', 'Removal', 'Cash', 150),
(1003, 'Pao Alberto', '0912 121 1111', '2024-05-15 14:00:00', 'Removal', 'Cash', 150),
(1003, 'Pao Alberto', '0912 121 1111', '2024-05-16 14:00:00', 'Soft BIAB', 'Cash', 500),
(1004, 'Judie Michelle', '0911 333 3636', '2024-05-17 10:00:00', 'Softgel Extensions', 'Cash', 700),
(1005, 'Denise', '0999 888 8181', '2024-06-03 10:00:00', 'Softgel Extensions', 'Cash', 700),
(1006, 'Sabrina', '0928 222 8212', '2024-06-03 14:00:00', 'Soft BIAB', 'Cash', 500),
(1007, 'Sabrina', '0928 822 1112', '2024-06-04 10:00:00', 'Softgel Extensions', 'GCash', 700),
(1008, 'Nico Bruce', '0905 515 5555', '2024-06-05 14:00:00', 'Gel Overlay', 'GCash', 400),
(1009, 'Anecka Estocado', '0905 787 8980', '2024-06-10 10:00:00', 'Soft BIAB', 'GCash', 500),
(1010, 'Maloi Ricalde', '0927 722 2111', '2024-06-25 10:00:00', 'Softgel Extensions', 'Cash', 700),
(1011, 'Stacey Sevilleja', '0927 334 9128', '2024-06-25 14:00:00', 'Soft BIAB', 'Cash', 500),
(1012, 'Aiah', '0925 644 4113', '2024-06-26 10:00:00', 'Removal', 'Cash', 150),
(1013, 'Jhoanna Robles', '0966 616 7177', '2024-06-26 14:00:00', 'Gel Overlay', 'Cash', 400),
(1014, 'Mikha Lim', '0967 722 6767', '2024-06-27 10:00:00', 'Softgel Extensions', 'Cash', 700),
(1015, 'Colet Vergara', '0906 711 8222', '2024-06-27 14:00:00', 'Soft BIAB', 'Cash', 500),
(1016, 'Sheena Catacutan', '0915 722 8910', '2024-06-28 10:00:00', 'Softgel Extensions', 'GCash', 700),
(1017, 'Gwen Apuli', '0961 822 4531', '2024-06-28 14:00:00', 'Softgel Extensions', 'Cash', 700),
(1002, 'Krishla Tuburan', '0963 633 3666', '2024-06-29 14:00:00', 'Removal', 'GCash', 150),
(1003, 'Pao Alberto', '0912 121 1111', '2024-06-30 14:00:00', 'Gel Overlay', 'Cash', 400),
(1020, 'Cherry', '0999 888 8181', '2024-06-30 14:00:00', 'Removal', 'Cash', 150),
(1021, 'Ashley', '0999 888 8181', '2024-06-30 14:00:00', 'Removal', 'Cash', 150);

SELECT * FROM Booking;


INSERT INTO Appointment (bookingID, tipAmount) VALUES
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 0),
(106, 0),
(107, 200),
(108, 0),
(109, 0),
(110, 0),
(111, 100),
(112, 150),
(113, 0),
(114, 0),
(115, 0),
(116, 0);

SELECT * FROM Appointment;

INSERT INTO Transaction (apptID, bookingID, status, subtotal, comment) VALUES
(201, 101, 'FAILED', 150, 'did not show up'),
(202, 102, 'FAILED', 150, 'did not show up'),
(203, 103, 'FAILED', 700, 'did not show up'),
(204, 104, 'FAILED', 150, 'did not show up'),
(205, 105, 'FAILED', 150, 'did not show up'),
(206, 106, 'FAILED', 500, 'did not show up'),
(207, 107, 'SUCCESS', 700, 'showed up'),
(208, 108, 'SUCCESS', 700, 'showed up'),
(209, 109, 'SUCCESS', 500, 'showed up'),
(210, 110, 'SUCCESS', 700, 'dshowed up'),
(211, 111, 'SUCCESS', 400, 'showed up'),
(212, 112, 'SUCCESS', 500, 'showed up');

SELECT * FROM Transaction;

INSERT INTO RejectedBooking (bookingID, comment) VALUES
(121, 'Bogus Buyer');

SELECT * FROM RejectedBooking;
