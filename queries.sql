--Grouping Employees by position
SELECT 		Fname, Lname, AVG(Salary)
FROM 		EMPLOYEES
GROUP BY 	Position;

--Nested Query with ALL
SELECT 	Fname, Lname
FROM 	EMPLOYEES
WHERE 	Salary > ALL(SELECT Salary
    				 FROM	EMPLOYEES
 		    		 WHERE	EMP_ID=42916038);

--GROUP BY and HAVING Query
SELECT 	Emp_ID, COUNT(*)
FROM    CASES AS C, HANDLES AS H
WHERE	C.Case_ID = H.Case_ID
GROUP 	BY	Emp_ID
HAVING	COUNT(*) > 1;

--Nested Query with IN
SELECT	Dept_ID, Available_Rooms, Location
FROM    DEPARTMENTS
WHERE	Dept_ID IN (SELECT	Dept_ID
                    FROM	HOSPITAL_RESOURCES
                    WHERE	Available_Rooms > Supply_Count AND Supply_Name = "Stretcher");

--Update
UPDATE PATIENTS
SET    Insurance = 'medicare'
WHERE  Patient_ID = 45100;

--Delete
DELETE FROM HANDLES
WHERE    	Emp_ID = 42916308;
