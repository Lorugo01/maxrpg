-- ============================================================
-- TEMPLATE PARA INSERÇÃO DE MAGIAS
-- ============================================================
-- Copie este template e preencha os campos conforme necessário
-- ============================================================

-- ============================================================
-- EXEMPLO 1: TRUQUE DE DANO (com aumentos por nível)
-- ============================================================
INSERT INTO "public"."spells" (
  "name", "level", "school", 
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Raio de Fogo',           -- Nome da magia
  0,                        -- Nível (0 = Truque)
  'Evocação',              -- Escola
  'Ação',                  -- Tempo de conjuração
  '120 pés',               -- Alcance
  'V, S',                  -- Componentes
  'Instantânea',           -- Duração
  'Você lança um raio de fogo em uma criatura ou objeto dentro do alcance. Faça um ataque mágico à distância contra o alvo. Se acertar, o alvo sofre 1d10 de dano de Fogo. Um objeto inflamável atingido por esta magia se incendeia se não estiver sendo vestido ou carregado.

Melhoria de Truque. O dano desta magia aumenta em 1d10 quando você atinge o nível 5 (2d10), 11 (3d10) e 17 (4d10).',
  'PHB 2024',              -- Fonte
  'Artificer, Sorcerer, Wizard', -- Classes (opcional)
  false,                   -- Ritual
  false,                   -- Concentração
  'damage',                -- Tipo de efeito
  '1d10',                  -- Dados base
  'Fogo',                  -- Tipo de dano
  '[{"level": 5, "dice": "2d10"}, {"level": 11, "dice": "3d10"}, {"level": 17, "dice": "4d10"}]'::jsonb
);

-- ============================================================
-- EXEMPLO 2: MAGIA DE DANO COM UPCAST
-- ============================================================
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Mísseis Mágicos',
  1,                       -- 1º Círculo
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você cria três dardos brilhantes de energia mágica. Cada dardo atinge uma criatura de sua escolha que você possa ver dentro do alcance. Um dardo causa 1d4 + 1 de dano de Força ao seu alvo. Os dardos atingem simultaneamente e você pode direcioná-los para atingir uma criatura ou várias.

Usando um Espaço de Magia de Nível Superior. Quando você conjura esta magia usando um espaço de magia de 2º nível ou superior, a magia cria um dardo adicional para cada nível de espaço acima do 1º.',
  'PHB 2024',
  'Sorcerer, Wizard',
  false,
  false,
  'damage',
  '3d4+3',                 -- 3 dardos de 1d4+1
  'Força',
  '1d4+1'                  -- +1 dardo por nível
);

-- ============================================================
-- EXEMPLO 3: MAGIA DE CURA
-- ============================================================
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Curar Ferimentos',
  1,
  'Evocação',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Uma criatura que você toca recupera um número de pontos de vida igual a 1d8 + seu modificador de habilidade de conjuração. Esta magia não tem efeito em mortos-vivos ou constructos.

Usando um Espaço de Magia de Nível Superior. Quando você conjura esta magia usando um espaço de magia de 2º nível ou superior, a cura aumenta em 1d8 para cada nível de espaço acima do 1º.',
  'PHB 2024',
  'Bard, Cleric, Druid, Paladin, Ranger',
  false,
  false,
  'healing',
  '1d8',
  true,                    -- Soma modificador de conjuração
  '1d8'                    -- +1d8 por nível
);

-- ============================================================
-- EXEMPLO 4: MAGIA DE UTILIDADE (sem dano/cura)
-- ============================================================
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Detectar Magia',
  1,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Pela duração, você sente a presença de magia a até 9 metros de você. Se você sentir magia desta forma, você pode usar sua ação para ver uma aura fraca ao redor de qualquer criatura ou objeto visível na área que tenha magia, e você aprende sua escola de magia, se houver.

A magia pode penetrar a maioria das barreiras, mas é bloqueada por 30 cm de pedra, 2,5 cm de metal comum, uma fina folha de chumbo ou 90 cm de madeira ou terra.',
  'PHB 2024',
  'Bard, Cleric, Druid, Paladin, Ranger, Sorcerer, Wizard',
  true,                    -- Pode ser conjurada como ritual
  true                     -- Requer concentração
);

-- ============================================================
-- EXEMPLO 5: MAGIA DE CONTROLE (Encantamento)
-- ============================================================
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Enfeitiçar Pessoa',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S',
  '1 hora',
  'Você tenta enfeitiçar um humanoide que você possa ver dentro do alcance. Ele deve fazer um teste de resistência de Sabedoria, e o faz com vantagem se você ou seus companheiros estiverem lutando contra ele. Se ele falhar no teste de resistência, ele fica enfeitiçado por você até que a magia termine ou até que você ou seus companheiros façam algo prejudicial a ele. A criatura enfeitiçada o considera um conhecido amigável. Quando a magia termina, a criatura sabe que foi enfeitiçada por você.

Usando um Espaço de Magia de Nível Superior. Quando você conjura esta magia usando um espaço de magia de 2º nível ou superior, você pode ter como alvo uma criatura adicional para cada nível de espaço acima do 1º. As criaturas devem estar a até 9 metros umas das outras quando você as tiver como alvo.',
  'PHB 2024',
  'Bard, Druid, Sorcerer, Warlock, Wizard',
  false,
  false
);

-- ============================================================
-- NOTAS IMPORTANTES:
-- ============================================================
-- 
-- 1. NÍVEL:
--    - 0 = Truque (Cantrip)
--    - 1-9 = Círculos de magia
--
-- 2. ESCOLAS:
--    - Abjuração, Adivinhação, Conjuração, Encantamento
--    - Evocação, Ilusão, Necromancia, Transmutação
--
-- 3. COMPONENTES:
--    - V = Verbal
--    - S = Somático
--    - M = Material (especificar entre parênteses)
--
-- 4. EFFECT_TYPE:
--    - 'damage' = Causa dano
--    - 'healing' = Cura
--    - NULL = Utilidade/Controle
--
-- 5. TIPOS DE DANO:
--    - Ácido, Concussão, Fogo, Frio, Força, Elétrico
--    - Necrótico, Perfurante, Psíquico, Radiante
--    - Trovejante, Cortante, Veneno
--
-- 6. CANTRIP_DICE_INCREASES:
--    - Apenas para truques (level = 0)
--    - Formato: [{"level": 5, "dice": "2d10"}, ...]
--
-- 7. UPCAST_DICE_PER_LEVEL:
--    - Para magias que escalam com nível superior
--    - Exemplo: '1d8' = +1d8 por nível acima do mínimo
--
-- 8. INCLUDE_SPELL_MOD:
--    - true = Soma modificador de conjuração
--    - Comum em magias de cura
--
-- 9. RITUAL:
--    - true = Pode ser conjurada como ritual (+10 min)
--    - Não gasta espaço de magia
--
-- 10. CONCENTRATION:
--     - true = Requer concentração
--     - Apenas uma magia de concentração por vez
--
-- ============================================================
