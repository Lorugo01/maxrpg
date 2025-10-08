# Sistema de Raças (Races) - D&D 5e

## 📋 Estrutura de Arquivos

### Arquivos:
1. **`Template_Raca.sql`** - Template para criar novas raças
2. **`Humano.sql`** - Exemplo de raça implementada (PHB 2024)
3. **`Anão.sql`** - Exemplo de raça implementada (PHB 2024)
4. **`README_RACAS.md`** - Este arquivo de documentação

## 🎯 Estrutura da Tabela `races`

### Campos Principais:
| Campo | Tipo | Descrição | Obrigatório |
|-------|------|-----------|-------------|
| `id` | UUID | Identificador único | ❌ (auto) |
| `name` | VARCHAR(50) | Nome da raça | ✅ Sim |
| `description` | TEXT | Descrição da raça | ❌ Não |
| `size` | TEXT | Tamanho da raça | ✅ Sim |
| `speed` | INTEGER | Velocidade em pés | ✅ Sim |
| `source` | VARCHAR | Fonte (PHB 2014, PHB 2024, etc.) | ✅ Sim |
| `languages` | VARCHAR(100) | Idiomas | ❌ Não |
| `traits` | JSONB | Traços raciais estruturados | ❌ Não |
| `traits_text` | TEXT | Traços em texto (compatibilidade) | ❌ Não |
| `racial_spells` | TEXT | Magias raciais | ❌ Não |
| `subraces` | VARCHAR | Subraças disponíveis | ❌ Não |

### Campos PHB 2014 (Compatibilidade):
| Campo | Tipo | Descrição |
|-------|------|-----------|
| `ability_score_increases` | JSONB | Aumentos de atributo estruturados |
| `ability_score_increase` | VARCHAR | Aumentos de atributo em texto |

---

## 📊 Estrutura JSONB: `traits`

### Estrutura Completa de um Traço:

```json
{
  "name": "Nome do Traço",
  "description": "Descrição detalhada do traço",
  "has_usage_limit": false,
  "usage_type": null,
  "usage_value": null,
  "usage_recovery": null,
  "usage_attribute": null,
  "has_dice_increase": false,
  "initial_dice": null,
  "dice_increases": [],
  "has_hit_point_increase": false,
  "hit_point_increase_per_level": null,
  "has_additional_features": false,
  "additional_feature_name": null,
  "additional_feature_description": null
}
```

### Tipos de Traços:

#### 1. **Traço Simples** (sem limites)
```json
{
  "name": "Visão no Escuro",
  "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
  "has_usage_limit": false,
  "has_dice_increase": false,
  "has_hit_point_increase": false
}
```

#### 2. **Traço com Limite de Usos**
```json
{
  "name": "Conhecimento de Pedras",
  "usage_type": "Por Proficiência",
  "description": "Você pode usar esta habilidade um número de vezes igual ao seu Bônus de Proficiência.",
  "usage_value": null,
  "usage_recovery": "Descanso Longo",
  "has_usage_limit": true,
  "usage_attribute": null,
  "has_dice_increase": false,
  "has_hit_point_increase": false
}
```

#### 3. **Traço com Aumento de PV**
```json
{
  "name": "Resistência dos Anões",
  "description": "Seus Pontos de Vida máximos aumentam em 1, e aumentam em 1 novamente sempre que você sobe de nível.",
  "has_usage_limit": false,
  "has_dice_increase": false,
  "has_hit_point_increase": true,
  "hit_point_increase_per_level": 1
}
```

#### 4. **Traço com Dados que Aumentam**
```json
{
  "name": "Ataque Desarmado",
  "description": "Seu ataque desarmado causa 1d6 de dano.",
  "has_usage_limit": false,
  "has_dice_increase": true,
  "initial_dice": "1d6",
  "dice_increases": [
    {"level": 5, "dice": "1d8"},
    {"level": 11, "dice": "1d10"},
    {"level": 17, "dice": "1d12"}
  ],
  "has_hit_point_increase": false
}
```

