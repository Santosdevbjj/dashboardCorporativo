## 📘 `/docs/03_transformacoes_realizadas.md`

```markdown
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

