# Sistema de Itens e Equipamentos - D&D 5e

## 📋 Estrutura de Arquivos

### Arquivos:
1. **`README_ITENS.md`** - Este arquivo de documentação
2. **`itens.sql`** - Exemplo de itens já inseridos (60 itens)

## 🎯 Duas Tabelas Distintas

### 1. **`items`** - Itens de Personagem
Itens que pertencem a um personagem específico (inventário pessoal).

### 2. **`equipment`** - Equipamentos do Jogo
Catálogo geral de equipamentos disponíveis no jogo (armas, armaduras, ferramentas, etc.).

---

## 📊 Tabela `items` (Itens de Personagem)

### Estrutura:
| Campo | Tipo | Descrição | Obrigatório |
|-------|------|-----------|-------------|
| `id` | UUID | Identificador único | ❌ (auto) |
| `character_id` | UUID | ID do personagem (FK) | ❌ Não |
| `name` | VARCHAR(100) | Nome do item | ✅ Sim |
| `description` | TEXT | Descrição do item | ❌ Não |
| `quantity` | INTEGER | Quantidade | ❌ (default: 1) |
| `weight` | NUMERIC(5,2) | Peso em libras | ❌ (default: 0) |
| `value` | NUMERIC(10,2) | Valor em PO | ❌ (default: 0) |
| `type` | VARCHAR(50) | Tipo do item | ✅ Sim |
| `equipped` | BOOLEAN | Se está equipado | ❌ (default: false) |
| `created_at` | TIMESTAMP | Data de criação | ❌ (auto) |
| `updated_at` | TIMESTAMP | Data de atualização | ❌ (auto) |

### Características:
- ✅ **Foreign Key:** `character_id` → `characters.id` (CASCADE on delete)
- ✅ **Índice:** `idx_items_character_id` para busca rápida
- ✅ **Trigger:** `update_items_updated_at` atualiza `updated_at` automaticamente

---

## 📊 Tabela `equipment` (Equipamentos do Jogo)

### Estrutura Completa:
| Campo | Tipo | Descrição | Uso |
|-------|------|-----------|-----|
| `id` | UUID | Identificador único | Todos |
| `name` | VARCHAR(100) | Nome do equipamento | Todos |
| `type` | VARCHAR(50) | Tipo (Arma, Armadura, etc.) | Todos |
| `category` | VARCHAR(50) | Categoria específica | Opcional |
| `cost` | NUMERIC(10,2) | Custo numérico | Opcional |
| `cost_text` | VARCHAR | Custo em texto | Opcional |
| `cost_currency` | VARCHAR | Moeda (PO, PP, PC, etc.) | Opcional |
| `weight` | NUMERIC(5,2) | Peso numérico | Opcional |
| `weight_text` | VARCHAR | Peso em texto | Opcional |
| `description` | TEXT | Descrição completa | Opcional |
| `source` | VARCHAR | Fonte (PHB 2024, etc.) | Opcional |

### Campos Específicos de Armas:
| Campo | Tipo | Descrição |
|-------|------|-----------|
| `damage` | VARCHAR(50) | Dado de dano (1d6, 1d8, etc.) |
| `damage_type` | VARCHAR(50) | Tipo de dano (Cortante, Perfurante, etc.) |
| `properties` | VARCHAR(200) | Propriedades da arma |
| `weapon_properties` | TEXT | Propriedades detalhadas |
| `weapon_mastery` | VARCHAR | Maestria da arma (PHB 2024) |
| `is_ranged` | BOOLEAN | Se é arma de longo alcance |
| `thrown_range` | VARCHAR | Alcance de arremesso (ex: 20/60) |

### Campos Específicos de Armaduras:
| Campo | Tipo | Descrição |
|-------|------|-----------|
| `armor_class` | INTEGER | CA base da armadura |
| `armor_class_modifier` | VARCHAR(50) | Modificador de CA (Destreza, etc.) |
| `stealth_disadvantage` | BOOLEAN | Se impõe desvantagem em Furtividade |
| `strength` | INTEGER | Força mínima requerida |
| `stealth` | VARCHAR(50) | Informações de furtividade |
| `attribute_requirements` | JSONB | Requisitos de atributos |
| `required_attributes` | TEXT | Atributos requeridos em texto |

### Características:
- ✅ **Índices:** `idx_equipment_type` e `idx_equipment_category` para busca rápida
- ✅ **Trigger:** `update_equipment_updated_at` atualiza `updated_at` automaticamente

---

## 🗂️ Tipos de Equipamentos

### Armas:
- **Arma Simples** - Armas básicas (Clava, Adaga, Lança, etc.)
- **Arma Marcial** - Armas avançadas (Espada Longa, Machado Grande, etc.)

