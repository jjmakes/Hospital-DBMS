--Benefits for employees making more than $40k
CREATE VIEW Query
CREATE VIEW	E_BENEFITS
AS SELECT	Fname, Minit, LName, Address, Salary
FROM		EMPLOYEES
WHERE		Salary > 40000;