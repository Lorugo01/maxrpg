-- Template para Inserção de Origens (Backgrounds) - D&D 5e PHB 2024
-- Baseado na tabela backgrounds.sql e add_background_screen.dart

-- ESTRUTURA DA TABELA backgrounds:
-- id: UUID (gerado automaticamente se não fornecido)
-- name: VARCHAR(50) - Nome da origem
-- description: TEXT - Descrição da origem
-- source: VARCHAR - Fonte (PHB 2014, PHB 2024, SRD, Homebrew, Outros)

-- CAMPOS PHB 2024:
-- ability_scores: TEXT - 3 atributos separados por vírgula (ex: "Inteligência, Sabedoria, Carisma")
-- feat: TEXT - Nome do talento
-- feat_id: UUID - ID do talento (foreign key para feats.id)
-- skill_proficiencies_2024: TEXT - 2 perícias separadas por vírgula
-- tool_proficiency: TEXT - Proficiência com ferramentas
-- equipment_choice_a_items: JSONB - Array de itens da escolha A
-- equipment_choice_b_items: JSONB - Array de itens da escolha B
-- equipment_choice_a_po: INTEGER - PO da escolha A
-- equipment_choice_b_po: INTEGER - PO da escolha B
-- equipment_choices: JSONB - Array de escolhas de equipamento

-- CAMPOS PHB 2014 (compatibilidade):
-- skill_proficiencies_2014: VARCHAR(100) - Proficiências em perícias
-- tool_proficiencies: VARCHAR(100) - Proficiências com ferramentas
-- languages: VARCHAR(100) - Idiomas
-- equipment_2014: VARCHAR(500) - Equipamento (texto)
-- equipment_2014_items: JSONB - Array de itens PHB 2014
-- equipment_2014_po: INTEGER - PO PHB 2014
-- features_2014: JSONB - Características especiais

-- CAMPOS OPCIONAIS (para ambas versões):
-- personality_traits: TEXT - Traços de personalidade
-- ideals: TEXT - Ideais
-- bonds: TEXT - Vínculos
-- flaws: TEXT - Defeitos
-- feature: TEXT - Característica especial
-- created_at: TIMESTAMP (gerado automaticamente)
-- updated_at: TIMESTAMP (gerado automaticamente)

-- EXEMPLO DE INSERT (PHB 2024):
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
  'Nome da Origem',
  'Descrição detalhada da origem...',
  'PHB 2024',
  'Inteligência, Sabedoria, Carisma',  -- 3 atributos
  'Nome do Talento',
  'uuid-do-talento-aqui',  -- Buscar o UUID do talento na tabela feats
  'Intuição, Religião',  -- 2 perícias
  'Suprimentos de Calígrafo',  -- Ferramenta
  '[
    {
      "name": "Item 1",
      "category": "Categoria",
      "cost": "10.0",
      "weight": "5.0",
      "quantity": 1
    },
    {
      "name": "Item 2",
      "category": "Categoria",
      "cost": "5.0",
      "weight": "2.0",
      "quantity": 2
    }
  ]'::jsonb,  -- Itens da escolha A
  '[]'::jsonb,  -- Itens da escolha B (vazio neste exemplo)
  8,  -- PO da escolha A
  50,  -- PO da escolha B
  '[
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
  ]'::jsonb  -- Escolhas de equipamento
);

-- EXEMPLO DE INSERT (PHB 2014):
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "skill_proficiencies_2014",
  "tool_proficiencies",
  "languages",
  "equipment_2014_items",
  "equipment_2014_po",
  "features_2014",
  "equipment_choices"
) VALUES (
  'Nome da Origem',
  'Descrição detalhada da origem...',
  'PHB 2014',
  'Escolha 2 entre Atletismo, Intimidação, Percepção',
  'Um tipo de kit de jogos',
  'Um idioma à sua escolha',
  '[
    {
      "name": "Item 1",
      "category": "Categoria",
      "cost": "10.0",
      "weight": "5.0",
      "quantity": 1
    }
  ]'::jsonb,
  15,  -- PO
  'Característica especial do antecedente...',
  '[
    {
      "description": "1 instrumento musical à sua escolha",
      "options": [
        {
          "name": "Flauta",
          "category": "Instrumento Musical",
          "cost": "2.0",
          "weight": "1.0"
        },
        {
          "name": "Lira",
          "category": "Instrumento Musical",
          "cost": "30.0",
          "weight": "2.0"
        }
      ]
    }
  ]'::jsonb
);

-- NOTAS IMPORTANTES:
-- 1. Para PHB 2024:
--    - ability_scores: SEMPRE 3 atributos
--    - skill_proficiencies_2024: SEMPRE 2 perícias
--    - feat e feat_id: Obrigatórios
--    - tool_proficiency: Obrigatório
--    - equipment_choice_a e equipment_choice_b: Duas escolhas de equipamento

-- 2. Para buscar o UUID de um talento:
--    SELECT id, name FROM feats WHERE name = 'Nome do Talento';

-- 3. Estrutura de equipment_choices:
--    - description: Texto descritivo da escolha (ex: "1 instrumento musical à sua escolha")
--    - options: Array de objetos com name, category, cost, weight

-- 4. Estrutura de equipment_*_items:
--    - name: Nome do item
--    - category: Categoria do item
--    - cost: Custo em PO (string)
--    - weight: Peso em libras (string ou null)
--    - quantity: Quantidade (integer)

-- 5. Os campos created_at e updated_at são preenchidos automaticamente

-- 6. O campo id pode ser omitido para gerar automaticamente, ou pode ser fornecido como UUID
