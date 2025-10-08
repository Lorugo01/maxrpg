# Sistema de Origens (Backgrounds) - D&D 5e

## 📋 Estrutura de Arquivos

### Arquivos:
1. **`Template_Origem.sql`** - Template para criar novas origens
2. **`Acolito.sql`** - Exemplo de origem implementada (PHB 2024)
3. **`README_ORIGENS.md`** - Este arquivo de documentação

## 🎯 Estrutura da Tabela `backgrounds`

### Campos Principais:
- **`id`** (UUID) - Identificador único (gerado automaticamente)
- **`name`** (VARCHAR 50) - Nome da origem
- **`description`** (TEXT) - Descrição da origem
- **`source`** (VARCHAR) - Fonte (PHB 2014, PHB 2024, SRD, Homebrew, Outros)

### Campos PHB 2024:
| Campo | Tipo | Descrição | Obrigatório |
|-------|------|-----------|-------------|
| `ability_scores` | TEXT | 3 atributos separados por vírgula | ✅ Sim |
| `feat` | TEXT | Nome do talento | ✅ Sim |
| `feat_id` | UUID | ID do talento (FK para feats) | ✅ Sim |
| `skill_proficiencies_2024` | TEXT | 2 perícias separadas por vírgula | ✅ Sim |
| `tool_proficiency` | TEXT | Proficiência com ferramentas | ✅ Sim |
| `equipment_choice_a_items` | JSONB | Array de itens da escolha A | ❌ Não |
| `equipment_choice_b_items` | JSONB | Array de itens da escolha B | ❌ Não |
| `equipment_choice_a_po` | INTEGER | PO da escolha A | ❌ Não |
| `equipment_choice_b_po` | INTEGER | PO da escolha B | ❌ Não |
| `equipment_choices` | JSONB | Escolhas de equipamento | ❌ Não |

### Campos PHB 2014 (Compatibilidade):
| Campo | Tipo | Descrição |
|-------|------|-----------|
| `skill_proficiencies_2014` | VARCHAR(100) | Proficiências em perícias |
| `tool_proficiencies` | VARCHAR(100) | Proficiências com ferramentas |
| `languages` | VARCHAR(100) | Idiomas |
| `equipment_2014` | VARCHAR(500) | Equipamento (texto) |
| `equipment_2014_items` | JSONB | Array de itens PHB 2014 |
| `equipment_2014_po` | INTEGER | PO PHB 2014 |
| `features_2014` | JSONB | Características especiais |

### Campos Opcionais (Ambas Versões):
- `personality_traits` (TEXT) - Traços de personalidade
- `ideals` (TEXT) - Ideais
- `bonds` (TEXT) - Vínculos
- `flaws` (TEXT) - Defeitos
- `feature` (TEXT) - Característica especial

## 📊 Estruturas JSONB

### 1. `equipment_choice_a_items` / `equipment_choice_b_items`
Array de objetos representando itens de equipamento:

```json
[
  {
    "name": "Suprimentos para calígrafo",
    "category": "Ferramentas de Artesão",
    "cost": "10.0",
    "weight": "5.0",
    "quantity": 1
  },
  {
    "name": "Livro",
    "category": "Equipamento Geral",
    "cost": "25.0",
    "weight": "5.0",
    "quantity": 2
  }
]
```

**Campos:**
- `name` (string) - Nome do item
- `category` (string) - Categoria do item
- `cost` (string) - Custo em PO
- `weight` (string ou null) - Peso em libras
- `quantity` (integer) - Quantidade

### 2. `equipment_choices`
Array de objetos representando escolhas de equipamento:

```json
[
  {
    "description": "1 Símbolo Sagrado",
    "options": [
      {
        "name": "Relicário",
        "category": "Símbolo Sagrado",
        "cost": "5.0",
        "weight": "2.0"
      },
      {
        "name": "Emblema",
        "category": "Símbolo Sagrado",
        "cost": "5.0",
        "weight": null
      },
      {
        "name": "Amuleto",
        "category": "Símbolo Sagrado",
        "cost": "5.0",
        "weight": "1.0"
      }
    ]
  }
]
```

