-- Creating a Database for Stadium Ticket System
CREATE DATABASE IF NOT EXISTS Stadium_Ticket_Systems; 
USE Stadium_Ticket_Systems;
-- Table for Storing User Information
CREATE TABLE IF NOT EXISTS Fans (
    fan_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(15),
    address_fan VARCHAR(255),
    account_balance int
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
-- Table for Seats in the Stadium
CREATE TABLE IF NOT EXISTS seat (
    seat_id VARCHAR(20),
    stadium_id VARCHAR(20),
    seat_number INT,
    seat_type VARCHAR(255),
    PRIMARY KEY (seat_id, stadium_id), -- Modified primary key
    FOREIGN KEY (stadium_id) REFERENCES match_event(stadium_id)
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

select * from fans;
select * from stadiums;
select * from match_event;
select * from seat;
select * from ticket;
select * from  reservation;
select *from payment; 

-- A stored procedure to perform the ticket purchase transaction
-- Stored Procedure Correction
-- Stored Procedure to perform the ticket purchase transaction
DELIMITER $$
CREATE PROCEDURE PurchaseTicket(IN p_fan_id VARCHAR(20), IN p_ticket_id VARCHAR(20))
BEGIN
    DECLARE ticket_price DECIMAL(10, 2);
    
    -- Start the transaction
    START TRANSACTION;

    -- Get the ticket price
    SELECT price INTO ticket_price FROM ticket WHERE ticket_id = p_ticket_id;

    -- Check if the ticket is available and the fan has enough balance
    IF EXISTS(SELECT 1 FROM ticket WHERE ticket_id = p_ticket_id AND status_ticket = 'Available')
        AND EXISTS(SELECT 1 FROM Fans WHERE fan_id = p_fan_id AND account_balance >= ticket_price) THEN

        -- Update the ticket status to 'Purchased'
        UPDATE ticket SET status_ticket = 'Sold' WHERE ticket_id = p_ticket_id;

        -- Deduct the ticket price from the fan's account balance
        UPDATE Fans SET account_balance = account_balance - ticket_price WHERE fan_id = p_fan_id;

        -- Insert a payment record
        INSERT INTO payment (payment_id, reservation_id, amount, payment_date)
        VALUES (CONCAT('PAY', LPAD(LAST_INSERT_ID(), 3, '0')), p_ticket_id, ticket_price, NOW());

        -- Commit the transaction
        COMMIT;
        
        SELECT 'Purchase successful!' AS Status;
    ELSE
        -- Rollback the transaction if the conditions are not met
        ROLLBACK;

        SELECT 'Purchase failed. Ticket not available or insufficient balance.' AS Status;
    END IF;
END $$
DELIMITER ;
CALL PurchaseTicket('F001', 'T001');
CALL PurchaseTicket('F002', 'T004');
CALL PurchaseTicket('F003', 'T005');
CALL PurchaseTicket('F002', 'T006');
Call PurchaseTicket('F002','T006');
Call PurchaseTicket('F002','T003');






-- Corrected Data Retrieval
SELECT * FROM ticket WHERE match_id = 2 AND seat_id = 'SEAT001';
SELECT * FROM ticket WHERE match_id = 3 AND seat_id = 'SEAT002';
select * from ticket where match_id = 3 and seat_id = 'SEAT004';
SELECT * FROM Fans WHERE fan_id = 'F003';


SELECT * FROM Fans WHERE fan_id = 'F002';
select * from payment;
SELECT * FROM ticket;
select * from match_event;
SELECT * FROM fans;
select * from Stadiums;
select * from seat;


