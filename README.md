# 📊 Dashboard Corporativo — ETL MySQL + Azure + Power BI

![Klabin003](https://github.com/user-attachments/assets/e99c36da-105b-45f8-bf63-cd2bbb3d3097)

**Bootcamp NTT DATA — Engenharia de Dados com Azure e Power BI**

---

## 1. Problema de Negócio

Dados corporativos espalhados em tabelas relacionais sem visualização são invisíveis para quem toma decisões. Um gestor que precisa saber quantos funcionários cada departamento tem, quais projetos estão ativos e qual a média salarial por área **não pode depender de consultas SQL manuais toda vez que precisar de uma resposta.**

O desafio é real e recorrente em empresas de qualquer porte: **como transformar dados operacionais armazenados em um banco relacional em inteligência corporativa acessível, atualizada e visualmente interpretável — sem que o gestor precise saber escrever uma linha de SQL?**

A resposta passa por um pipeline ETL robusto, hospedado em nuvem, integrado a uma ferramenta de BI que qualquer área do negócio consiga usar.

---

## 2. Contexto

Este projeto foi desenvolvido como parte do **Bootcamp NTT DATA**, com foco em engenharia de dados aplicada ao ambiente corporativo real.

A empresa fictícia **azure_company** possui dados operacionais distribuídos em cinco entidades relacionais: funcionários, departamentos, projetos, alocações de horas e dependentes. Esses dados estavam isolados no banco — sem qualquer camada analítica que permitisse extrair valor estratégico deles.

A solução construída percorre o caminho completo: o banco de dados MySQL foi provisionado na **Microsoft Azure**, os dados foram extraídos, limpos e transformados via **Power Query**, e o resultado final é um **dashboard interativo no Power BI** com métricas de RH, projetos e estrutura organizacional — acessível a qualquer perfil de usuário.

---

## 3. Premissas da Análise

Para a execução do pipeline ETL, as seguintes premissas foram adotadas:

- **Fonte única de verdade:** o banco MySQL hospedado na Azure é a origem oficial de todos os dados. Nenhuma transformação altera os dados na origem — apenas na camada Power Query.
- **Gerentes identificados pela ausência de supervisor:** funcionários com `Super_ssn` nulo são gerentes. Esse campo nulo não é erro — é informação de negócio.
- **Salário mínimo validado na origem:** a constraint `CHECK (Salary > 2000.0)` garante que nenhum registro inválido entra no banco, reduzindo o trabalho de limpeza no ETL.
- **Conexão em modo Importar:** os dados são importados para o modelo Power BI, não consultados em tempo real. Isso garante performance no dashboard mesmo com conexão instável com a Azure.
- **Colunas técnicas removidas na camada analítica:** chaves estrangeiras como `Ssn`, `Super_ssn` e `Dnumber` são eliminadas no Power Query — o modelo final expõe apenas o que o negócio precisa ver.

---

## 4. Estratégia da Solução

O pipeline foi construído em cinco etapas encadeadas:

**Etapa 1 — Provisionamento da infraestrutura na Azure**
Criação do servidor MySQL Flexible Server via Azure Cloud Shell com `az mysql flexible-server create`. Configuração de regras de firewall para permitir a conexão externa do Power BI Desktop. Banco `azure_company` criado e validado via MySQL Workbench.

**Etapa 2 — Modelagem e carga dos dados**
Execução dos scripts SQL para criação do schema relacional (employee, departament, project, works_on, dependent) e inserção dos dados operacionais. Constraints de integridade referencial e validação salarial aplicadas na camada de banco.

**Etapa 3 — Extração: Power BI → MySQL Azure**
Conexão estabelecida via conector nativo MySQL no Power BI Desktop, apontando para o servidor `mysql-corporativo.mysql.database.azure.com`. As cinco tabelas foram importadas para o modelo.

**Etapa 4 — Transformação (ETL no Power Query)**
Oito transformações aplicadas em sequência:
- Validação de tipos de dados (decimal para salários, date para datas)
- Tratamento de `Super_ssn` nulo → identificação de gerentes
- Merge `employee ↔ departament` pela chave `Dno / Dnumber` → coluna `Department_Name`
- Auto-merge `employee ↔ employee` via `Ssn / Super_ssn` → coluna `Manager_Name`
- Criação de `FullName = [Fname] + " " + [Lname]`
- Criação de `DeptLocation = [Dname] + " - " + [Dlocation]`
- Agrupamento por `Manager_Name` → contagem de subordinados por gerente
- Remoção de colunas técnicas desnecessárias para o modelo analítico

**Etapa 5 — Modelagem e visualização no Power BI**
Relacionamentos definidos no modelo estrela. Dashboard criado com quatro visualizações principais: funcionários por departamento, relação gerente-subordinados, horas por projeto e média salarial por área.

---

## 5. Decisões Técnicas

**Por que Azure e não um banco local?**
Um banco local resolve o problema técnico do bootcamp, mas não demonstra competência em nuvem — que é o ambiente onde 90% dos projetos de dados reais operam. Provisionar o MySQL na Azure e conectar o Power BI a um servidor remoto simula o cenário que qualquer analista ou engenheiro encontrará em empresas que já migraram para cloud.

**Por que Power Query para o ETL e não Python/SQL?**
Power Query é a ferramenta nativa do ecossistema Microsoft de BI, dominada por analistas de dados e engenheiros de BI em todo o mercado. Para um pipeline conectado diretamente ao Power BI, ela oferece o melhor custo-benefício: transformações visuais auditáveis, integradas ao modelo, sem dependência de scripts externos.

**Por que modo Importar e não DirectQuery?**
DirectQuery consulta o banco a cada interação do usuário no dashboard, o que gera latência em conexões com servidor remoto na nuvem. O modo Importar carrega os dados no modelo Power BI, garantindo performance fluida — adequado para o volume de dados deste projeto.

**Por que auto-merge para identificar gerentes?**
A relação gerente-subordinado está na mesma tabela `employee`, referenciada por `Super_ssn`. Um JOIN da tabela consigo mesma (self-join) é a solução técnica correta — e demonstra compreensão de modelagem relacional além do básico.

**O que eu faria diferente hoje?**
Implementaria atualização agendada dos dados via **Power BI Service** publicado na nuvem, eliminando a necessidade de atualização manual. Também adicionaria uma camada de staging com **Azure Data Factory** para orquestrar o pipeline de forma mais robusta e monitorável.

---

## 6. Insights do Desenvolvimento

Durante a execução do projeto, ficou evidente que:

- **O maior valor do ETL não está na extração — está na transformação.** A junção `employee ↔ employee` para identificar gerentes foi o passo mais sofisticado e o que mais agrega inteligência ao modelo: sem ele, o dashboard não conseguiria responder "quantos funcionários cada gerente supervisiona?"
- **Constraints no banco de dados são a primeira camada de qualidade de dados.** A validação `CHECK (Salary > 2000.0)` no MySQL eliminou uma classe inteira de problemas antes mesmo do ETL começar — é mais eficiente garantir qualidade na origem do que corrigir no destino.
- **Firewall e rede são frequentemente o gargalo em projetos cloud.** A configuração correta das regras de acesso no Azure foi o passo que mais consumiu tempo de diagnóstico — uma habilidade prática que tutoriais raramente ensinam.
- **O modelo estrela simplifica o dashboard.** Definir bem os relacionamentos no Power BI antes de criar qualquer visual reduziu significativamente o número de medidas DAX necessárias.

---

## 7. Resultados

Com o pipeline completo implementado, o projeto entrega:

- ✅ Banco de dados MySQL provisionado e operacional na **Microsoft Azure**
- ✅ Pipeline ETL completo: extração → limpeza → transformação → carga no modelo Power BI
- ✅ Quatro visualizações corporativas prontas para uso: funcionários por departamento, hierarquia gerencial, horas por projeto e média salarial
- ✅ Modelo relacional normalizado com cinco entidades e relacionamentos auditáveis
- ✅ Infraestrutura cloud reproduzível via scripts Azure CLI documentados

---

## 8. Próximos Passos

- [ ] Publicar o dashboard no **Power BI Service** com atualização agendada automática
- [ ] Implementar orquestração do pipeline com **Azure Data Factory**
- [ ] Adicionar medidas **DAX** para KPIs avançados: turnover por departamento, distribuição salarial, carga de horas por funcionário
- [ ] Criar **RLS (Row-Level Security)** para que cada gestor veja apenas os dados do seu departamento
- [ ] Conectar fontes adicionais (ex: folha de pagamento, controle de ponto) para ampliar o escopo analítico

---

## 🛠️ Tecnologias Utilizadas

| Categoria | Ferramenta |
|---|---|
| Banco de Dados | MySQL 8.0 — Azure Database for MySQL Flexible Server |
| Nuvem | Microsoft Azure (Portal + Cloud Shell + CLI) |
| ETL e Modelagem | Power Query (M Language) |
| Business Intelligence | Power BI Desktop |
| Gerenciamento do Banco | MySQL Workbench |
| Linguagem de Dados | SQL (DDL + DML) |
| Versionamento | Git + GitHub |

---

## 🏗️ Arquitetura do Pipeline

```
[Azure Cloud Shell]
        │
        ▼ az mysql flexible-server create
[MySQL 8.0 — Azure Database]
        │  schema: azure_company
        │  tabelas: employee, departament, project, works_on, dependent
        │
        ▼ Conector MySQL (modo Importar)
[Power BI Desktop — Power Query]
        │  limpeza → merges → colunas calculadas → agrupamentos
        │
        ▼ Fechar e Aplicar
[Modelo Power BI — Relacionamentos]
        │
        ▼
[Dashboard Interativo]
   ├── Funcionários por departamento
   ├── Gerentes e subordinados
   ├── Horas por projeto
   └── Média salarial por área
```

---

## 📂 Estrutura do Repositório

```
dashboardCorporativo/
├── data/
│   ├── bd_company_schema.sql        # DDL: criação de todas as tabelas e constraints
│   └── bd_company_insert.sql        # DML: inserção dos dados operacionais
├── powerbi/
│   ├── dashboard_corporativo.pbix   # Arquivo Power BI com modelo e visualizações
│   └── relatorio_dashboard.png      # Imagem do dashboard final
├── scripts/
│   └── azure_cli_commands.sh        # Comandos Azure CLI para provisionar a infraestrutura
└── README.md
```

---

## ☁️ Provisionamento da Infraestrutura (Azure CLI)

```bash
# Criar o servidor MySQL Flexible Server
az mysql flexible-server create \
  --name mysql-corporativo \
  --resource-group rg-dash-corporativo \
  --location brazilsouth \
  --admin-user admin_corp \
  --admin-password "Senha@123" \
  --sku-name Standard_B1ms

# Liberar acesso externo via regra de firewall
az mysql flexible-server firewall-rule create \
  --resource-group rg-dash-corporativo \
  --name mysql-corporativo \
  --rule-name AllowMyIP \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255

# Verificar status do servidor
az mysql flexible-server show \
  --name mysql-corporativo \
  --resource-group rg-dash-corporativo
```

**Conexão via MySQL Workbench:**
- Host: `mysql-corporativo.mysql.database.azure.com`
- Usuário: `admin_corp@mysql-corporativo`
- Banco: `azure_company`

---

## 🔗 Como Conectar o Power BI ao MySQL Azure

1. Abra o **Power BI Desktop**
2. Vá em **Obter Dados → Banco de Dados MySQL**
3. Insira:
   - Servidor: `mysql-corporativo.mysql.database.azure.com`
   - Banco de dados: `azure_company`
   - Modo de Conectividade: **Importar**
4. Autenticação → Banco de Dados → insira usuário e senha
5. Selecione as tabelas: `employee`, `departament`, `project`, `works_on`, `dependent`
6. Clique em **Transformar Dados** para abrir o Power Query e aplicar o ETL

---

## 📄 Licença

Este projeto está licenciado sob a **MIT License** — consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## Autor

**Sergio Santos**

> *"Transformar dados em decisões é o que move a inteligência corporativa."*

[![Portfólio](https://img.shields.io/badge/Portfólio-Sérgio_Santos-111827?style=for-the-badge&logo=githubpages&logoColor=00eaff)](https://portfoliosantossergio.vercel.app)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sérgio_Santos-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/santossergioluiz)
