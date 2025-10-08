# Sistema de Talentos (Feats) - D&D 5e PHB 2024

## 📋 Estrutura de Arquivos

### Arquivos Criados:
1. **`Template_Talento.sql`** - Template para criar novos talentos
2. **`insert_iniciado_em_magia.sql`** - Talento Iniciado em Magia (repetível)
3. **`insert_talentos_origem.sql`** - 15 talentos de Origem (nível 1)
4. **`insert_talentos_gerais.sql`** - 39 talentos Gerais (nível 4+)
5. **`insert_talentos_estilo_luta.sql`** - 11 talentos de Estilo de Luta
6. **`insert_talentos_dadiva_epica.sql`** - 12 talentos de Dádiva Épica (nível 19+)
7. **`insert_all_feats.sql`** - Script para executar todos de uma vez
8. **`README_TALENTOS.md`** - Este arquivo de documentação

## 🎯 Categorias de Talentos

### 1. **Talentos de Origem** (Origin Feats)
- **Pré-requisito:** Nenhum (adquiridos no nível 1)
- **Quantidade:** 15 talentos
- **Lista Completa:**
  1. ✅ Alerta
  2. ✅ Curador
  3. ✅ Sortudo
  4. ✅ Iniciado em Magia (arquivo separado, repetível)
  5. ✅ Músico
  6. ✅ Resistente
  7. ✅ Duro
  8. ✅ Observador
  9. ✅ Mestre de Habilidade
  10. ✅ Telepata
  11. ✅ Qualificado (repetível)
  12. ✅ Atacante Selvagem
  13. ✅ Tavern Brawler
  14. ✅ Telecinético
  15. ✅ Difícil

### 2. **Talentos Gerais** (General Feats)
- **Pré-requisito:** Nível 4+ (alguns exigem atributo 13+)
- **Quantidade:** 39 talentos
- **Lista Completa:**
  1. ✅ Adepto Elemental (repetível)
  2. ✅ Ator
  3. ✅ Assassino
  4. ✅ Atirador de Elite
  5. ✅ Atirador de Feitiços
  6. ✅ Atleta
  7. ✅ Atento
  8. ✅ Carregador
  9. ✅ Chefe de Cozinha
  10. ✅ Combatente Montado
  11. ✅ Conjurador de Guerra
  12. ✅ Conjurador de Rituais
  13. ✅ Duelista Defensivo
  14. ✅ Durável
  15. ✅ Envenenador
  16. ✅ Escondido
  17. ✅ Especialista em Besta
  18. ✅ Especialista em Habilidades
  19. ✅ Fortemente Blindado
  20. ✅ Grande Mestre de Armas
  21. ✅ Levemente Blindado
  22. ✅ Lutador
  23. ✅ Matador de Magos
  24. ✅ Mestre de Armadura Pesada
  25. ✅ Mestre de Armadura Média
  26. ✅ Mestre de Armas
  27. ✅ Mestre em Arma de Haste
  28. ✅ Moderadamente Blindado
  29. ✅ Perfurador
  30. ✅ Portador Duplo
  31. ✅ Rápido
  32. ✅ Resiliente
  33. ✅ Sentinela
  34. ✅ Telecinético
  35. ✅ Telepático
  36. ✅ Tocado pela Sombra
  37. ✅ Tocado por Fey
  38. ✅ Treinamento com Armas Marciais
  39. ✅ Triturador

### 3. **Talentos de Estilo de Luta** (Fighting Style Feats)
- **Pré-requisito:** Característica de Estilo de Luta
- **Quantidade:** 11 talentos
- **Lista Completa:**
  1. ✅ Tiro com arco
  2. ✅ Luta às Cegas
  3. ✅ Defesa
  4. ✅ Duelo
  5. ✅ Grande Luta com Armas
  6. ✅ Guerreiro Abençoado (Paladino)
  7. ✅ Guerreiro Druídico (Patrulheiro)
  8. ✅ Proteção
  9. ✅ Luta com Armas de Arremesso
  10. ✅ Luta com Duas Armas
  11. ✅ Luta Desarmada

### 4. **Talentos de Dádiva Épica** (Epic Boon Feats)
- **Pré-requisito:** Nível 19+
- **Quantidade:** 12 talentos
- **Lista Completa:**
  1. ✅ Dádiva da Proeza de Combate
  2. ✅ Dádiva da Viagem Dimensional
  3. ✅ Dádiva da Resistência à Energia
  4. ✅ Dádiva do Destino
  5. ✅ Dádiva da Fortitude
  6. ✅ Dádiva da Ofensa Irresistível
  7. ✅ Dádiva da Recuperação
  8. ✅ Dádiva da Habilidade
  9. ✅ Dádiva da Velocidade
  10. ✅ Dádiva de Recordação de Feitiços
  11. ✅ Dádiva do Espírito da Noite
  12. ✅ Dádiva da Verdadeira Visão

## 📊 Resumo de Talentos por Categoria

| Categoria | Quantidade | Pré-requisito |
|-----------|------------|---------------|
| **Origem** | 15 | Nenhum (nível 1) |
| **Geral** | 39 | Nível 4+ |
| **Estilo de Luta** | 11 | Característica de Estilo de Luta |
| **Dádiva Épica** | 12 | Nível 19+ |
| **TOTAL** | **77** | - |

