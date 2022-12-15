CREATE TABLE departments (
	dept_no VARCHAR(5) NOT NULL PRIMARY KEY
	, dept_name VARCHAR(30) NOT NULL
	);
	
CREATE TABLE titles (
	title_id VARCHAR(10) NOT NULL PRIMARY KEY
	, title VARCHAR(20) NOT NULL
	);
	
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY
	, emp_title_id VARCHAR(10) NOT NULL
	, FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
	, birth_date DATE NOT NULL
	, first_name VARCHAR(30) NOT NULL
	, last_name VARCHAR(30) NOT NULL
	, sex VARCHAR(2) NOT NULL
	, hire_date DATE NOT NULL
	);
	
CREATE TABLE dept_emp (
	emp_no INT NOT NULL
	, FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	, dept_no VARCHAR(5) NOT NULL
	, FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	);
	
CREATE TABLE dept_manager (
	dept_no VARCHAR(5) NOT NULL
	, FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	, emp_no INT NOT NULL
	, FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	);
	
CREATE TABLE salaries (
	emp_no INT NOT NULL
	, FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	, salary INT NOT NULL
	);
	
CREATE VIEW no_1 AS

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries ON
employees.emp_no = salaries.emp_no
;

CREATE VIEW no_2 AS

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date>='1986-01-01' AND hire_date<'1987-01-01'

;

CREATE VIEW no_3 AS

SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON
dept_manager.dept_no = departments.dept_no
JOIN employees ON
dept_manager.emp_no = employees.emp_no
;

CREATE VIEW no_4 AS

SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON
dept_emp.emp_no = employees.emp_no
JOIN departments ON
dept_emp.dept_no = departments.dept_no
;

CREATE VIEW no_5 AS

SELECT first_name, last_name, sex
FROM employees
WHERE last_name LIKE 'B%' AND first_name = 'Hercules'
;

CREATE VIEW no_6 AS

SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees ON 
dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007'
;

CREATE VIEW no_7 AS

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON 
dept_emp.emp_no = employees.emp_no
JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE dept_emp.dept_no IN
	(
		SELECT departments.dept_no
		FROM departments
		WHERE departments.dept_name IN ('Sales', 'Development')
	)
;

CREATE VIEW no_8 AS

SELECT last_name, count(*) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY last_name_count desc
;

