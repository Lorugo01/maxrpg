-- ============================================================
-- INSERÇÃO DE EQUIPAMENTOS - PHB 2024 - PARTE 2
-- ============================================================
-- Armas, Armaduras, Munições, Comida/Bebida, Montarias e Veículos
-- ============================================================

-- ============================================================
-- ARMAS SIMPLES
-- ============================================================

-- Clava
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Clava',
  'Arma Simples',
  0.10, '1', 'PP',
  2.00, '2',
  '1d4', 'Concussão',
  'Leve',
  'Lento',
  false,
  'PHB 2024'
);

-- Adaga
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Adaga',
  'Arma Simples',
  2.00, '2', 'PO',
  1.00, '1',
  '1d4', 'Perfurante',
  'Finesse, Leve, Arremessado',
  'Nick',
  '20/60',
  false,
  'PHB 2024'
);

-- Dardo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Dardo',
  'Arma Simples',
  0.05, '5', 'PC',
  0.25, '¼',
  '1d4', 'Perfurante',
  'Finesse, Arremessado',
  'Vex',
  '20/60',
  true,
  'PHB 2024'
);

-- Clava Grande
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Clava Grande',
  'Arma Simples',
  0.20, '2', 'PP',
  10.00, '10',
  '1d8', 'Concussão',
  'Duas Mãos',
  'Empurrar',
  false,
  'PHB 2024'
);

-- Dardo (arma de arremesso)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Dardo',
  'Arma Simples',
  0.50, '5', 'PP',
  2.00, '2',
  '1d6', 'Perfurante',
  'Arremessado',
  'Lento',
  '30/120',
  false,
  'PHB 2024'
);

-- Machado de Mão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "thrown_range", "is_ranged", "source"
) VALUES (
  'Machado de Mão',
  'Arma Simples',
  5.00, '5', 'PO',
  2.00, '2',
  '1d6', 'Cortante',
  'Leve, Arremessado',
  'Vex',
  '20/60',
  false,
  'PHB 2024'
);

-- ============================================================
-- ARMAS MARCIAIS
-- ============================================================

-- Machado de Batalha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Machado de Batalha',
  'Arma Marcial',
  10.00, '10', 'PO',
  4.00, '4',
  '1d8', 'Cortante',
  'Versátil (1d10)',
  'Derrubar',
  false,
  'PHB 2024'
);

-- Zarabatana
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Zarabatana',
  'Arma Marcial',
  10.00, '10', 'PO',
  1.00, '1',
  '1', 'Perfurante',
  'Munição (alcance 25/100 pés; agulha), Carregamento',
  'Vex',
  true,
  'PHB 2024'
);

-- Mangual
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Mangual',
  'Arma Marcial',
  10.00, '10', 'PO',
  2.00, '2',
  '1d8', 'Concussão',
  '',
  'Seiva',
  false,
  'PHB 2024'
);

-- Gládio
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Gládio',
  'Arma Marcial',
  20.00, '20', 'PO',
  6.00, '6',
  '1d10', 'Cortante',
  'Pesado, Alcance, Duas Mãos',
  'Pastar',
  false,
  'PHB 2024'
);

-- Machado Grande
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Machado Grande',
  'Arma Marcial',
  30.00, '30', 'PO',
  7.00, '7',
  '1d12', 'Cortante',
  'Pesado, Duas Mãos',
  'Fenda',
  false,
  'PHB 2024'
);

-- Espada Grande
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Espada Grande',
  'Arma Marcial',
  50.00, '50', 'PO',
  6.00, '6',
  '2d6', 'Cortante',
  'Pesado, Duas Mãos',
  'Pastar',
  false,
  'PHB 2024'
);

-- Besta de Mão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Besta de Mão',
  'Arma Marcial',
  75.00, '75', 'PO',
  3.00, '3',
  '1d6', 'Perfurante',
  'Munição (alcance 30/120 pés; virote), Leve, Carregamento',
  'Vex',
  true,
  'PHB 2024'
);

-- Besta Pesada
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "is_ranged", "source"
) VALUES (
  'Besta Pesada',
  'Arma Marcial',
  50.00, '50', 'PO',
  18.00, '18',
  '1d10', 'Perfurante',
  'Munição (alcance 100/400 pés; virote), Pesada, Carregamento, Duas Mãos',
  'Empurrar',
  true,
  'PHB 2024'
);

