-- ============================================================
-- INSERÇÃO DE TODAS AS RAÇAS - PHB 2024
-- ============================================================
-- Este script insere as raças do Player's Handbook 2024
-- Total: 9 raças (Humano e Anão já existem)
-- ============================================================

-- ============================================================
-- 1. AASIMAR
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Aasimar',
  'Aasimares são descendentes de seres celestiais, carregando uma centelha divina em seu sangue. Eles são abençoados com poderes celestiais e muitas vezes sentem um chamado para combater o mal e proteger os inocentes.',
  'Médio (cerca de 4 a 7 pés de altura) ou Pequeno (cerca de 2 a 4 pés de altura), escolhido ao selecionar esta espécie',
  30,
  'PHB 2024',
  'Comum',
  '[
    {
      "name": "Resistência Celestial",
      "description": "Você tem resistência a dano Necrótico e dano Radiante.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Mãos Curativas",
      "usage_type": "Por Longo Descanso",
      "description": "Como uma ação de Magia, você toca uma criatura e rola um número de d4s igual ao seu Bônus de Proficiência. A criatura recupera um número de Pontos de Vida igual ao total rolado. Depois de usar esta característica, você não pode usá-la novamente até terminar um Descanso Longo.",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Portador da Luz",
      "description": "Você conhece o truque da Luz. Carisma é a sua habilidade de conjuração para ele.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Revelação Celestial",
      "usage_type": "Por Longo Descanso",
      "description": "Ao atingir o nível 3 de personagem, você pode se transformar como uma Ação Bônus usando uma das opções: Asas Celestiais (Velocidade de Voo), Radiância Interior (emite luz e causa dano), ou Mortalha Necrótica (causa medo). A transformação dura 1 minuto. Uma vez em cada um dos seus turnos, você pode causar dano extra igual ao seu Bônus de Proficiência.",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Resistência Celestial: Você tem resistência a dano Necrótico e dano Radiante.
Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Mãos Curativas: Como uma ação de Magia, você toca uma criatura e rola um número de d4s igual ao seu Bônus de Proficiência. A criatura recupera um número de Pontos de Vida igual ao total rolado.
Portador da Luz: Você conhece o truque da Luz. Carisma é a sua habilidade de conjuração para ele.
Revelação Celestial: Ao atingir o nível 3, você pode se transformar como uma Ação Bônus (Asas Celestiais, Radiância Interior ou Mortalha Necrótica).',
  'Luz (truque)'
);

-- ============================================================
-- 2. DRACONATO (DRAGONBORN)
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Draconato',
  'Draconatos são descendentes de dragões, carregando a majestade e o poder de seus ancestrais dracônicos. Sua linhagem dracônica determina a cor de suas escamas e o tipo de sopro que possuem.',
  'Médio (cerca de 1,5 a 2,1 metros de altura)',
  30,
  'PHB 2024',
  'Comum, Dracônico',
  '[
    {
      "name": "Ancestralidade Dracônica",
      "description": "Sua linhagem provém de um progenitor dragão. Escolha o tipo de dragão (Preto/Azul/Latão/Bronze/Cobre/Ouro/Verde/Vermelho/Prata/Branco). Sua escolha afeta suas características de Sopro e Resistência a Dano, bem como sua aparência.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Sopro",
      "usage_type": "Por Proficiência",
      "description": "Ao realizar a ação de Ataque, você pode substituir um ataque por uma exalação de energia em Cone de 4,5m ou Linha de 9m. Criaturas na área fazem TR de Destreza (CD 8 + mod. Constituição + Bônus de Proficiência). Falha: 1d10 de dano do tipo da ancestralidade. Sucesso: metade. Dano aumenta em 1d10 nos níveis 5 (2d10), 11 (3d10) e 17 (4d10).",
      "usage_value": null,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": true,
      "initial_dice": "1d10",
      "dice_increases": [
        {"level": 5, "dice": "2d10"},
        {"level": 11, "dice": "3d10"},
        {"level": 17, "dice": "4d10"}
      ],
      "has_hit_point_increase": false
    },
    {
      "name": "Resistência a Dano",
      "description": "Você tem Resistência ao tipo de dano determinado pela sua característica Ancestralidade Dracônica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Voo Dracônico",
      "usage_type": "Por Longo Descanso",
      "description": "Ao atingir o nível 5, você pode criar asas espectrais com uma Ação Bônus que duram 10 minutos. Durante esse tempo, você tem Velocidade de Voo igual à sua Velocidade.",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Ancestralidade Dracônica: Escolha um tipo de dragão que determina seu sopro e resistência.
Sopro: Exale energia mágica em cone ou linha. Usos iguais ao Bônus de Proficiência.
Resistência a Dano: Resistência ao tipo de dano da sua ancestralidade.
Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Voo Dracônico: No nível 5, ganhe asas espectrais temporárias.',
  ''
);

