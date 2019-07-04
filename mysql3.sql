/*How many rows do we have in each table in the employees database?*/
SELECT 
    'employees'employees, 
     COUNT(*) 
FROM
    employees;

SELECT 
    'salaries'salaries, 
     COUNT(*) 
FROM
    salaries;

SELECT 
    'titles'titles, 
     COUNT(*) 
FROM
    titles;

SELECT 
    'dept_manager'dept_manager, 
     COUNT(*) 
FROM
    dept_manager;

SELECT 
    'dept_emp'dept_emp, 
     COUNT(*) 
FROM
    dept_emp;

SELECT 
    'departments'departments, 
     COUNT(*) 
FROM
    departments;


/*How many employees with the first name "Mark" do we have in our company?*/
SELECT COUNT(emp_no)
FROM employees WHERE first_name = "Mark";

/*How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?*/

SELECT  COUNT(emp_no)
FROM  employees
WHERE (first_name = "Eric") AND (last_name = "A%");

/* How many employees do we have that are working for us since 1985 and who are they?*/
SELECT  COUNT(emp_no)
FROM  employees
WHERE hire_date > "1985-01-01";

SELECT  first_name, last_name, hire_date
FROM  employees
WHERE hire_date > "1985-01-01";

/* How many employees got hired from 1990 until 1997 and who are they?*/
SELECT  COUNT(emp_no)
FROM  employees
WHERE (hire_date BETWEEN "1990-01-01" AND "1997-01-01");

SELECT  first_name, last_name, hire_date
FROM  employees
WHERE (hire_date BETWEEN "1990-01-01" AND "1997-01-01");

/*How many employees have salaries higher than EUR 70 000,00 and who are they? */
SELECT  COUNT(first_name)
FROM  employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE (salary > 70000);

SELECT  first_name, last_name, salary
FROM  employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE (salary > 70000);

/* How many employees do we have in the Research Department, who are working for us since 1992 and who are they?*/
SELECT COUNT(hire_date)
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE (hire_date > "1992-01-01") AND (dept_name = "Research");

SELECT first_name, last_name, dept_name, hire_date
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE (hire_date > "1992-01-01") AND (dept_name = "Research");

/* How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?*/
SELECT COUNT(first_name)
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
WHERE (hire_date > "1985-01-01") AND (dept_name = "Finance") AND (salary > 75000);

SELECT first_name, last_name
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
WHERE (hire_date > "1985-01-01") AND (dept_name = "Finance") AND (salary > 75000);

/*We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.*/
SELECT first_name, last_name, birth_date, gender, hire_date, title, salary
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN titles
ON titles.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no;

/* We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.*/
SELECT first_name, last_name, birth_date, gender, hire_date, title, dept_name, salary
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN titles
ON titles.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE (title = "Manager");

/* BONUS: Create a query which will join all tables and show all data from all tables.*/
SELECT * FROM employees
LEFT JOIN salaries on salaries.emp_no = employees.emp_no
UNION
SELECT * FROM employees
RIGHT JOIN salaries on salaries.emp_no = employees.emp_no
UNION
SELECT * FROM employees
LEFT JOIN dept_emp on dept_emp.emp_no = employees.emp_no
UNION
SELECT * FROM employees
RIGHT JOIN dept_emp on dept_emp.emp_no = employees.emp_no
UNION
SELECT * FROM employees
LEFT JOIN titles on titles.emp_no = employees.emp_no
UNION
SELECT * FROM employees
RIGHT JOIN titles on titles.emp_no = employees.emp_no
UNION
SELECT * FROM employees
LEFT JOIN dept_manager on dept_manager.emp_no =employees.emp_no
UNION
SELECT * FROM employees
RIGHT JOIN dept_manager on dept_manager.emp_no =employees.emp_no
UNION
SELECT * FROM employees
LEFT JOIN departments on dept_manager.dept_no = departments.dept_no
UNION
SELECT * FROM employees
RIGHT JOIN departments on dept_manager.dept_no = departments.dept_no;

/*Now you should create at least 5 queries on your own, try to use data from more than 2 tables.*/

/*Age of all Female employees*/
SELECT first_name, last_name, YEAR(CURDATE()) - YEAR(birth_date) AS age 
FROM employees
WHERE gender = "F";

/*employees, who has higher salary than average*/
SELECT first_name, last_name, salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salary > (
    SELECT AVG(salary)
    FROM salaries
);