-- 1. How many employees are there in total?
SELECT COUNT(employee_id) AS total_employees
FROM employee_salary;

-- 2. How many employees work in each department?
SELECT pd.department_name, COUNT(s.employee_id) AS employee_count
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name;

-- 3. What is the average age of employees overall and by department?

-- Overall average
SELECT AVG(age) AS overall_avg_age
FROM employee_demographics;

-- By department
SELECT pd.department_name, AVG(d.age) AS avg_age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY avg_age;

-- 4. Which department has the youngest and oldest average workforce?

-- Youngest average workforce
SELECT pd.department_name, AVG(d.age) AS avg_age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY avg_age ASC
LIMIT 1;

-- Oldest average workforce
SELECT pd.department_name, AVG(d.age) AS avg_age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY avg_age DESC
LIMIT 1;

-- 5. What is the average, minimum, and maximum salary per department?
SELECT pd.department_name, AVG(s.salary) AS avg_salary, MIN(s.salary) AS min_salary, MAX(s.salary) AS max_salary
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY avg_salary, min_salary, max_salary;

-- 6. Which department has the highest total payroll cost?
SELECT pd.department_name, SUM(s.salary) AS total_payroll
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY total_payroll
LIMIT 1;

-- 7. Which 3 employees have the highest salaries across the organization?
SELECT d.first_name, d.last_name, s.salary
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
ORDER BY s.salary DESC
LIMIT 3;

-- 8. Which employees earn above their department’s average salary?
SELECT d.first_name, d.last_name, pd.department_name, s.salary
FROM employee_demographics d
JOIN employee_salary s 
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
WHERE s.salary > (
    SELECT AVG(s2.salary)
    FROM employee_salary s2
    WHERE s2.dept_id = s.dept_id
);

-- 9. Is there a gender pay gap within each department (Male vs Female average salary)?
SELECT pd.department_name, d.gender, AVG(s.salary) AS avg_salary
FROM employee_demographics d
JOIN employee_salary s 
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name, d.gender
ORDER BY pd.department_name, avg_salary DESC;

-- 10. Rank employees by salary within their department.
SELECT 
    d.first_name, 
    d.last_name, 
    pd.department_name, 
    s.salary,
    RANK() OVER (PARTITION BY pd.department_name ORDER BY s.salary DESC) AS salary_rank
FROM employee_demographics d
JOIN employee_salary s 
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
ORDER BY pd.department_name, salary_rank;


-- 11. Find the top 3 youngest high earners (under 40 with salary > 60k).
SELECT d.first_name, d.last_name, d.age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
WHERE d.age <= 40 AND s.salary > 60000
ORDER BY d.age DESC
LIMIT 3;

-- 12. Identify employees who are at or near retirement age (60+).
SELECT d.first_name, d.last_name, d.age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
WHERE d.age >= 60 
ORDER BY d.age DESC;

-- 13. Which employees exist in employee_salary but not in employee_demographics?
SELECT s.first_name, s.last_name, s.dept_id
FROM employee_salary s
LEFT JOIN employee_demographics d
ON s.employee_id = d.employee_id
WHERE d.employee_id IS NULL;

-- 14. Which employees have a NULL dept_id?
SELECT first_name, last_name, dept_id
FROM employee_salary
WHERE dept_id IS NULL;

-- 15. What is the gender distribution across departments?
SELECT d.gender, pd.department_name, COUNT(d.employee_id) AS employee_count
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY d.gender, pd.department_name
ORDER BY d.gender, pd.department_name;










