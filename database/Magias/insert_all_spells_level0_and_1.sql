-- ============================================================
-- SCRIPT MESTRE - TRUQUES E 1º CÍRCULO
-- ============================================================
-- Este script insere todas as magias de nível 0 e 1 do PHB 2024
-- Execute no Supabase SQL Editor
-- ============================================================

-- ============================================================
-- PARTE 1: TRUQUES (NÍVEL 0) - 32 magias
-- ============================================================

\i database/Magias/insert_cantrips_phb2024.sql

-- ============================================================
-- PARTE 2: 1º CÍRCULO - 52 magias
-- ============================================================

\i database/Magias/insert_level1_spells_phb2024.sql
\i database/Magias/insert_level1_spells_phb2024_part2.sql

-- ============================================================
-- VERIFICAÇÃO FINAL COMPLETA
-- ============================================================

-- Total geral
SELECT 
  'RESUMO GERAL' as categoria,
  COUNT(*) as total_magias
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1);

-- Por nível
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques'
    WHEN level = 1 THEN '1º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
GROUP BY level
ORDER BY level;

-- Por escola (todos os níveis)
SELECT 
  school as escola,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
GROUP BY school
ORDER BY quantidade DESC;

-- Magias de dano
SELECT 
  'Magias de Dano' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
  AND effect_type = 'damage';

-- Magias de cura
SELECT 
  'Magias de Cura' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
  AND effect_type = 'healing';

-- Magias rituais
SELECT 
  'Magias Rituais' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
  AND ritual = true;

-- Magias de concentração
SELECT 
  'Magias de Concentração' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (0, 1)
  AND concentration = true;

SELECT '✅ INSERÇÃO COMPLETA! 84 magias adicionadas (32 truques + 52 de 1º círculo)' as status;

-- ============================================================
-- FIM DO SCRIPT MESTRE
-- ============================================================
