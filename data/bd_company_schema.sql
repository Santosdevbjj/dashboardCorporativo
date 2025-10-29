# 📁 **PASTA: `data/`**

## 🗂️ `bd_company_schema.sql`

```sql
-- ==========================================================
-- BANCO DE DADOS: bd_company
-- Autor: Sérgio Santos
-- Descrição: Estrutura das tabelas principais do projeto ETL Azure + Power BI
-- ==========================================================

CREATE DATABASE IF NOT EXISTS bd_company;
USE bd_company;

-- ==========================================================
-- TABELA: DEPARTMENT
-- ==========================================================
CREATE TABLE DEPARTMENT (
    Dnumber INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);

-- ==========================================================
-- TABELA: EMPLOYEE
-- ==========================================================
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

-- ==========================================================
-- TABELA: PROJECT
-- ==========================================================
CREATE TABLE PROJECT (
    Pnumber INT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    Plocation VARCHAR(50),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- ==========================================================
-- TABELA: WORKS_ON
-- ==========================================================
CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(5,2),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- ==========================================================
-- TABELA: DEPENDENT
-- ==========================================================
CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(20),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(15),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- ==========================================================
-- INSERÇÃO DE DADOS DE EXEMPLO
-- ==========================================================

INSERT INTO DEPARTMENT VALUES 
(1, 'Research', '123456789', '2022-01-15'),
(2, 'Administration', '987654321', '2023-03-01');

INSERT INTO EMPLOYEE VALUES
('John', 'B', 'Smith', '123456789', '1985-01-09', '731 Fondren, Houston, TX', 'M', 75000, NULL, 1),
('Jennifer', 'S', 'Wallace', '987654321', '1988-06-20', '291 Berry, Bellaire, TX', 'F', 68000, '123456789', 2),
('Ahmad', 'K', 'Jabbar', '456789123', '1990-03-15', '980 Dallas, Houston, TX', 'M', 55000, '987654321', 1);

INSERT INTO PROJECT VALUES
(1, 'ProductX', 'Bellaire', 1),
(2, 'ProductY', 'Sugarland', 2),
(3, 'ProjectZ', 'Houston', 1);

INSERT INTO WORKS_ON VALUES
('123456789', 1, 32.5),
('987654321', 2, 20.0),
('456789123', 3, 40.0);

INSERT INTO DEPENDENT VALUES
('123456789', 'Alice', 'F', '2010-05-12', 'Daughter'),
('987654321', 'Robert', 'M', '2012-08-24', 'Son');
