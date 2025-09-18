# 🌳 Parks and Recreation SQL Analysis  

This SQL project explores a fictional **Parks and Recreation employee dataset**. Using structured queries, I analyzed demographics, salaries, and departmental distribution to extract meaningful business insights.  

---

## 📁 Dataset Overview  

The database contains three main tables:  

- **employee_demographics**: employee_id, first_name, last_name, gender, age  
- **employee_salary**: employee_id, job_title, salary, dept_id  
- **parks_departments**: department_id, department_name  

---

## 🎯 Objectives  

The main goals of this project were to:  
- Strengthen SQL querying skills  
- Analyze HR-style data (demographics, salaries, departments)  
- Answer business-style questions useful for workforce planning  

---

## 🔍 Key Questions Answered  

###  1. How many employees are there in total?
```sql
SELECT COUNT(employee_id) AS total_employees
FROM employee_salary;
```

**Answer:**

<img width="95" height="34" alt="Screenshot 2025-09-18 110056" src="https://github.com/user-attachments/assets/8cb326da-2736-4ba0-b8e6-b3188d2ca7e0" />

Total number of employees is 12.

***

### 2. How many employees work in each department?
```sql
SELECT pd.department_name, COUNT(s.employee_id) AS employee_count
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name;
```

**Answer:**

<img width="212" height="85" alt="Screenshot 2025-09-18 110331" src="https://github.com/user-attachments/assets/7c6552b1-f961-4523-aedf-14e1300411d0" />

- **Parks and Recreation** have 7 employees.
- **Healthcare** has 1 employee.
- **Public Works** have 2 employees.
- **Finance** has 1 employees.

***

### 3. What is the average age of employees overall and by department?
```sql
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
```

**Answer:**

<img width="94" height="36" alt="Screenshot 2025-09-18 110841" src="https://github.com/user-attachments/assets/c86d66fc-8180-49dc-8674-c4474e6ce8bf" />

The overall average of employees is 40 years old.

<img width="174" height="85" alt="Screenshot 2025-09-18 110947" src="https://github.com/user-attachments/assets/70d14b2a-8162-478a-976a-84f5301954e8" />

The average age by department:
- **Healthcare** is 35 years old.
- **Finance** is 38 years old.
- **Public Works** is 41 years old.
- **Parks and Recreation** is 42 years old.

***

### 4. Which department has the youngest and oldest average workforce?
```sql
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
```

**Answer:**

<img width="160" height="33" alt="Screenshot 2025-09-18 111535" src="https://github.com/user-attachments/assets/9bef8d86-ffbc-4614-9733-becb26e10714" />

The youngest average workforce belongs to the **healthcare** department which has an average age of 35 years old.

<img width="174" height="35" alt="Screenshot 2025-09-18 111734" src="https://github.com/user-attachments/assets/98e474c8-89fd-443c-a5da-4919c209fbc3" />

The oldest average workforce belongs to the **parks and recreation** department which has an average age of 42 years old.

***

### 5. What is the average, minimum, and maximum salary per department?
```sql
SELECT pd.department_name, AVG(s.salary) AS avg_salary, MIN(s.salary) AS min_salary, MAX(s.salary) AS max_salary
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY avg_salary, min_salary, max_salary;
```

**Answer:**

<img width="330" height="87" alt="Screenshot 2025-09-18 112129" src="https://github.com/user-attachments/assets/b68c8cef-53d6-4395-8b3f-24c6e70c738c" />

***

### 6. Which department has the highest total payroll cost?
```sql
SELECT pd.department_name, SUM(s.salary) AS total_payroll
FROM employee_salary s
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name
ORDER BY total_payroll
LIMIT 1;
```

**Answer:**

<img width="182" height="37" alt="Screenshot 2025-09-18 112326" src="https://github.com/user-attachments/assets/514db572-bf49-4d93-9552-6ade6cb93b9f" />

The **healthcare** department has the highest total payroll cost.

***

### 7. Which 3 employees have the highest salaries across the organization?
```sql
SELECT d.first_name, d.last_name, s.salary
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
ORDER BY s.salary DESC
LIMIT 3;
```

**Answer:**

<img width="177" height="68" alt="Screenshot 2025-09-18 112624" src="https://github.com/user-attachments/assets/a7e02623-784c-4274-9f8f-d92c796ed8c5" />

