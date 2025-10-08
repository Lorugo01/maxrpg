-- ============================================================
-- TEMPLATE PARA NOVOS EQUIPAMENTOS
-- ============================================================
-- Use este template como base para criar novos equipamentos
-- Copie o bloco apropriado e preencha os valores
-- ============================================================

-- ============================================================
-- 1. ARMA SIMPLES
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",                    -- Nome da arma
  "type",                    -- 'Arma Simples'
  "cost",                    -- Custo numérico (ex: 2.00)
  "cost_text",               -- Custo em texto (ex: '2')
  "cost_currency",           -- Moeda (PO, PP, PC, PE, PL)
  "weight",                  -- Peso numérico (ex: 1.00)
  "weight_text",             -- Peso em texto (ex: '1')
  "damage",                  -- Dado de dano (ex: '1d4', '1d6', '1d8')
  "damage_type",             -- Tipo de dano (Cortante, Perfurante, Concussão, etc.)
  "weapon_properties",       -- Propriedades (Leve, Arremesso, Acuidade, etc.)
  "weapon_mastery",          -- Maestria (Ágil, Afligir, Empurrar, Lentidão, Trespassar)
  "thrown_range",            -- Alcance de arremesso (ex: '20/60') - NULL se não for arremessável
  "is_ranged",               -- true se for arma de longo alcance, false caso contrário
  "description",             -- Descrição adicional (opcional)
  "source"                   -- Fonte (PHB 2024, PHB 2014, etc.)
) VALUES (
  'Nome da Arma',
  'Arma Simples',
  0.00, '0', 'PO',
  0.00, '0',
  '1d6',
  'Cortante',
  'Leve, Acuidade',
  'Ágil',
  NULL,
  false,
  '',
  'PHB 2024'
);

-- ============================================================
-- 2. ARMA MARCIAL
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Arma Marcial'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "damage",
  "damage_type",
  "weapon_properties",
  "weapon_mastery",
  "thrown_range",
  "is_ranged",
  "description",
  "source"
) VALUES (
  'Nome da Arma',
  'Arma Marcial',
  0.00, '0', 'PO',
  0.00, '0',
  '1d8',
  'Cortante',
  'Versátil',
  'Trespassar',
  NULL,
  false,
  '',
  'PHB 2024'
);

-- ============================================================
-- 3. ARMADURA LEVE
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Armadura Leve'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "armor_class",             -- CA base (ex: 11, 12)
  "armor_class_modifier",    -- 'Destreza' (mod. completo para armadura leve)
  "stealth_disadvantage",    -- true ou false
  "description",
  "source"
) VALUES (
  'Nome da Armadura',
  'Armadura Leve',
  0.00, '0', 'PO',
  0.00, '0',
  11,
  'Destreza',
  false,
  '',
  'PHB 2024'
);

-- ============================================================
-- 4. ARMADURA MÉDIA
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Armadura Média'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "armor_class",             -- CA base (ex: 12, 13, 14, 15)
  "armor_class_modifier",    -- 'Destreza (máx +2)' para armadura média
  "stealth_disadvantage",    -- true ou false
  "strength",                -- Força mínima requerida (NULL se não houver)
  "description",
  "source"
) VALUES (
  'Nome da Armadura',
  'Armadura Média',
  0.00, '0', 'PO',
  0.00, '0',
  13,
  'Destreza (máx +2)',
  false,
  NULL,
  '',
  'PHB 2024'
);

-- ============================================================
-- 5. ARMADURA PESADA
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Armadura Pesada'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "armor_class",             -- CA fixa (ex: 14, 16, 18)
  "armor_class_modifier",    -- NULL (armadura pesada não usa mod. Destreza)
  "stealth_disadvantage",    -- Geralmente true para armadura pesada
  "strength",                -- Força mínima requerida (ex: 13, 15)
  "description",
  "source"
) VALUES (
  'Nome da Armadura',
  'Armadura Pesada',
  0.00, '0', 'PO',
  0.00, '0',
  16,
  NULL,
  true,
  13,
  '',
  'PHB 2024'
);

-- ============================================================
-- 6. ESCUDO
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Escudo'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "armor_class",             -- Bônus de CA (geralmente 2)
  "armor_class_modifier",    -- '+2 CA'
  "stealth_disadvantage",
  "description",
  "source"
) VALUES (
  'Escudo',
  'Escudo',
  0.00, '0', 'PO',
  0.00, '0',
  2,
  '+2 CA',
  false,
  'Um escudo aumenta sua CA em 2.',
  'PHB 2024'
);

