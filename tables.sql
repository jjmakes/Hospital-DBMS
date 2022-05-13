CREATE TABLE DEPARTMENTS (
Dept_ID   		 	INT   	 		NOT NULL,
Available_Rooms    	INT   	 		DEFAULT 0,
Location   	 		VARCHAR(15)   	NOT NULL,
Num_Employees      	INT,
Budget              DECIMAL(10),
PRIMARY KEY (Dept_ID));

CREATE TABLE EMPLOYEES (  
Fname   	VARCHAR(15)  NOT NULL, 
Minit      	CHAR, 
LName      	VARCHAR(20)  NOT NULL, 
Position    VARCHAR(20)  NOT NULL, 
Address    	VARCHAR(100), 
Salary     	DECIMAL(6), 
EMP_ID      INT          NOT NULL, 
Dept_ID     INT          NOT NULL, 
PRIMARY KEY (EMP_ID, Dept_ID),
FOREIGN KEY (Dept_ID) REFERENCES DEPARTMENTS (Dept_ID));

CREATE TABLE SCHEDULES(
Shift_ID	INT	    NOT NULL,
Start_Time  TIME 	NOT NULL,
End_Time    TIME    NOT NULL,
EMP_ID      INT     NOT NULL,
Date        DATE    NOT NULL,
PRIMARY KEY (EMP_ID, Shift_ID),
FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEES(EMP_ID));

CREATE TABLE HOSPITAL_RESOURCES(
Supply_Name		VARCHAR(60),
Supply_Type		VARCHAR(60),
Supply_Count	INT,
Dept_ID         INT,
PRIMARY KEY(Supply_Name, Dept_ID),
FOREIGN KEY(Dept_ID)  REFERENCES DEPARTMENTS (Dept_ID));

CREATE TABLE PATIENTS (
FName   	 VARCHAR(15)   	 NOT NULL,
MInit   	 CHAR,
LName   	 VARCHAR(20)   	 NOT NULL,
SSN   		 CHAR(9)   		 NOT NULL,   	 
Patient_ID   INT   			 NOT NULL,
DOB   		 DATE,
Address   	 VARCHAR(100),
Insurance    VARCHAR(40),
Policy_ID    INT,
PRIMARY KEY (SSN, Patient_ID),
UNIQUE (Patient_ID));

CREATE TABLE CASES(
Case_ID     	INT  		NOT NULL,
Room_Num   		INT,       
Admitted_By     INT     	NOT NULL,
Prescriptions   VARCHAR(30),
Patient_ID      INT         NOT NULL,
Admit_Date      DATE        NOT NULL,
Discharge_Date  DATE,
PRIMARY KEY (Case_ID, Patient_ID),
FOREIGN KEY(Patient_ID) REFERENCES PATIENTS(Patient_ID));

CREATE TABLE HANDLES (
Emp_ID   	 INT   	 NOT NULL,
Case_ID   	 INT   	 NOT NULL,
PRIMARY KEY (EMP_ID, Case_ID),
FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES (EMP_ID),
FOREIGN KEY    (Case_ID) REFERENCES CASES (Case_ID)
);

CREATE TABLE HOUSED_UNDER (
Patient_ID   INT   	 NOT NULL,
Dept_ID   	 INT   	 NOT NULL,
Case_ID   	 INT   	 NOT NULL,
PRIMARY KEY (Patient_ID, Dept_ID, Case_ID),
FOREIGN KEY    (Patient_ID) REFERENCES PATIENTS (Patient_ID),
FOREIGN KEY    (Case_ID) REFERENCES CASES (Case_ID),
FOREIGN KEY    (Dept_ID) REFERENCES DEPARTMENTS (Dept_ID)
);