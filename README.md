## Criando um Dashboard corporativo com integração com MySQL e Azure.

![Klabin003](https://github.com/user-attachments/assets/e99c36da-105b-45f8-bf63-cd2bbb3d3097)



---


# 📊 Dashboard Corporativo – ETL MySQL + Azure + Power BI

> **Autor:** Sérgio Santos  
> **Objetivo:** Desenvolver um processo ETL completo e simplificado, integrando **MySQL na Azure** ao **Power BI**, com transformação, limpeza e modelagem de dados para criação de um **Dashboard Corporativo**.  
>  
> **Repositório:** [github.com/Santosdevbjj/dashboardCorporativo](https://github.com/Santosdevbjj/dashboardCorporativo)

---

## 🧠 Sumário
1. [Descrição do Desafio](#descrição-do-desafio)
2. [Arquitetura do Projeto](#arquitetura-do-projeto)
3. [Estrutura do Repositório](#estrutura-do-repositório)
4. [Criação da Instância MySQL no Azure](#criação-da-instância-mysql-no-azure)
5. [Configuração de Firewall e Conexão via Workbench](#configuração-de-firewall-e-conexão-via-workbench)
6. [Execução dos Scripts SQL](#execução-dos-scripts-sql)
7. [Integração do Power BI com MySQL Azure](#integração-do-power-bi-com-mysql-azure)
8. [Transformações de Dados (ETL)](#transformações-de-dados-etl)
9. [Modelo de Dados e Dashboard Final](#modelo-de-dados-e-dashboard-final)
10. [Comandos Azure CLI e Cloud Shell](#comandos-azure-cli-e-cloud-shell)
11. [Tecnologias Utilizadas](#tecnologias-utilizadas)
12. [Autor](#autor)

---

## 🧩 Descrição do Desafio

Neste projeto, foi desenvolvido um fluxo completo de **Extração, Transformação e Carga (ETL)** utilizando:
- **Banco de dados MySQL hospedado na Azure**
- **Power BI** para integração, transformação e visualização dos dados.

O objetivo é demonstrar a criação de um **dashboard corporativo** com métricas estratégicas, aplicando boas práticas de governança, modelagem e integração de dados em nuvem.

---

## 🏗️ Arquitetura do Projeto

[Usuário / Power BI] │ ▼ [MySQL Workbench / Azure] │ ▼ [Azure MySQL Database Server] │ ▼ [ETL Power Query + Modelagem Power BI] │ ▼ [Dashboard Interativo Power BI]

**Fluxo:**  
`Azure Cloud Shell → MySQL Server → Power BI Desktop → Dashboard Final`

---

## 📁 Estrutura do Repositório


<img width="964" height="1072" alt="Screenshot_20251029-191601" src="https://github.com/user-attachments/assets/3443c698-aabc-4e01-98db-9f78308f007e" />



---

## ☁️ Criação da Instância MySQL no Azure

### 🔹 1. Acesse o Portal Azure
- Vá até: [https://portal.azure.com](https://portal.azure.com)
- Pesquise por **“Banco de Dados para MySQL”**
- Clique em **Criar Recurso → Banco de Dados → Banco de Dados MySQL**

### 🔹 2. Configure a Instância
- **Nome do Servidor:** `mysql-corporativo`
- **Usuário administrador:** `admin_corp`
- **Senha:** `Senha@123`
- **Localização:** Brazil South
- **Versão:** MySQL 8.0
- **Camada de computação:** Basic / 1 vCore

### 🔹 3. Criar o Banco de Dados via Cloud Shell
```bash
az mysql flexible-server create \
  --name mysql-corporativo \
  --resource-group rg-dash-corporativo \
  --location brazilsouth \
  --admin-user admin_corp \
  --admin-password "Senha@123" \
  --sku-name Standard_B1ms


---
```


🔐 **Configuração de Firewall e Conexão via Workbench**

Criar regra de firewall para acesso externo:

az mysql flexible-server firewall-rule create \
  --resource-group rg-dash-corporativo \
  --name mysql-corporativo \
  --rule-name AllowMyIP \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255

**Conexão via Workbench**

Host: mysql-corporativo.mysql.database.azure.com

Usuário: admin_corp@mysql-corporativo

Senha: Senha@123

Banco: azure_company



---

🧱 **Execução dos Scripts SQL**

1. No MySQL Workbench, execute:



**Criação do Schema e Tabelas**

CREATE SCHEMA IF NOT EXISTS azure_company;
USE azure_company;

CREATE TABLE employee(
 Fname VARCHAR(15) NOT NULL,
 Minit CHAR,
 Lname VARCHAR(15) NOT NULL,
 Ssn CHAR(9) NOT NULL PRIMARY KEY,
 Bdate DATE,
 Address VARCHAR(30),
 Sex CHAR,
 Salary DECIMAL(10,2),
 Super_ssn CHAR(9),
 Dno INT NOT NULL DEFAULT 1,
 CONSTRAINT chk_salary_employee CHECK (Salary > 2000.0),
 FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
     ON DELETE SET NULL ON UPDATE CASCADE
);

**Criação das Demais Tabelas**

(veja arquivo completo em /data/bd_company_schema.sql)

**Inserção dos Dados**

INSERT INTO employee VALUES 
('John', 'B', 'Smith', '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, '333445555', 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, '888665555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, '987654321', 4);


---

🔗 **Integração do Power BI com MySQL Azure**

1. Abra o Power BI Desktop


2. Vá em Obter Dados → MySQL Database


3. **Insira:**

Servidor: mysql-corporativo.mysql.database.azure.com

Banco: azure_company

Modo de Conexão: Importar



4. **Autenticação → Usuário e Senha**


5. Selecione as tabelas: employee, departament, project, works_on, dependent




---

🔄 **Transformações de Dados (ETL)**

1️⃣ Verificação de Cabeçalhos e Tipos

Confirme os tipos de dados (decimal, date, text) no Power Query.

Corrija valores monetários para tipo Decimal Number.


2️⃣ **Tratamento de Valores Nulos**

Super_ssn nulo → indica gerente.

Substitua nulos por "Sem Gerente" ou mantenha como null se gerentes forem identificados.


3️⃣ **Junção Employee + Departament**

Merge Queries → base: employee

Chave: Dno ↔ Dnumber

Resultado: coluna Department_Name adicionada a employee.



4️⃣ **Junção Colaboradores ↔ Gerentes**

Crie uma auto-mescla da tabela employee com ela mesma:

employee.Ssn ↔ employee.Super_ssn

Nova coluna: Manager_Name



5️⃣ **Mesclagem de Colunas**

Crie FullName = [Fname] & " " & [Lname]

Crie DeptLocation = [Dname] & " - " & [Dlocation]


6️⃣ **Agrupamento**

Agrupe por Manager_Name → Contagem de funcionários subordinados.


7️⃣ **Eliminação de Colunas Desnecessárias**

Remova colunas técnicas como Ssn, Super_ssn, Dnumber, etc., mantendo apenas as de análise.


8️⃣ **Carregamento no Power BI**

Clique em Fechar e Aplicar → para carregar os dados transformados no modelo.



---

🌟 **Modelo de Dados e Dashboard Final**

Modelo Relacional:

employee ──< works_on >── project
    │
    ▼
departament ──< dept_locations

Visualizações Criadas:

Total de funcionários por departamento

Relação de gerentes e subordinados

Total de horas por projeto

Média salarial por departamento

Localização dos departamentos


📸 Veja em: /powerbi/relatorio_dashboard.png


---

💻 **Comandos Azure CLI e Cloud Shell**

# Conectar ao servidor MySQL
az mysql flexible-server connect --name mysql-corporativo --user admin_corp --admin-password "Senha@123"

# Listar bancos de dados
az mysql flexible-server db list --resource-group rg-dash-corporativo --server-name mysql-corporativo

# Verificar status do servidor
az mysql flexible-server show --name mysql-corporativo --resource-group rg-dash-corporativo


---

🧰 **Tecnologias Utilizadas**

Categoria	Ferramenta

Banco de Dados	MySQL 8.0 (Azure Database for MySQL)
ETL / BI	Power BI Desktop
Linguagem de Suporte	SQL / Power Query / Python (opcional)
Nuvem	Microsoft Azure
Ferramenta de Gerenciamento	Azure Cloud Shell / MySQL Workbench
Versionamento	Git + GitHub



---

👨‍💻 **Autor**

Sérgio Santos




---

> “Transformar dados em decisões é o que move a inteligência corporativa.”
— Sérgio Santos



---

