# Configuração de Regra de Firewall – Azure MySQL

## 🎯 Objetivo
Permitir que o Power BI Desktop e o MySQL Workbench acessem o banco hospedado na Azure.

---

### 🔧 Comando CLI

```bash
az mysql server firewall-rule create \
  --resource-group rg-dashboard-etl \
  --server mysql-dashboard-server \
  --name AllowLocalAccess \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255


---

🧱 Via Portal Azure

1. Acesse Azure Portal → MySQL Server → Networking


2. Clique em Add firewall rule


3. Insira:

Nome: AllowLocalAccess

Start IP: seu IP atual

End IP: mesmo IP



4. Clique em Save




---

✅ Resultado

Conexão externa liberada para Power BI e MySQL Workbench.

---