-- ============================================================
-- 7. ITEM DE AVENTURA
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Item de Aventura'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Descrição completa do item
  "source"
) VALUES (
  'Nome do Item',
  'Item de Aventura',
  0.00, '0', 'PO',
  0.00, '0',
  'Descrição completa do item e como ele funciona.',
  'PHB 2024'
);

-- ============================================================
-- 8. INSTRUMENTO MUSICAL
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Instrumento Musical'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Inclua: Habilidade (Carisma), CD para tocar, etc.
  "source"
) VALUES (
  'Nome do Instrumento',
  'Instrumento Musical',
  0.00, '0', 'PO',
  0.00, '0',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15).',
  'PHB 2024'
);

-- ============================================================
-- 9. FERRAMENTA DE ARTESÃO
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Ferramenta'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Habilidade, uso, artesanato possível
  "source"
) VALUES (
  'Nome da Ferramenta',
  'Ferramenta',
  0.00, '0', 'PO',
  0.00, '0',
  'Habilidade: [Atributo]. Utilizar: [Descrição]. Artesanato: [Itens que pode criar].',
  'PHB 2024'
);

-- ============================================================
-- 10. FOCO DE CONJURAÇÃO (ARCANO)
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Foco em conjuração'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Quais classes podem usar
  "source"
) VALUES (
  'Nome do Foco',
  'Foco em conjuração',
  0.00, '0', 'PO',
  0.00, '0',
  'Um [classe] pode usar este item como Foco de Conjuração.',
  'PHB 2024'
);

-- ============================================================
-- 11. SÍMBOLO SAGRADO (DIVINO)
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Foco em conjuração'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Como deve ser usado (segurado, vestido, etc.)
  "source"
) VALUES (
  'Nome do Símbolo',
  'Foco em conjuração',
  0.00, '0', 'PO',
  0.00, '0',
  'Um Símbolo Sagrado assume uma forma específica e é adornado com joias ou pintado para canalizar magia divina. Um Clérigo ou Paladino pode usar um Símbolo Sagrado como Foco de Conjuração.',
  'PHB 2024'
);

-- ============================================================
-- 12. PACOTE DE EQUIPAMENTO
-- ============================================================
INSERT INTO "public"."equipment" (
  "name",
  "type",                    -- 'Item de Aventura'
  "cost",
  "cost_text",
  "cost_currency",
  "weight",
  "weight_text",
  "description",             -- Liste todos os itens incluídos
  "source"
) VALUES (
  'Pacote do [Classe]',
  'Item de Aventura',
  0.00, '0', 'PO',
  0.00, '0',
  'Um Pacote do [Classe] contém os seguintes itens: [lista completa de itens].',
  'PHB 2024'
);

-- ============================================================
-- NOTAS IMPORTANTES
-- ============================================================
-- 
-- TIPOS DE DANO:
-- - Ácido, Concussão, Frio, Fogo, Força, Raio, Necrótico, 
--   Perfurante, Veneno, Psíquico, Radiante, Trovão, Cortante
--
-- PROPRIEDADES DE ARMAS:
-- - Acuidade, Arremesso, Duas Mãos, Leve, Pesada, Versátil,
--   Munição, Alcance, Recarga, Especial
--
-- MAESTRIAS DE ARMAS (PHB 2024):
-- - Ágil, Afligir, Empurrar, Lentidão, Trespassar, Desarmar,
--   Investida, Perfurar, Corte, Esmagamento
--
-- MOEDAS:
-- - PC (Peça de Cobre) = 0,01 PO
-- - PP (Peça de Prata) = 0,1 PO
-- - PE (Peça de Electrum) = 0,5 PO
-- - PO (Peça de Ouro) = 1 PO
-- - PL (Peça de Platina) = 10 PO
--
-- PESO:
-- - Sempre em libras (1 libra ≈ 0,45 kg)
-- - NULL ou '' = sem peso significativo
--
-- ALCANCE DE ARREMESSO:
-- - Formato: 'alcance_normal/alcance_máximo' (ex: '20/60')
-- - Alcance normal: sem penalidade
-- - Alcance máximo: com desvantagem
--
-- ============================================================