## 📊 Estrutura da Tabela `feats`

```sql
CREATE TABLE public.feats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL UNIQUE,
  prerequisite VARCHAR(200) NULL,
  description TEXT NOT NULL,
  benefits JSONB NULL,              -- Obsoleto
  benefit TEXT NULL,                -- Obsoleto
  source VARCHAR(50) NULL,
  category VARCHAR(50) NULL,        -- Origem, Geral, Estilo de Luta, Dádiva Épica
  is_repeatable BOOLEAN DEFAULT false,
  abilities JSONB DEFAULT '[]'::jsonb,  -- USAR ESTE CAMPO
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);
```

## 🔧 Como Inserir Talentos

### Estrutura do `abilities` (JSONB):
```json
[
  {
    "name": "Nome do Benefício",
    "description": "Descrição detalhada do benefício..."
  },
  {
    "name": "Outro Benefício",
    "description": "Outra descrição..."
  }
]
```

### Exemplo de INSERT:
```sql
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
  'Nome do Talento',
  'Nível 4+, Força 13+',  -- ou NULL se não houver
  '',  -- Deixar vazio
  '',  -- Deixar vazio
  'PHB 2024',
  'Geral',  -- Origem, Geral, Estilo de Luta, Dádiva Épica
  false,  -- true se repetível
  '[
    {
      "name": "Benefício 1",
      "description": "Descrição..."
    }
  ]'::jsonb
);
```

## 📥 Como Executar os Scripts

### Opção 1: Executar todos de uma vez
```sql
\i database/Talentos/insert_all_feats.sql
```

### Opção 2: Executar individualmente
```sql
\i database/Talentos/insert_talentos_origem.sql
\i database/Talentos/insert_iniciado_em_magia.sql
\i database/Talentos/insert_talentos_gerais.sql
\i database/Talentos/insert_talentos_estilo_luta.sql
\i database/Talentos/insert_talentos_dadiva_epica.sql
```

## 🎮 Integração com o App

O arquivo `add_feat_screen.dart` está configurado para:
- ✅ Criar talentos com múltiplos benefícios (`abilities`)
- ✅ Suportar categorias (Origem, Geral, Estilo de Luta, Dádiva Épica)
- ✅ Marcar talentos como repetíveis
- ✅ Adicionar pré-requisitos
- ✅ Salvar no formato JSONB correto

## 🔍 Verificação

Para verificar os talentos inseridos:
```sql
-- Ver todos os talentos por categoria
SELECT name, category, prerequisite, is_repeatable
FROM feats
ORDER BY category, name;

-- Contar talentos por categoria
SELECT category, COUNT(*) as total
FROM feats
GROUP BY category
ORDER BY category;

-- Ver detalhes de um talento específico
SELECT name, abilities
FROM feats
WHERE name = 'Iniciado em Magia';

-- Ver talentos repetíveis
SELECT name, category, prerequisite
FROM feats
WHERE is_repeatable = true
ORDER BY category, name;
```

## 📚 Referências
- **Fonte:** Player's Handbook 2024 (PHB'24)
- **Páginas:** 200-211
- **SRD 5.2.1** e **Regras Básicas (2024)**

## ⚠️ Notas Importantes

1. **Campos Obsoletos:** `description`, `benefit`, `benefits` - Deixar vazios, usar `abilities`
2. **Campo Principal:** `abilities` (JSONB) - Array de objetos com `name` e `description`
3. **Categoria Obrigatória:** Para PHB 2024, sempre definir `category`
4. **Pré-requisitos:** Usar formato legível (ex: "Nível 4+, Força 13+")
5. **Repetíveis:** Marcar `is_repeatable = true` quando aplicável

## 🎯 Talentos Repetíveis

Estes talentos podem ser adquiridos múltiplas vezes com diferentes opções:
- **Iniciado em Magia** (Origem) - Escolher listas de magias diferentes (Clérigo, Druida, Mago)
- **Qualificado** (Origem) - Adquirir proficiências diferentes a cada vez
- **Adepto Elemental** (Geral) - Escolher tipos de dano diferentes (Ácido, Frio, Fogo, Relâmpago, Trovão)

## 📈 Estatísticas Detalhadas

### Talentos de Origem (15):
- Com aumento de habilidade: 5
- Sem aumento de habilidade: 10
- Repetíveis: 2 (Iniciado em Magia, Qualificado)

### Talentos Gerais (39):
- Com aumento de habilidade: 39 (todos)
- Relacionados a combate: 18
- Relacionados a magia: 8
- Relacionados a habilidades: 6
- Relacionados a armadura: 4
- Outros: 3

### Talentos de Estilo de Luta (11):
- Para combate corpo a corpo: 5
- Para combate à distância: 3
- Para conjuradores: 2
- Para proteção: 1

### Talentos de Dádiva Épica (12):
- Todos concedem aumento de habilidade até 30
- Todos são de nível 19+

---

**Total de Talentos Implementados:** 77 talentos
**Status:** ✅ Pronto para uso no banco de dados

---

## 🎉 Conclusão

Este sistema completo de talentos cobre todas as opções do PHB 2024, organizadas por categoria e prontas para serem inseridas no banco de dados. Todos os talentos seguem o mesmo padrão de estrutura JSONB, facilitando a manutenção e expansão futura do sistema.