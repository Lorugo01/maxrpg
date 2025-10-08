-- ============================================================
-- SCRIPT MESTRE - MAGIAS DE 0º A 3º CÍRCULO
-- ============================================================
-- Este script executa todos os scripts de inserção de magias
-- do PHB 2024, do nível 0 (Truques) ao nível 3.
-- 
-- Total de magias: 193 (32 truques + 52 nível 1 + 50 nível 2 + 49 nível 3)
-- ============================================================

-- ============================================================
-- TRUQUES (Nível 0) - 32 magias
-- ============================================================
\i database/Magias/insert_cantrips_phb2024.sql

-- ============================================================
-- 1º CÍRCULO - 52 magias
-- ============================================================
\i database/Magias/insert_level1_spells_phb2024.sql
\i database/Magias/insert_level1_spells_phb2024_part2.sql

-- ============================================================
-- 2º CÍRCULO - 50 magias
-- ============================================================
\i database/Magias/insert_level2_spells_phb2024.sql
\i database/Magias/insert_level2_spells_phb2024_part2.sql
\i database/Magias/insert_level2_spells_phb2024_part3.sql

-- ============================================================
-- 3º CÍRCULO - 49 magias
-- ============================================================
\i database/Magias/insert_level3_spells_phb2024.sql
\i database/Magias/insert_level3_spells_phb2024_part2.sql
\i database/Magias/insert_level3_spells_phb2024_part3.sql

-- ============================================================
-- VERIFICAÇÃO FINAL COMPLETA
-- ============================================================

-- Contagem total por nível
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3
GROUP BY level
ORDER BY level;

-- Contagem por escola de magia
SELECT 
  school as escola,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3
GROUP BY school
ORDER BY quantidade DESC;

-- Contagem total
SELECT 
  'TOTAL DE MAGIAS PHB 2024 (0º-3º)' as status,
  COUNT(*) as total
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3;

-- ============================================================
-- ESTATÍSTICAS ADICIONAIS
-- ============================================================

-- Magias por tipo de efeito
SELECT 
  effect_type as tipo_efeito,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3
  AND effect_type IS NOT NULL
GROUP BY effect_type
ORDER BY quantidade DESC;

-- Magias de concentração
SELECT 
  'Magias de Concentração' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3
  AND concentration = true;

-- Magias rituais
SELECT 
  'Magias Rituais' as tipo,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 3
  AND ritual = true;

-- ============================================================
-- FIM DO SCRIPT MESTRE
-- ============================================================
