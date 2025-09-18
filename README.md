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



















