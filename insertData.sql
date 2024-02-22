INSERT INTO Fans (fan_id, first_name, middle_name, last_name, email, phone, address_fan, account_balance)
VALUES
    ('F001', 'John', 'A.', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, CityA', 500),
    ('F002', 'Jane', 'B.', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St, CityB', 1000),
    ('F003', 'David', 'C.', 'Johnson', 'david.johnson@example.com', '555-123-4567', '789 Oak St, CityC', 750);
    
    
INSERT INTO Stadiums (stadium_id, stadium_name, address_stadium, capacity)
VALUES
    ('ST001', 'StadiumA', '123 Main St, CityA', 10000),
    ('ST002', 'StadiumB', '456 Elm St, CityB', 15000),
    ('ST003', 'StadiumC', '789 Oak St, CityC', 20000);


INSERT INTO match_event (match_id, match_name, description_match, date_match, time_match, stadium_id)
VALUES
    (1, 'MatchA', 'Description for MatchA', '2024-03-01', '18:00:00', 'ST001'),
    (2, 'MatchB', 'Description for MatchB', '2024-03-05', '20:00:00', 'ST002'),
    (3, 'MatchC', 'Description for MatchC', '2024-03-10', '19:30:00', 'ST003');


INSERT INTO seat (seat_id, stadium_id, seat_number, seat_type)
VALUES
    ('SEAT001', 'ST001', 1, 'Regular'),
    ('SEAT002', 'ST001', 2, 'VIP'),
    ('SEAT003', 'ST002', 1, 'Regular'),
    ('SEAT004', 'ST002', 2, 'VIP'),
    ('SEAT005', 'ST003', 1, 'Regular'),
    ('SEAT006', 'ST003', 2, 'VIP');



INSERT INTO ticket (ticket_id, match_id, seat_id, price, status_ticket)
VALUES
    ('T001', 1, 'SEAT001', 50.00, 'Available'),
    ('T002', 1, 'SEAT002', 100.00, 'Available'),
    ('T003', 2, 'SEAT001', 75.00, 'Available'),
    ('T004', 2, 'SEAT002', 150.00, 'Available'),
    ('T005', 3, 'SEAT003', 60.00, 'Available'),
    ('T006', 3, 'SEAT004', 120.00, 'Available');



-- Inserting sample data into the reservation table
INSERT INTO reservation (reservation_id, fan_id, ticket_id, date_reservation, time_reservation, priority_reservation)
VALUES
    ('RES001', 'F002', 'T006', '2024-02-22', '18:00:00', 'Regular'),
    ('RES002', 'F001', 'T004', '2024-02-23', '19:30:00', 'VIP'),
    ('RES003', 'F003', 'T005', '2024-02-24', '20:00:00', 'Regular');

-- Inserting sample data into the payment table
INSERT INTO payment (payment_id, reservation_id, amount, payment_date)
VALUES
    ('PAY001', 'RES001', 120.00, '2024-02-22'),
    ('PAY002', 'RES002', 150.00, '2024-02-23'),
    ('PAY003', 'RES003', 60.00, '2024-02-24');
