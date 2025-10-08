-- ============================================================
-- INSERÇÃO DE EQUIPAMENTOS - PHB 2024 - PARTE 4
-- ============================================================
-- Armas Adicionais, Montarias, Veículos Aquáticos, Arreios
-- ============================================================

-- ============================================================
-- ARMAS SIMPLES ADICIONAIS
-- ============================================================

-- Besta Leve
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Besta Leve',
  'Arma Simples',
  25.00, '25', 'PO',
  5.00, '5',
  '1d8', 'Perfurante',
  'Munição (alcance 80/320 pés; virote), Carregamento, Duas Mãos',
  'Lento',
  true,
  'PHB 2024'
);

-- Martelo Leve
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Martelo Leve',
  'Arma Simples',
  2.00, '2', 'PO',
  2.00, '2',
  '1d4', 'Concussão',
  'Leve, Arremessado',
  'Nick',
  '20/60',
  false,
  'PHB 2024'
);

-- Maça
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Maça',
  'Arma Simples',
  5.00, '5', 'PO',
  4.00, '4',
  '1d6', 'Concussão',
  '',
  'Seiva',
  false,
  'PHB 2024'
);

-- Bastão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Bastão',
  'Arma Simples',
  0.20, '2', 'PP',
  4.00, '4',
  '1d6', 'Concussão',
  'Versátil (1d8)',
  'Derrubar',
  false,
  'PHB 2024'
);

-- Lâmina Psíquica
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Lâmina Psíquica',
  'Arma Simples',
  0.00, '', '',
  NULL, '',
  '1d6', 'Psíquico',
  'Finesse, Arremessado',
  'Vex',
  '60/120',
  false,
  'PHB 2024'
);

-- Arco Curto
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Arco Curto',
  'Arma Simples',
  25.00, '25', 'PO',
  2.00, '2',
  '1d6', 'Perfurante',
  'Munição (alcance 80/320 pés; flecha), Duas Mãos',
  'Vex',
  true,
  'PHB 2024'
);

-- Foice
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Foice',
  'Arma Simples',
  1.00, '1', 'PO',
  2.00, '2',
  '1d4', 'Cortante',
  'Leve',
  'Nick',
  false,
  'PHB 2024'
);

-- Estilingue
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Estilingue',
  'Arma Simples',
  0.10, '1', 'PP',
  NULL, '',
  '1d4', 'Concussão',
  'Munição (Alcance 30/120 pés; Bala de estilingue)',
  'Lento',
  true,
  'PHB 2024'
);

-- Lança
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Lança',
  'Arma Simples',
  1.00, '1', 'PO',
  3.00, '3',
  '1d6', 'Perfurante',
  'Arremessado, Versátil (1d8)',
  'Seiva',
  '20/60',
  false,
  'PHB 2024'
);

-- ============================================================
-- ARMAS MARCIAIS ADICIONAIS
-- ============================================================

-- Lança
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "description", "source"
) VALUES (
  'Lança',
  'Arma Marcial',
  10.00, '10', 'PO',
  6.00, '6',
  '1d10', 'Perfurante',
  'Pesado, Alcance, Duas Mãos (a menos que montado)',
  'Derrubar',
  false,
  'Uma Lança requer duas mãos para ser empunhada quando você não está montado.',
  'PHB 2024'
);

-- Arco Longo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Arco Longo',
  'Arma Marcial',
  50.00, '50', 'PO',
  2.00, '2',
  '1d8', 'Perfurante',
  'Munição (Alcance 150/600 pés; Flecha), Pesada, Duas Mãos',
  'Lento',
  true,
  'PHB 2024'
);

-- Espada Longa
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Espada Longa',
  'Arma Marcial',
  15.00, '15', 'PO',
  3.00, '3',
  '1d8', 'Cortante',
  'Versátil (1d10)',
  'Seiva',
  false,
  'PHB 2024'
);

-- Malho
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Malho',
  'Arma Marcial',
  10.00, '10', 'PO',
  10.00, '10',
  '2d6', 'Concussão',
  'Pesado, Duas Mãos',
  'Derrubar',
  false,
  'PHB 2024'
);

