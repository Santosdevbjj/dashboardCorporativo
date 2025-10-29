# Conexão ao Servidor MySQL Azure via MySQL Workbench

## 🎯 Objetivo
Estabelecer conexão segura com o banco de dados **`bd_company`** hospedado no Azure MySQL, permitindo manipulação via interface gráfica.

---

## 🧭 1. Pré-requisitos
- Conta Azure configurada
- Servidor MySQL ativo (ver `azure_mysql_setup.md`)
- Firewall liberado (ver `firewall_rule_setup.md`)
- MySQL Workbench instalado (versão 8.0+)

---

## ⚙️ 2. Parâmetros de Conexão

| Campo | Valor |
|--------|--------|
| **Connection Name** | Azure MySQL Dashboard |
| **Hostname** | `mysql-dashboard-server.mysql.database.azure.com` |
| **Port** | `3306` |
| **Username** | `adminsergio@mysql-dashboard-server` |
| **Password** | (inserir senha configurada no setup) |
| **Default Schema** | `bd_company` |

---

## 🔑 3. Testar a Conexão
1. Clique em **Test Connection**  
2. Caso apareça a mensagem “Successfully made the MySQL connection”, clique em **OK**.  
3. Se ocorrer erro de acesso:
   - Verifique o **firewall** na Azure
   - Confirme se o **IP local** está permitido
   - Valide as **credenciais**

---

## 🧱 4. Executar os Scripts
1. Acesse o menu **File → Open SQL Script**  
2. Selecione:
   - `/data/bd_company_schema.sql`  
   - `/data/bd_company_inserts.sql` (se aplicável)  
   - `/data/consultas_exemplos.sql` (para validação)
3. Execute com o ícone **⚡ (Execute)**

---

## ✅ 5. Resultado Esperado
- Tabelas criadas corretamente  
- Dados carregados  
- Conexão validada  
- Banco pronto para integração com Power BI
