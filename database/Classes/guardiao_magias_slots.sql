-- Magias Conhecidas e Espaços de Magia - Classe Guardião
-- Para inserção no campo spell_levels da tabela classes

-- MAGIAS CONHECIDAS (spell_levels)
'[
  {"level": 1, "cantrips": 2, "known_spells": 2},
  {"level": 2, "cantrips": 2, "known_spells": 3},
  {"level": 3, "cantrips": 2, "known_spells": 4},
  {"level": 4, "cantrips": 2, "known_spells": 5},
  {"level": 5, "cantrips": 3, "known_spells": 6},
  {"level": 6, "cantrips": 3, "known_spells": 6},
  {"level": 7, "cantrips": 3, "known_spells": 7},
  {"level": 8, "cantrips": 3, "known_spells": 7},
  {"level": 9, "cantrips": 4, "known_spells": 9},
  {"level": 10, "cantrips": 4, "known_spells": 9},
  {"level": 11, "cantrips": 4, "known_spells": 10},
  {"level": 12, "cantrips": 4, "known_spells": 10},
  {"level": 13, "cantrips": 5, "known_spells": 11},
  {"level": 14, "cantrips": 5, "known_spells": 11},
  {"level": 15, "cantrips": 5, "known_spells": 12},
  {"level": 16, "cantrips": 5, "known_spells": 12},
  {"level": 17, "cantrips": 6, "known_spells": 14},
  {"level": 18, "cantrips": 6, "known_spells": 14},
  {"level": 19, "cantrips": 6, "known_spells": 15},
  {"level": 20, "cantrips": 6, "known_spells": 15}
]'::jsonb

-- ESPAÇOS DE MAGIA (spell_slots_levels)
'[
  {"level": 1, "level_1": 2},
  {"level": 2, "level_1": 2},
  {"level": 3, "level_1": 3},
  {"level": 4, "level_1": 3},
  {"level": 5, "level_1": 4, "level_2": 2},
  {"level": 6, "level_1": 4, "level_2": 2},
  {"level": 7, "level_1": 4, "level_2": 3},
  {"level": 8, "level_1": 4, "level_2": 3},
  {"level": 9, "level_1": 4, "level_2": 3, "level_3": 2},
  {"level": 10, "level_1": 4, "level_2": 3, "level_3": 2},
  {"level": 11, "level_1": 4, "level_2": 3, "level_3": 3},
  {"level": 12, "level_1": 4, "level_2": 3, "level_3": 3},
  {"level": 13, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 1},
  {"level": 14, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 1},
  {"level": 15, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 2},
  {"level": 16, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 2},
  {"level": 17, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 1},
  {"level": 18, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 1},
  {"level": 19, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2},
  {"level": 20, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2}
]'::jsonb

-- EXEMPLO DE USO PARA ATUALIZAR UMA CLASSE EXISTENTE:
-- UPDATE classes 
-- SET 
--   spell_levels = '[
--     {"level": 1, "cantrips": 2, "known_spells": 2},
--     {"level": 2, "cantrips": 2, "known_spells": 3},
--     {"level": 3, "cantrips": 2, "known_spells": 4},
--     {"level": 4, "cantrips": 2, "known_spells": 5},
--     {"level": 5, "cantrips": 3, "known_spells": 6},
--     {"level": 6, "cantrips": 3, "known_spells": 6},
--     {"level": 7, "cantrips": 3, "known_spells": 7},
--     {"level": 8, "cantrips": 3, "known_spells": 7},
--     {"level": 9, "cantrips": 4, "known_spells": 9},
--     {"level": 10, "cantrips": 4, "known_spells": 9},
--     {"level": 11, "cantrips": 4, "known_spells": 10},
--     {"level": 12, "cantrips": 4, "known_spells": 10},
--     {"level": 13, "cantrips": 5, "known_spells": 11},
--     {"level": 14, "cantrips": 5, "known_spells": 11},
--     {"level": 15, "cantrips": 5, "known_spells": 12},
--     {"level": 16, "cantrips": 5, "known_spells": 12},
--     {"level": 17, "cantrips": 6, "known_spells": 14},
--     {"level": 18, "cantrips": 6, "known_spells": 14},
--     {"level": 19, "cantrips": 6, "known_spells": 15},
--     {"level": 20, "cantrips": 6, "known_spells": 15}
--   ]'::jsonb,
--   spell_slots_levels = '[
--     {"level": 1, "level_1": 2},
--     {"level": 2, "level_1": 2},
--     {"level": 3, "level_1": 3},
--     {"level": 4, "level_1": 3},
--     {"level": 5, "level_1": 4, "level_2": 2},
--     {"level": 6, "level_1": 4, "level_2": 2},
--     {"level": 7, "level_1": 4, "level_2": 3},
--     {"level": 8, "level_1": 4, "level_2": 3},
--     {"level": 9, "level_1": 4, "level_2": 3, "level_3": 2},
--     {"level": 10, "level_1": 4, "level_2": 3, "level_3": 2},
--     {"level": 11, "level_1": 4, "level_2": 3, "level_3": 3},
--     {"level": 12, "level_1": 4, "level_2": 3, "level_3": 3},
--     {"level": 13, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 1},
--     {"level": 14, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 1},
--     {"level": 15, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 2},
--     {"level": 16, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 2},
--     {"level": 17, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 1},
--     {"level": 18, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 1},
--     {"level": 19, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2},
--     {"level": 20, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2}
--   ]'::jsonb
-- WHERE name = 'Guardião';