3 employees that have the highest salaries across the organization:
- Chris Traeger
- Leslie Knope
- Ben Wyatt

***

### 8. Which employees earn above their department’s average salary?
```sql
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
```

**Answer:**

<img width="313" height="85" alt="Screenshot 2025-09-18 114010" src="https://github.com/user-attachments/assets/9232d5a0-5f67-4279-9dcb-33664053f86d" />

Employees that earn above their department’s average salary:
- **Parks and Recreation**: Leslie Knope, Donna Meagle, Craig Middlebrooks
- **Public Works**: Chris Traeger

***

### 9. Is there a gender pay gap within each department (Male vs Female average salary)?
```sql
SELECT pd.department_name, d.gender, AVG(s.salary) AS avg_salary
FROM employee_demographics d
JOIN employee_salary s 
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY pd.department_name, d.gender
ORDER BY pd.department_name, avg_salary DESC;
```

**Answer:**

<img width="238" height="103" alt="Screenshot 2025-09-18 211710" src="https://github.com/user-attachments/assets/8a5c57e4-d97a-419b-9a48-1bf018659ba6" />

Most departments in this dataset have employees of only one gender, so no gender pay comparison can be made there.
In the **Parks & Recreation** department, however, both genders are present. On average, males earned $55,000, while females earned $53,333.33, suggesting a pay gap of about $1666.67 in favor of males.

***

### 10. Rank employees by salary within their department.
```sql
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
```

**Answer:**

<img width="389" height="188" alt="Screenshot 2025-09-18 212407" src="https://github.com/user-attachments/assets/de2031b1-7028-4d34-8bb8-814d4368adea" />

***

### 11. Find the top 3 youngest high earners (under 40 with salary > 60k).
```sql
SELECT d.first_name, d.last_name, d.age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
WHERE d.age <= 40 AND s.salary > 60000
ORDER BY d.age DESC
LIMIT 3;
```

**Answer:**

<img width="187" height="52" alt="Screenshot 2025-09-18 212618" src="https://github.com/user-attachments/assets/fdb3e314-4ec5-44f5-adec-4d7422b4958b" />

There is only 2 youngest high earners, which are Ben Wyatt and Craig Middlebrooks

***

### 12.  Identify employees who are at or near retirement age (60+).
```sql
SELECT d.first_name, d.last_name, d.age
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
WHERE d.age >= 60 
ORDER BY d.age DESC;
```

**Answer:**

<img width="173" height="34" alt="Screenshot 2025-09-18 212903" src="https://github.com/user-attachments/assets/04a9e305-2be8-4484-8148-74b324fd0285" />

**Jerry Gergich** is the employee who is at or near retirement age (60+).

***

### 13. Which employees exist in employee_salary but not in employee_demographics?
```sql
SELECT s.first_name, s.last_name, s.dept_id
FROM employee_salary s
LEFT JOIN employee_demographics d
ON s.employee_id = d.employee_id
WHERE d.employee_id IS NULL;
```

**Answer:**

<img width="183" height="34" alt="Screenshot 2025-09-18 213352" src="https://github.com/user-attachments/assets/8ac26840-dbd2-461d-9a77-8bcb8fc9cf03" />

**Ron Swanson** is the employee that exist in employee_salary but not in employee_demographics.

***

### 14. Which employees have a NULL dept_id?
```sql
SELECT first_name, last_name, dept_id
FROM employee_salary
WHERE dept_id IS NULL;
```

**Answer:**

<img width="184" height="39" alt="Screenshot 2025-09-18 213532" src="https://github.com/user-attachments/assets/c06a2041-efe7-4ac4-9373-09df309fd64d" />

Andy Dwyer is the one have a NULL dept_id.

### 15. What is the gender distribution across departments?
```sql
SELECT d.gender, pd.department_name, COUNT(d.employee_id) AS employee_count
FROM employee_demographics d
JOIN employee_salary s
  ON d.employee_id = s.employee_id
JOIN parks_departments pd
  ON s.dept_id = pd.department_id
GROUP BY d.gender, pd.department_name
ORDER BY d.gender, pd.department_name;
```

**Answer:**

<img width="263" height="102" alt="Screenshot 2025-09-18 213831" src="https://github.com/user-attachments/assets/13cd184a-fdbd-4e5f-acb8-8c69f4326887" />




















