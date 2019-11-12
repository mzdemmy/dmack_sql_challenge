-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW v_emplsal AS
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e
LEFT JOIN salaries s
ON e.emp_no = s.emp_no;

--view employee record with salary
select * from v_emplsal;

-- 2. List employees who were hired in 1986.
CREATE VIEW v_empl86 AS
select emp_no, last_name, first_name, hire_date
from employees 
where DATE_PART('year', hire_date) = 1986
;
--view list of employees hired in 1986
select * from v_empl86; 

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW v_deptmgr AS
select dm.dept_no, d.dept_name, dm.emp_no as mgr_emp_no
       ,e.last_name as mgr_lname, e.first_name as mgr_fname
	   ,dm.from_date as start_dt, dm.to_date as end_dt
from dept_manager dm
left join departments d ON d.dept_no = dm.dept_no
inner join employees e on e.emp_no = dm.emp_no
;
--view dept manager records	   
select * from v_deptmgr;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW v_empdept AS
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
inner join
(select emp_no, dept_no, max(to_date) 
	from dept_emp 
	group by emp_no, dept_no) as de on de.emp_no = e.emp_no
	left join departments d on d.dept_no = de.dept_no
;
--view lastest empl dept information	   
select * from v_empdept;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
CREATE VIEW v_herculesb AS
select *
from employees 
where first_name = 'Hercules'
and last_name like 'B%'
;
--view employee record with salary
select * from v_herculesb;


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW v_salesdept AS
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
inner join
(select emp_no, dept_no, max(to_date) 
	from dept_emp 
	group by emp_no, dept_no) as de on de.emp_no = e.emp_no
	inner join 
		(select dept_no, dept_name 
		from departments
		where dept_name = 'Sales') as d on d.dept_no = de.dept_no
;
--view latest Sales dept employees
select * from v_salesdept;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW v_sales_dev AS
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
inner join
(select emp_no, dept_no, max(to_date) 
	from dept_emp 
	group by emp_no, dept_no) as de on de.emp_no = e.emp_no
	inner join 
		(select dept_no, dept_name 
		from departments
		where dept_name in ('Sales', 'Development')) as d on d.dept_no = de.dept_no
;
--view latest Sales and Development dept employees
select * from v_sales_dev;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE VIEW v_lname_cnt AS
select last_name as empl_lname, count(last_name) as dup_lname_cnt
from employees 
group by last_name
order by dup_lname_cnt desc
;
--view emp last names in descending order by count  
select * from v_lname_cnt;