-- ============================================================
-- MUNIÇÕES
-- ============================================================

-- Flecha (unidade)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Flecha',
  'Munição',
  0.05, '5', 'PC',
  0.05, '0,8 oz',
  'Flechas são usadas com armas que possuem a propriedade de munição para realizar ataques à distância. Cada vez que você ataca com a arma, você gasta uma peça de munição. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As flechas geralmente são armazenadas em uma aljava (comprada separadamente).',
  'PHB 2024'
);

-- Flechas (20)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Flechas (20)',
  'Munição',
  1.00, '1', 'PO',
  1.00, '1',
  'Flechas são usadas com armas que possuem a propriedade de munição para realizar ataques à distância. Cada vez que você ataca com a arma, você gasta uma peça de munição. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. As flechas geralmente são armazenadas em uma aljava (comprada separadamente).',
  'PHB 2024'
);

-- Virote (unidade)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Virote',
  'Munição',
  0.05, '5', 'PC',
  0.075, '1,2 oz',
  'Virotes de besta são usados com armas que possuem a propriedade de munição para realizar ataques à distância. Cada vez que você ataca com a arma, você gasta uma peça de munição. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. Os virotes são normalmente armazenados em um estojo para virotes de besta (comprado separadamente).',
  'PHB 2024'
);

-- Virotes (20)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Virotes (20)',
  'Munição',
  1.00, '1', 'PO',
  1.50, '1½',
  'Virotes de besta são usados com armas que possuem a propriedade de munição para realizar ataques à distância. Cada vez que você ataca com a arma, você gasta uma peça de munição. Ao final da batalha, você pode recuperar metade da sua munição gasta dedicando um minuto para vasculhar o campo de batalha. Os virotes são normalmente armazenados em um estojo para virotes de besta (comprado separadamente).',
  'PHB 2024'
);

-- Bala de Arma de Fogo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bala de Arma de Fogo',
  'Munição',
  0.30, '3', 'PP',
  0.20, '⅕',
  'A munição de uma arma de fogo é destruída ao ser usada. As balas de armas de fogo geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- Balas de Arma de Fogo (10)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Balas de Arma de Fogo (10)',
  'Munição',
  3.00, '3', 'PO',
  2.00, '2',
  'A munição de uma arma de fogo é destruída ao ser usada. As balas de armas de fogo geralmente são armazenadas em uma bolsa (comprada separadamente).',
  'PHB 2024'
);

-- ============================================================
-- ARMADURAS LEVES
-- ============================================================

-- (Já existe Armadura de Couro e Acolchoada no banco)

-- ============================================================
-- ARMADURAS MÉDIAS
-- ============================================================

-- Peitoral
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Peitoral',
  'Armadura Média',
  400.00, '400', 'PO',
  20.00, '20',
  14, 'Destreza (máx +2)', false,
  'PHB 2024'
);

-- Camisa de Corrente
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Camisa de Corrente',
  'Armadura Média',
  50.00, '50', 'PO',
  20.00, '20',
  13, 'Destreza (máx +2)', false,
  'PHB 2024'
);

-- Meia Armadura de Placa
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "description", "source"
) VALUES (
  'Meia Armadura de Placa',
  'Armadura Média',
  750.00, '750', 'PO',
  40.00, '40',
  15, 'Destreza (máx +2)', true,
  'O usuário tem Desvantagem em testes de Destreza (Furtividade).',
  'PHB 2024'
);

-- Armadura de Couro (Média)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage",
  "source"
) VALUES (
  'Armadura de Couro',
  'Armadura Média',
  10.00, '10', 'PO',
  12.00, '12',
  12, 'Destreza (máx +2)', false,
  'PHB 2024'
);

-- ============================================================
-- ARMADURAS PESADAS
-- ============================================================

-- Cota de Malha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "armor_class", "armor_class_modifier", "stealth_disadvantage", "strength",
  "description", "source"
) VALUES (
  'Cota de Malha',
  'Armadura Pesada',
  75.00, '75', 'PO',
  55.00, '55',
  16, NULL, true, 13,
  'O usuário tem Desvantagem em testes de Destreza (Furtividade). Se o usuário tiver um valor de Força menor que 13, sua velocidade será reduzida em 3 metros.',
  'PHB 2024'
);

