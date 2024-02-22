
-- Main Admin View
CREATE OR REPLACE VIEW MainAdminView AS
SELECT * FROM Fans;
SELECT * FROM Stadiums;
SELECT * FROM match_event;
SELECT * FROM seat;
SELECT * FROM ticket;
SELECT * FROM reservation;
SELECT * FROM payment;

-- Event Manager View
CREATE OR REPLACE VIEW EventManagerView AS
SELECT * FROM Stadiums;
SELECT * FROM match_event;
SELECT * FROM seat;
SELECT * FROM ticket;
SELECT * FROM reservation;
SELECT * FROM payment;

-- Ticket Seller View
CREATE OR REPLACE VIEW TicketSellerView AS
SELECT * FROM match_event;
SELECT * FROM seat;
SELECT * FROM ticket;
SELECT * FROM reservation;

-- Customer View
CREATE OR REPLACE VIEW CustomerView AS
SELECT * FROM Stadiums;
SELECT * FROM match_event;
SELECT * FROM seat;
SELECT * FROM ticket;
SELECT * FROM reservation;
SELECT * FROM payment;


CREATE OR REPLACE VIEW EventManagerViewNew AS
SELECT
    s.stadium_id AS stadium_id_s,
    s.stadium_name,
    s.address_stadium,
    s.capacity AS stadium_capacity,
    me.match_id,
    me.match_name,
    me.description_match,
    me.date_match,
    me.time_match,
    se.seat_id AS seat_id_se,
    se.seat_number,
    se.seat_type,
    t.ticket_id,
    t.price AS ticket_price,
    t.status_ticket,
    r.reservation_id,
    r.fan_id,
    r.date_reservation,
    r.time_reservation,
    r.priority_reservation,
    p.payment_id,
    p.amount AS payment_amount,
    p.payment_date
FROM
    Stadiums s
JOIN match_event me ON s.stadium_id = me.stadium_id
JOIN seat se ON me.stadium_id = se.stadium_id
JOIN ticket t ON me.match_id = t.match_id AND se.seat_id = t.seat_id
JOIN reservation r ON t.ticket_id = r.ticket_id
JOIN payment p ON r.reservation_id = p.reservation_id;



SELECT * FROM MainAdminView;
SELECT * FROM EventManagerView;
SELECT * FROM TicketSellerView;
SELECT * FROM CustomerView;

-- Select all columns from the EventManagerViewNew view
SELECT * FROM EventManagerViewNew;