-- ============================================================
-- 3. ELFO
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Elfo',
  'Elfos são seres graciosos e mágicos, com uma conexão profunda com a natureza e a magia. Sua linhagem élfica determina suas habilidades sobrenaturais e magias conhecidas.',
  'Médio (cerca de 1,5 a 1,8 metros de altura)',
  30,
  'PHB 2024',
  'Comum, Élfico',
  '[
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Linhagem Élfica",
      "description": "Escolha uma linhagem: Drow (Visão no Escuro 36m, Luzes Dançantes, Fogo de Fada nv3, Escuridão nv5), Alto Elfo (Prestidigitação, Detectar Magia nv3, Passo Nebuloso nv5), ou Elfo da Floresta (Velocidade 35 pés, Druidismo, Longstrider nv3, Passe sem deixar rastros nv5). Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Ancestralidade Feérica",
      "description": "Você tem Vantagem em testes de resistência que realiza para evitar ou encerrar a condição Encantado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Sentidos Aguçados",
      "description": "Você tem proficiência na perícia Intuição, Percepção ou Sobrevivência.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Transe",
      "description": "Você não precisa dormir, e magia não pode te fazer dormir. Você pode terminar um Descanso Longo em 4 horas se passar essas horas em uma meditação semelhante a um transe, durante a qual você retém a consciência.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Linhagem Élfica: Escolha Drow, Alto Elfo ou Elfo da Floresta para determinar suas magias e habilidades.
Ancestralidade Feérica: Vantagem contra a condição Encantado.
Sentidos Aguçados: Proficiência em Intuição, Percepção ou Sobrevivência.
Transe: Descanso Longo em 4 horas de meditação.',
  'Varia por linhagem'
);

-- ============================================================
-- 4. GNOMO
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Gnomo',
  'Gnomos são pequenos humanoides conhecidos por sua curiosidade, inteligência e afinidade com a magia e a engenhosidade. Sua linhagem gnômica determina suas habilidades especiais.',
  'Pequeno (cerca de 3-4 pés de altura)',
  30,
  'PHB 2024',
  'Comum, Gnômico',
  '[
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Astúcia Gnômica",
      "description": "Você tem vantagem em testes de resistência de Inteligência, Sabedoria e Carisma.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Linhagem Gnômica",
      "description": "Escolha uma linhagem: Gnomo da Floresta (Ilusão Menor, Falar com Animais usos = Bônus de Proficiência) ou Gnomo de Pedra (Reparo e Prestidigitação, pode criar dispositivos mecânicos). Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Astúcia Gnômica: Vantagem em TR de Inteligência, Sabedoria e Carisma.
Linhagem Gnômica: Escolha Gnomo da Floresta ou Gnomo de Pedra para determinar suas magias e habilidades.',
  'Varia por linhagem'
);

-- ============================================================
-- 5. GOLIATH
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Goliath',
  'Goliaths são descendentes de gigantes, conhecidos por sua força impressionante e resistência. Sua ancestralidade gigante lhes concede poderes sobrenaturais relacionados ao tipo de gigante de que descendem.',
  'Médio (cerca de 2,10 a 2,40 metros de altura)',
  35,
  'PHB 2024',
  'Comum, Gigante',
  '[
    {
      "name": "Ancestralidade Gigante",
      "usage_type": "Por Proficiência",
      "description": "Escolha um benefício: Passeio das Nuvens (teletransporte 9m), Queimadura de Fogo (+1d10 fogo), Frio de Gelo (+1d6 gelo e reduz velocidade), Queda da Colina (derruba alvo), Resistência da Pedra (reduz dano com 1d12 + mod. Constituição), ou Trovão da Tempestade (1d8 trovão em reação). Usos = Bônus de Proficiência.",
      "usage_value": null,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Forma Grande",
      "usage_type": "Por Longo Descanso",
      "description": "A partir do nível 5, você pode alterar seu tamanho para Grande como uma Ação Bônus. A transformação dura 10 minutos. Você tem Vantagem em testes de Força e sua Velocidade aumenta em 3 metros.",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Estrutura Poderosa",
      "description": "Você tem Vantagem em testes para encerrar a condição Agarrado. Você também conta como um tamanho maior ao determinar sua capacidade de carga.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Ancestralidade Gigante: Escolha um poder relacionado a um tipo de gigante. Usos = Bônus de Proficiência.
Forma Grande: No nível 5, torne-se Grande temporariamente com vantagem em Força.
Estrutura Poderosa: Vantagem contra Agarrado e maior capacidade de carga.',
  ''
);

