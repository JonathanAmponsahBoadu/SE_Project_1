-- --Create Database
-- CREATE DATABASE comp_eng_dept;

-- --Create Students Table
-- CREATE TABLE students (
--     student_id CHAR(8) PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     email VARCHAR(100),
--     personal_info TEXT
-- );

-- --Create Fees Payments Table
-- CREATE TABLE fees_payments (
--     payment_id SERIAL PRIMARY KEY,
--     student_id CHAR(8) REFERENCES students(student_id),
--     amount_paid NUMERIC(10, 2),
--     payment_date DATE
-- );

-- --Create Courses Table
-- CREATE TABLE courses (
--     course_id CHAR(7) PRIMARY KEY,
--     course_name VARCHAR(100)
-- );

-- --Create Enrollments Table
-- CREATE TABLE enrollments (
--     enrollment_id SERIAL PRIMARY KEY,
--     student_id CHAR(8) REFERENCES students(student_id),
--     course_id CHAR(7) REFERENCES courses(course_id),
--     enrollment_date DATE
-- );

-- --Create Lectures Table
-- CREATE TABLE lectures (
--     lecture_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     email VARCHAR(100),
--     title VARCHAR(100)
-- );

-- --Create Course Assignments Table
-- CREATE TABLE course_assignments (
--     assignment_id SERIAL PRIMARY KEY,
--     lecture_id INT REFERENCES lectures(lecture_id),
--     course_id CHAR(7) REFERENCES courses(course_id)
-- );

-- --Create TA Assignments Table
-- CREATE TABLE ta_assignments (
--     assignment_id SERIAL PRIMARY KEY,
--     lecture_id INT REFERENCES lectures(lecture_id),
--     student_id CHAR(8) REFERENCES students(student_id)
-- );

-- --Insert Sample Data

-- --Students
-- INSERT INTO students (student_id, first_name, last_name, email, personal_info) VALUES
-- ('11023456', 'John', 'Doe', 'jodoe123@st.ug.edu.gh', 'Personal info about John Doe'),
-- ('11023457', 'Jane', 'Smith', 'jasmith234@st.ug.edu.gh', 'Personal info about Jane Smith'),
-- ('11023458', 'Alice', 'Johnson', 'aljohnson345@st.ug.edu.gh', 'Personal info about Alice Johnson'),
-- ('11023459', 'Bob', 'Brown', 'bobrown456@st.ug.edu.gh', 'Personal info about Bob Brown'),
-- ('11023460', 'Charlie', 'Davis', 'chdavis567@st.ug.edu.gh', 'Personal info about Charlie Davis'),
-- ('10023461', 'David', 'Wilson', 'dawilson678@st.ug.edu.gh', 'Personal info about David Wilson'),
-- ('10023462', 'Eve', 'Miller', 'evmiller789@st.ug.edu.gh', 'Personal info about Eve Miller'),
-- ('10023463', 'Frank', 'Moore', 'frmoore890@st.ug.edu.gh', 'Personal info about Frank Moore'),
-- ('10023464', 'Grace', 'Taylor', 'grtaylor901@st.ug.edu.gh', 'Personal info about Grace Taylor'),
-- ('10023465', 'Hank', 'Anderson', 'handerson012@st.ug.edu.gh', 'Personal info about Hank Anderson');


-- -- Fees Payments
-- INSERT INTO fees_payments (student_id, amount_paid, payment_date) VALUES
-- ('11023456', 500.00, '2024-01-10'),
-- ('11023457', 600.00, '2024-01-15'),
-- ('11023458', 550.00, '2024-01-20'),
-- ('11023459', 700.00, '2024-01-25'),
-- ('11023460', 650.00, '2024-02-01'),
-- ('10023461', 400.00, '2024-02-05'),
-- ('10023462', 450.00, '2024-02-10'),
-- ('10023463', 300.00, '2024-02-15'),
-- ('10023464', 200.00, '2024-02-20'),
-- ('10023465', 350.00, '2024-02-25');

-- -- Courses
-- INSERT INTO courses (course_id, course_name) VALUES
-- ('CPEN201', 'Data Structures'),
-- ('CPEN202', 'Operating Systems'),
-- ('CPEN203', 'Database Systems'),
-- ('CPEN204', 'Networks'),
-- ('CPEN205', 'Software Engineering');

-- -- Enrollments
-- INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
-- ('11023456', 'CPEN201', '2024-03-01'),
-- ('11023457', 'CPEN202', '2024-03-02'),
-- ('11023458', 'CPEN203', '2024-03-03'),
-- ('11023459', 'CPEN204', '2024-03-04'),
-- ('11023460', 'CPEN205', '2024-03-05'),
-- ('10023461', 'CPEN201', '2024-03-06'),
-- ('10023462', 'CPEN202', '2024-03-07'),
-- ('10023463', 'CPEN203', '2024-03-08'),
-- ('10023464', 'CPEN204', '2024-03-09'),
-- ('10023465', 'CPEN205', '2024-03-10');

-- -- Lectures
-- INSERT INTO lectures (first_name, last_name, email, title) VALUES
-- ('Dr.', 'Smith', 'drsmith@ug.edu.gh', 'Professor'),
-- ('Dr.', 'Johnson', 'drjohnson@ug.edu.gh', 'Associate Professor'),
-- ('Dr.', 'Williams', 'drwilliams@ug.edu.gh', 'Assistant Professor');

-- -- Course Assignments
-- INSERT INTO course_assignments (lecture_id, course_id) VALUES
-- (1, 'CPEN201'),
-- (2, 'CPEN202'),
-- (3, 'CPEN203');

-- -- TA Assignments
-- INSERT INTO ta_assignments (lecture_id, student_id) VALUES
-- (1, '11023456'),
-- (2, '11023457'),
-- (3, '11023458');

-- -- Function to Calculate Outstanding Fees
-- CREATE OR REPLACE FUNCTION calculate_outstanding_fees()
-- RETURNS JSON AS $$
-- DECLARE
--     result JSON;
-- BEGIN
--     SELECT JSON_AGG(
--                JSON_BUILD_OBJECT(
--                    'student_id', s.student_id,
--                    'first_name', s.first_name,
--                    'last_name', s.last_name,
--                    'outstanding_fees', outstanding_fees.amount_due
--                )
--            )
--     INTO result
--     FROM students s
--     LEFT JOIN (
--         SELECT student_id, 1000.00 - COALESCE(SUM(amount_paid), 0) AS amount_due
--         FROM fees_payments
--         GROUP BY student_id
--     ) AS outstanding_fees ON s.student_id = outstanding_fees.student_id;

--     RETURN result;
-- END;
-- $$ LANGUAGE plpgsql;

-- --Test the Function
-- SELECT calculate_outstanding_fees();