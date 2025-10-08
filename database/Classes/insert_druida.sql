-- Inserir classe Druida (PHB 2024)
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
  'Druida',
  8,
  'Sabedoria',
  'Inteligência, Sabedoria',
  'Arcanismo, Adestrar Animais, Intuição, Medicina, Natureza, Percepção, Religião, Sobrevivência',
  null,
  null,
  '""',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Escudos',
  'Armas Simples',
  'Kit de Herbalismo',
  '',
  'Invocando a magia primordial da natureza, os Druidas são guardiões do mundo natural. Eles canalizam o poder dos elementos, transformam-se em bestas selvagens e comandam as forças da natureza para proteger o equilíbrio entre civilização e natureza. Druidas acreditam que a natureza é uma força viva e consciente, e dedicam suas vidas a preservá-la.',
  '',
  '',
  '[
    {
      "name": "Druídico",
      "level": 1,
      "description": "Você conhece o Druídico, a língua secreta dos Druidas. Ao aprender essa língua ancestral, você também desbloqueou a magia da comunicação com os animais; você sempre tem o feitiço Falar com Animais preparado.\n\nVocê pode usar o Druídico para deixar mensagens ocultas. Você e outros que conhecem o Druídico identificam automaticamente tais mensagens. Outros identificam a presença da mensagem com um teste bem-sucedido de Inteligência CD 15 (Investigação), mas não conseguem decifrá-la sem magia.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ordem Primordial",
      "level": 1,
      "description": "Você se dedicou a uma das seguintes funções sagradas de sua escolha.\n\nMágico: Você conhece um truque extra da lista de magias de Druida. Além disso, sua conexão mística com a natureza lhe concede um bônus em seus testes de Inteligência (Arcana ou Natureza). O bônus é igual ao seu modificador de Sabedoria (bônus mínimo de +1).\n\nDiretor: Treinado para a batalha, você ganha proficiência com armas marciais e treinamento com armaduras médias.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Você aprendeu a conjurar magias estudando as forças místicas da natureza.\n\nTruques. Você conhece dois truques à sua escolha da lista de magias do Druida. Artesanato do Druida e Produzir Chama são recomendados.\n\nSempre que você ganha um nível de Druida, você pode substituir um dos seus truques por outro truque de sua escolha da lista de magias de Druida.\n\nQuando você alcança os níveis 4 e 10 de Druida, você aprende outro truque de sua escolha na lista de magias de Druida, como mostrado na coluna Truques da tabela Características do Druida.\n\nEspaços de Magia. A tabela de Recursos do Druida mostra quantos espaços de magia você tem para conjurar suas magias de nível 1+. Você recupera todos os espaços gastos ao terminar um Descanso Longo.\n\nMagias Preparadas de Nível 1+. Você prepara a lista de magias de nível 1+ disponíveis para você conjurar com esta habilidade. Para começar, escolha quatro magias de nível 1 da lista de magias do Druida. Amizade Animal, Curar Ferimentos, Fogo Feérico e Onda Trovejante são recomendadas.\n\nO número de magias na sua lista aumenta à medida que você ganha níveis de Druida, conforme mostrado na coluna Magias Preparadas da tabela de Características do Druida.\n\nAlterando suas Magias Preparadas. Sempre que terminar um Descanso Longo, você pode alterar sua lista de magias preparadas.\n\nHabilidade de Conjuração. Sabedoria é sua habilidade de conjuração para suas magias de Druida.\n\nFoco de Conjuração. Você pode usar um Foco Druídico como Foco de Conjuração para suas magias de Druida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Companheiro Selvagem",
      "level": 2,
      "description": "Você pode invocar um espírito da natureza que assume a forma de um animal para ajudá-lo. Como uma ação de Magia, você pode gastar um espaço de magia ou usar Forma Selvagem para conjurar a magia Encontrar Familiar sem componentes Materiais.\n\nQuando você lança o feitiço dessa forma, o familiar é Fey e desaparece quando você termina um Descanso Longo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Forma Selvagem",
      "level": 2,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "O poder da natureza permite que você assuma a forma de um animal. Como uma Ação Bônus, você se transforma em uma forma Bestial que aprendeu para esta habilidade. Você permanece nessa forma por um número de horas igual à metade do seu nível de Druida ou até usar Forma Selvagem novamente, ficar na condição Incapacitado ou morrer.\n\nNúmero de Usos. Você pode usar Forma Selvagem duas vezes. Você recupera um uso gasto ao terminar um Descanso Curto e recupera todos os usos gastos ao terminar um Descanso Longo.\n\nFormas Conhecidas. Você conhece quatro formas de Besta para esta habilidade, escolhidas entre blocos de atributos de Besta que têm um Nível de Desafio máximo de 1/4 e que não possuem Velocidade de Voo. Rato, Cavalo de Montaria, Aranha e Lobo são recomendados.\n\nAo atingir certos níveis de Druida, o número de formas conhecidas e o Nível de Desafio máximo para essas formas aumentam:\n- Nível 2: 4 formas, CR 1/4, sem voo\n- Nível 4: 6 formas, CR 1/2, sem voo\n- Nível 8: 8 formas, CR 1, com voo\n\nRegras para a Transformação:\n- Pontos de Vida Temporários: Ao assumir a forma Selvagem, você ganha uma quantidade de Pontos de Vida Temporários igual ao seu nível de Druida.\n- Estatísticas do Jogo: Suas estatísticas de jogo são substituídas pelo bloco de estatísticas da Besta, mas você mantém seu tipo de criatura, Pontos de Vida, Dados de Ponto de Vida, valores de Inteligência, Sabedoria e Carisma, características de classe, idiomas e talentos.\n- Sem Conjuração de Magias: Você não pode conjurar magias, mas a mudança de forma não quebra sua Concentração.\n- Objetos: Você escolhe se seu equipamento cai no seu espaço, se funde com a sua nova forma ou se é usado por ela.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "manual_level_increases": [
        {"level": 6, "increase": 3},
        {"level": 10, "increase": 4},
        {"level": 14, "increase": 5},
        {"level": 18, "increase": 6}
      ],
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse Druida",
      "level": 3,
      "description": "Você ganha uma subclasse de Druida à sua escolha. Uma subclasse é uma especialização que lhe concede características em determinados níveis de Druida. Pelo resto da sua carreira, você ganha cada uma das características da sua subclasse que sejam do seu nível de Druida ou inferior.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha para o qual você se qualifique. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Druida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ressurgimento Selvagem",
      "level": 5,
      "description": "Uma vez em cada um dos seus turnos, se você não tiver mais usos de Forma Selvagem, você pode se dar um uso gastando um espaço de magia (nenhuma ação necessária).\n\nAlém disso, você pode gastar um uso de Forma Selvagem (nenhuma ação necessária) para ganhar um espaço de magia de nível 1, mas não pode fazer isso novamente até terminar um Descanso Longo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua Subclasse de Druida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Fúria Elemental",
      "level": 7,
      "description": "O poder dos elementos flui através de você. Você ganha uma das seguintes opções à sua escolha.\n\nConjuração Potente: Adicione seu modificador de Sabedoria ao dano causado com qualquer truque de Druida.\n\nAtaque Primordial: Uma vez em cada um dos seus turnos, ao atingir uma criatura com uma jogada de ataque usando uma arma ou um ataque da forma Bestial em Forma Selvagem, você pode fazer com que o alvo receba 1d8 de dano adicional de Gelo, Fogo, Raio ou Trovão (escolha quando atingir).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na pontuação de habilidade",
      "level": 8,
      "description": "Você ganha o Talento de Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 10,
      "description": "Você ganha uma característica da sua Subclasse de Druida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na Pontuação de Habilidade",
      "level": 12,
      "description": "Você ganha o Talento de Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 14,
      "description": "Você ganha uma característica da sua Subclasse de Druida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Fúria Elemental Aprimorada",
      "level": 15,
      "description": "A opção que você escolheu para Fúria Elemental fica mais poderosa, conforme detalhado abaixo.\n\nConjuração Potente: Quando você conjura um truque mágico de Druida com alcance de 3 metros ou mais, o alcance da magia aumenta em 90 metros.\n\nAtaque Primordial: O dano extra do seu Ataque Primordial aumenta para 2d8.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na Pontuação de Habilidade",
      "level": 16,
      "description": "Você ganha o Talento de Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Feitiços de Besta",
      "level": 18,
      "description": "Ao usar Forma Selvagem, você pode conjurar magias na forma Bestial, exceto qualquer magia que tenha um componente Material com um custo especificado ou que consuma seu componente Material.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha para o qual você se qualifique. Dádiva de Viagem Dimensional é recomendada.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Arquidruida",
      "level": 20,
      "description": "A vitalidade da natureza floresce constantemente dentro de você, concedendo-lhe os seguintes benefícios.\n\nForma Selvagem Perene: Sempre que você rolar Iniciativa e não tiver mais usos para Forma Selvagem, você recupera um uso gasto dela.\n\nMago da Natureza: Você pode converter usos de Forma Selvagem em um espaço de magia (nenhuma ação necessária). Escolha um número de usos não utilizados de Forma Selvagem e converta-os em um único espaço de magia, com cada uso contribuindo com 2 níveis de magia. Por exemplo, se você converter dois usos de Forma Selvagem, você produz um espaço de magia de nível 4. Depois de usar este benefício, você não poderá fazê-lo novamente até terminar um Descanso Longo.\n\nLongevidade: A magia primordial que você exerce faz com que você envelheça mais lentamente. A cada dez anos que se passam, seu corpo envelhece apenas um ano.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
  '[
    {"level": 1, "cantrips": 2, "known_spells": 4},
    {"level": 2, "cantrips": 2, "known_spells": 5},
    {"level": 3, "cantrips": 2, "known_spells": 6},
    {"level": 4, "cantrips": 3, "known_spells": 7},
    {"level": 5, "cantrips": 3, "known_spells": 9},
    {"level": 6, "cantrips": 3, "known_spells": 10},
    {"level": 7, "cantrips": 3, "known_spells": 11},
    {"level": 8, "cantrips": 3, "known_spells": 12},
    {"level": 9, "cantrips": 3, "known_spells": 14},
    {"level": 10, "cantrips": 4, "known_spells": 15},
    {"level": 11, "cantrips": 4, "known_spells": 16},
    {"level": 12, "cantrips": 4, "known_spells": 16},
    {"level": 13, "cantrips": 4, "known_spells": 17},
    {"level": 14, "cantrips": 4, "known_spells": 17},
    {"level": 15, "cantrips": 4, "known_spells": 18},
    {"level": 16, "cantrips": 4, "known_spells": 18},
    {"level": 17, "cantrips": 4, "known_spells": 19},
    {"level": 18, "cantrips": 4, "known_spells": 20},
    {"level": 19, "cantrips": 4, "known_spells": 21},
    {"level": 20, "cantrips": 4, "known_spells": 22}
  ]'::jsonb,
  '[
    {"level": 1, "level_1": 2},
    {"level": 2, "level_1": 3},
    {"level": 3, "level_1": 4, "level_2": 2},
    {"level": 4, "level_1": 4, "level_2": 3},
    {"level": 5, "level_1": 4, "level_2": 3, "level_3": 2},
    {"level": 6, "level_1": 4, "level_2": 3, "level_3": 3},
    {"level": 7, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 1},
    {"level": 8, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 2},
    {"level": 9, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 1},
    {"level": 10, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2},
    {"level": 11, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1},
    {"level": 12, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1},
    {"level": 13, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1, "level_7": 1},
    {"level": 14, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1, "level_7": 1},
    {"level": 15, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1, "level_7": 1, "level_8": 1},
    {"level": 16, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1, "level_7": 1, "level_8": 1},
    {"level": 17, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 2, "level_6": 1, "level_7": 1, "level_8": 1, "level_9": 1},
    {"level": 18, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 3, "level_6": 1, "level_7": 1, "level_8": 1, "level_9": 1},
    {"level": 19, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 3, "level_6": 2, "level_7": 1, "level_8": 1, "level_9": 1},
    {"level": 20, "level_1": 4, "level_2": 3, "level_3": 3, "level_4": 3, "level_5": 3, "level_6": 2, "level_7": 2, "level_8": 1, "level_9": 1}
  ]'::jsonb,
  '[
    {
      "name": "Círculo da Terra",
      "description": "Celebre a conexão com o mundo natural. O Círculo da Terra é composto por místicos e sábios que salvaguardam conhecimentos e ritos ancestrais. Esses druidas se reúnem em círculos sagrados de árvores ou pedras eretas para sussurrar segredos primordiais em druídico.",
      "features": [
        {
          "name": "Círculo das Magias da Terra",
          "level": 3,
          "description": "Ao terminar um Descanso Longo, escolha um tipo de terreno: árido, polar, temperado ou tropical. Você já tem as magias listadas para o seu nível de Druida e inferiores preparadas.\n\nTerra árida (Nível 3): Borrão, Mãos em Chamas, Raio de Fogo; (5º) Bola de fogo; (7º) Praga; (9º) Muro de Pedra\n\nTerra Polar (Nível 3): Nuvem de neblina, Segure a pessoa, Raio de gelo; (5º) Tempestade de granizo; (7º) Tempestade de gelo; (9º) Cone de Frio\n\nTerra temperada (Nível 3): Passo Enevoado, Aperto Chocante, Sono; (5º) Relâmpago; (7º) Liberdade de movimento; (9º) Passo da Árvore\n\nTerra Tropical (Nível 3): Acid Splash, Raio de Doença, Web; (5º) Nuvem Fedorenta; (7º) Polimorfo; (9º) Praga de insetos",
          "isPassive": true
        },
        {
          "name": "Auxílio da Terra",
          "level": 3,
          "description": "Como uma ação de Magia, você pode gastar um uso da sua Forma Selvagem e escolher um ponto a até 18 metros de você. Flores que dão vitalidade e espinhos que drenam a vida aparecem por um momento em uma Esfera de 3 metros de raio centrada naquele ponto. Cada criatura à sua escolha na Esfera deve realizar um teste de resistência de Constituição contra sua CD de magia, sofrendo 2d6 de dano Necrótico em uma falha ou metade do dano em um sucesso. Uma criatura à sua escolha naquela área recupera 2d6 Pontos de Vida.\n\nO dano e a cura aumentam em 1d6 quando você atinge os níveis de Druida 10 (3d6) e 14 (4d6).",
          "isPassive": false
        },
        {
          "name": "Recuperação Natural",
          "level": 6,
          "description": "Você pode conjurar uma das magias de nível 1+ que você preparou do seu recurso Magias do Círculo sem gastar um espaço de magia, e você deve terminar um Descanso Longo antes de fazer isso novamente.\n\nAlém disso, ao terminar um Descanso Curto, você pode escolher espaços de magia gastos para recuperar. Os espaços de magia podem ter um nível combinado igual ou inferior à metade do seu nível de Druida (arredondado para cima), e nenhum deles pode ser de nível 6+.",
          "isPassive": false
        },
        {
          "name": "Proteção da Natureza",
          "level": 10,
          "description": "Você é imune à condição Envenenado e tem Resistência a um tipo de dano associado à sua escolha de terreno atual:\n- Árido: Fogo\n- Polar: Frio\n- Temperado: Raio\n- Tropical: Tóxico",
          "isPassive": true
        },
        {
          "name": "Santuário da Natureza",
          "level": 14,
          "description": "Como uma ação de Magia, você pode gastar um uso da sua Forma Selvagem e fazer com que árvores e trepadeiras espectrais apareçam em um Cubo de 4,5 metros no chão a até 36 metros de você. Elas permanecem lá por 1 minuto. Você e seus aliados têm Meia Cobertura enquanto estiverem nessa área, e seus aliados ganham a Resistência atual da sua Proteção da Natureza.\n\nComo uma Ação Bônus, você pode mover o Cubo até 18 metros do chão em um raio de 36 metros de você.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Círculo da Lua",
      "description": "Adote formas animais para proteger a natureza. Os druidas do Círculo da Lua recorrem à magia lunar para se transformar. Mutável como a lua, um druida deste círculo pode rondar como um grande felino numa noite, planar sobre as copas das árvores como uma águia no dia seguinte e, então, atravessar a vegetação rasteira como um urso.",
      "features": [
        {
          "name": "Círculo da Lua",
          "level": 3,
          "description": "Quando você alcança um nível de Druida especificado, você sempre tem as magias listadas preparadas. Além disso, você pode lançar magias deste recurso enquanto estiver na forma Selvagem.\n\nNível 3: Curar Feridas, Raio de Lua, Fogo-fátuo Estrelado\nNível 5: Conjurar Animais\nNível 7: Fonte do Luar\nNível 9: Cura em massa de feridas",
          "isPassive": true
        },
        {
          "name": "Formas circulares",
          "level": 3,
          "description": "Você pode canalizar magia lunar ao assumir a forma Selvagem:\n\nNível de Desafio: O CR máximo para a forma é igual ao seu nível de Druida dividido por 3 (arredondado para baixo).\n\nClasse de Armadura: Até você sair da forma, sua CA é igual a 13 mais seu modificador de Sabedoria se esse total for maior que a CA da Besta.\n\nPontos de Vida Temporários: Você ganha uma quantidade de Pontos de Vida Temporários igual a três vezes o seu nível de Druida.",
          "isPassive": true
        },
        {
          "name": "Formas circulares aprimoradas",
          "level": 6,
          "description": "Enquanto estiver na forma Selvagem, você ganha os seguintes benefícios:\n\nResplendor Lunar: Cada um dos seus ataques na Forma Selvagem pode causar dano normal ou dano Radiante.\n\nResistência Aumentada: Você pode adicionar seu modificador de Sabedoria aos seus testes de resistência de Constituição.",
          "isPassive": true
        },
        {
          "name": "Passo do Luar",
          "level": 10,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Como uma Ação Bônus, você se teletransporta até 9 metros para um espaço desocupado que você possa ver, e tem Vantagem na próxima jogada de ataque que fizer antes do final deste turno.\n\nVocê pode usar esta habilidade um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez) e recupera todos os usos gastos ao terminar um Descanso Longo. Você também pode recuperar usos gastando um espaço de magia de nível 2+ para cada uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Forma Lunar",
          "level": 14,
          "description": "O poder da lua o envolve:\n\nResplendor Lunar Aprimorado: Uma vez por turno, você pode causar 2d10 de dano Radiante adicional a um alvo atingido com um ataque de uma Forma Selvagem.\n\nLuar Compartilhado: Sempre que usar Passo do Luar, você também pode teletransportar uma criatura disposta a até 3 metros de você para um espaço a até 3 metros do seu destino.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Círculo do Mar",
      "description": "Torne-se um com as marés e tempestades. Os druidas do Círculo do Mar inspiram-se nas forças tempestuosas dos oceanos e tempestades. Alguns se veem como personificações da ira da natureza, buscando vingança contra aqueles que a despojam.",
      "features": [
        {
          "name": "Círculo do Mar",
          "level": 3,
          "description": "Quando você alcança um nível de Druida especificado, você sempre tem as magias listadas preparadas:\n\nNível 3: Nuvem de neblina, rajada de vento, raio de geada, estilhaço, onda de trovão\nNível 5: Relâmpago, Respiração na Água\nNível 7: Controle de água, tempestade de gelo\nNível 9: Conjurar Elemental, Segurar Monstro",
          "isPassive": true
        },
        {
          "name": "Ira do Mar",
          "level": 3,
          "description": "Como uma Ação Bônus, você pode gastar um uso da sua Forma Selvagem para manifestar uma Emanação de 1,5 metro que assume a forma de borrifos do oceano e o cerca por 10 minutos.\n\nAo manifestar a Emanação, e como uma Ação Bônus em seus turnos subsequentes, você pode escolher outra criatura que possa ver na Emanação. O alvo deve ser bem-sucedido em um teste de resistência de Constituição contra sua CD de magia ou sofrer dano de Gelo e, se a criatura for Grande ou menor, será empurrada até 4,5 metros. Para determinar esse dano, role um número de d6s igual ao seu modificador de Sabedoria (mínimo de um dado).",
          "isPassive": false
        },
        {
          "name": "Afinidade Aquática",
          "level": 6,
          "description": "O tamanho da Emanação criada pela sua Ira do Mar aumenta para 3 metros.\n\nAlém disso, você ganha uma Velocidade de Natação igual à sua Velocidade.",
          "isPassive": true
        },
        {
          "name": "Nascido da Tempestade",
          "level": 10,
          "description": "Sua Ira do Mar confere mais dois benefícios enquanto ativa:\n\nVoo: Você ganha uma Velocidade de Voo igual à sua Velocidade.\n\nResistência: Você tem resistência a danos de Frio, Raio e Trovão.",
          "isPassive": true
        },
        {
          "name": "Dom Oceânico",
          "level": 14,
          "description": "Em vez de manifestar a Emanação da Fúria do Mar ao seu redor, você pode manifestá-la ao redor de uma criatura disposta a até 18 metros de distância. Essa criatura ganha todos os benefícios da Emanação e usa sua CD de resistência à magia e seu modificador de Sabedoria.\n\nAlém disso, você pode manifestar a Emanação ao redor da outra criatura e de si mesmo se você gastar dois usos da sua Forma Selvagem em vez de um.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Círculo das Estrelas",
      "description": "Aproveite os segredos escondidos nas constelações. O Círculo das Estrelas rastreia padrões celestiais desde tempos imemoriais, descobrindo segredos ocultos entre as constelações. Ao compreender esses segredos, os druidas deste círculo buscam dominar os poderes do cosmos.",
      "features": [
        {
          "name": "Mapa Estelar",
          "level": 3,
          "description": "Você criou um mapa estelar como parte dos seus estudos celestiais. É um objeto minúsculo e você pode usá-lo como Foco de Conjuração para suas magias de Druida.\n\nEnquanto segura o mapa, você tem as magias Orientação e Raio Guia preparadas, e pode conjurar Raio Guia sem gastar um espaço de magia. Você pode conjurá-lo dessa forma um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez), e você recupera todos os usos gastos ao terminar um Descanso Longo.\n\nSe você perder o mapa, poderá realizar uma cerimônia de 1 hora para criar magicamente um substituto.",
          "isPassive": true
        },
        {
          "name": "Forma Estrelada",
          "level": 3,
          "description": "Como uma Ação Bônus, você pode gastar um uso de sua Forma Selvagem para assumir uma forma estrelada. Esta forma dura 10 minutos e emite Luz Brilhante em 3 metros e Luz Penumbra por mais 3 metros.\n\nEscolha uma constelação:\n\nArqueiro: Ao ativar e como Ação Bônus, ataque mágico à distância (18m) causando 1d8 + Sabedoria de dano Radiante.\n\nCálice: Sempre que conjurar uma magia que restaure PV, você ou outra criatura a 9m recupera 1d8 + Sabedoria PV.\n\nDragão: Em testes de Int/Sab ou testes de Constituição para Concentração, considere 9 ou menos como 10.",
          "isPassive": false
        },
        {
          "name": "Presságio Cósmico",
          "level": 6,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Ao terminar um Descanso Longo, consulte seu Mapa Estelar e role um dado. Até seu próximo Descanso Longo, você ganha uma Reação especial:\n\nBem (par): Role 1d6 e some ao Teste D20 de uma criatura a 9m.\n\nAi (ímpar): Role 1d6 e subtraia do Teste D20 de uma criatura a 9m.\n\nVocê pode usar esta Reação um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez).",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Constelações Cintilantes",
          "level": 10,
          "description": "As constelações da sua Forma Estrelada melhoram:\n\n- O 1d8 do Arqueiro e do Cálice se torna 2d8\n- Enquanto o Dragão estiver ativo, você tem Velocidade de Voo de 6 metros e pode pairar\n- No início de cada turno, você pode mudar qual constelação brilha em seu corpo",
          "isPassive": true
        },
        {
          "name": "Cheio de Estrelas",
          "level": 14,
          "description": "Enquanto estiver em sua Forma Estrelada, você se torna parcialmente incorpóreo, o que lhe dá Resistência a danos Contundentes, Perfurantes e Cortantes.",
          "isPassive": true
        }
      ]
    }
  ]'::jsonb,
  2,
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
    {"name": "Escudo", "cost": "10.0", "weight": "6.0", "category": "Armadura", "quantity": 1},
    {"name": "Foice", "cost": "1.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Foco druídico (Cajado)", "cost": "5.0", "weight": "4.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do explorador", "cost": "10.0", "weight": null, "category": "Pacote", "quantity": 1},
    {"name": "Kit de herbalismo", "cost": "5.0", "weight": "3.0", "category": "Ferramenta", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  9,
  50,
  '[]'::jsonb
);
