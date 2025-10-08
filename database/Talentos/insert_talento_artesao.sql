-- ============================================================
-- TALENTO: ARTESÃO (CRAFTER) - PHB 2024
-- ============================================================
-- Talento de Origem necessário para a origem "Artesão"
-- Categoria: Origem
-- Fonte: Player's Handbook 2024, página 202
-- ============================================================

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
  'Você é treinado na criação de itens úteis. Você aprendeu a trabalhar com ferramentas de artesão e pode criar objetos práticos e funcionais.',
  'Você ganha proficiência com ferramentas de artesão, desconto em compras e pode criar itens durante descansos longos.',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Proficiência em Ferramentas",
      "description": "Você ganha proficiência com três Ferramentas de Artesão à sua escolha. Exemplos incluem: Ferramentas de Alquimista, Ferramentas de Cervejeiro, Suprimentos de Calígrafo, Ferramentas de Carpinteiro, Ferramentas de Cartógrafo, Ferramentas de Sapateiro, Utensílios de Cozinheiro, Ferramentas de Vidreiro, Ferramentas de Joalheiro, Ferramentas de Coureiro, Ferramentas de Pedreiro, Ferramentas de Pintor, Ferramentas de Oleiro, Ferramentas de Ferreiro, Ferramentas de Funileiro, Ferramentas de Tecelão, ou Ferramentas de Entalhador."
    },
    {
      "name": "Desconto",
      "description": "Sempre que você compra um item não mágico, você recebe um desconto de 20% no preço normal do item. Isso representa sua habilidade de avaliar materiais e negociar preços justos."
    },
    {
      "name": "Criação Rápida",
      "description": "Quando você termina um Descanso Longo, você pode criar um item não mágico que vale 50 PO ou menos, desde que você tenha proficiência com as ferramentas necessárias para criar o item e tenha acesso a elas. O item dura até você terminar outro Descanso Longo, a menos que você gaste uma quantidade de PO igual ao valor do item para torná-lo permanente. Você pode ter apenas um item temporário criado por este benefício por vez."
    }
  ]'::jsonb
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
-- Verificar se o talento foi inserido corretamente
SELECT 
  id,
  name,
  category,
  source,
  is_repeatable,
  jsonb_array_length(abilities) as total_abilities
FROM feats
WHERE name = 'Artesão';

-- ============================================================
-- NOTAS DE IMPLEMENTAÇÃO
-- ============================================================
-- 1. Este talento é usado pela origem "Artesão" (Artisan)
-- 2. Permite escolher 3 ferramentas de artesão
-- 3. Fornece desconto de 20% em compras de itens não mágicos
-- 4. Permite criar itens temporários durante descansos longos
-- 5. Itens criados podem se tornar permanentes gastando PO
-- ============================================================
