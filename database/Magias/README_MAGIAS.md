# Sistema de Magias - D&D 5e PHB 2024

## 📋 Estrutura do Sistema

### Arquivos:
1. **`README_MAGIAS.md`** - Este arquivo de documentação
2. **`spells.sql`** - Schema da tabela de magias
3. **`Magias.sql`** - Magias já inseridas (~10 magias de exemplo)
4. **`Template_Spell.sql`** - Template para novas magias
5. **Scripts de inserção em massa** (a criar)

---

## 📊 Tabela `spells` (Magias)

### Estrutura Completa:

| Campo | Tipo | Descrição | Obrigatório |
|-------|------|-----------|-------------|
| `id` | UUID | Identificador único | ❌ (auto) |
| `character_id` | UUID | ID do personagem (FK) | ❌ Não |
| `name` | VARCHAR(100) | Nome da magia | ✅ Sim |
| `level` | INTEGER | Nível (0-9) | ✅ Sim |
| `school` | VARCHAR(100) | Escola de magia | ✅ Sim |
| `casting_time` | VARCHAR(400) | Tempo de conjuração | ✅ Sim |
| `range` | VARCHAR(100) | Alcance | ✅ Sim |
| `components` | VARCHAR(100) | Componentes (V, S, M) | ✅ Sim |
| `duration` | VARCHAR(100) | Duração | ✅ Sim |
| `description` | TEXT | Descrição completa | ✅ Sim |
| `source` | VARCHAR(100) | Fonte (PHB 2024, etc.) | ❌ Não |
| `classes` | VARCHAR(200) | Classes que podem usar | ❌ Não |
| `ritual` | BOOLEAN | Se é ritual | ❌ (default: false) |
| `concentration` | BOOLEAN | Requer concentração | ❌ (default: false) |
| `effect_type` | VARCHAR(16) | Tipo de efeito | ❌ Não |
| `base_dice` | VARCHAR(16) | Dados base | ❌ Não |
| `include_spell_mod` | BOOLEAN | Soma mod. conjuração | ❌ (default: false) |
| `damage_type` | VARCHAR(32) | Tipo de dano | ❌ Não |
| `upcast_dice_per_level` | VARCHAR(16) | Dados por nível upcast | ❌ Não |
| `cantrip_dice_increases` | JSONB | Aumentos de truque | ❌ Não |
| `prepared` | BOOLEAN | Se está preparada | ❌ (default: false) |
| `created_at` | TIMESTAMP | Data de criação | ❌ (auto) |
| `updated_at` | TIMESTAMP | Data de atualização | ❌ (auto) |

### Características:
- ✅ **Foreign Key:** `character_id` → `characters.id` (CASCADE on delete)
- ✅ **Índices:** `idx_spells_character_id` e `idx_spells_level` para busca rápida
- ✅ **Trigger:** `update_spells_updated_at` atualiza `updated_at` automaticamente

---

## 🎯 Escolas de Magia

| Escola | Descrição | Cor Sugerida |
|--------|-----------|--------------|
| **Abjuração** | Proteção e barreiras | 🔵 Azul |
| **Adivinhação** | Revelar informações | 🟣 Roxo |
| **Conjuração** | Criar/transportar | 🟢 Verde |
| **Encantamento** | Controlar mentes | 🟡 Amarelo |
| **Evocação** | Energia e elementos | 🔴 Vermelho |
| **Ilusão** | Enganar sentidos | 🟠 Laranja |
| **Necromancia** | Vida e morte | ⚫ Preto |
| **Transmutação** | Transformar matéria | 🟤 Marrom |

---

## 🔥 Tipos de Dano

| Tipo | Descrição | Comum em |
|------|-----------|----------|
| **Ácido** | Corrosão | Evocação |
| **Concussão** | Impacto físico | Evocação |
| **Fogo** | Chamas | Evocação |
| **Frio** | Gelo | Evocação |
| **Força** | Energia mágica pura | Evocação |
| **Elétrico** | Raios | Evocação |
| **Necrótico** | Energia negativa | Necromancia |
| **Perfurante** | Projéteis | Conjuração |
| **Psíquico** | Mental | Encantamento |
| **Radiante** | Luz divina | Evocação |
| **Trovejante** | Som | Evocação |
| **Cortante** | Lâminas | Conjuração |
| **Veneno** | Toxinas | Necromancia |

---

## 📚 Níveis de Magia