-- ============================================================
-- 6. HALFLING
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Halfling',
  'Halflings são pequenos humanoides conhecidos por sua coragem, sorte e habilidade de passar despercebidos. Apesar de seu tamanho, são aventureiros corajosos e resilientes.',
  'Pequeno (cerca de 2 a 3 pés de altura)',
  30,
  'PHB 2024',
  'Comum, Halfling',
  '[
    {
      "name": "Corajoso",
      "description": "Você tem Vantagem em testes de resistência que realiza para evitar ou encerrar a condição de Assustado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Agilidade Halfling",
      "description": "Você pode se mover pelo espaço de qualquer criatura que seja um tamanho maior que você, mas não pode parar no mesmo espaço.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Sorte",
      "description": "Ao tirar 1 no d20 de um Teste D20, você pode rolar o dado novamente e deve usar o novo resultado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Naturalmente Furtivo",
      "description": "Você pode realizar a ação Esconder-se mesmo quando estiver obscurecido apenas por uma criatura que seja pelo menos um tamanho maior que você.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Corajoso: Vantagem contra a condição Assustado.
Agilidade Halfling: Pode se mover pelo espaço de criaturas maiores.
Sorte: Rerrole 1s em Testes D20.
Naturalmente Furtivo: Esconda-se atrás de criaturas maiores.',
  ''
);

-- ============================================================
-- 7. ORC
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Orc',
  'Orcs são guerreiros ferozes e resilientes, conhecidos por sua força e tenacidade em batalha. Sua adrenalina e resistência os tornam adversários formidáveis.',
  'Médio (cerca de 1,80 a 2,13 metros de altura)',
  30,
  'PHB 2024',
  'Comum, Orc',
  '[
    {
      "name": "Adrenalina",
      "usage_type": "Por Proficiência",
      "description": "Você pode realizar a ação de Disparada como uma Ação Bônus. Ao fazer isso, você ganha uma quantidade de Pontos de Vida Temporários igual ao seu Bônus de Proficiência. Usos = Bônus de Proficiência.",
      "usage_value": null,
      "usage_recovery": "Descanso Curto ou Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 36 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Resistência Implacável",
      "usage_type": "Por Longo Descanso",
      "description": "Quando você for reduzido a 0 Pontos de Vida, mas não for morto imediatamente, você pode cair para 1 Ponto de Vida. Depois de usar esta característica, você não poderá fazê-lo novamente até terminar um Descanso Longo.",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "has_usage_limit": true,
      "usage_attribute": null,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Adrenalina: Disparada como Ação Bônus ganhando PV temporários. Usos = Bônus de Proficiência.
Visão no Escuro: Você tem Visão no Escuro com um alcance de 36 metros.
Resistência Implacável: Uma vez por descanso longo, caia para 1 PV ao invés de 0.',
  ''
);

-- ============================================================
-- 8. TIEFLING
-- ============================================================
INSERT INTO "public"."races" (
  "name",
  "description",
  "size",
  "speed",
  "source",
  "languages",
  "traits",
  "traits_text",
  "racial_spells"
) VALUES (
  'Tiefling',
  'Tieflings carregam a marca de uma herança demoníaca, manifestando traços sobrenaturais e poderes mágicos. Seu legado demoníaco determina suas resistências e magias conhecidas.',
  'Médio (cerca de 4 a 7 pés de altura) ou Pequeno (cerca de 3 a 4 pés de altura), escolhido ao selecionar esta espécie',
  30,
  'PHB 2024',
  'Comum',
  '[
    {
      "name": "Visão no Escuro",
      "description": "Você tem Visão no Escuro com um alcance de 18 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Legado Demoníaco",
      "description": "Escolha um legado: Abissal (Resistência a Veneno, Spray de Veneno, Raio da Doença nv3, Segurar Pessoa nv5), Ctônico (Resistência Necrótico, Toque Congelante, Vida Falsa nv3, Raio de Enfraquecimento nv5), ou Infernal (Resistência a Fogo, Raio de Fogo, Repreensão Infernal nv3, Escuridão nv5). Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    },
    {
      "name": "Presença Sobrenatural",
      "description": "Você conhece o truque Taumaturgia. Ao conjurá-lo, a magia usa a mesma habilidade de conjuração do seu Legado Demoníaco.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_hit_point_increase": false
    }
  ]'::jsonb,
  'Visão no Escuro: Você tem Visão no Escuro com um alcance de 18 metros.
Legado Demoníaco: Escolha Abissal, Ctônico ou Infernal para determinar resistência e magias.
Presença Sobrenatural: Você conhece o truque Taumaturgia.',
  'Varia por legado + Taumaturgia'
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
-- Verificar quantas raças foram inseridas
SELECT 
  COUNT(*) as total_racas,
  source
FROM races
WHERE source = 'PHB 2024'
GROUP BY source;

-- Listar todas as raças PHB 2024
SELECT 
  name,
  size,
  speed,
  jsonb_array_length(traits) as total_tracos
FROM races
WHERE source = 'PHB 2024'
ORDER BY name;
