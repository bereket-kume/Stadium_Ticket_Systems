-- Creating a Database
CREATE DATABASE IF NOT EXISTS Student_Enrollment_System;
USE Student_Enrollment_System;

-- Creating Tables
-- Table 1
CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address_student VARCHAR(255)
);

-- Table 2
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255),
    department VARCHAR(255),
    credits INT
);

-- Table 3
CREATE TABLE IF NOT EXISTS Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

-- Table 4
CREATE TABLE IF NOT EXISTS Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    grade VARCHAR(2),
    FOREIGN KEY(enrollment_id) REFERENCES Enrollments(enrollment_id)
);

-- Table 5
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    phone VARCHAR(20)
);

-- Table 6
CREATE TABLE IF NOT EXISTS UserRoles (
    user_id INT,
    role VARCHAR(50),
    PRIMARY KEY (user_id, role),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Table 7
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    transaction_date DATE
);

-- Table 8
CREATE TABLE IF NOT EXISTS TransactionDetails (
    transaction_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    user_id INT,
    amount INT,
    FOREIGN KEY (transaction_id) REFERENCES Transactions (transaction_id),
    FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

-- Inserting Data
-- Note: Removed `enrollment_id` from INSERT INTO Enrollments statement as it's AUTO_INCREMENT
INSERT INTO Students(student_id, first_name, middle_name, last_name, email, phone, address_student) VALUES
    (1, 'John', 'Doe', 'Smith', 'john.doe@example.com', '1234567890', '123 Main St'),
    (2, 'Jane', 'Marie', 'Johnson', 'jane.johnson@example.com', '9876543210', '456 Oak St');

INSERT INTO Courses(course_id, course_name, department, credits) VALUES
    (101, 'Introduction to Computer Science', 'Computer Science', 3),
    (102, 'Calculus I', 'Mathematics', 4);

INSERT INTO Enrollments(student_id, course_id, enrollment_date) VALUES
    (1, 101, '2023-01-15'),
    (2, 102, '2023-02-01');

INSERT INTO Grades(grade_id, enrollment_id, grade) VALUES
    (1, 1, 'A'),
    (2, 2, 'B');

INSERT INTO Users(user_id, username, phone) VALUES
    (1, 'john_doe', '1234567890'),
    (2, 'jane_johnson', '9876543210'),
    (3, 'professor', '5555555555'),
    (4, 'university', '9999999999');

INSERT INTO UserRoles(user_id, role) VALUES
    (1, 'Student'),
    (2, 'Student'),
    (3, 'Professor'),
    (4, 'University');

INSERT INTO Transactions(transaction_id, description, transaction_date) VALUES
    (1, 'Enrollment Fee', '2023-02-15'),
    (2, 'Professor Payment', '2023-02-15');

-- Corrected Table 8 insertions: Added `transaction_id` to match the table structure
INSERT INTO TransactionDetails(transaction_id, user_id, amount) VALUES
    (1, 4, 1000), -- University receives tuition fee
    (2, 3, 500); -- Professor receives payment
    
    
    -- Select All Tables
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Grades;
SELECT * FROM Users;
SELECT * FROM UserRoles;
SELECT * FROM Transactions;
SELECT * FROM TransactionDetails;

-- Additional Queries
-- Retrieve Enrollments for a Specific Student
SELECT Students.first_name, Students.last_name, Courses.course_name, Enrollments.enrollment_date, Grades.grade
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
JOIN Grades ON Enrollments.enrollment_id = Grades.enrollment_id;

-- Retrieve Courses with Available Credits
SELECT * FROM Courses WHERE credits > 0;

DELIMITER $$

CREATE PROCEDURE EnrollStudentPro(
    IN student_id_param INT,
    IN course_id_param INT
)
BEGIN
    -- Declare a variable to store the credits
    DECLARE available_credits INT;

    -- Start Transaction
    START TRANSACTION;

    -- Step 1: Check Course Availability
    SELECT credits INTO available_credits
    FROM Courses
    WHERE course_id = course_id_param;

    -- Check if there are enough credits (assuming here, adjust as necessary)
    IF available_credits > 0 THEN
        -- Step 2: Enroll Student in Course
        INSERT INTO Enrollments(student_id, course_id, enrollment_date) 
        VALUES (student_id_param, course_id_param, NOW());

        -- Step 3: Update Credits in Courses
        UPDATE Courses
        SET credits = credits - 3
        WHERE course_id = course_id_param;

        -- Assuming transaction_id is auto-increment, thus no need to specify it in INSERT statement
        -- Step 4: Debit Student (if applicable)
        -- Note: This step may need to be adjusted based on the actual schema and logic for handling transactions

        -- Step 5: Credit Professor (if applicable)
        -- This step assumes there's a mechanism to determine the correct professor and transaction_id

        -- Step 6: Credit University (tuition fees)
        -- Similar to above, ensure the logic matches your schema and requirements

        -- Commit Transaction
        COMMIT;
    ELSE
        -- If not enough credits, rollback the transaction
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

CALL EnrollStudentPro(1, 101);

SELECT * FROM Enrollments;
SELECT * FROM TransactionDetails;