-- Estrela da Manhã
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Estrela da Manhã',
  'Arma Marcial',
  15.00, '15', 'PO',
  4.00, '4',
  '1d8', 'Perfurante',
  '',
  'Seiva',
  false,
  'PHB 2024'
);

-- Mosquete
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Mosquete',
  'Arma Marcial',
  500.00, '500', 'PO',
  10.00, '10',
  '1d12', 'Perfurante',
  'Munição (alcance 40/120 pés; bala de arma de fogo), Carregamento, Duas Mãos',
  'Lento',
  true,
  'PHB 2024'
);

-- Pique
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Pique',
  'Arma Marcial',
  5.00, '5', 'PO',
  18.00, '18',
  '1d10', 'Perfurante',
  'Pesado, Alcance, Duas Mãos',
  'Empurrar',
  false,
  'PHB 2024'
);

-- Pistola
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Pistola',
  'Arma Marcial',
  250.00, '250', 'PO',
  3.00, '3',
  '1d10', 'Perfurante',
  'Munição (alcance 30/90 pés; bala de arma de fogo), Carregamento',
  'Vex',
  true,
  'PHB 2024'
);

-- Florete
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Florete',
  'Arma Marcial',
  25.00, '25', 'PO',
  2.00, '2',
  '1d8', 'Perfurante',
  'Finesse',
  'Vex',
  false,
  'PHB 2024'
);

-- Cimitarra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Cimitarra',
  'Arma Marcial',
  25.00, '25', 'PO',
  3.00, '3',
  '1d6', 'Cortante',
  'Finesse, Leve',
  'Nick',
  false,
  'PHB 2024'
);

-- Espada Curta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Espada Curta',
  'Arma Marcial',
  10.00, '10', 'PO',
  2.00, '2',
  '1d6', 'Perfurante',
  'Finesse, Leve',
  'Vex',
  false,
  'PHB 2024'
);

-- Tridente
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Tridente',
  'Arma Marcial',
  5.00, '5', 'PO',
  4.00, '4',
  '1d8', 'Perfurante',
  'Arremessado, Versátil (1d10)',
  'Derrubar',
  '20/60',
  false,
  'PHB 2024'
);

-- Picareta de Guerra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Picareta de Guerra',
  'Arma Marcial',
  5.00, '5', 'PO',
  2.00, '2',
  '1d8', 'Perfurante',
  'Versátil (1d10)',
  'Seiva',
  false,
  'PHB 2024'
);

-- Martelo de Guerra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Martelo de Guerra',
  'Arma Marcial',
  15.00, '15', 'PO',
  5.00, '5',
  '1d8', 'Concussão',
  'Versátil (1d10)',
  'Empurrar',
  false,
  'PHB 2024'
);

-- Chicote
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Chicote',
  'Arma Marcial',
  2.00, '2', 'PO',
  3.00, '3',
  '1d4', 'Cortante',
  'Finesse, Alcance',
  'Lento',
  false,
  'PHB 2024'
);

-- ============================================================
-- MUNIÇÕES ADICIONAIS
-- ============================================================

-- Agulha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Agulha',
  'Munição',
  0.02, '2', 'PC',
  0.02, '0,32 oz',
  'Agulhas de zarabatana são usadas com armas que possuem a propriedade de munição para realizar ataques à distância. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As agulhas geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- Agulhas (50)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Agulhas (50)',
  'Munição',
  1.00, '1', 'PO',
  1.00, '1',
  'Agulhas de zarabatana são usadas com armas que possuem a propriedade de munição para realizar ataques à distância. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As agulhas geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- Bala de Estilingue
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bala de Estilingue',
  'Munição',
  0.002, '0,2', 'PC',
  0.075, '1,2 oz',
  'Balas de funda são usadas com uma arma que possui a propriedade de munição para realizar um ataque à distância. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As balas de estilingue geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- Balas de Estilingue (20)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Balas de Estilingue (20)',
  'Munição',
  0.04, '4', 'PC',
  1.50, '1½',
  'Balas de funda são usadas com uma arma que possui a propriedade de munição para realizar um ataque à distância. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As balas de estilingue geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- ============================================================