### Armaduras:
- **Armadura Leve** - CA + mod. Destreza completo (Couro, Acolchoada)
- **Armadura Média** - CA + mod. Destreza (máx +2)
- **Armadura Pesada** - CA fixo, sem mod. Destreza

### Outros:
- **Item de Aventura** - Equipamentos gerais (Mochila, Corda, Tocha, etc.)
- **Instrumento Musical** - Instrumentos para bardos
- **Ferramenta** - Ferramentas de artesão
- **Foco em conjuração** - Focos arcanos e divinos

---

## 💰 Moedas do Sistema

| Moeda | Nome | Valor em PO |
|-------|------|-------------|
| **PC** | Peça de Cobre | 0,01 PO |
| **PP** | Peça de Prata | 0,1 PO |
| **PE** | Peça de Electrum | 0,5 PO |
| **PO** | Peça de Ouro | 1 PO |
| **PL** | Peça de Platina | 10 PO |

---

## 🎯 Propriedades de Armas (PHB 2024)

### Propriedades Básicas:
- **Acuidade** - Pode usar Destreza ao invés de Força
- **Arremesso** - Pode ser arremessada
- **Duas Mãos** - Requer duas mãos
- **Leve** - Arma leve para duas armas
- **Pesada** - Criaturas Pequenas têm desvantagem
- **Versátil** - Pode usar uma ou duas mãos

### Maestrias de Armas (PHB 2024):
- **Ágil** - +2 CA até próximo turno
- **Afligir** - Desvantagem no próximo ataque do alvo
- **Empurrar** - Empurra 3 metros
- **Lentidão** - Reduz velocidade
- **Trespassar** - Dano em criatura adjacente

---

## 📝 Exemplos de Equipamentos

### Arma Simples:
```sql
INSERT INTO equipment (
  name, type, cost, cost_text, cost_currency, weight, weight_text,
  damage, damage_type, weapon_properties, weapon_mastery, 
  thrown_range, source
) VALUES (
  'Adaga',
  'Arma Simples',
  2.00, '2', 'PO',
  1.00, '1',
  '1d4', 'Perfurante',
  'Leve, Arremesso, Acuidade',
  'Ágil',
  '20/60',
  'PHB 2024'
);
```

### Armadura Leve:
```sql
INSERT INTO equipment (
  name, type, cost, cost_text, cost_currency, weight, weight_text,
  armor_class, armor_class_modifier, stealth_disadvantage, source
) VALUES (
  'Armadura de couro',
  'Armadura Leve',
  10.00, '10', 'PO',
  10.00, '10',
  11, 'Destreza', false,
  'PHB 2024'
);
```

### Item de Aventura:
```sql
INSERT INTO equipment (
  name, type, cost, cost_text, cost_currency, weight, weight_text,
  description, source
) VALUES (
  'Mochila',
  'Item de Aventura',
  2.00, '2', 'PO',
  NULL, '',
  'Uma mochila suporta até 13,6 kg em 1 pé cúbico. Ela também pode servir como alforje.',
  'PHB 2024'
);
```

### Instrumento Musical:
```sql
INSERT INTO equipment (
  name, type, cost, cost_text, cost_currency, weight, weight_text,
  description, source
) VALUES (
  'Flauta',
  'Instrumento Musical',
  2.00, '2', 'PO',
  1.00, '1',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15).',
  'PHB 2024'
);
```

---

## 🔍 Consultas Úteis

### Listar todos os equipamentos:
```sql
SELECT name, type, cost_text, cost_currency, weight_text
FROM equipment
ORDER BY type, name;
```

### Buscar armas:
```sql
SELECT name, damage, damage_type, weapon_properties, weapon_mastery
FROM equipment
WHERE type LIKE '%Arma%'
ORDER BY type, name;
```

### Buscar armaduras:
```sql
SELECT name, type, armor_class, armor_class_modifier, stealth_disadvantage
FROM equipment
WHERE type LIKE '%Armadura%'
ORDER BY armor_class;
```

### Buscar por tipo específico:
```sql
SELECT name, cost_text, cost_currency, description
FROM equipment
WHERE type = 'Instrumento Musical'
ORDER BY name;
```

### Listar itens de um personagem:
```sql
SELECT i.name, i.quantity, i.weight, i.value, i.equipped
FROM items i
WHERE i.character_id = 'uuid-do-personagem'
ORDER BY i.equipped DESC, i.name;
```

### Calcular peso total do inventário:
```sql
SELECT 
  SUM(weight * quantity) as peso_total
FROM items
WHERE character_id = 'uuid-do-personagem';
```

### Calcular valor total do inventário:
```sql
SELECT 
  SUM(value * quantity) as valor_total
FROM items
WHERE character_id = 'uuid-do-personagem';
```

---

## 📊 Estatísticas dos Itens Existentes

