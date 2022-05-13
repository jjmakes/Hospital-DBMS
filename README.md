# Hospital DBMS
This project is an example DBMS created for a fictitous hospital for the use of the facility's management to handle staff, patients and resources.

## Table of Contents

## Summary of System Requirements
### Departments & Resources
The hospital consists of several distinct departments of which different types of employees are assigned to. Each department is supported by a budget and set of hospital resources which are assigned to patients on a case by case basis. The budget determines the number of employees and amount of hospital resources available. Each department is of its own type and contains data including location, available rooms, list and number of employees, list and number of patients. They keep track of their available resources (medical equipment, patient room necessities, office supplies, pharmaceuticals, etc.). A budget is also designated, which determines the resources and staff available.

### Employees & Scheduling
Each employee is designated a schedule and assigned a number of patients and cases within that department. Employees consist of all hospital staff including: doctors, nurses, receptionists, technicians, pharmacists, sanitary workers, food staff, medical assistants, interns, and the management team. The database would keep a record of each employee along with their personal information such as: name, address, salary, employee ID, etc. The employees are assigned to work on a schedule which specifies what shift each employee works. The database will keep track of the shift date, start and end times of each employee.

### Patients
The database holds a record of each patient’s case. Doctors and nurses are assigned to handle a particular case determined by their specialization. The case includes information such as the patient name and ID, room number, doctor/nurse name, hospital resources needed/used, prescriptions, actions taken by personnel, and who the patient was admitted by. Patient documentation is archived with necessary information (name, date of birth, insurance, medical history, current case, prior cases, admittance date and discharge date). Depending on their condition, a patient will be housed under a specific department.

## Entity-Relationship Diagram
![entity-relationship diagram](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/entity_diagram.png)
## Relational Logical Database Design
![relational logic database design](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/relational-design.png)
## Tables & Sample Records
See `tables.sql` for table creation statements and `sample-data.sql` for insert statements.
### Departments
![departments](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/departments.png)
### Employees
![employees](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/employees.png)
### Schedules
![schedules](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/schedules.png)
### Resources
![resources](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/resources.png)
### Patients
![patients](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/patients.png)
### Cases
![cases](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/cases.png)

### Handles
![handles](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/handles.png)
### Housed Under
![housed_under](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/housed_under.png)


## Queries, Updates & Deletes
Selecting employee names and salary and grouping by position.
```
SELECT 		Fname, Lname, AVG(Salary)
FROM 		EMPLOYEES
GROUP BY 	Position;
```
![group_by](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/group_by.png)

Selecting the first and last names of employees of which have a salary greater than that owned by Employee ID 42916038.
```
SELECT 	Fname, Lname
FROM 	EMPLOYEES
WHERE 	Salary > ALL(SELECT Salary
    				 FROM	EMPLOYEES
 		    		 WHERE	EMP_ID=42916038);
```
![owned_patient](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/owned_patient.png)

Select employees that are handling more than 1 case.
```
SELECT 	Emp_ID, COUNT(*)
FROM    CASES AS C, HANDLES AS H
WHERE	C.Case_ID = H.Case_ID
GROUP 	BY	Emp_ID
HAVING	COUNT(*) > 1;
```
![handles_case](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/handles_case.png)

Select departments where number of rooms exceeds the amount of stretchers assigned to the department.
```
SELECT	Dept_ID, Available_Rooms, Location
FROM    DEPARTMENTS
WHERE	Dept_ID IN (SELECT	Dept_ID
                    FROM	HOSPITAL_RESOURCES
                    WHERE	Available_Rooms > Supply_Count AND Supply_Name = "Stretcher");
```
![exceeds](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/exceeds.png)

Update a patients insurance to "Medicare".
```
UPDATE PATIENTS
SET    Insurance = 'medicare'
WHERE  Patient_ID = 45100;
```
![update](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/update.png)

Remove employee from all cases.
```
DELETE FROM HANDLES
WHERE    	Emp_ID = 42916308;
```
![delete](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/delete.png)

## Views
Below is a view for management to see a list of employees who make more than $40,000 a year to assist mailing benefits information. (see `view.png` for creation statement)

![view](https://github.com/jjmakely/Hospital-DBMS/blob/master/img/view.png)
