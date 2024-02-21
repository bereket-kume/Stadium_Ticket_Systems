# Student Enrollment System

#Project Description: Student Enrollment System

The Student Enrollment System is a database-driven application designed to manage student enrollments in 
various courses within an educational institution. This system tracks student details, course information,
 grades, and financial transactions related to enrollments.

Key Components:

1. Database Structure:
   - Students Table: Stores information about students.
   - Courses Table: Contains details of available courses.
   - Enrollments Table: Tracks student enrollments in specific courses.
   - Grades Table: Records grades associated with enrollments.
   - Users Table: Manages user accounts for students, professors, and university staff.
   - UserRoles Table: Specifies roles (e.g., Student, Professor, University) for users.
   - Transactions Table: Records financial transactions with a unique transaction ID.

2. TransactionDetails Table:
   - Records specific details for each transaction, including the user involved and the transaction amount.
   - Foreign keys link entries to Users and Transactions tables.

Project Workflow:

1. Enrollment Process:
   - A stored procedure (EnrollStudentProc) facilitates the enrollment of a student in a course.
   - Checks are made for course availability (based on available credits) before proceeding.
   - Upon successful enrollment:
     - The student is added to the Enrollments table.
     - Credits are updated in the Courses table.
     - A financial transaction is recorded in the TransactionDetails table.

2. Financial Transactions:
   - The system handles financial transactions associated with enrollments.
   - Transactions involve debiting the student (tuition fees) and crediting the professor and the university.
   - Specific amounts are recorded in the TransactionDetails table.

3. User Roles:
   - The UserRoles table determines the role of each user (Student, Professor, University).

4. Queries:
   - The system includes queries to retrieve enrollment details for a specific student and courses with available credits.

How Transactions Work:
   - Transactions are initiated by the EnrollStudentProc stored procedure.
   - It uses a transaction block to ensure atomicity, consistency, isolation, and durability (ACID properties).
   - Checks for course availability, enrolls the student, updates credits, and records financial transactions within a single transaction.
   - If any step fails, the entire transaction is rolled back to maintain data integrity.

Usage Example:
   - Execute the stored procedure with parameters (@student_id and @course_id) to enroll a student in a specific course.

Note: Ensure correct transaction_id values when recording financial transactions in the TransactionDetails table.

This project aims to provide a robust and comprehensive system for managing student enrollments, grades, and associated financial transactions within an educational institution.





Entity-Relationship Diagram (ERD) for Student Enrollment System:

1. Entities:

- Students:
     - Attributes: student_id (PK), first_name, middle_name, last_name, email, phone, address_student.

   - Courses:
     - Attributes: course_id (PK), course_name, department, credits.

   - Enrollments:
     - Attributes: enrollment_id (PK), student_id (FK), course_id (FK), enrollment_date.
  
   - Grades:
     - Attributes: grade_id (PK), enrollment_id (FK), grade.

   - Users:
     - Attributes: user_id (PK), username, phone.

   - UserRoles:
     - Attributes: user_id (FK), role.
  
   - Transactions:
     - Attributes: transaction_id (PK), description, transaction_date.
  
   - TransactionDetails:
     - Attributes: transaction_detail_id (PK), transaction_id (FK), user_id (FK), amount.

2. Relationships:

   - One-to-Many Relationship:
     - Students (1) to Enrollments (Many) [student_id in Students -> student_id in Enrollments] - Enrolls In
     - Courses (1) to Enrollments (Many) [course_id in Courses -> course_id in Enrollments] - Offered In
     - Enrollments (1) to Grades (Many) [enrollment_id in Enrollments -> enrollment_id in Grades] - Assigned Grades
     - Users (1) to UserRoles (Many) [user_id in Users -> user_id in UserRoles] - Has Roles
     - Transactions (1) to TransactionDetails (Many) [transaction_id in Transactions -> transaction_id in TransactionDetails] - Comprises Transactions

   - Foreign Key Relationships:
     - Enrollments.student_id (FK) to Students.student_id (PK) - Enrolled Student
     - Enrollments.course_id (FK) to Courses.course_id (PK) - Enrolled In Course
     - Grades.enrollment_id (FK) to Enrollments.enrollment_id (PK) - Grade For Enrollment
     - UserRoles.user_id (FK) to Users.user_id (PK) - User Has Role
     - TransactionDetails.transaction_id (FK) to Transactions.transaction_id (PK) - Part of Transaction
     - TransactionDetails.user_id (FK) to Users.user_id (PK) - Transaction User

3. Attributes:

   - Attributes are listed with their corresponding entities.
   - PK indicates primary key attributes.
   - FK indicates foreign key attributes.

Note:
- Ensure the correct transaction_id in the TransactionDetails table in the code snippet.
- Adjust the ERD based on specific requirements and constraints.
*/