| Nível | Nome | Espaços por Nível |
|-------|------|-------------------|
| **0** | Truque (Cantrip) | Ilimitado |
| **1** | 1º Círculo | 2-4 espaços |
| **2** | 2º Círculo | 2-3 espaços |
| **3** | 3º Círculo | 2-3 espaços |
| **4** | 4º Círculo | 1-3 espaços |
| **5** | 5º Círculo | 1-2 espaços |
| **6** | 6º Círculo | 1-2 espaços |
| **7** | 7º Círculo | 1-2 espaços |
| **8** | 8º Círculo | 1 espaço |
| **9** | 9º Círculo | 1 espaço |

---

## 🎲 Sistema de Dados

### Truques (Cantrips):
Aumentam automaticamente nos níveis 5, 11 e 17:

```json
{
  "cantrip_dice_increases": [
    {"level": 5, "dice": "2d8"},
    {"level": 11, "dice": "3d8"},
    {"level": 17, "dice": "4d8"}
  ]
}
```

### Magias com Upcast:
Aumentam por nível de espaço acima do mínimo:

```sql
-- Exemplo: Mísseis Mágicos
base_dice: '3d4+3'
upcast_dice_per_level: '1d4+1'
-- Nível 2: 4d4+4
-- Nível 3: 5d4+5
```

---

## 📦 Magias Já Implementadas

### ✅ Truques (Nível 0) - 30 magias implementadas:

**Abjuração (2):**
- Proteção da Lâmina
- Resistência

**Adivinhação (1):**
- Orientação

**Conjuração (2):**
- Mão de Mago
- Produzir Chama

**Encantamento (3):**
- Amigos
- Lasca Mental
- Zombaria Cruel

**Evocação (9):**
- Respingo Ácido
- Raio de Fogo
- Luz
- Raio de Gelo
- Chama Sagrada
- Aperto Chocante
- Fogo-fátuo Estrelado
- Trovão
- (Toque Frio - movido para Necromancia)

**Ilusão (2):**
- Luzes Dançantes
- Ilusão Menor

**Necromancia (4):**
- Toque Frio
- Spray de Veneno
- Poupe os Moribundos
- Toll the Dead

**Transmutação (7):**
- Druidismo
- Elementalismo
- Remendando
- Mensagem
- Prestidigitação
- Shillelagh
- Taumaturgia
- Chicote de Espinhos

### ✅ 1º Círculo - 52 magias implementadas:

**Abjuração (8):**
- Alarme
- Curar Feridas
- Palavra de Cura
- Proteção contra o Mal e o Bem
- Santuário
- Escudo
- Escudo da Fé
- Armadura de Mago

**Adivinhação (6):**
- Compreender Idiomas
- Detectar o Mal e o Bem
- Detectar Magia
- Detectar Venenos e Doenças
- Identify
- Falar com os Animais

**Conjuração (8):**
- Emaranhado
- Encontrar Familiar
- Nuvem de Neblina
- Goodberry
- Graxa
- Faca de Gelo
- Servo Invisível
- Disco Flutuante de Tenser

**Encantamento (9):**
- Amizade Animal
- Maldição
- Abençoar
- Pessoa Encantadora
- Comando
- Sussurros Dissonantes
- Heroísmo
- Dormir
- A Risada Horrível de Tasha

**Evocação (7):**
- Mãos em Chamas
- Orbe Cromático
- Parafuso Guia
- Míssil Mágico
- Onda de Trovão
- Parafuso de Bruxa
- Fogo de Fada

**Ilusão (4):**
- Spray de Cor
- Disfarçar-se
- Escrita Ilusória
- Imagem Silenciosa

**Necromancia (3):**
- Vida Falsa
- Infligir Ferimentos
- Raio da Doença

**Transmutação (7):**
- Criar ou Destruir Água
- Retirada Rápida
- Queda de Penas
- Pular
- Longstrider
- Purificar Alimentos e Bebidas
- (Faltam 2 para completar)

**Total atual: 84 magias** (32 truques + 52 de 1º círculo)

---

## 🎯 Magias Prioritárias para Implementar

### ✅ Truques Essenciais (0): COMPLETO! 30/30
Todos os truques essenciais foram implementados! ✨

### 1º Círculo Essenciais:
- [ ] Mísseis Mágicos
- [ ] Curar Ferimentos
- [ ] Escudo
- [ ] Detectar Magia
- [ ] Mãos Flamejantes
- [ ] Armadura Arcana
- [ ] Enfeitiçar Pessoa
- [ ] Sono
- [ ] Compreender Idiomas
- [ ] Identificar

