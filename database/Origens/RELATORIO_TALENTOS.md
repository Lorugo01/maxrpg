# 📊 Relatório: Talentos Necessários para as Origens

## ✅ Status da Verificação

### Talentos Necessários (10 únicos):

| # | Talento | Status | Arquivo | Observações |
|---|---------|--------|---------|-------------|
| 1 | **Alerta** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 4-32 |
| 2 | **Artesão** | ❌ **FALTANDO** | - | **PRECISA SER CRIADO** |
| 3 | **Atacante Selvagem** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 310-335 |
| 4 | **Curador** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 34-62 |
| 5 | **Duro** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 160-185 |
| 6 | **Iniciado em Magia** | ✅ **ENCONTRADO** | `insert_iniciado_em_magia.sql` | Arquivo separado |
| 7 | **Músico** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 100-129 |
| 8 | **Qualificado** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 280-309 |
| 9 | **Sortudo** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 64-96 |
| 10 | **Tavern Brawler** | ✅ **ENCONTRADO** | `insert_talentos_origem.sql` | Linha 336-373 |

---

## 📈 Resumo Estatístico

- **Total Necessário:** 10 talentos únicos
- **Total Encontrado:** 9 talentos (90%)
- **Total Faltando:** 1 talento (10%)

### Status Geral: ⚠️ **QUASE PRONTO** (falta apenas 1 talento)

---

## ❌ Talentos Faltando

### 1. Artesão (Crafter/Artisan)

**Usado por:**
- Origem: **Artesão** (Artisan)

**Informações do PHB 2024:**
- **Categoria:** Origem
- **Pré-requisito:** Nenhum
- **Descrição:** Você é treinado na criação de itens úteis. Você ganha os seguintes benefícios:
  - **Proficiência em Ferramentas:** Você ganha proficiência com três Ferramentas de Artesão à sua escolha.
  - **Desconto:** Sempre que você compra um item não mágico, recebe um desconto de 20% no preço normal.
  - **Criação Rápida:** Quando você termina um Descanso Longo, você pode criar um item não mágico que vale 50 PO ou menos, desde que você tenha proficiência com as ferramentas necessárias e tenha acesso a elas. O item dura até você terminar outro Descanso Longo, a menos que você gaste PO igual ao valor do item para torná-lo permanente.

---

## 🔧 Ação Necessária

### Criar o Talento "Artesão"

Arquivo sugerido: `database/Talentos/insert_talento_artesao.sql`

```sql
-- Talento: Artesão (Crafter) - PHB 2024
-- Talento de Origem necessário para a origem "Artesão"

INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Artesão',
  null,
  'Você é treinado na criação de itens úteis.',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Proficiência em Ferramentas",
      "description": "Você ganha proficiência com três Ferramentas de Artesão à sua escolha."
    },
    {
      "name": "Desconto",
      "description": "Sempre que você compra um item não mágico, recebe um desconto de 20% no preço normal."
    },
    {
      "name": "Criação Rápida",
      "description": "Quando você termina um Descanso Longo, você pode criar um item não mágico que vale 50 PO ou menos, desde que você tenha proficiência com as ferramentas necessárias e tenha acesso a elas. O item dura até você terminar outro Descanso Longo, a menos que você gaste PO igual ao valor do item para torná-lo permanente."
    }
  ]'::jsonb
);
```

---

## 📋 Mapeamento Completo: Origens → Talentos

| Origem | Talento | Status |
|--------|---------|--------|
| Acólito | Iniciado em Magia (Clérigo) | ✅ OK |
| **Artesão** | **Artesão** | ❌ **FALTA** |
| Criminal | Alerta | ✅ OK |
| Artista | Músico | ✅ OK |
| Agricultor | Duro | ✅ OK |
| Guarda | Alerta | ✅ OK |
| Guia | Iniciado em Magia (Druida) | ✅ OK |
| Eremita | Curador | ✅ OK |
| Comerciante | Sortudo | ✅ OK |
| Nobre | Qualificado | ✅ OK |
| Sábio | Iniciado em Magia (Mago) | ✅ OK |
| Marinheiro | Tavern Brawler | ✅ OK |
| Escriba | Qualificado | ✅ OK |
| Soldado | Atacante Selvagem | ✅ OK |
| Viajante | Sortudo | ✅ OK |

---

## 🚀 Plano de Ação

### Opção 1: Criar Apenas o Talento Faltante
```bash
# 1. Criar o talento Artesão
\i database/Talentos/insert_talento_artesao.sql

# 2. Inserir as origens
\i database/Origens/insert_all_backgrounds_phb2024.sql
```

### Opção 2: Adicionar ao Script de Talentos de Origem
Adicionar o talento "Artesão" ao arquivo `insert_talentos_origem.sql` existente.

### Opção 3: Atualizar o Script insert_all_feats.sql
Adicionar a linha para incluir o novo talento:
```sql
\i database/Talentos/insert_talento_artesao.sql
```

---

## ⚠️ Impacto

**Sem o talento "Artesão":**
- ❌ A origem "Artesão" **NÃO PODE** ser inserida no banco de dados
- ❌ Erro de Foreign Key ao tentar inserir (feat_id não encontrado)
- ❌ 1 de 16 origens ficará indisponível (6,25% das origens)

**Com o talento "Artesão":**
- ✅ Todas as 16 origens podem ser inseridas
- ✅ Sistema 100% funcional
- ✅ Compatibilidade completa com PHB 2024

---

## 📝 Checklist de Implementação

- [x] Verificar talentos existentes
- [x] Identificar talentos faltando
- [ ] **Criar talento "Artesão"**
- [ ] Testar inserção do talento
- [ ] Executar script de origens
- [ ] Verificar integridade dos dados

---

## 📚 Referências

- **PHB 2024:** Player's Handbook 2024, página 179
- **Categoria:** Origin Feat
- **Arquivo de Talentos:** `database/Talentos/insert_talentos_origem.sql`
- **Arquivo de Origens:** `database/Origens/insert_all_backgrounds_phb2024.sql`

---

**Data do Relatório:** 2025-10-08  
**Status:** ⚠️ Aguardando criação do talento "Artesão"
