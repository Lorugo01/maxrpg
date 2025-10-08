-- ============================================================
-- MIGRAÇÃO: ALTERAR COLUNAS DA TABELA SPELLS
-- ============================================================
-- Corrige campos VARCHAR(100) que são muito pequenos para magias de alto nível
-- Execute este script no Supabase SQL Editor ANTES de inserir as magias
-- ============================================================

-- Alterar campos que são muito pequenos
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

-- Verificar se as alterações foram aplicadas
SELECT 
  column_name,
  data_type,
  character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'spells' 
  AND table_schema = 'public'
  AND column_name IN ('name', 'school', 'range', 'components', 'duration', 'source', 'classes', 'damage_type', 'effect_type', 'base_dice', 'upcast_dice_per_level')
ORDER BY column_name;

-- ============================================================
-- FIM DA MIGRAÇÃO
-- ============================================================
