# HR_Data_Analysis_using_SQL

/* Checking if the data has been succesfully uploaded or not */
SELECT * FROM hrdb.hrdata;

DESCRIBE hrdb.hrdata;

/* Checking the total number of employees */
SELECT COUNT(Employee_ID) AS Total_employees FROM hrdb.hrdata;

/* Listing the different departments available */
SELECT DISTINCT(Department) FROM hrdb.hrdata;

/* Checking the total number of male and femaile employees */
SELECT Gender,COUNT(Employee_ID) AS NumberofEmployees FROM hrdb.hrdata group by Gender;

/* Checking the maximun and minimum age among all the employees */
SELECT MAX(Age) FROM hrdb.hrdata; 
SELECT MIN(Age) FROM hrdb.hrdata; 
SELECT MAX(Age), MIN(Age) FROM hrdb.hrdata; 

/* Counting the number of employees per region */
SELECT Region,COUNT(Employee_ID) FROM hrdb.hrdata group by Region ORDER BY COUNT(Employee_ID) DESC;

/* Checking the level of education completed by different employees */
SELECT Education,COUNT(Employee_ID) AS COUNT FROM hrdb.hrdata group by Education ORDER BY COUNT(Employee_ID) DESC;

/* Deleting the rows having the null value in Education column */ 
DELETE FROM hrdb.hrdata WHERE Education='';

/* Checking the number of employees that completed different level of education */
SELECT Education,COUNT(Employee_ID) AS COUNT FROM hrdb.hrdata group by Education ORDER BY COUNT(Employee_ID) DESC;

/* Checking the number of employees per each department */
SELECT Department,COUNT(Employee_ID) FROM hrdb.hrdata GROUP BY Department ORDER BY COUNT(Employee_ID) desc;

/* Checking the employees with the longest length of service */
SELECT * FROM hrdb.hrdata WHERE Length_of_service= (SELECT MAX(Length_of_service) FROM hrdb.hrdata);

ALTER TABLE hrdb.hrdata modify COLUMN Awards_won char(20);
UPDATE hrdb.hrdata SET Awards_won='NO' WHERE Awards_won=0; 
UPDATE hrdb.hrdata SET Awards_won='YES' WHERE Awards_won=1;

/* Checking how many won an award */
SELECT Awards_won, count(Employee_ID) FROM hrdb.hrdata group by Awards_won;

/* Listing all the employees who have won awards */
SELECT * FROM hrdb.hrdata WHERE Awards_won=(SELECT MAX(Awards_won) FROM hrdb.hrdata) ORDER BY Length_of_service DESC;

/* Replacing the empty values in Previous_year_rating with 0 */
UPDATE hrdb.hrdata SET Previous_year_rating=1 WHERE Previous_year_rating=0;

/* Checking the number of emolyees per rating */
SELECT Previous_year_rating,COUNT(Employee_ID) AS Number_of_Employees FROM hrdb.hrdata GROUP BY Previous_year_rating ORDER BY Previous_year_rating DESC;

/*Checking for the top scorers */
SELECT * FROM hrdb.hrdata WHERE Avg_training_score=(SELECT MAX(Avg_training_score) FROM hrdb.hrdata) ORDER BY Previous_year_rating DESC,no_of_trainings DESC;

/* Checking which department has the highest number of highly ranked employees */
SELECT Department, COUNT(Employee_ID) AS Number_of_employees FROM hrdb.hrdata WHERE Previous_year_rating=5 group by Department ORDER BY COUNT(Employee_ID) DESC;

/* Creating a criteria for age and printing the numbero employees under each criteria*/
SELECT COUNT(Employee_ID) AS Number_of_Employees,
CASE
WHEN Age>=20 AND Age<30 THEN '20-30'
WHEN Age>=30 AND Age<40 THEN '30-40'
WHEN Age>=40 AND Age<50 THEN '40-50'
WHEN Age>=50 AND Age<60 THEN '50-60'
WHEN Age>=60 THEN '60 Above'
END AS Age_Criteria
from hrdb.hrdata GROUP BY Age_Criteria;

SELECT Age from hrdb.hrdata WHERE Age='' ;
