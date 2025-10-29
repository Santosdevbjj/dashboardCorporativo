## 📘 /docs/03_transformacoes_realizadas.md

# Transformações Realizadas no Power Query

Este documento descreve as transformações aplicadas no Power Query dentro do Power BI para limpeza, padronização e integração dos dados do banco de dados Azure MySQL.



---

## 🧹 1. Etapas de Limpeza e Normalização

**Tabelas processadas:**  
- `employees`  
- `departments`  
- `projects`  
- `employee_projects`

### Principais Ações:
- Remoção de colunas redundantes (ex.: `middle_name`, `phone_number`).
- Padronização de nomes de colunas para o formato `snake_case`.
- Conversão de datas para o padrão `dd/MM/yyyy`.
- Correção de registros nulos com `null → "Não informado"`.

---

## 🧩 2. Junção e Relacionamentos

Foram aplicadas junções (merge queries) para relacionar as tabelas conforme o modelo lógico:

```text
employees.department_id = departments.department_id
employee_projects.employee_id = employees.employee_id
employee_projects.project_id = projects.project_id.

```

---

Após as junções, as colunas foram expandidas e renomeadas para facilitar o entendimento dos relatórios.


---

🔢 3. Criação de Colunas Calculadas

Foram criadas as seguintes colunas personalizadas no Power Query:

Coluna	Fórmula DAX	Descrição

anos_empresa	Date.Year(DateTime.LocalNow()) - Date.Year([hire_date])	Tempo de casa em anos
faixa_salarial	if [salary] < 3000 then "Júnior" else if [salary] < 7000 then "Pleno" else "Sênior"	Classificação de nível
departamento_upper	Text.Upper([department_name])	Nome do departamento em maiúsculas



---

🔄 4. Tipagem e Formatação Final

Campos de data → Data

Campos de valores → Número decimal

Campos de texto → Texto

Chaves primárias → Número inteiro



---

📊 5. Tabelas Finais Exportadas ao Modelo

Tabela Final	Descrição	Origem

dim_departamentos	Dimensão dos departamentos	departments
dim_funcionarios	Dimensão dos funcionários	employees
fato_projetos	Fato consolidada de projetos	projects + employee_projects



---

🧠 6. Observações

As transformações foram realizadas somente no Power Query, sem alterar os dados originais do MySQL.

Todas as colunas derivadas possuem documentação e rastreabilidade.

As consultas M completas estão documentadas em docs/power_query_steps.md.



---

Autor: Sérgio Santos
Última atualização: Outubro/2025
Licença: MIT

---


