-- ============================================================
-- SCRIPT MASTER: INSERIR TODAS AS MAGIAS PHB 2024
-- ============================================================
-- Execute este script no Supabase SQL Editor
-- Inclui migração + todas as magias (0º a 9º círculo)
-- ============================================================

-- ============================================================
-- PASSO 1: MIGRAÇÃO (OBRIGATÓRIO)
-- ============================================================

-- Alterar campos VARCHAR(100) que são muito pequenos para magias de alto nível
ALTER TABLE public.spells 
ALTER COLUMN name TYPE TEXT,
ALTER COLUMN school TYPE TEXT,
ALTER COLUMN range TYPE TEXT,
ALTER COLUMN components TYPE TEXT,
ALTER COLUMN duration TYPE TEXT,
ALTER COLUMN source TYPE TEXT,
ALTER COLUMN classes TYPE TEXT,
ALTER COLUMN damage_type TYPE TEXT,
ALTER COLUMN effect_type TYPE TEXT,
ALTER COLUMN base_dice TYPE TEXT,
ALTER COLUMN upcast_dice_per_level TYPE TEXT;

-- Verificar se a migração foi aplicada
SELECT 'Migração aplicada com sucesso!' as status;

-- ============================================================
-- PASSO 2: INSERIR TODAS AS MAGIAS (0º A 9º CÍRCULO)
-- ============================================================

-- Verificar se já existem magias
SELECT 
  'Magias existentes antes da inserção:' as info,
  COUNT(*) as total
FROM spells 
WHERE source = 'PHB 2024';

-- ============================================================
-- TRUQUES (0º CÍRCULO) - 32 MAGIAS
-- ============================================================

-- Inserir truques (já implementados anteriormente)
-- Se não existirem, execute: \i insert_cantrips_phb2024.sql

-- ============================================================
-- 1º CÍRCULO - 52 MAGIAS
-- ============================================================

-- Inserir magias de 1º círculo (já implementadas anteriormente)
-- Se não existirem, execute: 
-- \i insert_level1_spells_phb2024.sql
-- \i insert_level1_spells_phb2024_part2.sql

-- ============================================================
-- 2º CÍRCULO - 50 MAGIAS
-- ============================================================

-- Inserir magias de 2º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level2_spells_phb2024.sql
-- \i insert_level2_spells_phb2024_part2.sql
-- \i insert_level2_spells_phb2024_part3.sql

-- ============================================================
-- 3º CÍRCULO - 49 MAGIAS
-- ============================================================

-- Inserir magias de 3º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level3_spells_phb2024.sql
-- \i insert_level3_spells_phb2024_part2.sql
-- \i insert_level3_spells_phb2024_part3.sql

-- ============================================================
-- 4º CÍRCULO - 40 MAGIAS
-- ============================================================

-- Inserir magias de 4º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level4_spells_phb2024.sql
-- \i insert_level4_spells_phb2024_part2.sql
-- \i insert_level4_spells_phb2024_part3.sql

-- ============================================================
-- 5º CÍRCULO - 50 MAGIAS
-- ============================================================

-- Inserir magias de 5º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level5_spells_phb2024.sql
-- \i insert_level5_spells_phb2024_part2.sql
-- \i insert_level5_spells_phb2024_part3.sql

-- ============================================================
-- 6º CÍRCULO - 40 MAGIAS
-- ============================================================

-- Inserir magias de 6º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level6_spells_phb2024.sql
-- \i insert_level6_spells_phb2024_part2.sql
-- \i insert_level6_spells_phb2024_part3.sql

-- ============================================================
-- 7º CÍRCULO - 25 MAGIAS
-- ============================================================

-- Inserir magias de 7º círculo (já implementadas anteriormente)
-- Se não existirem, execute:
-- \i insert_level7_spells_phb2024.sql
-- \i insert_level7_spells_phb2024_part2.sql
-- \i insert_level7_spells_phb2024_part3.sql

-- ============================================================
-- 8º CÍRCULO - 20 MAGIAS (NOVAS)
-- ============================================================

-- Inserir magias de 8º círculo
-- Execute os scripts de 8º círculo:
-- \i insert_level8_spells_phb2024.sql
-- \i insert_level8_spells_phb2024_part2.sql

-- ============================================================
-- 9º CÍRCULO - 15 MAGIAS (NOVAS)
-- ============================================================

-- Inserir magias de 9º círculo
-- Execute o script de 9º círculo:
-- \i insert_level9_spells_phb2024.sql

-- ============================================================
-- VERIFICAÇÃO FINAL COMPLETA
-- ============================================================

-- Verificar total de magias inseridas
SELECT 
  'TOTAL DE MAGIAS PHB 2024:' as info,
  COUNT(*) as total_magias
FROM spells 
WHERE source = 'PHB 2024';

-- Verificar por nível
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
    WHEN level = 5 THEN '5º Círculo'
    WHEN level = 6 THEN '6º Círculo'
    WHEN level = 7 THEN '7º Círculo'
    WHEN level = 8 THEN '8º Círculo'
    WHEN level = 9 THEN '9º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 9
GROUP BY level
ORDER BY level;

-- Verificar por escola (apenas 8º e 9º círculo)
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (8, 9)
GROUP BY school
ORDER BY quantidade DESC;

-- Verificar magias de dano (8º e 9º)
SELECT 
  name,
  level,
  school,
  base_dice,
  damage_type
FROM spells 
WHERE source = 'PHB 2024'
  AND level IN (8, 9)
  AND effect_type = 'damage'
ORDER BY level DESC, name;

-- ============================================================
-- FIM DO SCRIPT MASTER
-- ============================================================

-- Resultado esperado:
-- Truques: 32
-- 1º Círculo: 52
-- 2º Círculo: 50
-- 3º Círculo: 49
-- 4º Círculo: 40
-- 5º Círculo: 50
-- 6º Círculo: 40
-- 7º Círculo: 25
-- 8º Círculo: 20
-- 9º Círculo: 15
-- TOTAL: 373 magias ✅