**Campos:**
- `description` (string) - Descrição da escolha (ex: "1 instrumento musical à sua escolha")
- `options` (array) - Array de objetos com as opções disponíveis
  - `name` (string) - Nome da opção
  - `category` (string) - Categoria da opção
  - `cost` (string) - Custo em PO
  - `weight` (string ou null) - Peso em libras

## 🔧 Como Inserir uma Nova Origem

### Passo 1: Buscar o UUID do Talento

```sql
SELECT id, name, category 
FROM feats 
WHERE name = 'Iniciado em Magia';
```

### Passo 2: Preparar os Dados

**PHB 2024 - Campos Obrigatórios:**
- ✅ Nome da origem
- ✅ Descrição
- ✅ 3 atributos (ability_scores)
- ✅ Nome do talento (feat)
- ✅ UUID do talento (feat_id)
- ✅ 2 perícias (skill_proficiencies_2024)
- ✅ 1 ferramenta (tool_proficiency)

**PHB 2024 - Campos Opcionais:**
- Itens da escolha A (equipment_choice_a_items)
- Itens da escolha B (equipment_choice_b_items)
- PO da escolha A (equipment_choice_a_po)
- PO da escolha B (equipment_choice_b_po)
- Escolhas de equipamento (equipment_choices)

### Passo 3: Criar o INSERT

```sql
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Acólito',
  'Você se dedicou ao serviço em um templo...',
  'PHB 2024',
  'Inteligência, Sabedoria, Carisma',
  'Iniciado em Magia (Clerigo)',
  '86c0fd17-9012-4f81-abec-303738d8d7af',
  'Intuição, Religião',
  'Suprimentos de Calígrafo',
  '[...]'::jsonb,  -- Array de itens
  '[]'::jsonb,     -- Array vazio ou com itens
  8,               -- PO
  50,              -- PO
  '[...]'::jsonb   -- Escolhas
);
```

## 📝 Exemplo Completo: Acólito (PHB 2024)

```sql
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Acólito',
  'Você se dedicou ao serviço em um templo, localizado em uma aldeia ou em um bosque sagrado, onde realizava ritos em homenagem a um deus ou panteão. Sob a orientação de um sacerdote, você estudou religião e, graças à sua devoção, aprendeu a canalizar um pouco do poder divino para o seu local de culto e para as pessoas que ali oravam.',
  'PHB 2024',
  'Inteligência, Sabedoria, Carisma',
  'Iniciado em Magia (Clerigo)',
  '86c0fd17-9012-4f81-abec-303738d8d7af',
  'Intuição, Religião',
  'Suprimentos de Calígrafo',
  '[
    {
      "name": "Suprimentos para calígrafo",
      "category": "",
      "cost": "10.0",
      "weight": "5.0",
      "quantity": 1
    },
    {
      "name": "Símbolo Sagrado",
      "category": "",
      "cost": "0.0",
      "weight": null,
      "quantity": 1
    },
    {
      "name": "Pergaminho",
      "category": "",
      "cost": "1.0",
      "weight": null,
      "quantity": 1
    },
    {
      "name": "Manto",
      "category": "",
      "cost": "1.0",
      "weight": "4.0",
      "quantity": 1
    },
    {
      "name": "Livro",
      "category": "",
      "cost": "25.0",
      "weight": "5.0",
      "quantity": 2
    }
  ]'::jsonb,
  '[]'::jsonb,
  8,
  50,
  '[
    {
      "description": "1 Símbolo Sagrado",
      "options": [
        {
          "name": "Relicário",
          "category": "",
          "cost": "5.0",
          "weight": "2.0"
        },
        {
          "name": "Emblema",
          "category": "",
          "cost": "5.0",
          "weight": null
        },
        {
          "name": "Amuleto",
          "category": "",
          "cost": "5.0",
          "weight": "1.0"
        }
      ]
    }
  ]'::jsonb
);
```

## 🔍 Consultas Úteis

### Listar todas as origens:
```sql
SELECT name, source, ability_scores, feat
FROM backgrounds
ORDER BY source, name;
```

