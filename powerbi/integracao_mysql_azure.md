# Integração Power BI com Azure Database for MySQL

Este documento descreve as etapas para conectar o Power BI ao banco de dados MySQL hospedado no Azure, permitindo a criação de dashboards e análises de dados corporativas.

---

## 🔧 1. Pré-requisitos

Antes de começar, certifique-se de ter:

- Uma instância **Azure Database for MySQL** configurada e acessível.
- Firewall configurado no portal Azure para permitir o IP da máquina local.
- Driver **MySQL Connector/ODBC** instalado.
- Power BI Desktop atualizado.

---

## 🔌 2. Configuração da Conexão

1. Abra o **Power BI Desktop**.
2. Vá até **Obter Dados → Banco de Dados → MySQL**.
3. Insira as credenciais de conexão:
   - **Servidor:** `meubanco.mysql.database.azure.com`
   - **Banco de Dados:** `companydb`
   - **Usuário:** `adminuser@meubanco`
   - **Senha:** (senha definida no Azure)
4. Clique em **Avançar**.

---

## ⚙️ 3. Definição de Consulta SQL (opcional)

Para otimizar a performance, você pode definir uma consulta SQL direta na conexão Power BI:

```sql
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    e.hire_date,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id;




---


Essa consulta traz os principais dados dos colaboradores e departamentos.


---

📈 4. Criação do Modelo de Dados

1. Após carregar as tabelas, acesse a guia Modelo no Power BI.


2. Verifique os relacionamentos entre:

departments.department_id ↔ employees.department_id

projects.project_id ↔ employee_projects.project_id



3. Ajuste os tipos de dados conforme necessário (ex.: datas e valores numéricos).




---

🎨 5. Construção dos Dashboards

Exemplos de visualizações recomendadas:

Gráfico de barras: distribuição de funcionários por departamento.

Indicadores (cards): total de funcionários e média salarial.

Gráfico de linhas: evolução salarial média por ano de admissão.

Matriz: relação entre projetos e departamentos.



---

🔄 6. Atualização Automática

Para atualizar os relatórios periodicamente:

1. Publique o relatório no Power BI Service.


2. Configure o Gateway de Dados.


3. Agende atualizações (ex.: diariamente às 8h).




---

✅ 7. Boas Práticas

Utilize consultas parametrizadas para performance e segurança.

Sempre valide as credenciais de acesso no Azure.

Crie visões SQL específicas para relatórios de alta frequência.



---

Autor: Sérgio Santos
Última atualização: Outubro/2025
Licença: MIT

---




