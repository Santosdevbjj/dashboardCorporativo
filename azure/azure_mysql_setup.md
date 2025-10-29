# Configuração do MySQL Server no Azure

## 🎯 Objetivo
Criar e configurar um servidor MySQL na Azure para hospedar o banco de dados **`bd_company`**, que será integrado ao Power BI.


---

## ☁️ 1. Criar Grupo de Recursos

```bash
az group create --name rg-dashboard-etl --location eastus


```

---


🗃️ 2. Criar Servidor MySQL no Azure

az mysql server create \
  --resource-group rg-dashboard-etl \
  --name mysql-dashboard-server \
  --location eastus \
  --admin-user adminsergio \
  --admin-password 'SenhaForte@2025' \
  --sku-name GP_Gen5_2

> 💡 Dica: Substitua SenhaForte@2025 por uma senha segura conforme política Azure (mínimo 8 caracteres, 3 tipos diferentes).




---

🔥 3. Configurar Regra de Firewall

Permite conexões do seu IP local:

az mysql server firewall-rule create \
  --resource-group rg-dashboard-etl \
  --server mysql-dashboard-server \
  --name AllowMyIP \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255

> 💡 Para segurança em produção, use o IP real obtido com https://whatismyipaddress.com




---

🧱 4. Criar Banco de Dados

az mysql db create \
  --resource-group rg-dashboard-etl \
  --server-name mysql-dashboard-server \
  --name bd_company


---

🔗 5. Conectar via MySQL Workbench

Credenciais de Conexão

Servidor: mysql-dashboard-server.mysql.database.azure.com

Usuário: adminsergio@mysql-dashboard-server

Banco: bd_company

Porta: 3306


> ✅ Após a conexão, execute os scripts SQL contidos em /data/ para criar e popular as tabelas.




---

🧰 6. Configurar Variável de Conexão (Power BI)

No Power BI Desktop:

Servidor: mysql-dashboard-server.mysql.database.azure.com
Banco de dados: bd_company
Autenticação: Basic
Usuário: adminsergio@mysql-dashboard-server
Senha: ***********


---

🚀 7. Resultado Esperado

Banco bd_company criado e acessível remotamente

Permissão configurada

Pronto para integração Power BI


---
