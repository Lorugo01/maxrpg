-- Template para Inserção de Talentos (Feats)
-- Baseado na tabela feats.sql e add_feat_screen.dart

-- Estrutura da tabela feats:
-- id: UUID (gerado automaticamente)
-- name: VARCHAR(100) - Nome do talento
-- prerequisite: VARCHAR(200) - Pré-requisitos (opcional)
-- description: TEXT - Descrição geral (pode ficar vazio se usar abilities)
-- benefits: JSONB - Benefícios antigos (obsoleto, use abilities)
-- benefit: TEXT - Benefício antigo (obsoleto, use abilities)
-- source: VARCHAR(50) - Fonte (PHB 2014, PHB 2024, SRD, Homebrew, Outros)
-- category: VARCHAR(50) - Categoria (Origem, Estilo de Luta, Dádiva Épica, Geral) - Obrigatório para PHB 2024
-- is_repeatable: BOOLEAN - Se pode ser adquirido múltiplas vezes
-- abilities: JSONB - Lista de benefícios do talento (USAR ESTE)
-- created_at: TIMESTAMP (gerado automaticamente)
-- updated_at: TIMESTAMP (gerado automaticamente)

-- EXEMPLO DE INSERT:
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
  'Pré-requisitos (ex: Nível 4, Força 13 ou superior)',
  '',  -- Deixar vazio, usar abilities
  '',  -- Deixar vazio, usar abilities
  'PHB 2024',  -- ou 'PHB 2014', 'SRD', 'Homebrew', 'Outros'
  'Geral',  -- ou 'Origem', 'Estilo de Luta', 'Dádiva Épica' (obrigatório para PHB 2024)
  false,  -- true se pode ser adquirido múltiplas vezes
  '[
    {
      "name": "Nome do Benefício 1",
      "description": "Descrição detalhada do benefício..."
    },
    {
      "name": "Nome do Benefício 2",
      "description": "Descrição detalhada do benefício..."
    }
  ]'::jsonb
);

-- NOTAS:
-- 1. O campo 'abilities' é um array JSONB com objetos contendo 'name' e 'description'
-- 2. Para PHB 2024, 'category' é obrigatório
-- 3. 'prerequisite' pode ser NULL se não houver pré-requisitos
-- 4. 'description' e 'benefit' são obsoletos, deixar vazios e usar 'abilities'
-- 5. Cada benefício em 'abilities' deve ter 'name' e 'description'