-- ARMADURAS ADICIONAIS
-- ============================================================

-- Armadura de Couro (Leve)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Armadura de Couro',
  'Armadura Leve',
  10.00, '10', 'PO',
  10.00, '10',
  11, 'Destreza', false,
  'PHB 2024'
);

-- Armadura Acolchoada
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "description", "source"
) VALUES (
  'Armadura Acolchoada',
  'Armadura Leve',
  5.00, '5', 'PO',
  8.00, '8',
  11, 'Destreza', true,
  'O usuário tem Desvantagem em testes de Destreza (Furtividade).',
  'PHB 2024'
);

-- Armadura de Placas
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage", "strength",
  "description", "source"
) VALUES (
  'Armadura de Placas',
  'Armadura Pesada',
  1500.00, '1.500', 'PO',
  65.00, '65',
  18, NULL, true, 15,
  'O usuário tem Desvantagem em testes de Destreza (Furtividade). Se o usuário tiver um valor de Força menor que 15, sua velocidade será reduzida em 3 metros.',
  'PHB 2024'
);

-- Armadura de Couro Cravejado
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Armadura de Couro Cravejado',
  'Armadura Leve',
  45.00, '45', 'PO',
  13.00, '13',
  12, 'Destreza', false,
  'PHB 2024'
);

-- Cota de Malha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Cota de Malha',
  'Armadura Pesada',
  30.00, '30', 'PO',
  40.00, '40',
  14, NULL, true,
  'PHB 2024'
);

-- Brunea
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Brunea',
  'Armadura Média',
  50.00, '50', 'PO',
  45.00, '45',
  14, 'Destreza (máx. 2)', true,
  'PHB 2024'
);

-- Armadura de Tala
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage", "strength",
  "description", "source"
) VALUES (
  'Armadura de Tala',
  'Armadura Pesada',
  200.00, '200', 'PO',
  60.00, '60',
  17, NULL, true, 15,
  'O usuário tem Desvantagem em testes de Destreza (Furtividade). Se o usuário tiver um valor de Força menor que 15, sua velocidade será reduzida em 3 metros.',
  'PHB 2024'
);

-- Escudo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Escudo',
  'Armadura (escudo)',
  10.00, '10', 'PO',
  6.00, '6',
  2, '+2', false,
  'PHB 2024'
);

-- ============================================================
-- MONTARIAS ADICIONAIS
-- ============================================================

-- Mastim
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Mastim',
  'Montaria',
  25.00, '25', 'PO',
  NULL, '',
  'Velocidade: 40 pés, Capacidade de carga: 195 lb.',
  'PHB 2024'
);

-- Mula
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Mula',
  'Montaria',
  8.00, '8', 'PO',
  NULL, '',
  'Velocidade: 40 pés, Capacidade de carga: 420 lb.',
  'PHB 2024'
);

-- Pônei
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pônei',
  'Montaria',
  30.00, '30', 'PO',
  NULL, '',
  'Velocidade: 40 pés, Capacidade de carga: 225 lb.',
  'PHB 2024'
);

-- Cavalo de Montaria
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cavalo de Montaria',
  'Montaria',
  75.00, '75', 'PO',
  NULL, '',
  'Velocidade: 60 pés, Capacidade de carga: 480 lb.',
  'PHB 2024'
);

-- Cavalo de Guerra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cavalo de Guerra',
  'Montaria',
  400.00, '400', 'PO',
  NULL, '',
  'Velocidade: 60 pés, Capacidade de carga: 540 lb.',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS AQUÁTICOS ADICIONAIS
-- ============================================================