### Por Tipo (60 itens no exemplo):
- **Arma Simples:** ~10 itens
- **Arma Marcial:** ~2 itens
- **Armadura Leve:** ~2 itens
- **Item de Aventura:** ~25 itens
- **Instrumento Musical:** ~10 itens
- **Ferramenta:** ~3 itens
- **Foco em conjuração:** ~4 itens
- **Outro:** ~4 itens

---

## ⚠️ Notas Importantes

### 1. **Diferença entre `items` e `equipment`:**
- `equipment`: Catálogo geral (biblioteca de itens)
- `items`: Inventário do personagem (instâncias)

### 2. **Campos Duplicados:**
- `cost` (numérico) e `cost_text` (texto)
- `weight` (numérico) e `weight_text` (texto)
- Use os campos numéricos para cálculos
- Use os campos texto para exibição

### 3. **Moedas:**
- Sempre especifique `cost_currency`
- Conversão: 1 PO = 10 PP = 100 PC

### 4. **Peso:**
- Sempre em **libras**, não quilos
- 1 libra ≈ 0,45 kg
- NULL ou vazio = sem peso significativo

### 5. **PHB 2024 vs PHB 2014:**
- PHB 2024 tem **Maestrias de Armas**
- PHB 2024 tem propriedades atualizadas
- Sempre especifique a `source`

---

## 🚀 Como Executar

### 📦 No Supabase (Recomendado):

**📖 Consulte o guia completo:** [`GUIA_SUPABASE.md`](./GUIA_SUPABASE.md)

**Resumo rápido:**
1. **Acesse o SQL Editor** no painel do Supabase
2. **Copie e cole** o conteúdo dos arquivos na ordem:
   - `insert_equipment_phb2024_parte1.sql` (~80 itens)
   - `insert_equipment_phb2024_parte2.sql` (~50 itens)
   - `insert_equipment_phb2024_parte3.sql` (~50 itens)
   - `insert_equipment_phb2024_parte4.sql` (~50 itens)
3. **Execute** cada script separadamente (RUN)
4. **Verifique** os resultados com as queries de verificação

⚠️ **Importante:** Execute os scripts **na ordem** para evitar problemas de dependências.

### 💻 Via psql Local:

### Inserir Todos os Equipamentos:
```sql
-- Inserção completa (~320 itens)
\i database/Itens/insert_all_equipment_phb2024.sql
```

### 🧹 Limpeza de Duplicados:
Se você executou os scripts múltiplas vezes e tem itens duplicados:

**No Supabase (SQL Editor):**
```sql
-- Copie e cole o conteúdo de cleanup_duplicates_supabase.sql
-- no SQL Editor do Supabase e execute
```

**Via psql local:**
```sql
\i database/Itens/cleanup_duplicates.sql
```

### 🔍 Verificar Duplicados Manualmente:
```sql
-- Listar todos os duplicados
SELECT 
  name,
  type,
  COUNT(*) as duplicatas
FROM equipment 
WHERE source = 'PHB 2024'
GROUP BY name, type
HAVING COUNT(*) > 1
ORDER BY duplicatas DESC;

-- Ver detalhes dos duplicados
SELECT 
  name,
  type,
  cost,
  created_at,
  id
FROM equipment 
WHERE source = 'PHB 2024'
  AND (name, type) IN (
    SELECT name, type
    FROM equipment 
    WHERE source = 'PHB 2024'
    GROUP BY name, type
    HAVING COUNT(*) > 1
  )
ORDER BY name, type, created_at DESC;
```

Este script mestre executa automaticamente:
- **Parte 1:** Itens de Aventura, Ferramentas, Instrumentos e Focos (~40 itens)
- **Parte 2:** Armas, Armaduras, Munições, Comida/Bebida, Montarias e Veículos (~25 itens)

### Executar Partes Individuais:
```sql
-- Apenas Parte 1
\i database/Itens/insert_equipment_phb2024_parte1.sql

-- Apenas Parte 2
\i database/Itens/insert_equipment_phb2024_parte2.sql
```

### Verificar Inserção:
```sql
SELECT type, COUNT(*) as quantidade
FROM equipment
WHERE source = 'PHB 2024'
GROUP BY type
ORDER BY type;
```

---

## 📖 Referências

- **Tabela Items:** `public.items`
- **Tabela Equipment:** `public.equipment`
- **Screen:** `lib/screens/rules/edit/edit_item_screen.dart`
- **Foreign Key:** `items.character_id` → `characters.id`
- **Triggers:** 
  - `update_items_updated_at`
  - `update_equipment_updated_at`

---

**Status:** ✅ Sistema completo com scripts de inserção em massa
**Itens Disponíveis:** 
- 60 itens exemplo já no banco
- ~65 itens adicionais nos scripts de inserção
- **Total: ~125 equipamentos do PHB 2024**
