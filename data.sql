-- Creating a Database for Stadium Ticket System
CREATE DATABASE IF NOT EXISTS Stadium_Ticket_Systems; 
USE Stadium_Ticket_Systems;
drop database Stadium_Ticket_Systems;
-- Table for Storing User Information
CREATE TABLE IF NOT EXISTS Fans (
    fan_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(15),
    address_fan VARCHAR(255)
);

-- Table for Stadium Venues
CREATE TABLE IF NOT EXISTS Stadiums (
    stadium_id VARCHAR(20) PRIMARY KEY,
    stadium_name VARCHAR(255),
    address_stadium VARCHAR(255),
    capacity INT -- Assuming capacity is an integer
);

-- Table for Football Matches
CREATE TABLE IF NOT EXISTS match_event (
    match_id INT PRIMARY KEY,
    match_name VARCHAR(255), 
    description_match VARCHAR(255),
    date_match DATE,
    time_match TIME, -- Changed to TIME
    stadium_id VARCHAR(20),
    FOREIGN KEY(stadium_id) REFERENCES Stadiums(stadium_id)
);

-- Table for Seats in the Stadium
CREATE TABLE IF NOT EXISTS seat (
    seat_id VARCHAR(20) PRIMARY KEY,
    stadium_id VARCHAR(20),
    seat_number INT,
    seat_type VARCHAR(255),
    FOREIGN KEY(stadium_id) REFERENCES match_event(stadium_id) 
);

-- Table for Ticketing Information
CREATE TABLE IF NOT EXISTS ticket (
    ticket_id VARCHAR(20) PRIMARY KEY,
    match_id INT,
    seat_id VARCHAR(20),
    price DECIMAL(10, 2),
    status_ticket VARCHAR(255),
    FOREIGN KEY(match_id) REFERENCES match_event(match_id),
    FOREIGN KEY(seat_id) REFERENCES seat(seat_id) 
);

-- Table for Fan Reservations
CREATE TABLE IF NOT EXISTS reservation (
    reservation_id VARCHAR(255) PRIMARY KEY,
    fan_id VARCHAR(20),
    ticket_id VARCHAR(255),
    date_reservation DATE,
    time_reservation TIME,
    priority_reservation VARCHAR(255),
    FOREIGN KEY(fan_id) REFERENCES Fans(fan_id),
    FOREIGN KEY(ticket_id) REFERENCES ticket(ticket_id)
);

-- Table for Payment Records
CREATE TABLE IF NOT EXISTS payment (
    payment_id VARCHAR(20) PRIMARY KEY,
    reservation_id VARCHAR(255),
    amount DECIMAL(10, 2), -- Adjusted to DECIMAL
    payment_date DATE,
    FOREIGN KEY(reservation_id) REFERENCES reservation(reservation_id) 
);

-- Inserting Sample Data into Tables

-- Fans
INSERT INTO Fans (fan_id, first_name, middle_name, last_name, email, phone, address_fan)
VALUES ('F001', 'John', 'Doe', 'Smith', 'john.doe@email.com', 1234567890, '123 Main St');

INSERT INTO Fans (fan_id, first_name, middle_name, last_name, email, phone, address_fan)
VALUES ('F002', 'Alice', 'Jane', 'Johnson', 'alice.johnson@email.com', 9876543210, '456 Oak St');
-- Add more fan data as needed.

-- Stadiums
INSERT INTO Stadiums (stadium_id, stadium_name, address_stadium, capacity)
VALUES ('S001', 'Stadium A', '123 Stadium Ave', 50000);

INSERT INTO Stadiums (stadium_id, stadium_name, address_stadium, capacity)
VALUES ('S002', 'Stadium B', '456 Stadium Blvd', 35000);
-- Add more stadium data as needed.

-- Matches
INSERT INTO match_event (match_id, match_name, description_match, date_match, time_match, stadium_id)
VALUES (1, 'Football Match 1', 'Exciting match', '2024-03-15', '20:00:00', 'S001');

INSERT INTO match_event (match_id, match_name, description_match, date_match, time_match, stadium_id)
VALUES (2, 'Football Match 2', 'Intense competition', '2024-03-20', '20:00:00', 'S002');
-- Add more match data as needed.

-- Seats
INSERT INTO seat (seat_id, stadium_id, seat_number, seat_type)
VALUES ('SEAT001', 'S001', 101, 'VIP');

INSERT INTO seat (seat_id, stadium_id, seat_number, seat_type)
VALUES ('SEAT002', 'S001', 102, 'Regular');