-- Barco de Quilha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Barco de Quilha',
  'Veículo (água)',
  3000.00, '3.000', 'PO',
  NULL, '',
  'Velocidade: 1 mph. Capacidade de carga: 1/2 tonelada de carga, 6 passageiros. Tripulação 1, CA 15, HP 100, Limite de dano 10. Barcos de quilha são usados em lagos e rios. Se for descer a correnteza, adicione a velocidade da correnteza à velocidade do veículo. Reparo: 1 PV = 1 dia + 20 GP.',
  'PHB 2024'
);

-- Longship
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Longship',
  'Veículo (água)',
  10000.00, '10.000', 'PO',
  NULL, '',
  'Velocidade: 3 mph. Capacidade de carga: 10 toneladas de carga, 150 passageiros. Tripulação 40, CA 15, HP 300, Limite de danos 15. Um navio navegando contra um vento forte move-se à metade da velocidade. Reparo: 1 PV = 1 dia + 20 GP.',
  'PHB 2024'
);

-- Barco a Remo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Barco a Remo',
  'Veículo (água)',
  50.00, '50', 'PO',
  NULL, '',
  'Velocidade: 1½ mph. Capacidade de transporte: 3 passageiros. Tripulação 1, CA 11, HP 50. Barcos a remo são usados em lagos e rios. Se for descer a correnteza, adicione a velocidade da correnteza à velocidade do veículo. Um barco a remo pode ser carregado e pesa 45 kg. Reparo: 1 PV = 1 dia + 20 GP.',
  'PHB 2024'
);

-- Veleiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Veleiro',
  'Veículo (água)',
  10000.00, '10.000', 'PO',
  NULL, '',
  'Velocidade: 2 mph. Capacidade de carga: 100 toneladas de carga, 20 passageiros. Tripulação 20, CA 15, HP 300, Limite de danos 15. Um navio navegando contra um vento forte move-se à metade da velocidade. Reparo: 1 PV = 1 dia + 20 GP.',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS TERRESTRES ADICIONAIS
-- ============================================================

-- Trenó
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Trenó',
  'Veículo (terrestre)',
  20.00, '20', 'PO',
  300.00, '300',
  'Veículo terrestre puxado por animais, ideal para neve e gelo.',
  'PHB 2024'
);

-- Vagão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Vagão',
  'Veículo (terrestre)',
  35.00, '35', 'PO',
  400.00, '400',
  'Veículo terrestre puxado por animais para transporte de carga e passageiros.',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS AQUÁTICOS MILITARES
-- ============================================================

-- Navio de Guerra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Navio de Guerra',
  'Veículo (água)',
  25000.00, '25.000', 'PO',
  NULL, '',
  'Velocidade: 2½ mph. Capacidade de carga: 200 toneladas de carga, 60 passageiros. Tripulação 60, CA 15, HP 500, Limite de danos 20. Um navio navegando contra um vento forte move-se à metade da velocidade. Reparo: 1 PV = 1 dia + 20 GP.',
  'PHB 2024'
);

-- ============================================================
-- ARREIOS E EQUIPAMENTOS ADICIONAIS
-- ============================================================

-- Sela Militar
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Sela Militar',
  'Arreios e Equipamentos',
  20.00, '20', 'PO',
  30.00, '30',
  'A saddle comes with a bit, a bridle, reins, and any other equipment needed to use the saddle. A Military Saddle gives Advantage on any ability check you make to remain mounted.',
  'PHB 2024'
);

-- Sela de Montaria
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Sela de Montaria',
  'Arreios e Equipamentos',
  10.00, '10', 'PO',
  25.00, '25',
  'Uma sela vem com um freio, um freio, rédeas e qualquer outro equipamento necessário para usá-la.',
  'PHB 2024'
);

-- Estabulação (por dia)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Estabulação (por dia)',
  'Arreios e Equipamentos',
  0.05, '5', 'PC',
  NULL, '',
  'Custo diário para manter uma montaria em um estábulo.',
  'PHB 2024'
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
SELECT 
  type,
  COUNT(*) as quantidade
FROM equipment 
WHERE source = 'PHB 2024'
GROUP BY type
ORDER BY type;
