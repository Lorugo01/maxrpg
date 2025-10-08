-- ============================================================
-- SCRIPT DE INSERÇÃO COMPLETA DE TALENTOS - D&D 5e PHB 2024
-- ============================================================
-- Este script insere todos os 55 talentos do PHB 2024
-- Categorias: Origem (11), Geral (25), Estilo de Luta (7), Dádiva Épica (12)
-- ============================================================

-- Executar na ordem:
\echo '=== Inserindo Talentos de Origem (11 talentos) ==='
\i database/Talentos/insert_talentos_origem.sql

\echo '=== Inserindo Talento Artesão (necessário para origens) ==='
\i database/Talentos/insert_talento_artesao.sql

\echo '=== Inserindo Talento Iniciado em Magia (repetível) ==='
\i database/Talentos/insert_iniciado_em_magia.sql

\echo '=== Inserindo Talentos Gerais (25 talentos) ==='
\i database/Talentos/insert_talentos_gerais.sql

\echo '=== Inserindo Talentos de Estilo de Luta (7 talentos) ==='
\i database/Talentos/insert_talentos_estilo_luta.sql

\echo '=== Inserindo Talentos de Dádiva Épica (12 talentos) ==='
\i database/Talentos/insert_talentos_dadiva_epica.sql

\echo '=== Verificando inserção ==='
SELECT 
  category,
  COUNT(*) as total_talentos
FROM feats
GROUP BY category
ORDER BY category;

\echo '=== Total de talentos inseridos ==='
SELECT COUNT(*) as total FROM feats;

\echo '=== Talentos repetíveis ==='
SELECT name, category FROM feats WHERE is_repeatable = true;

\echo '=== Inserção completa! ==='
