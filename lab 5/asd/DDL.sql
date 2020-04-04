-- Creating and using required database
CREATE DATABASE IF NOT EXISTS `Course processing System`;
USE `Course processing System`;

-- Creating Department table with pk dept_id, no fk
CREATE TABLE IF NOT EXISTS Department(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

-- Creating Professor table with pk prof_id, fk dept_id from department
CREATE TABLE IF NOT EXISTS Professor(
    prof_id INT PRIMARY KEY,
    prof_name VARCHAR(40) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Creating Students table with pk student_id, no fk
CREATE TABLE IF NOT EXISTS student(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(40) NOT NULL,
    major VARCHAR(40) NOT NULL,
    level VARCHAR(2) NOT NULL,
    age INT NOT NULL
);

-- Creating Course table with pk course_code, no fk
CREATE TABLE IF NOT EXISTS course(
    course_code VARCHAR(5) PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

-- Creating Semester_course with composite pk (course_code,quarter,year), fk course_code from course, prof_id from professor
CREATE TABLE IF NOT EXISTS semester_course(
    course_code VARCHAR(5) NOT NULL,
    quarter VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    prof_id INT NOT NULL,
    PRIMARY KEY (course_code,quarter,year),
    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id),
    FOREIGN KEY (course_code) REFERENCES course(course_code)
);

-- Creating Enrolled table with composite pk (student_id,course_code,quarter,year), fk student_id from student, composite fk (course_code,quarter,year) from 
-- (course_code,quarter,year) of semester_course
CREATE TABLE IF NOT EXISTS enrolled(
    student_id INT NOT NULL,
    course_code VARCHAR(5) NOT NULL,
    quarter VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    enrolled_at DATE NOT NULL,
    PRIMARY KEY (student_id,course_code,quarter,year),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_code,quarter,year) REFERENCES semester_course(course_code,quarter,year)
);


