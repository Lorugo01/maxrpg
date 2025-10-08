-- Script auxiliar para buscar UUIDs de talentos para usar nas origens
-- Execute este script para encontrar o UUID do talento que deseja usar

-- ============================================================
-- BUSCAR TALENTO ESPECÍFICO
-- ============================================================
-- Substitua 'Nome do Talento' pelo nome que você procura
SELECT 
  id as feat_id,
  name as feat_name,
  category,
  prerequisite,
  source
FROM feats
WHERE name ILIKE '%Iniciado em Magia%'  -- Use % para busca parcial
ORDER BY name;

-- ============================================================
-- LISTAR TODOS OS TALENTOS DE ORIGEM (para PHB 2024)
-- ============================================================
SELECT 
  id as feat_id,
  name as feat_name,
  prerequisite,
  is_repeatable,
  source
FROM feats
WHERE category = 'Origem'
ORDER BY name;

-- ============================================================
-- LISTAR TALENTOS POR CATEGORIA
-- ============================================================
SELECT 
  category,
  COUNT(*) as total_talentos
FROM feats
GROUP BY category
ORDER BY category;

-- ============================================================
-- BUSCAR TALENTOS POR FONTE
-- ============================================================
SELECT 
  id as feat_id,
  name as feat_name,
  category,
  source
FROM feats
WHERE source = 'PHB 2024'
ORDER BY category, name;

-- ============================================================
-- TALENTOS REPETÍVEIS (útil para origens)
-- ============================================================
SELECT 
  id as feat_id,
  name as feat_name,
  category,
  prerequisite
FROM feats
WHERE is_repeatable = true
ORDER BY name;

-- ============================================================
-- BUSCAR TALENTO PARA COPIAR UUID
-- ============================================================
-- Execute esta query e copie o UUID do talento desejado
SELECT 
  id,
  name,
  category
FROM feats
WHERE name = 'Iniciado em Magia'  -- Substitua pelo nome exato
LIMIT 1;

-- ============================================================
-- VERIFICAR SE TALENTO EXISTE
-- ============================================================
SELECT 
  CASE 
    WHEN COUNT(*) > 0 THEN 'Talento encontrado!'
    ELSE 'Talento NÃO encontrado'
  END as status,
  COUNT(*) as quantidade
FROM feats
WHERE name = 'Iniciado em Magia';  -- Substitua pelo nome exato

-- ============================================================
-- TALENTOS MAIS USADOS EM ORIGENS
-- ============================================================
SELECT 
  f.name as feat_name,
  f.category,
  COUNT(b.id) as vezes_usado,
  STRING_AGG(b.name, ', ') as origens
FROM feats f
LEFT JOIN backgrounds b ON b.feat_id = f.id
WHERE f.category = 'Origem'
GROUP BY f.id, f.name, f.category
ORDER BY vezes_usado DESC, f.name;

-- ============================================================
-- FORMATO PARA COPIAR E COLAR NO INSERT
-- ============================================================
-- Execute esta query e copie o resultado para usar no INSERT
SELECT 
  CONCAT(
    'feat: ''', name, ''',',
    E'\n',
    'feat_id: ''', id, ''''
  ) as insert_format
FROM feats
WHERE name = 'Iniciado em Magia';  -- Substitua pelo nome exato