-- ============================================================
-- COMIDA E BEBIDA
-- ============================================================

-- Cerveja (caneca)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Cerveja (caneca)',
  'Comida e Bebida',
  0.04, '4', 'PC',
  NULL, '',
  'PHB 2024'
);

-- Pão (pão)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Pão (pão)',
  'Comida e Bebida',
  0.02, '2', 'PC',
  NULL, '',
  'PHB 2024'
);

-- Queijo (cunha)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Queijo (cunha)',
  'Comida e Bebida',
  0.10, '1', 'PP',
  NULL, '',
  'PHB 2024'
);

-- Vinho Comum (garrafa)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Vinho Comum (garrafa)',
  'Comida e Bebida',
  0.20, '2', 'PP',
  NULL, '',
  'PHB 2024'
);

-- Vinho Fino (garrafa)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Vinho Fino (garrafa)',
  'Comida e Bebida',
  10.00, '10', 'PO',
  NULL, '',
  'PHB 2024'
);

-- ============================================================
-- MONTARIAS
-- ============================================================

-- Camelo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Camelo',
  'Montaria',
  50.00, '50', 'PO',
  NULL, '',
  'Velocidade: 50 pés, Capacidade de carga: 450 lb.',
  'PHB 2024'
);

-- Cavalo de Tração
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cavalo de Tração',
  'Montaria',
  50.00, '50', 'PO',
  NULL, '',
  'Velocidade: 40 pés, Capacidade de carga: 540 lb.',
  'PHB 2024'
);

-- Elefante
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Elefante',
  'Montaria',
  200.00, '200', 'PO',
  NULL, '',
  'Velocidade: 40 pés, Capacidade de carga: 1320 lb.',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS TERRESTRES
-- ============================================================

-- Transporte
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Transporte',
  'Veículo (terrestre)',
  100.00, '100', 'PO',
  600.00, '600',
  'PHB 2024'
);

-- Carrinho
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Carrinho',
  'Veículo (terrestre)',
  15.00, '15', 'PO',
  200.00, '200',
  'PHB 2024'
);

-- Carruagem
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Carruagem',
  'Veículo (terrestre)',
  250.00, '250', 'PO',
  100.00, '100',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS AÉREOS
-- ============================================================

-- Dirigível
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Dirigível',
  'Veículo (aéreo)',
  40000.00, '40.000', 'PO',
  NULL, '',
  'Velocidade: 8 mph. Capacidade de carga: 1 tonelada de carga, 20 passageiros. Tripulação 10, CA 13, HP 300. Um navio navegando contra um vento forte move-se à metade da velocidade. Em uma calmaria total (sem vento), os navios não podem navegar à vela e devem ser remados.',
  'PHB 2024'
);

-- ============================================================
-- VEÍCULOS AQUÁTICOS
-- ============================================================

-- Galera
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Galera',
  'Veículo (água)',
  30000.00, '30.000', 'PO',
  NULL, '',
  'Velocidade: 4 mph. Capacidade de carga: 150 toneladas de carga. Tripulação 80, CA 15, HP 500, Limite de dano 20. Um navio navegando contra um vento forte move-se à metade da velocidade. Reparo de Navios: Reparar 1 Ponto de Vida de dano requer 1 dia e custa 20 GP em materiais e mão de obra.',
  'PHB 2024'
);

-- ============================================================
-- ARREIOS E EQUIPAMENTOS
-- ============================================================

-- Sela Exótica
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Sela Exótica',
  'Arreios e Equipamentos',
  60.00, '60', 'PO',
  40.00, '40',
  'Uma sela vem com freio, bridão, rédeas e qualquer outro equipamento necessário para usá-la. Uma sela exótica é necessária para montar uma montaria aquática ou voadora.',
  'PHB 2024'
);

-- Alimentação (por dia)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "source"
) VALUES (
  'Alimentação (por dia)',
  'Arreios e Equipamentos',
  0.05, '5', 'PC',
  10.00, '10',
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