---

## 🔧 Tipos de `usage_type`

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| `Por Nível` | Usos = Nível do personagem | 1 uso por nível |
| `Manual por Nível` | Usos definidos manualmente | Nv1: 2 usos, Nv5: 3 usos |
| `Por Modificador de Atributo` | Usos = Modificador do atributo | Modificador de Constituição |
| `Por Proficiência` | Usos = Bônus de Proficiência | Igual ao bônus de proficiência |
| `Fixo` | Número fixo de usos | 3 usos |
| `Por Longo Descanso` | Recupera após descanso longo | 2 usos por descanso longo |
| `Por Curto Descanso` | Recupera após descanso curto | 1 uso por descanso curto |

---

## 📏 Tamanhos e Velocidades

### Tamanhos Comuns:
- **Pequeno:** 60cm a 1,2m (Gnomo, Halfling)
- **Médio:** 1,2m a 2,4m (Humano, Elfo, Anão)
- **Grande:** 2,4m a 4,8m (Goliath, Centauro)

### Velocidades Comuns:
- **25 pés:** Raças pequenas ou lentas (Anão, Gnomo, Halfling)
- **30 pés:** Velocidade padrão (Humano, Elfo, Meio-Elfo)
- **35 pés:** Raças rápidas (Elfo da Floresta, Tabaxi)
- **40 pés:** Raças muito rápidas (Centauro)

---

## 🔄 PHB 2024 vs PHB 2014

### PHB 2024:
- ❌ **NÃO** tem aumentos de atributo na raça
- ✅ Aumentos de atributo vêm da **ORIGEM**
- ✅ Foco em traços raciais únicos
- ✅ Mais flexibilidade na criação de personagens

### PHB 2014:
- ✅ **TEM** aumentos de atributo fixos na raça
- ✅ Exemplo: Anão (+2 Constituição)
- ✅ Subraças podem adicionar mais aumentos
- ✅ Sistema mais tradicional

---

## 📝 Como Inserir uma Nova Raça

### Passo 1: Definir Informações Básicas

```sql
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages"
) VALUES (
  'Nome da Raça',
  'Descrição...',
  'Médio',
  30,
  'PHB 2024',
  'Comum, Idioma Racial'
);
```

### Passo 2: Adicionar Traços Raciais

```sql
-- Dentro do INSERT, adicionar:
"traits" = '[
  {
    "name": "Traço 1",
    "description": "Descrição do traço 1",
    "has_usage_limit": false,
    "has_dice_increase": false,
    "has_hit_point_increase": false
  },
  {
    "name": "Traço 2",
    "description": "Descrição do traço 2",
    "has_usage_limit": true,
    "usage_type": "Por Proficiência",
    "usage_recovery": "Descanso Longo"
  }
]'::jsonb
```

### Passo 3: Adicionar traits_text (Compatibilidade)

```sql
"traits_text" = 'Traço 1: Descrição do traço 1
Traço 2: Descrição do traço 2'
```

---

## 📚 Exemplos Implementados

### 1. Humano (PHB 2024)

**Características:**
- **Tamanho:** Médio ou Pequeno (escolha do jogador)
- **Velocidade:** 30 pés
- **Traços:**
  - Engenhoso (ganha Inspiração Heroica após descanso longo)
  - Habilidoso (proficiência em 1 perícia)
  - Versátil (ganha 1 talento de Origem)

**Sem aumentos de atributo** (vêm da origem)

### 2. Anão (PHB 2024)

**Características:**
- **Tamanho:** Médio (1,2m a 1,5m)
- **Velocidade:** 30 pés
- **Traços:**
  - Visão no Escuro (36 metros)
  - Resiliência Anã (resistência a veneno)
  - Resistência dos Anões (+1 PV por nível)
  - Conhecimento de Pedras (Sismiconsciência, usos por proficiência)

**Sem aumentos de atributo** (vêm da origem)

---

## 🔍 Consultas Úteis

