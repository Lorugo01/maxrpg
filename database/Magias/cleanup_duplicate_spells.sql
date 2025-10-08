-- ============================================================
-- SCRIPT DE LIMPEZA - REMOVER MAGIAS DUPLICADAS
-- ============================================================
-- Versão para Supabase
-- Este script remove magias duplicadas, mantendo apenas
-- o registro mais recente de cada magia
-- ============================================================

-- Verificar duplicados antes da limpeza
SELECT 
  'Magias duplicadas encontradas:' as status;

SELECT 
  name,
  source,
  COUNT(*) as duplicatas
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY name, source
HAVING COUNT(*) > 1
ORDER BY duplicatas DESC;

-- Remover duplicados (mantém apenas o mais recente)
-- Usando CTE para identificar registros a manter
WITH spells_to_keep AS (
  SELECT DISTINCT ON (name, source)
    id
  FROM spells
  WHERE source = 'PHB 2024'
  ORDER BY name, source, created_at DESC
),
duplicates_to_delete AS (
  SELECT id
  FROM spells
  WHERE source = 'PHB 2024'
    AND id NOT IN (SELECT id FROM spells_to_keep)
)
DELETE FROM spells
WHERE id IN (SELECT id FROM duplicates_to_delete);

-- Verificar resultado
SELECT 
  'Verificando se ainda há duplicados:' as status;

SELECT 
  name,
  source,
  COUNT(*) as duplicatas
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY name, source
HAVING COUNT(*) > 1
ORDER BY duplicatas DESC;

-- Estatísticas finais por nível
SELECT 
  'Estatísticas após limpeza (por nível):' as status;

SELECT 
  level,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY level
ORDER BY level;

-- Estatísticas finais por escola
SELECT 
  'Estatísticas após limpeza (por escola):' as status;

SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total
SELECT 
  'Total de magias únicas:' as status,
  COUNT(*) as total_magias 
FROM spells 
WHERE source = 'PHB 2024';

SELECT 'LIMPEZA CONCLUÍDA COM SUCESSO!' as status;
