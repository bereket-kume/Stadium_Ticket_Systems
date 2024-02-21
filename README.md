**Stadium Ticket System

This repository contains the code and database structure for a Stadium Ticket System. The system manages ticket sales, reservations, and payments for football matches in various stadiums. It also includes user management for administrators, event managers, and fans.

#Features
User registration and login for fans.
Stadium and match management for event managers.
Ticket purchasing and reservation for fans.
Payment processing and transaction history.
Access control for administrators and event managers.
Technologies Used
Programming Language: SQL
Database Management System: MySQL
Database Design: Relational Database
User Interface: N/A (This project focuses on the backend logic and database structure)
Database Structure
The database structure consists of the following tables:

Fans: Stores information about registered fans, including their personal details and account balance.
Stadiums: Stores information about stadiums, including their names, addresses, and capacities.
match_event: Stores information about football matches, including match details, dates, times, and associated stadiums.
seat: Stores information about seats in the stadiums, including seat numbers, types, and the stadiums they belong to.
ticket: Stores information about tickets, including ticket IDs, associated matches, seats, prices, and availability status.
reservation: Stores information about fan reservations, including reservation IDs, associated fans, tickets, reservation dates, times, and priorities.
payment: Stores information about payment records, including payment IDs, associated reservations, payment amounts, and dates.
Stored Procedure
The project includes a stored procedure called PurchaseTicket that performs the ticket purchase transaction. It checks the availability of tickets, updates the ticket status, deducts the ticket price from the fan's account balance, and records the payment details.

#User Roles
The system includes the following user roles:

Main Admin: The main administrator has full access to all database tables.
Event Manager: The event manager has select, insert, update, and delete access to the stadiums, match_event, seat, ticket, reservation tables, and select and insert access to the payment table.
Setting Up the Database
To set up the Stadium Ticket System database, follow these steps:

Create a MySQL database and name it "Stadium_Ticket_Systems".
Execute the SQL script provided in the repository to create the necessary tables and insert sample data.
Create the users "MainAdmin" and "EventManager" with their respective privileges as mentioned in the script.
Update the database connection configuration in your application code to connect to the created database.
Usage
The Stadium Ticket System can be used as a backend system for managing ticket sales and reservations for football matches in stadiums. It provides the necessary database structure and logic to handle user registrations, ticket purchases, reservations, and payment processing.

Developers can integrate the system with a user interface or build APIs to interact with the database and implement the desired functionality for fans, administrators, and event managers.

#Contributors
The Stadium Ticket System project is developed and maintained by [Your Name]. Contributions and improvements to the project are welcome.

Please feel free to report any issues or suggest enhancements through the repository's issue tracker.

#License
This project is licensed under the MIT License. You are free to modify, distribute, and use the code as per the terms of the license.

#Conclusion
The Stadium Ticket System provides a solid foundation for managing ticket sales, reservations, and payments for football matches. It offers a well-structured database design and a stored procedure for handling the ticket purchase transaction. Developers can build upon this system to create a complete ticketing solution for stadiums and fans.