### Buscar origem específica:
```sql
SELECT *
FROM backgrounds
WHERE name = 'Acólito';
```

### Listar origens por fonte:
```sql
SELECT name, feat, skill_proficiencies_2024
FROM backgrounds
WHERE source = 'PHB 2024'
ORDER BY name;
```

### Verificar talentos disponíveis:
```sql
SELECT id, name, category, prerequisite
FROM feats
WHERE category = 'Origem'
ORDER BY name;
```

### Contar origens por fonte:
```sql
SELECT source, COUNT(*) as total
FROM backgrounds
GROUP BY source
ORDER BY source;
```

## ⚠️ Notas Importantes

1. **UUID do Talento:**
   - Sempre busque o UUID correto do talento antes de inserir
   - Use: `SELECT id, name FROM feats WHERE name = 'Nome do Talento';`

2. **Atributos (PHB 2024):**
   - SEMPRE 3 atributos separados por vírgula
   - Exemplo: `"Inteligência, Sabedoria, Carisma"`

3. **Perícias (PHB 2024):**
   - SEMPRE 2 perícias separadas por vírgula
   - Exemplo: `"Intuição, Religião"`

4. **JSONB:**
   - Use `'[]'::jsonb` para arrays vazios
   - Use aspas duplas dentro do JSON
   - Sempre termine com `::jsonb` para cast correto

5. **Equipamento:**
   - `equipment_choice_a` e `equipment_choice_b` são duas opções diferentes
   - Cada uma pode ter seus próprios itens e PO
   - `equipment_choices` são escolhas adicionais (ex: "1 instrumento musical à sua escolha")

6. **Compatibilidade:**
   - PHB 2014 usa campos diferentes (skill_proficiencies_2014, equipment_2014, etc.)
   - Não misture campos de PHB 2014 e PHB 2024 na mesma origem

## 📚 Referências

- **Tabela:** `public.backgrounds`
- **Foreign Key:** `feat_id` → `feats.id`
- **Trigger:** `update_backgrounds_updated_at` (atualiza `updated_at` automaticamente)
- **Screen:** `lib/screens/rules/add/add_background_screen.dart`

## 🎉 Próximos Passos

1. Use o `Template_Origem.sql` como base
2. Busque o UUID do talento desejado
3. Preencha todos os campos obrigatórios
4. Adicione itens de equipamento conforme necessário
5. Execute o INSERT no banco de dados
6. Verifique se a origem aparece corretamente no app

## 📦 Inserção em Massa

Para inserir todas as 16 origens do PHB 2024 de uma vez:

```bash
# No Supabase SQL Editor ou psql
\i database/Origens/insert_all_backgrounds_phb2024.sql
```

**Origens Incluídas no Script:**
1. ✅ Acólito (Acolyte)
2. ✅ Artesão (Artisan)
3. ✅ Criminal (Criminal)
4. ✅ Artista (Entertainer)
5. ✅ Agricultor (Farmer)
6. ✅ Guarda (Guard)
7. ✅ Guia (Guide)
8. ✅ Eremita (Hermit)
9. ✅ Comerciante (Merchant)
10. ✅ Nobre (Noble)
11. ✅ Sábio (Sage)
12. ✅ Marinheiro (Sailor)
13. ✅ Escriba (Scribe)
14. ✅ Soldado (Soldier)
15. ✅ Viajante (Wayfarer)

**Talentos Necessários:**
- Alerta (Alert)
- Artesão (Artisan)
- Atacante Selvagem (Savage Attacker)
- Curador (Healer)
- Duro (Tough)
- Iniciado em Magia (Magic Initiate)
- Músico (Musician)
- Qualificado (Skilled)
- Sortudo (Lucky)
- Tavern Brawler

⚠️ **IMPORTANTE:** Execute primeiro o script de talentos (`database/Talentos/insert_all_feats.sql`) antes de executar este script!

---

**Status:** ✅ Sistema pronto para receber novas origens
**Origens Implementadas:** 16 origens do PHB 2024 (incluindo Acólito)