### Listar todas as raças:
```sql
SELECT name, size, speed, source
FROM races
ORDER BY source, name;
```

### Buscar raça específica:
```sql
SELECT *
FROM races
WHERE name = 'Humano';
```

### Listar raças por fonte:
```sql
SELECT name, size, speed
FROM races
WHERE source = 'PHB 2024'
ORDER BY name;
```

### Contar traços de uma raça:
```sql
SELECT 
  name,
  jsonb_array_length(traits) as total_tracos
FROM races
WHERE name = 'Anão';
```

### Listar raças com aumento de PV:
```sql
SELECT 
  r.name,
  t->>'name' as trait_name,
  (t->>'hit_point_increase_per_level')::int as hp_per_level
FROM races r,
  jsonb_array_elements(r.traits) as t
WHERE (t->>'has_hit_point_increase')::boolean = true
ORDER BY r.name;
```

---

## ⚠️ Notas Importantes

### 1. **Diferença PHB 2024 vs 2014:**
- PHB 2024: Aumentos de atributo vêm da **origem**
- PHB 2014: Aumentos de atributo vêm da **raça**

### 2. **Traços JSONB:**
- Use `::jsonb` ao final do array JSON
- Sempre valide o JSON antes de inserir
- Campos booleanos devem ser `true` ou `false` (minúsculas)

### 3. **Compatibilidade:**
- `traits` (JSONB): Sistema completo e estruturado
- `traits_text` (TEXT): Compatibilidade com telas antigas

### 4. **Limites de Uso:**
- Sempre defina `usage_recovery` quando `has_usage_limit = true`
- `usage_value` pode ser `null` para tipos como "Por Proficiência"

### 5. **Velocidade:**
- Sempre em **pés**, não em metros
- 1 metro ≈ 3,3 pés
- 30 pés ≈ 9 metros

---

## 🎨 Raças do PHB 2024

### Raças Implementadas:
1. ✅ **Humano** - Engenhoso, Habilidoso, Versátil
2. ✅ **Anão** - Visão no Escuro, Resiliência, +1 PV/nível
3. ✅ **Elfo** - Linhagem Élfica (Drow/Alto/Floresta), Transe
4. ✅ **Halfling** - Corajoso, Sorte, Naturalmente Furtivo
5. ✅ **Draconato** - Ancestralidade Dracônica, Sopro, Voo
6. ✅ **Gnomo** - Astúcia Gnômica, Linhagem (Floresta/Pedra)
7. ✅ **Tiefling** - Legado Demoníaco, Presença Sobrenatural
8. ✅ **Orc** - Adrenalina, Resistência Implacável
9. ✅ **Goliath** - Ancestralidade Gigante, Forma Grande
10. ✅ **Aasimar** - Resistência Celestial, Mãos Curativas, Revelação Celestial

### Raças Adicionais (Outras Fontes):
- ⏳ **Meio-Elfo** - Pendente
- ⏳ **Meio-Orc** - Pendente

---

## 🚀 Como Executar

### Inserir Todas as Raças:
```sql
\i database/Raças/insert_all_races_phb2024.sql
```

Este script insere 7 raças (Humano e Anão já existem):
- Aasimar
- Draconato
- Elfo
- Gnomo
- Goliath
- Halfling
- Orc
- Tiefling

### Verificar Inserção:
```sql
SELECT name, size, speed, source
FROM races
WHERE source = 'PHB 2024'
ORDER BY name;
```

---

## 📖 Referências

- **Tabela:** `public.races`
- **Screen:** `lib/screens/rules/add/add_race_screen.dart`
- **Exemplos:** `Humano.sql`, `Anão.sql`
- **Template:** `Template_Raca.sql`
- **Trigger:** `update_races_updated_at` (atualiza `updated_at` automaticamente)

---

**Status:** ✅ Sistema completo com todas as raças principais do PHB 2024
**Raças Implementadas:** 10 de 10 raças do PHB 2024 (100%) 🎉
