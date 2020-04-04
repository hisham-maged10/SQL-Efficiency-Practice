--  1. Find the names of students with level “SR” who are enrolled in a class taught by professor whose id=“1”.
-- joining student, enrolled, semester_course and limiting students to be sr level and limiting semester course to prof id of 1
SELECT DISTINCT s.student_name 
FROM student s, enrolled e, semester_course sc
WHERE e.course_code = sc.course_code
AND	  e.quarter = sc.quarter
AND	  e.year = sc.year 
AND   e.student_id = s.student_id
AND   s.level = 'SR'
AND   sc.prof_id = 1;

-- 2. Find the age of the oldest student who is either a “History” major or enrolled in a course taught by “Michael Miller”.
-- joining student, enrolled, semester_course, Professor tables and limiting students to be taught by michael miller or student major is history
SELECT MAX(s.age)
FROM student s, enrolled e, semester_course sc, Professor p
WHERE e.course_code = sc.course_code
AND	  e.quarter = sc.quarter
AND	  e.year = sc.year 
AND   e.student_id = s.student_id
AND	  sc.prof_id = p.prof_id
AND   (s.major = 'History' or p.prof_name = 'Michael Miller');

-- 3. Find the names of all students and their courses' name even if they weren’t enrolled in any course.
-- student left join with (inline view of join of enrolled and course)
SELECT student_name, name as Course_Name
FROM student s 
LEFT JOIN (SELECT e.student_id, c.name FROM enrolled e, course c WHERE e.course_code = c.course_code) ec 
ON s.student_id = ec.student_id;

-- 4. Find the names of professors whose combined enrollment of all courses that they
-- taught is less than five.
-- joining professor with (inline view of join of enrolled, semester course counting columns grouped by prof_id)
-- Limiting Combined_Enrollment to be less than 5 
SELECT prof_name, Combined_Enrollment
FROM Professor p, (SELECT sc.prof_id,count(*) AS Combined_Enrollment
				   FROM   enrolled e, semester_course sc
				   WHERE  e.course_code = sc.course_code
				   AND	  e.quarter = sc.quarter
				   AND	  e.year = sc.year
				   GROUP BY(sc.prof_id)
				   HAVING Combined_Enrollment < 5) ce
WHERE p.prof_id = ce.prof_id;

-- 5. Find students' names enrolled in all courses that professor with id="2" has taught.
-- joining student, enrolled, semester_course and limiting students to be taught by prof_id = 2 by limiting semester course to prof id of 1
SELECT s.student_name 
FROM student s, enrolled e, semester_course sc
WHERE e.course_code = sc.course_code
AND	  e.quarter = sc.quarter
AND	  e.year = sc.year 
AND   e.student_id = s.student_id
AND   sc.prof_id = 2;

-- 6. Find all courses that haven't been taught before, as well as courses taught by
-- professors who work in department “Computer Science”.
-- left joining course with semester course and limiting course code to be null to get Courses that hadn't been taught
-- union Courses that had been taught by professors who are in computer science 
-- by joining professor table with department table limiting to computer science department 
-- and using result as operand of in operator in where clause of courses, semester courses join
SELECT c.course_code, name AS course_name
FROM course c LEFT JOIN semester_course sc ON c.course_code = sc.course_code
WHERE sc.course_code IS NULL
UNION
SELECT c.course_code, name
FROM course c, semester_course sc
WHERE c.course_code = sc.course_code
AND prof_id IN (SELECT prof_id
				FROM Professor p, Department d
				WHERE p.dept_id = d.dept_id
				AND d.dept_name = 'Computer Science');

-- 7. Find names of all students whose names start with M and age < 20 and all
-- professors whose names starts with M and teaches more than 2 courses ( note: 2
-- courses with same code but different years/semester are counted twice)
-- Limiting students to names that starts with M and has age < 20
-- union with Professors that taught more than two courses and starts with M
-- by joining professor table with inline view of ( prof_id with no, of courses taught  from semester_course having more than 2 courses)
-- on prof_id and limiting that output to professors whose name starts with M
SELECT student_name AS Names
FROM student 
WHERE student_name LIKE 'M%'
AND age < 20
UNION
SELECT prof_name
FROM Professor p, (SELECT prof_id, COUNT(*) count_courses_taught
				   FROM semester_course
				   GROUP BY (prof_id)
				   HAVING count_courses_taught > 2) more_than_two_courses
WHERE p.prof_id = more_than_two_courses.prof_id
AND p.prof_name LIKE 'M%';

-- 8. Find the names and ids of the professors that have enrolled in less than 2 courses
-- and whose department is either 1,2,3,4
-- joining professor with an (inline view of semester_course that is of semester course 
-- that is limited to professors who taught less than two courses) then the result
-- of that join is limited to professors in departments 1,2,3,4 only
SELECT p.prof_name, p.prof_id
FROM Professor p, (SELECT prof_id, COUNT(*) count_courses_taught
				   FROM semester_course
				   GROUP BY (prof_id)
				   HAVING count_courses_taught < 2) less_than_two_courses
WHERE p.prof_id = less_than_two_courses.prof_id
AND p.dept_id IN (1,2,3,4);

-- 9. Find all students with their professor according to their enrollment in the
-- professors’ courses, including the professor who doesn't teach any class or have no
-- students enrolling in their courses and the student who haven't been enrolled in a
-- class yet
SELECT student_name,prof_name
FROM (SELECT student_id,prof_id
FROM enrolled e LEFT JOIN semester_course sc ON e.course_code = sc.course_code
and e.quarter = sc.quarter
and e.`year` = sc.`year`) sce RIGHT JOIN student s ON (s.student_id = sce.student_id)
LEFT JOIN Professor p ON (p.prof_id = sce.prof_id)
UNION 
SELECT student_name, prof_name 
FROM (SELECT student_id,prof_id
FROM enrolled e LEFT JOIN semester_course sc ON e.course_code = sc.course_code
and e.quarter = sc.quarter
and e.`year` = sc.`year`) sce RIGHT JOIN Professor p ON (p.prof_id = sce.prof_id)
LEFT JOIN student s ON (s.student_id = sce.student_id)

-- 10.Find course name, course code and professor name and id for courses that the
-- same professor taught twice or more.
SELECT name AS Course_Name, c.course_code, prof_name, p.prof_id
FROM Professor p, (SELECT prof_id, course_code, COUNT(*) count_courses_taught
				   FROM semester_course
				   GROUP BY prof_id,course_code
				   HAVING count_courses_taught >= 2) AS same_course_twice, course c
WHERE c.course_code = same_course_twice.course_code
AND p.prof_id = same_course_twice.prof_id;

-- 11. Find names of all departments whose professors collectively teach less that 3
-- courses
SELECT d.dept_name
FROM Professor p
LEFT JOIN semester_course sc
USING(prof_id)
RIGHT JOIN Department d
USING(dept_id)
GROUP BY d.dept_id
HAVING COUNT(*) < 3;

