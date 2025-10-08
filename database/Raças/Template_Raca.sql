-- ============================================================
-- TEMPLATE PARA INSERÇÃO DE RAÇAS - D&D 5e PHB 2024
-- ============================================================
-- Baseado na tabela races.sql e add_race_screen.dart
-- ============================================================

-- ESTRUTURA DA TABELA races:
-- id: UUID (gerado automaticamente se não fornecido)
-- name: VARCHAR(50) - Nome da raça
-- description: TEXT - Descrição da raça
-- size: TEXT - Tamanho (Pequeno, Médio, Grande)
-- speed: INTEGER - Velocidade em pés
-- source: VARCHAR - Fonte (PHB 2014, PHB 2024, SRD, Homebrew, Outros)

-- CAMPOS PRINCIPAIS:
-- ability_score_increases: JSONB - Aumentos de atributo (PHB 2014)
-- ability_score_increase: VARCHAR - Descrição dos aumentos (PHB 2014)
-- traits: JSONB - Array de traços raciais estruturados
-- traits_text: TEXT - Texto dos traços (compatibilidade)
-- languages: VARCHAR(100) - Idiomas que a raça conhece
-- subraces: VARCHAR - Subraças disponíveis
-- racial_spells: TEXT - Magias raciais
-- created_at: TIMESTAMP (gerado automaticamente)
-- updated_at: TIMESTAMP (gerado automaticamente)

-- ============================================================
-- ESTRUTURA DE TRAITS (JSONB)
-- ============================================================
-- Cada traço pode ter:
-- - name: Nome do traço
-- - description: Descrição do traço
-- - has_usage_limit: Boolean - Se tem limite de usos
-- - usage_type: String - Tipo de limite (Por Nível, Por Proficiência, etc.)
-- - usage_value: Integer - Valor do limite
-- - usage_recovery: String - Como recupera os usos
-- - usage_attribute: String - Atributo usado (se aplicável)
-- - has_dice_increase: Boolean - Se os dados aumentam
-- - initial_dice: String - Dado inicial (ex: 1d6)
-- - dice_increases: Array - Aumentos de dados por nível
-- - has_hit_point_increase: Boolean - Se aumenta PV
-- - hit_point_increase_per_level: Integer - PV por nível
-- - has_additional_features: Boolean - Se tem funcionalidades extras
-- - additional_feature_name: String - Nome da funcionalidade
-- - additional_feature_description: String - Descrição da funcionalidade

-- ============================================================
-- EXEMPLO DE INSERT (PHB 2024)
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells",
  "subraces"
) VALUES (
  'Nome da Raça',
  'Descrição detalhada da raça, sua origem, cultura e características...',
  'Médio (cerca de 1,5 a 2 m de altura)',
  30,
  'PHB 2024',
  'Comum, Idioma Racial',
  '[
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Resistência Racial",
      "description": "Você tem Resistência a dano de Veneno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Habilidade Especial",
      "usage_type": "Por Proficiência",
      "description": "Você pode usar esta habilidade um número de vezes igual ao seu Bônus de Proficiência.",
      "usage_value": null,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Aumento de PV",
      "description": "Seus Pontos de Vida máximos aumentam em 1, e aumentam em 1 novamente sempre que você sobe de nível.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": true,
      "hit_point_increase_per_level": 1
    }
  ]'::jsonb,
  'Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Resistência Racial: Você tem Resistência a dano de Veneno.
Habilidade Especial: Você pode usar esta habilidade um número de vezes igual ao seu Bônus de Proficiência.
Aumento de PV: Seus Pontos de Vida máximos aumentam em 1, e aumentam em 1 novamente sempre que você sobe de nível.',
  '',
  ''
);

-- ============================================================
-- EXEMPLO DE INSERT (PHB 2014)
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "ability_score_increase",
  "languages",
  "traits",
  "traits_text",
  "racial_spells",
  "subraces"
) VALUES (
  'Nome da Raça',
  'Descrição detalhada da raça...',
  'Médio',
  30,
  'PHB 2014',
  '+2 Força, +1 Constituição',
  'Comum, Anão',
  '[
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.',
  '',
  'Anão da Colina, Anão da Montanha'
);

-- ============================================================
-- TIPOS DE USAGE_TYPE DISPONÍVEIS
-- ============================================================
-- 'Por Nível' - Usos baseados no nível do personagem
-- 'Manual por Nível' - Usos definidos manualmente por nível
-- 'Por Modificador de Atributo' - Usos baseados no modificador de um atributo
-- 'Por Proficiência' - Usos baseados no bônus de proficiência
-- 'Fixo' - Número fixo de usos
-- 'Por Longo Descanso' - Recupera após descanso longo
-- 'Por Curto Descanso' - Recupera após descanso curto

-- ============================================================
-- ATRIBUTOS DISPONÍVEIS
-- ============================================================
-- 'Força', 'Destreza', 'Constituição', 'Inteligência', 'Sabedoria', 'Carisma'

-- ============================================================
-- TAMANHOS DISPONÍVEIS
-- ============================================================
-- 'Pequeno' - Cerca de 60cm a 1,2m
-- 'Médio' - Cerca de 1,2m a 2,4m
-- 'Grande' - Cerca de 2,4m a 4,8m

-- ============================================================
-- VELOCIDADES COMUNS
-- ============================================================
-- 25 pés - Raças pequenas ou lentas (Anão, Gnomo, Halfling)
-- 30 pés - Velocidade padrão (Humano, Elfo, etc.)
-- 35 pés - Raças rápidas (Elfo da Floresta, Tabaxi)
-- 40 pés - Raças muito rápidas (Centauro)

-- ============================================================
-- NOTAS IMPORTANTES
-- ============================================================
-- 1. PHB 2024 vs PHB 2014:
--    - PHB 2024: Aumentos de atributo vêm da ORIGEM, não da raça
--    - PHB 2014: Aumentos de atributo são fixos na raça

-- 2. Traços JSONB vs traits_text:
--    - traits (JSONB): Estrutura completa com limites de uso
--    - traits_text (TEXT): Compatibilidade com telas antigas

-- 3. Campos obrigatórios:
--    - name, size, speed, source

-- 4. Campos opcionais:
--    - description, languages, subraces, racial_spells
--    - ability_score_increase (apenas PHB 2014)

-- 5. O campo 'id' pode ser omitido para gerar automaticamente

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
-- Verificar se a raça foi inserida corretamente
SELECT 
  id,
  name,
  size,
  speed,
  source,
  jsonb_array_length(traits) as total_traits
FROM races
WHERE name = 'Nome da Raça';
