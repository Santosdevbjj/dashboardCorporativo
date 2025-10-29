# Transformações Power Query – Dashboard Corporativo

## 🎯 Objetivo
Limpar, transformar e combinar os dados do banco `bd_company` hospedado no Azure MySQL antes da modelagem e criação do dashboard no Power BI.

---

## 🧱 1. Conexão com o Banco MySQL Azure
**Origem:**  
> MySQL Database → `mysql-dashboard-server.mysql.database.azure.com`  
> Database: `bd_company`  

Credenciais:  
> Usuário: `adminsergio@mysql-dashboard-server`

---

## 🧩 2. Etapas de Transformação

| Etapa | Ação | Descrição Técnica |
|-------|------|------------------|
| 1 | **Promover cabeçalhos** | Promove a primeira linha como cabeçalho válido |
| 2 | **Alterar tipos de dados** | Ajusta tipos para `Texto`, `Número Decimal`, `Data` |
| 3 | **Remover colunas** | Exclui campos redundantes (endereços, middle name) |
| 4 | **Mesclar consultas** | Une `EMPLOYEE` + `DEPARTMENT` (campo `Dno = Dnumber`) |
| 5 | **Adicionar coluna personalizada** | Cria `Nome_Completo = [Fname] & " " & [Lname]` |
| 6 | **Mesclar com WORKS_ON** | Junta por `Ssn = Essn` para trazer `Hours` e `Pno` |
| 7 | **Mesclar com PROJECT** | Inclui `Pname` e `Plocation` |
| 8 | **Remover valores nulos** | Substitui nulos por “Não informado” |
| 9 | **Agrupar dados** | Total de horas e média salarial por `Gerente` e `Departamento` |
| 10 | **Renomear colunas finais** | Padroniza nomes em formato de apresentação (`Depto`, `Projeto`, `Horas Trabalhadas`) |

---

## 📊 3. Resultado Final
- 1 tabela integrada (`Dashboard_View`)  
- Total de **10 colunas normalizadas**  
- Dados limpos, consistentes e prontos para visualização

---

## 💡 Campos Finais
| Campo | Descrição |
|--------|-----------|
| Nome_Completo | Nome completo do colaborador |
| Departamento | Nome do departamento |
| Projeto | Nome do projeto |
| Localização | Cidade do projeto |
| Horas Trabalhadas | Total de horas alocadas |
| Salário | Valor do salário mensal |
| Gerente | Nome do supervisor |
| Data de Início | Data de admissão ou início do projeto |

---

## ✅ 4. Próximo Passo
Publicar o relatório Power BI no **serviço Power BI Cloud** e conectar via gateway ao banco MySQL Azure.
