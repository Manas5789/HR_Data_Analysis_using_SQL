--Using the HR database
USE HRDATA;

--Printing the Employees table
SELECT * FROM Employees;

--Printing the Jobs table
SELECT * FROM Jobs;

--Printong the department table
SELECT * FROM Departments;

--Printing the Dependents table
SELECT * FROM Dependents;

--Printing the Locations table
SELECT * FROM Locations;

--Printing the Countries table
SELECT * FROM Countries;

--Printing the Regions table
SELECT * FROM Regions;

-- Joining all the tables 
WITH total_data AS
(
 SELECT Employees.Employee_id, Employees.First_name,Employees.Last_name, Employees.Email, Employees.Phone_number, Employees.Job_id,Jobs.Job_title, Employees.Salary, Employees.Hire_date,Employees.Manager_id,Employees.Department_id,Departments.Department_name, Locations.Location_id,Locations.City,Locations.Postal_code, Countries.Country_id,Countries.Country_name,Regions.Region_id,Regions.Region_name
 FROM Employees
 JOIN Jobs ON Employees.Job_id=Jobs.Job_id
 JOIN Dependents ON Employees.Employee_id=Dependents.Employee_id 
 JOIN Departments ON Employees.Department_id=Departments.Department_id
 JOIN Locations ON Departments.Location_id=Locations.Location_id
 JOIN Countries ON Locations.Country_id=Countries.Country_id
 JOIN Regions ON Countries.Region_id=Regions.Region_id
)

--Printing all the data after combining all the tables
--SELECT * FROM total_data;

-- checking the number of employees under each maanger
--SELECT Manager_id, COUNT(Employee_id) AS Employees_under_manager, AVG(Salary) AS Average_salary FROM total_data GROUP BY Manager_id
  
--Providing ranking to countries based on the number of employees in it 
--SELECT Country_id, Country_name, City,COUNT(Employee_id) AS Country_Employee_count,RANK()OVER(ORDER BY COUNT(Employee_id) DESC) AS Country_rn FROM total_data GROUP BY Country_id, Country_name, City ;

--Ranking the department based on number of employees (Employye_count) and the average salary provided to employess in each department (Department_salary_ranking)
--SELECT Department_id, Department_name,COUNT(*) AS Employee_count, DENSE_RANK()OVER(ORDER BY COUNT(*) DESC)  AS Department_ranking, AVG(Salary) AS average_salary,DENSE_RANK()OVER(ORDER BY AVG(Salary) DESC) AS Depatment_salary_ranking FROM total_data 
--GROUP BY Department_id, Department_name ORDER BY Department_ranking;

--Employee_ranking_based_on_salary_in_each_department
--SELECT Employee_id,First_name, Last_name,Email,Phone_number,Department_name,Job_id,Job_title,Salary,DENSE_RANK()OVER(Partition by Department_name ORDER BY Salary DESC) AS Employee_ranking_based_on_salary_in_each_department FROM total_data
 
-- Checking the Employee salary and the maximum slary provided to an employee in the department
--SELECT Employee_id,First_name, Last_name,Email,Phone_number,Department_name,Job_id,Job_title,Salary,MAX(Salary)OVER( PARTITION BY Department_name ORDER BY Salary DESC) AS Max_Salary_in_Department FROM total_data

--Using CASE statement to show whether the salary of an employee is less than or more than the average salary
/*
SELECT Employee_id,First_name, Department_name, Salary, AVG(Salary)OVER() AS Average_salary, 
CASE
 WHEN Salary>AVG(salary)OVER() THEN 'More than the average salary'
 WHEN Salary<AVG(Salary)OVER() THEN 'Less than the average salary'
 ELSE 'Is equal to average salary'
END AS Salary_comparison
FROM total_data
GROUP BY  Employee_id,First_name, Department_name,Salary
*/

--Selecting all employees and their details whose first names start with 'J'
--SELECT* FROM total_data WHERE First_name LIKE 'J%'ORDER BY Employee_id

SELECT * FROM total_data