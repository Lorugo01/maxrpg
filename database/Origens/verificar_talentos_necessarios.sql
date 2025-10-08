-- ============================================================
-- VERIFICAÇÃO DE TALENTOS NECESSÁRIOS PARA AS ORIGENS
-- ============================================================
-- Execute este script ANTES de inserir as origens para garantir
-- que todos os talentos necessários estão cadastrados
-- ============================================================

-- Lista de talentos necessários para as 16 origens do PHB 2024
WITH talentos_necessarios AS (
  SELECT unnest(ARRAY[
    'Alerta',
    'Artesão',
    'Atacante Selvagem',
    'Curador',
    'Duro',
    'Iniciado em Magia',
    'Músico',
    'Qualificado',
    'Sortudo',
    'Tavern Brawler'
  ]) AS talento_nome
)
SELECT 
  tn.talento_nome AS "Talento Necessário",
  CASE 
    WHEN f.id IS NOT NULL THEN '✅ Encontrado'
    ELSE '❌ NÃO ENCONTRADO'
  END AS "Status",
  f.id AS "UUID",
  f.category AS "Categoria",
  f.source AS "Fonte"
FROM talentos_necessarios tn
LEFT JOIN feats f ON f.name ILIKE '%' || tn.talento_nome || '%'
ORDER BY 
  CASE WHEN f.id IS NOT NULL THEN 0 ELSE 1 END,
  tn.talento_nome;

-- ============================================================
-- RESUMO
-- ============================================================
WITH talentos_necessarios AS (
  SELECT unnest(ARRAY[
    'Alerta',
    'Artesão',
    'Atacante Selvagem',
    'Curador',
    'Duro',
    'Iniciado em Magia',
    'Músico',
    'Qualificado',
    'Sortudo',
    'Tavern Brawler'
  ]) AS talento_nome
)
SELECT 
  COUNT(*) AS "Total Necessário",
  COUNT(f.id) AS "Total Encontrado",
  COUNT(*) - COUNT(f.id) AS "Total Faltando",
  CASE 
    WHEN COUNT(*) = COUNT(f.id) THEN '✅ PRONTO PARA INSERIR ORIGENS'
    ELSE '❌ FALTAM TALENTOS - EXECUTE insert_all_feats.sql PRIMEIRO'
  END AS "Status Geral"
FROM talentos_necessarios tn
LEFT JOIN feats f ON f.name ILIKE '%' || tn.talento_nome || '%';

-- ============================================================
-- LISTA DE TALENTOS FALTANDO (se houver)
-- ============================================================
WITH talentos_necessarios AS (
  SELECT unnest(ARRAY[
    'Alerta',
    'Artesão',
    'Atacante Selvagem',
    'Curador',
    'Duro',
    'Iniciado em Magia',
    'Músico',
    'Qualificado',
    'Sortudo',
    'Tavern Brawler'
  ]) AS talento_nome
)
SELECT 
  tn.talento_nome AS "Talentos Faltando"
FROM talentos_necessarios tn
LEFT JOIN feats f ON f.name ILIKE '%' || tn.talento_nome || '%'
WHERE f.id IS NULL
ORDER BY tn.talento_nome;

-- ============================================================
-- MAPEAMENTO DE ORIGENS E TALENTOS
-- ============================================================
SELECT 
  'Acólito' AS origem,
  'Iniciado em Magia' AS talento_necessario
UNION ALL SELECT 'Artesão', 'Artesão'
UNION ALL SELECT 'Criminal', 'Alerta'
UNION ALL SELECT 'Artista', 'Músico'
UNION ALL SELECT 'Agricultor', 'Duro'
UNION ALL SELECT 'Guarda', 'Alerta'
UNION ALL SELECT 'Guia', 'Iniciado em Magia'
UNION ALL SELECT 'Eremita', 'Curador'
UNION ALL SELECT 'Comerciante', 'Sortudo'
UNION ALL SELECT 'Nobre', 'Qualificado'
UNION ALL SELECT 'Sábio', 'Iniciado em Magia'
UNION ALL SELECT 'Marinheiro', 'Tavern Brawler'
UNION ALL SELECT 'Escriba', 'Qualificado'
UNION ALL SELECT 'Soldado', 'Atacante Selvagem'
UNION ALL SELECT 'Viajante', 'Sortudo'
ORDER BY origem;