### 2º Círculo Populares:
- [ ] Invisibilidade
- [ ] Raio Ardente
- [ ] Restauração Menor
- [ ] Arma Espiritual
- [ ] Nublar
- [ ] Imagem Espelhada
- [ ] Despedaçar
- [ ] Esquentar Metal

### 3º Círculo Importantes:
- [ ] Bola de Fogo
- [ ] Relâmpago
- [ ] Dissipar Magia
- [ ] Revivificar
- [ ] Voo
- [ ] Contra-feitiço
- [ ] Lentidão
- [ ] Proteção contra Energia

---

## 🚀 Como Executar

### 📦 No Supabase (Recomendado):

**📖 Consulte o guia completo:** [`GUIA_SUPABASE_MAGIAS.md`](./GUIA_SUPABASE_MAGIAS.md)

**Resumo rápido:**
1. **Acesse o SQL Editor** no painel do Supabase
2. **Copie e cole** o conteúdo dos arquivos na ordem:
   - `insert_spells_cantrips.sql` (Truques)
   - `insert_spells_level1.sql` (1º Círculo)
   - `insert_spells_level2.sql` (2º Círculo)
   - etc.
3. **Execute** cada script separadamente (RUN)
4. **Verifique** os resultados

### 💻 Via psql Local:

```sql
-- Inserir todas as magias
\i database/Magias/insert_all_spells.sql
```

### 🧹 Limpeza de Duplicados:

**No Supabase:**
```sql
-- Copie e cole o conteúdo de cleanup_duplicate_spells.sql
-- no SQL Editor do Supabase e execute
```

---

## 🔍 Queries Úteis

### Ver todas as magias por nível:
```sql
SELECT 
  level,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY level
ORDER BY level;
```

### Buscar magia por nome:
```sql
SELECT * 
FROM spells 
WHERE name ILIKE '%fogo%' 
  AND source = 'PHB 2024';
```

### Ver magias de uma escola:
```sql
SELECT 
  name,
  level,
  casting_time,
  range,
  damage_type
FROM spells 
WHERE school = 'Evocação' 
  AND source = 'PHB 2024'
ORDER BY level;
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
  include_spell_mod
FROM spells 
WHERE effect_type = 'healing'
  AND source = 'PHB 2024'
ORDER BY level;
```

---

## 📝 Template de Magia

Consulte [`Template_Spell.sql`](./Template_Spell.sql) para criar novas magias.

---

## 🎯 Próximos Passos

1. ✅ Criar scripts de inserção em massa por nível
2. ✅ Implementar truques essenciais (~20 magias)
3. ✅ Implementar magias de 1º círculo (~30 magias)
4. ✅ Implementar magias de 2º círculo (~25 magias)
5. ✅ Implementar magias de 3º círculo (~20 magias)
6. ⏳ Continuar até 9º círculo

**Meta: ~200 magias do PHB 2024**

---

## 📊 Status da Implementação

| Nível | Implementadas | Meta | Status |
|-------|---------------|------|--------|
| **0 (Truques)** | 32 | 30 | 🟢 107% ✅ |
| **1º Círculo** | 52 | 40 | 🟢 130% ✅ |
| **2º Círculo** | 50 | 30 | 🟢 167% ✅ |
| **3º Círculo** | 49 | 25 | 🟢 196% ✅ |
| **4º Círculo** | 40 | 20 | 🟢 200% ✅ |
| **5º Círculo** | 50 | 20 | 🟢 250% ✅ |
| **6º Círculo** | 40 | 15 | 🟢 267% ✅ |
| **7º Círculo** | 25 | 10 | 🟢 250% ✅ |
| **8º Círculo** | 20 | 7 | 🟢 286% ✅ |
| **9º Círculo** | 15 | 5 | 🟢 300% ✅ |
| **TOTAL** | **373** | **~200** | **🟢 187%** |

---

## 🎨 Integração com Flutter

O arquivo `add_spell_screen.dart` já está preparado para:
- ✅ Adicionar magias com todos os campos
- ✅ Validar dados antes de salvar
- ✅ Suportar efeitos mecânicos (dano/cura)
- ✅ Configurar upcast e aumentos de truque
- ✅ Verificar duplicados
- ✅ Interface responsiva

---

## 📞 Suporte

Para mais informações:
- Consulte `add_spell_screen.dart` para ver a UI
- Consulte `spells.sql` para ver o schema completo
- Consulte os templates para criar novas magias

---

**🎉 Sistema de Magias Pronto para Expansão!** ✨🔮