INSERT INTO seat (seat_id, stadium_id, seat_number, seat_type)
VALUES ('SEAT003', 'S002', 201, 'Premium');
-- Add more seat data as needed.

-- Tickets
INSERT INTO ticket (ticket_id, match_id, seat_id, price, status_ticket)
VALUES ('TICKET001', 1, 'SEAT001', 100, 'Available');

INSERT INTO ticket (ticket_id, match_id, seat_id, price, status_ticket)
VALUES ('TICKET002', 1, 'SEAT002', 50, 'Available');
INSERT INTO ticket (ticket_id, match_id, seat_id, price, status_ticket)
VALUES ('TICKET003', 2, 'SEAT003', 75, 'Available');
-- Add more ticket data as needed.

-- Reservations
INSERT INTO reservation (reservation_id, fan_id, ticket_id, date_reservation, time_reservation, priority_reservation)
VALUES ('RES001', 'F001', 'TICKET001', '2024-03-10', '20:00:00', 'VIP');

INSERT INTO reservation (reservation_id, fan_id, ticket_id, date_reservation, time_reservation, priority_reservation)
VALUES ('RES002', 'F002', 'TICKET002', '2024-03-12', '20:30:00', 'Normal');
-- Add more reservation data as needed.
-- Payments
INSERT INTO payment (payment_id, reservation_id, amount, payment_date)
VALUES ('PAY001', 'RES001', 100, '2024-03-11');

INSERT INTO payment (payment_id, reservation_id, amount, payment_date)
VALUES ('PAY002', 'RES002', 50, '2024-03-13');


select * from fans;
select * from stadiums;
select * from match_event;
select * from seat;
select * from ticket;
select * from  reservation;
select *from payment; 

-- A stored procedure to perform the ticket purchase transaction
-- Stored Procedure Correction
DELIMITER $$

CREATE PROCEDURE PurchaseTicket(IN p_fan_id VARCHAR(20), IN p_match_id INT, IN p_seat_id VARCHAR(20))
BEGIN
    DECLARE available_tickets INT;
    DECLARE ticket_price DECIMAL(10, 2);

    -- Start the transaction
    START TRANSACTION;

    -- Get the available tickets and ticket price
    SELECT COUNT(*) INTO available_tickets FROM ticket WHERE match_id = p_match_id AND seat_id = p_seat_id AND status_ticket = 'Available';
    SELECT price INTO ticket_price FROM ticket WHERE match_id = p_match_id AND seat_id = p_seat_id AND status_ticket = 'Available';

    -- Check if there are available tickets
    IF available_tickets > 0 THEN
        -- Update the ticket status to 'Sold'
        UPDATE ticket SET status_ticket = 'Sold' WHERE match_id = p_match_id AND seat_id = p_seat_id AND status_ticket = 'Available';

        -- Deduct the ticket price from the fan's account
        UPDATE Fans SET account_balance = account_balance - ticket_price WHERE fan_id = p_fan_id;

        -- Insert a payment record
        INSERT INTO payment (payment_id, reservation_id, amount, payment_date)
        VALUES (CONCAT('PAY', LPAD(LAST_INSERT_ID(), 3, '0')), CONCAT('RES', LPAD(LAST_INSERT_ID(), 3, '0')), ticket_price, NOW());
    END IF;

    -- Commit the transaction
    COMMIT;
END $$

DELIMITER ;


CALL PurchaseTicket('F001', 2, 'SEAT002');
-- Corrected Data Retrieval
SELECT * FROM ticket WHERE match_id = 2 AND seat_id = 'SEAT002';
SELECT * FROM ticket WHERE match_id = 2 AND seat_id = 'SEAT003';


SELECT * FROM Fans WHERE fan_id = 'F002';
select * from payment;
SELECT * FROM ticket;
SELECT * FROM fans;

-- Create Users

-- Main Admin
CREATE USER IF NOT EXISTS 'MainAdmin'@'localhost' IDENTIFIED BY 'MainAdminPass';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'MainAdmin'@'localhost';

-- Event Manager
CREATE USER IF NOT EXISTS 'EventManager'@'localhost' IDENTIFIED BY 'EventManagerPass';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_Systems.Stadiums TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_Systems.match_event TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_Systems.seat TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_Systems.ticket TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_Systems.reservation TO 'EventManager'@'localhost';
GRANT SELECT, INSERT ON Stadium_Ticket_Systems.payment TO 'EventManager'@'localhost';
FLUSH PRIVILEGES;

show grants for 'EventManager'@'localhost';
