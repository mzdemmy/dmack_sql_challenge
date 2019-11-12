-- create and load 6 tables related to sql challenge

--drop table dept_manager;
--drop table dept_emp;
--drop table departments;
--drop table employees;
--drop table salaries;
--drop table titles;

--TABLE #1
CREATE TABLE employees(
  emp_no serial primary key,
  birth_date date,
  first_name varchar not null,
  last_name varchar not null,
  gender varchar, 
  hire_date date not null
);

--import records from employees_csv
--view table 
select * from employees

--TABLE #2
--drop table departments;
CREATE TABLE departments(
  dept_no varchar primary key,
  dept_name VARCHAR NOT NULL
);
--import records from departments.csv
--view table
select * from departments;

--TABLE #3
--drop table dept_manager;
CREATE TABLE dept_manager(
  	dept_no varchar not null,
  	emp_no int not null, 
  	from_date date not null,
  	to_date date not null,
 	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
 	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

--import records from dept_manager.csv
--view table
select * from dept_manager;

--TABLE #4
--drop table dept_emp;
CREATE TABLE dept_emp(
  	emp_no int not null, 
  	dept_no varchar not null,
  	from_date date not null, 
  	to_date date not null, 
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

--import records from dept_emp.csv
--view table
select * from dept_emp;


--TABLE #5
--drop table salaries;
CREATE TABLE salaries(
  	emp_no int not null, 
	salary int not null,
  	from_date date not null, 
  	to_date date not null, 
  	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, from_date)
);
select * from salaries;

--TABLE #6
--drop table titles;
CREATE TABLE titles(
  	emp_no int not null, 
  	title varchar not null,
  	from_date date not null, 
  	to_date date not null, 
  	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);
select * from titles;


