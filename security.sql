-- Create Users

-- Main Admin
CREATE USER IF NOT EXISTS 'MainAdmin'@'localhost' IDENTIFIED BY 'MainAdminPass';
GRANT ALL PRIVILEGES ON Stadium_Ticket_System.* TO 'MainAdmin'@'localhost';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'MainAdmin'@'localhost';

-- Event Manager
CREATE USER IF NOT EXISTS 'EventManager'@'localhost' IDENTIFIED BY 'EventManagerPass';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.Stadiums TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.match_event TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.seat TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.ticket TO 'EventManager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.reservation TO 'EventManager'@'localhost';
GRANT SELECT, INSERT ON Stadium_Ticket_System.payment TO 'EventManager'@'localhost';
FLUSH PRIVILEGES;

show grants for 'EventManager'@'localhost';

-- Ticket Seller
CREATE USER IF NOT EXISTS 'TicketSeller'@'localhost' IDENTIFIED BY 'TicketSellerPass';
GRANT SELECT ON Stadium_Ticket_System.match_event TO 'TicketSeller'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.seat TO 'TicketSeller'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Stadium_Ticket_System.ticket TO 'TicketSeller'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.reservation TO 'TicketSeller'@'localhost';
FLUSH PRIVILEGES;

show grants for 'TicketSeller'@'localhost';

-- Customer
CREATE USER IF NOT EXISTS 'Customer'@'localhost' IDENTIFIED BY 'CustomerPass';
GRANT SELECT ON Stadium_Ticket_System.Stadiums TO 'Customer'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.match_event TO 'Customer'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.seat TO 'Customer'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.ticket TO 'Customer'@'localhost'; 
GRANT SELECT ON Stadium_Ticket_System.reservation TO 'Customer'@'localhost';
GRANT SELECT ON Stadium_Ticket_System.payment TO 'Customer'@'localhost';
FLUSH PRIVILEGES;

show grants for 'Customer'@'localhost';
