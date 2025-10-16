-- Inserir classe Guardião (PHB 2024)
INSERT INTO "public"."classes" (
  "id",
  "name",
  "hit_die",
  "primary_ability",
  "saving_throws",
  "skill_proficiencies",
  "equipment",
  "features",
  "spellcasting",
  "created_at",
  "updated_at",
  "source",
  "armor_proficiencies",
  "weapon_proficiencies",
  "tool_proficiencies",
  "subclasses",
  "description",
  "equipment_lado_a",
  "equipment_lado_b",
  "level_features",
  "has_spells",
  "spell_levels",
  "spell_slots_levels",
  "subclasses_details",
  "skill_count",
  "has_usage_limit",
  "usage_type",
  "usage_value",
  "usage_recovery",
  "usage_attribute",
  "manual_level_increases",
  "has_dice_increase",
  "initial_dice",
  "dice_increases",
  "has_proficiency_doubling",
  "proficiency_skill_count",
  "equipment_lado_a_items",
  "equipment_lado_b_items",
  "po_lado_a",
  "po_lado_b",
  "equipment_choices"
) VALUES (
  gen_random_uuid(),
  'Guardião',
  10,
  'Sabedoria',
  'Força, Sabedoria',
  'Adestrar Animais, Atletismo, Furtividade, Intuição, Investigação, Medicina, Natureza, Percepção, Religião, Sobrevivência',
  null,
  null,
  '""',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Armaduras Médias, Escudos',
  'Armas Simples, Armas Marciais',
  '',
  '',
  'Os Guardiões são protetores da natureza, usando magia primitiva para defender o mundo natural e suas criaturas. Eles são versáteis combatentes que combinam habilidades marciais com magia divina, servindo como intermediários entre o mundo civilizado e o selvagem.',
  '',
  '',
  '[
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Você aprendeu a conjurar magias através de sua conexão com a natureza.\n\nTruques. Você conhece dois truques à sua escolha da lista de magias de Guardião. Orientação e Produzir Chamas são recomendados.\n\nSempre que você ganha um nível de Guardião, você pode substituir um dos seus truques por outro truque de sua escolha da lista de magias de Guardião.\n\nQuando você alcança os níveis 4, 8, 12, 16 e 20 de Guardião, você aprende outro truque de sua escolha da lista de magias de Guardião, como mostrado na coluna Truques da tabela de Recursos do Guardião.\n\nEspaços de Magia. A tabela de Recursos do Guardião mostra quantos espaços de magia você tem para conjurar suas magias de nível 1+. Você recupera todos os espaços gastos ao terminar um Descanso Longo.\n\nMagias Conhecidas de Nível 1+. Você conhece magias de nível 1+ da lista de magias de Guardião. Para começar, escolha duas magias de nível 1 da lista de magias de Guardião. Cura de Ferimentos e Raio Guia são recomendadas.\n\nO número de magias na sua lista aumenta à medida que você ganha níveis de Guardião, conforme mostrado na coluna Magias Conhecidas da tabela de Características do Guardião.\n\nAlterando suas Magias Conhecidas. Sempre que terminar um Descanso Longo, você pode substituir uma magia conhecida por outra magia de Guardião do mesmo nível.\n\nHabilidade de Conjuração. Sabedoria é sua habilidade de conjuração para suas magias de Guardião.\n\nFoco de Conjuração. Você pode usar um Foco Druídico como Foco de Conjuração para suas magias de Guardião.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Inimigo Favorito",
      "level": 1,
      "description": "Você tem experiência significativa estudando, rastreando, caçando e até mesmo conversando com um certo tipo de inimigo.\n\nEscolha um tipo de inimigo favorito: aberrações, bestas, celestiais, constructos, dragões, elementais, fadas, gigantes, monstros, mortos-vivos ou plantas. Você tem vantagem em testes de Sobrevivência para rastrear suas criaturas favoritas, bem como em testes de Inteligência para lembrar informações sobre elas.\n\nQuando você ganha essa característica, você também aprende uma língua de sua escolha, normalmente uma falada por seu tipo de inimigo favorito ou uma língua relacionada a ele.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Arma",
      "level": 1,
      "description": "Você ganha proficiência com armas marciais e com armaduras médias.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Estilo de Luta",
      "level": 2,
      "description": "Você adota um estilo particular de luta como sua especialidade. Escolha uma das seguintes opções:\n\nArqueiro: Você ganha um bônus de +2 nas jogadas de ataque que você faz com armas à distância.\n\nDefesa: Enquanto você estiver usando armadura, você ganha um bônus de +1 na sua Classe de Armadura.\n\nDuelista: Quando você empunha uma arma corpo a corpo em uma mão e nenhuma outra arma, você ganha um bônus de +2 no dano com essa arma.\n\nLuta com Duas Armas: Quando você se engaja em luta com duas armas, você pode adicionar seu modificador de habilidade ao dano do segundo ataque.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Explorador Hábil",
      "level": 2,
      "description": "Você é um explorador excepcional. Você ganha as seguintes características:\n\nExplorador Natural: Você tem vantagem em testes de Sobrevivência para rastrear criaturas, bem como em testes de Inteligência para lembrar informações sobre terrenos, assentamentos e criaturas que você já observou.\n\nExplorador do Mundo: Você pode se mover através de terreno difícil (exceto terreno mágico) sem sofrer penalidades de movimento. Quando você viaja por uma hora ou mais, você ganha os seguintes benefícios:\n• Terreno difícil não diminui a velocidade de viagem do seu grupo\n• Seu grupo não pode se perder, exceto por meios mágicos\n• Mesmo quando você está engajado em outra atividade enquanto viaja (como forrageamento, navegação ou rastreamento), você permanece alerta ao perigo\n• Se você viaja sozinho, você pode se mover furtivamente a uma velocidade normal\n• Quando você forrageia, você encontra o dobro da comida que normalmente encontraria\n• Enquanto rastreia outras criaturas, você também aprende seu número exato, seus tamanhos e há quanto tempo passaram pela área.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Guardião",
      "level": 3,
      "description": "Você ganha uma subclasse de Guardião à sua escolha. Uma subclasse é uma especialização que lhe concede características em determinados níveis de Guardião. Pelo resto da sua carreira, você ganha cada uma das características da sua subclasse que sejam do seu nível de Guardião ou inferior.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aumento no Valor de Atributo",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha para o qual você se qualifique. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Guardião.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataque Extra",
      "level": 5,
      "description": "Você pode atacar duas vezes, em vez de uma vez, sempre que você realizar a ação de Ataque no seu turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Errante",
      "level": 6,
      "description": "Você ganha a capacidade de se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 7,
      "description": "Você ganha uma característica da sua Subclasse de Guardião.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aumento no Valor de Atributo",
      "level": 8,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Especialista",
      "level": 9,
      "description": "Você ganha a capacidade de se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Incansável",
      "level": 10,
      "description": "Você pode se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 11,
      "description": "Você ganha uma característica da sua Subclasse de Guardião.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aumento no Valor de Atributo",
      "level": 12,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Predador Implacável",
      "level": 13,
      "description": "Você pode se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Véu da Natureza",
      "level": 14,
      "description": "Você pode se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 15,
      "description": "Você ganha uma característica da sua Subclasse de Guardião.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aumento no Valor de Atributo",
      "level": 16,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Caçador Preciso",
      "level": 17,
      "description": "Você pode se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Sentidos Selvagens",
      "level": 18,
      "description": "Você pode se mover através de qualquer terreno sem sofrer penalidades de movimento. Terreno difícil não diminui sua velocidade de viagem, e você pode se mover através de terreno não-mágico sem sofrer penalidades de movimento. Além disso, você tem vantagem em testes de salvamento contra plantas mágicas e efeitos mágicos que criam terreno difícil.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Dádiva Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha para o qual você se qualifique.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Matador de Inimigos Favoritos",
      "level": 20,
      "description": "Você se torna um mestre caçador. Quando você ataca sua criatura favorita, você ganha os seguintes benefícios:\n\n• Você tem vantagem em jogadas de ataque contra suas criaturas favoritas\n• Sempre que você acertar uma criatura favorita com uma jogada de ataque, a criatura sofre dano extra igual ao seu modificador de Sabedoria (mínimo de 1)\n• Você tem vantagem em testes de salvamento contra as habilidades e magias de suas criaturas favoritas",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
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
  ]'::jsonb,
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
  ]'::jsonb,
  '[
    {
      "name": "Guardião da Natureza",
      "description": "Os Guardiões da Natureza são protetores dedicados do mundo natural. Eles usam magia primitiva para defender as terras selvagens e suas criaturas contra aqueles que as ameaçam.",
      "features": [
        {
          "name": "Magias do Guardião da Natureza",
          "level": 3,
          "description": "Sua conexão com a natureza garante que você sempre tenha certas magias prontas. Ao atingir um nível de Guardião especificado, você sempre terá as magias listadas preparadas:\n\nNível 3: Amizade com Animais, Falar com Plantas\nNível 5: Convocar Animais, Locais de Plantas\nNível 7: Convocar Feras, Locais de Plantas\nNível 9: Convocar Elementais, Locais de Plantas",
          "isPassive": true
        },
        {
          "name": "Companheiro Animal",
          "level": 3,
          "description": "Você ganha um companheiro animal que luta ao seu lado. O companheiro obedece aos seus comandos e age no seu turno de combate.",
          "isPassive": true
        },
        {
          "name": "Proteção da Natureza",
          "level": 7,
          "description": "Você pode usar sua ação para magicamente assumir a forma de uma besta que você já viu. Você pode usar essa característica duas vezes. Você recupera usos gastos quando termina um descanso longo.",
          "isPassive": false
        },
        {
          "name": "Fúria da Natureza",
          "level": 11,
          "description": "Você pode conjurar a magia Convocar Feras sem gastar um espaço de magia. Você recupera essa habilidade quando termina um descanso longo.",
          "isPassive": false
        },
        {
          "name": "Mestre da Natureza",
          "level": 15,
          "description": "Você pode usar sua ação para magicamente assumir a forma de uma besta que você já viu de CR 4 ou menor. Você pode usar essa característica duas vezes. Você recupera usos gastos quando termina um descanso longo.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Caçador",
      "description": "Os Caçadores são especialistas em rastrear e eliminar ameaças específicas. Eles são mestres em localizar, estudar e derrotar seus inimigos favoritos.",
      "features": [
        {
          "name": "Magias do Caçador",
          "level": 3,
          "description": "Sua especialização em caça garante que você sempre tenha certas magias prontas:\n\nNível 3: Localizar Objeto, Passar Sem Rastros\nNível 5: Localizar Criatura, Passar Sem Rastros\nNível 7: Localizar Objeto, Passar Sem Rastros\nNível 9: Localizar Criatura, Passar Sem Rastros",
          "isPassive": true
        },
        {
          "name": "Inimigo Favorito Aprimorado",
          "level": 3,
          "description": "Você ganha vantagem em jogadas de ataque contra suas criaturas favoritas. Além disso, você pode adicionar seu modificador de Sabedoria ao dano causado a suas criaturas favoritas.",
          "isPassive": true
        },
        {
          "name": "Rastreador Implacável",
          "level": 7,
          "description": "Você pode rastrear criaturas através de qualquer terreno, mesmo através de magia que normalmente impediria o rastreamento. Você tem vantagem em testes de Sobrevivência para rastrear suas criaturas favoritas.",
          "isPassive": true
        },
        {
          "name": "Caçador de Monstros",
          "level": 11,
          "description": "Você ganha resistência ao dano causado por suas criaturas favoritas. Além disso, você pode usar sua ação para fazer um ataque especial contra uma criatura favorita que você possa ver a até 18 metros de você.",
          "isPassive": false
        },
        {
          "name": "Mestre Caçador",
          "level": 15,
          "description": "Você se torna um mestre em eliminar suas criaturas favoritas. Quando você ataca uma criatura favorita, você pode rolar novamente qualquer jogada de ataque que errar e deve usar o novo resultado.",
          "isPassive": true
        }
      ]
    }
  ]'::jsonb,
  3,
  false,
  null,
  null,
  null,
  null,
  null,
  false,
  null,
  null,
  false,
  0,
  '[
    {"name": "Armadura de couro", "cost": "10.0", "weight": "10.0", "category": "Armadura", "quantity": 1},
    {"name": "Arco longo", "cost": "50.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Aljava com 20 flechas", "cost": "1.0", "weight": "1.0", "category": "Munição", "quantity": 1},
    {"name": "Foco druídico", "cost": "5.0", "weight": "1.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do explorador", "cost": "10.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[
    {"name": "Armadura de couro", "cost": "10.0", "weight": "10.0", "category": "Armadura", "quantity": 1},
    {"name": "Espada longa", "cost": "15.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Escudo", "cost": "10.0", "weight": "6.0", "category": "Armadura", "quantity": 1},
    {"name": "Foco druídico", "cost": "5.0", "weight": "1.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do explorador", "cost": "10.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  0,
  0,
  '[]'::jsonb
);
