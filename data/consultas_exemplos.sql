-- ==========================================================
-- CONSULTAS SQL DE ANÁLISE - bd_company
-- Autor: Sérgio Santos
-- Descrição: Consultas utilizadas para verificação, análise
-- e integração com o Power BI no projeto ETL Azure.
-- ==========================================================

USE bd_company;

-- ==========================================================
-- 1️⃣ Total de funcionários por departamento
-- ==========================================================
SELECT 
    D.Dname AS Departamento,
    COUNT(E.Ssn) AS Total_Funcionarios
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.Dnumber = E.Dno
GROUP BY D.Dname;

-- ==========================================================
-- 2️⃣ Salário médio por departamento
-- ==========================================================
SELECT 
    D.Dname AS Departamento,
    ROUND(AVG(E.Salary), 2) AS Salario_Medio
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.Dnumber = E.Dno
GROUP BY D.Dname
ORDER BY Salario_Medio DESC;

-- ==========================================================
-- 3️⃣ Relação de projetos por funcionário
-- ==========================================================
SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS Nome_Funcionario,
    P.Pname AS Projeto,
    W.Hours AS Horas_Alocadas
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
ORDER BY Nome_Funcionario;

-- ==========================================================
-- 4️⃣ Total de horas trabalhadas por projeto
-- ==========================================================
SELECT 
    P.Pname AS Projeto,
    SUM(W.Hours) AS Total_Horas
FROM PROJECT P
JOIN WORKS_ON W ON P.Pnumber = W.Pno
GROUP BY P.Pname
ORDER BY Total_Horas DESC;

-- ==========================================================
-- 5️⃣ Funcionários e seus dependentes
-- ==========================================================
SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS Funcionario,
    D.Dependent_name AS Dependente,
    D.Relationship AS Relacao,
    D.Bdate AS Nascimento
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
ORDER BY Funcionario;

-- ==========================================================
-- 6️⃣ Hierarquia de funcionários e gerentes
-- ==========================================================
SELECT 
    CONCAT(E.Fname, ' ', E.Lname) AS Funcionario,
    CONCAT(S.Fname, ' ', S.Lname) AS Gerente,
    E.Dno AS Departamento
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE S ON E.Super_ssn = S.Ssn
ORDER BY Gerente;

-- ==========================================================
-- 7️⃣ Resumo geral de métricas
-- ==========================================================
SELECT
    COUNT(DISTINCT E.Ssn) AS Total_Funcionarios,
    COUNT(DISTINCT P.Pnumber) AS Total_Projetos,
    SUM(W.Hours) AS Horas_Totais,
    ROUND(AVG(E.Salary), 2) AS Salario_Medio
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber;
