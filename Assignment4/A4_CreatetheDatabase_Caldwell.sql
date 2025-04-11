-- CSCI-C442 Assignment 4 Part 1
-- Create the Database

-- Drew D. Caldwell
-- 4/10/2025

-- STEP A: Create company database
CREATE DATABASE COMPANY;
USE COMPANY;

-- STEP B: Create tables that match the schema in figure 5.6, the COMPANY database in your book. Include all necessary constraints.

-- Employees Table
CREATE TABLE Employee (
    Fname       CHAR(15),
    Minit       CHAR(1),
    Lname       CHAR(15),
    Ssn         INT PRIMARY KEY,
    Bdate       DATE,
    Address     CHAR(40),
    Sex         CHAR(1),
    Salary      INT,
    Super_Ssn   INT,
    Dno         INT
);

-- Department Table
CREATE TABLE Department (
    Dname           CHAR(15),
    Dnumber         INT PRIMARY KEY,
    Mgr_ssn         INT,
    Mgr_start_date  DATE
);

-- Dept_Locations Table
CREATE TABLE Dept_Locations ( 
    Dnumber     INT,
    Dlocation   CHAR(15)
);

-- Works_On Table
CREATE TABLE Works_On (
    Essn    INT,
    Pno     INT,
    Hours   DECIMAL(5,2)
);

-- Project Table
CREATE TABLE Project (
    Pname       CHAR(15),
    Pnumber     INT PRIMARY KEY,
    Plocation   CHAR(15),
    Dnum        INT
);

-- Dependent Table
CREATE TABLE Dependent (
    Essn            INT,
    Dependent_name  CHAR(15),
    Sex             CHAR(1),
    Bdate           DATE,
    Relationship    CHAR(15)
);

-- Expenses Table
CREATE TABLE Expenses (
    ExpenseID       INT,
    Essn            INT,
    Amount          DECIMAL(8,2),
    Description     CHAR(35)
);

-- Paychecks Table
CREATE TABLE Paychecks (
    PaycheckID      CHAR(15),
    Essn            INT,
    Amount          DECIMAL(8,2),
    PayDate         DATE
);

-- Foreign Keys
ALTER TABLE Employee
    ADD FOREIGN KEY (Super_Ssn) REFERENCES Employee(Ssn),
    ADD FOREIGN KEY (Dno) REFERENCES Department(Dnumber);

ALTER TABLE Department
    ADD FOREIGN KEY (Mgr_ssn) REFERENCES Employee(Ssn);

ALTER TABLE Dept_Locations
    ADD FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber);

ALTER TABLE Project
    ADD FOREIGN KEY (Dnum) REFERENCES Department(Dnumber);

ALTER TABLE Works_On
    ADD FOREIGN KEY (Essn) REFERENCES Employee(Ssn),
    ADD FOREIGN KEY (Pno) REFERENCES Project(Pnumber);

ALTER TABLE Dependent
    ADD FOREIGN KEY (Essn) REFERENCES Employee(Ssn);

ALTER TABLE Expenses
    ADD FOREIGN KEY (Essn) REFERENCES Employee(Ssn);

ALTER TABLE Paychecks
    ADD FOREIGN KEY (Essn) REFERENCES Employee(Ssn);

-- STEP D: Insert sample data

INSERT INTO Employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_Ssn, Dno) 
VALUES
('John'      , 'B', 'Smith'    , 123456789, '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, 333445555, 5),
('Franklin'  , 'T', 'Wong'     , 333445555, '1955-12-08', '638 Voss, Houston, TX'   , 'M', 40000, 888665555, 5),
('Alicia'    , 'J', 'Zelaya'   , 999887777, '1968-01-19', '3321 Castle, Spring, TX' , 'F', 25000, 987654321, 4),
('Jennifer'  , 'S', 'Wallace'  , 987654321, '1941-06-20', '291 Berry, Bellaire, TX' , 'F', 43000, 888665555, 4),
('Ramesh'    , 'K', 'Narayan'  , 666884444, '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5),
('Joyce'     , 'A', 'English'  , 453453453, '1972-07-31', '5631 Rice, Houston, TX'  , 'F', 25000, 333445555, 5),
('Ahmad'     , 'V', 'Jabbar'   , 987987987, '1969-03-29', '980 Dallas, Houston, TX' , 'M', 25000, 987654321, 4),
('James'     , 'E', 'Borg'     , 888665555, '1937-11-10', '450 Stone, Houston, TX'  , 'M', 55000, NULL     , 1);

INSERT INTO Department (Dname, Dnumber, Mgr_ssn, Mgr_start_date) 
VALUES
('Research',       5, 333445555, '1988-05-22'),
('Administration', 4, 987654321, '1988-05-22'),
('Headquarters',   1, 888665555, '1981-06-19');

INSERT INTO Dept_Locations (Dnumber, Dlocation) 
VALUES
(1, 'Houston'  ),
(4, 'Stafford' ),
(5, 'Bellaire' ),
(5, 'Sugarland'),
(5, 'Houston'  );

INSERT INTO Project (Pname, Pnumber, Plocation, Dnum)
VALUES
('ProductX',         1, 'Bellaire' , 5),
('ProductY',         2, 'Sugarland', 5),
('ProductZ',         3, 'Houston'  , 5),
('Computerization', 10, 'Stafford' , 4),
('Reorganization',  20, 'Houston'  , 1),
('Newbenefits',     30, 'Stafford' , 4);

INSERT INTO WORKS_ON(Essn, Pno, Hours)
VALUES
(123456789, 1  , 32.5),
(123456789, 2  ,  7.5),
(666884444, 3  , 40.0),
(453453453, 1  , 20.0),
(453453453, 2  , 20.0),
(333445555, 2  , 10.0),
(333445555, 3  , 10.0),
(333445555, 10 , 10.0),
(333445555, 20 , 10.0),
(999887777, 30 , 30.0),
(999887777, 10 , 10.0),
(987987987, 10 , 35.5),
(987987987, 30 ,  5.0),
(987654321, 30 , 20.0),
(987654321, 20 , 15.0),
(888665555, 20 , NULL);

INSERT INTO Dependent (Essn, Dependent_name, Sex, Bdate, Relationship)
 VALUES
(333445555, 'Alice'    , 'F', '1986-04-05', 'Daughter'),
(333445555, 'Theodore' , 'M', '1983-10-25', 'Son'     ),
(333445555, 'Joy'      , 'F', '1958-05-03', 'Spouse'  ), 
(987654321, 'Abner'    , 'M', '1942-02-28', 'Spouse'  ),
(123456789, 'Michael'  , 'M', '1988-01-04', 'Son'     ),
(123456789, 'Alice'    , 'F', '1988-12-30', 'Daughter'),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse'  );
