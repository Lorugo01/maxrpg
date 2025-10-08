# 🔮 Guia Rápido - Magias no Supabase

## 📋 Passo a Passo para Inserir Magias

### 1️⃣ **Acessar o SQL Editor**
1. Abra seu projeto no [Supabase Dashboard](https://app.supabase.com)
2. Clique em **SQL Editor** no menu lateral
3. Clique em **+ New query**

---

### 2️⃣ **Executar Migração (OBRIGATÓRIO)**

**IMPORTANTE:** Execute este script ANTES de inserir as magias para corrigir campos pequenos:

```sql
-- Migração: Alterar colunas da tabela spells
ALTER TABLE public.spells 
ALTER COLUMN name TYPE TEXT,
ALTER COLUMN school TYPE TEXT,
ALTER COLUMN range TYPE TEXT,
ALTER COLUMN components TYPE TEXT,
ALTER COLUMN duration TYPE TEXT,
ALTER COLUMN source TYPE TEXT,
ALTER COLUMN classes TYPE TEXT,
ALTER COLUMN damage_type TYPE TEXT,
ALTER COLUMN effect_type TYPE TEXT,
ALTER COLUMN base_dice TYPE TEXT,
ALTER COLUMN upcast_dice_per_level TYPE TEXT;
```

### 3️⃣ **Verificar Magias Existentes**

Antes de inserir, verifique quantas magias já existem:

```sql
-- Total de magias
SELECT COUNT(*) as total FROM spells WHERE source = 'PHB 2024';

-- Por nível
SELECT 
  level,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY level
ORDER BY level;
```

---

### 4️⃣ **Inserir Novas Magias**

Use o template `Template_Spell.sql` como base. Exemplo:

```sql
-- Exemplo: Raio de Fogo (Truque)
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Raio de Fogo',
  0,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você lança um raio de fogo em uma criatura ou objeto dentro do alcance...',
  'PHB 2024',
  false,
  false,
  'damage',
  '1d10',
  'Fogo',
  '[{"level": 5, "dice": "2d10"}, {"level": 11, "dice": "3d10"}, {"level": 17, "dice": "4d10"}]'::jsonb
);
```

---

### 4️⃣ **Verificar Duplicados**

Após inserir, verifique se há duplicados:

```sql
-- Listar duplicados
SELECT 
  name,
  source,
  COUNT(*) as duplicatas
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY name, source
HAVING COUNT(*) > 1
ORDER BY duplicatas DESC;
```

---

### 5️⃣ **Limpar Duplicados (Se Necessário)**

Se encontrou duplicados, execute o script de limpeza:

```
📁 Arquivo: cleanup_duplicate_spells.sql
```

Copie e cole o conteúdo completo no SQL Editor e execute.

---

## 🎯 Tipos de Magias

### 🔥 **Truque de Dano (Cantrip)**

```sql
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description", "source",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Nome do Truque',
  0,                       -- Truque = nível 0
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Descrição...',
  'PHB 2024',
  false,
  false,
  'damage',
  '1d10',                  -- Dano base
  'Fogo',
  '[{"level": 5, "dice": "2d10"}, {"level": 11, "dice": "3d10"}, {"level": 17, "dice": "4d10"}]'::jsonb
);
```

---

### ⚔️ **Magia de Dano com Upcast**

```sql
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description", "source",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Bola de Fogo',
  3,                       -- 3º Círculo
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (uma bolinha de guano de morcego e enxofre)',
  'Instantânea',
  'Descrição...',
  'PHB 2024',
  false,
  false,
  'damage',
  '8d6',                   -- Dano base
  'Fogo',
  '1d6'                    -- +1d6 por nível acima do 3º
);
```

---

### 💚 **Magia de Cura**

```sql
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description", "source",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Curar Ferimentos',
  1,
  'Evocação',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Descrição...',
  'PHB 2024',
  false,
  false,
  'healing',
  '1d8',                   -- Cura base
  true,                    -- Soma modificador de conjuração
  '1d8'                    -- +1d8 por nível
);
```

---

### 🛡️ **Magia de Utilidade**

```sql
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description", "source",
  "ritual", "concentration"
) VALUES (
  'Escudo',
  1,
  'Abjuração',
  'Reação',
  'Próprio',
  'V, S',
  '1 rodada',
  'Descrição...',
  'PHB 2024',
  false,
  false
  -- Sem effect_type, base_dice, etc.
);
```

---

## 🔍 Queries Úteis

### Ver todas as magias de uma escola:
```sql
SELECT 
  name,
  level,
  casting_time,
  range
FROM spells 
WHERE school = 'Evocação' 
  AND source = 'PHB 2024'
ORDER BY level, name;
```

### Ver truques com dano:
```sql
SELECT 
  name,
  base_dice,
  damage_type,
  cantrip_dice_increases
FROM spells 
WHERE level = 0 
  AND effect_type = 'damage'
  AND source = 'PHB 2024'
ORDER BY name;
```

### Ver magias de cura:
```sql
SELECT 
  name,
  level,
  base_dice,
  include_spell_mod,
  upcast_dice_per_level
FROM spells 
WHERE effect_type = 'healing'
  AND source = 'PHB 2024'
ORDER BY level;
```

### Ver magias de concentração:
```sql
SELECT 
  name,
  level,
  school,
  duration
FROM spells 
WHERE concentration = true
  AND source = 'PHB 2024'
ORDER BY level, name;
```

### Ver magias rituais:
```sql
SELECT 
  name,
  level,
  school,
  casting_time
FROM spells 
WHERE ritual = true
  AND source = 'PHB 2024'
ORDER BY level, name;
```

### Buscar magia por nome:
```sql
SELECT * 
FROM spells 
WHERE name ILIKE '%fogo%' 
  AND source = 'PHB 2024';
```

---

## ⚠️ Problemas Comuns

### ❌ Erro: "invalid input syntax for type json"
**Causa:** Formato incorreto do JSONB para `cantrip_dice_increases`.

**Solução:**
```sql
-- ✅ CORRETO
'[{"level": 5, "dice": "2d10"}]'::jsonb

-- ❌ ERRADO
'{"level": 5, "dice": "2d10"}'  -- Falta array []
```

### ❌ Erro: "duplicate key value violates unique constraint"
**Causa:** Já existe uma magia com o mesmo nome e fonte.

**Solução:**
1. Verifique se a magia já existe:
```sql
SELECT * FROM spells WHERE name = 'Nome da Magia' AND source = 'PHB 2024';
```
2. Se existir, delete ou use UPDATE ao invés de INSERT

### ❌ Erro: "null value in column violates not-null constraint"
**Causa:** Faltam campos obrigatórios.

**Solução:** Certifique-se de preencher:
- `name` ✅
- `level` ✅
- `school` ✅
- `casting_time` ✅
- `range` ✅
- `components` ✅
- `duration` ✅
- `description` ✅

---

## 📊 Estatísticas Esperadas

Após inserir as magias essenciais:

| Nível | Quantidade Mínima |
|-------|-------------------|
| **0 (Truques)** | ~30 magias |
| **1º Círculo** | ~40 magias |
| **2º Círculo** | ~30 magias |
| **3º Círculo** | ~25 magias |
| **4º Círculo** | ~20 magias |
| **5º Círculo** | ~20 magias |
| **6º Círculo** | ~15 magias |
| **7º Círculo** | ~10 magias |
| **8º Círculo** | ~7 magias |
| **9º Círculo** | ~5 magias |
| **TOTAL** | **~200 magias** |

---

## 🎯 Próximos Passos

Após inserir as magias:

1. ✅ Teste a busca de magias no app Flutter
2. ✅ Verifique se as magias aparecem na criação de personagem
3. ✅ Teste o sistema de preparação de magias
4. ✅ Verifique se os cálculos de dano estão corretos
5. ✅ Teste o upcast de magias

---

## 📞 Suporte

Se encontrar problemas:

1. Verifique os logs do Supabase (SQL Editor → History)
2. Confira se a estrutura da tabela está correta (`spells.sql`)
3. Execute as queries de verificação acima
4. Consulte o `README_MAGIAS.md` para mais detalhes
5. Use o `Template_Spell.sql` como referência

---

**🎉 Pronto! Seu banco Supabase está pronto para receber magias do PHB 2024!** ✨🔮
