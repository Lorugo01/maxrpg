-- Inserir classe Clérigo (PHB 2024)
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
  'Clérigo',
  8,
  'Sabedoria',
  'Sabedoria, Carisma',
  'História, Intuição, Medicina, Persuasão, Religião',
  null,
  null,
  '""',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Armaduras Médias, Escudos',
  'Armas Simples',
  '',
  '',
  'Invocando magia através de orações e meditação, os Clérigos são condutos do poder divino. Eles canalizam energia divina diretamente dos Planos Exteriores para curar ferimentos, inspirar aliados e punir inimigos. Clérigos são definidos por suas divindades e domínios, que concedem acesso a diferentes magias e habilidades.',
  '',
  '',
  '[
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Você aprendeu a conjurar magias por meio de orações e meditação.\n\nTruques. Você conhece três truques à sua escolha da lista de magias de Clérigo. Orientação, Chama Sagrada e Taumaturgia são recomendados.\n\nSempre que você ganha um nível de Clérigo, você pode substituir um dos seus truques por outro truque de sua escolha da lista de magias de Clérigo.\n\nQuando você alcança os níveis 4 e 10 de Clérigo, você aprende outro truque de sua escolha na lista de magias de Clérigo, como mostrado na coluna Truques da tabela de Recursos do Clérigo.\n\nEspaços de Magia. A tabela de Recursos do Clérigo mostra quantos espaços de magia você tem para conjurar suas magias de nível 1+. Você recupera todos os espaços gastos ao terminar um Descanso Longo.\n\nMagias Preparadas de Nível 1+. Você prepara a lista de magias de nível 1+ disponíveis para você conjurar com esta habilidade. Para começar, escolha quatro magias de nível 1 da lista de magias de Clérigo. Bênção, Cura de Ferimentos, Raio Guia e Escudo da Fé são recomendadas.\n\nO número de magias na sua lista aumenta à medida que você ganha níveis de Clérigo, conforme mostrado na coluna Magias Preparadas da tabela de Características do Clérigo.\n\nAlterando suas Magias Preparadas. Sempre que terminar um Descanso Longo, você pode alterar sua lista de magias preparadas.\n\nHabilidade de Conjuração. Sabedoria é sua habilidade de conjuração para suas magias de Clérigo.\n\nFoco de Conjuração. Você pode usar um Símbolo Sagrado como Foco de Conjuração para suas magias de Clérigo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ordem Divina",
      "level": 1,
      "description": "Você se dedicou a uma das seguintes funções sagradas de sua escolha.\n\nProtetor: Treinado para a batalha, você ganha proficiência com armas marciais e treinamento com armadura pesada.\n\nTaumaturgo: Você conhece um truque extra da lista de magias de Clérigo. Além disso, sua conexão mística com o divino lhe concede um bônus em seus testes de Inteligência (Arcana ou Religião). O bônus é igual ao seu modificador de Sabedoria (mínimo de +1).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Canalizar Divindade",
      "level": 2,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Você pode canalizar energia divina diretamente dos Planos Exteriores para alimentar efeitos mágicos. Você começa com dois desses efeitos: Centelha Divina e Expulsar Mortos-Vivos.\n\nCentelha Divina: Como uma ação de Magia, você aponta seu Símbolo Sagrado para outra criatura que você possa ver a até 9 metros de você e concentra energia divina nela. Role 1d8 e adicione seu modificador de Sabedoria. Você restaura Pontos de Vida da criatura igual a esse total ou força a criatura a realizar um teste de resistência de Constituição. Em caso de falha, a criatura sofre dano Necrótico ou Radiante (à sua escolha) igual a esse total.\n\nVocê rola um d8 adicional quando atinge os níveis de Clérigo 7 (2d8), 13 (3d8) e 18 (4d8).\n\nExpulsar Mortos-Vivos: Como uma ação de Magia, você apresenta seu Símbolo Sagrado e censura criaturas Mortas-Vivas. Cada Morto-Vivo à sua escolha a até 9 metros de você deve realizar um teste de resistência de Sabedoria. Se a criatura falhar no teste, ela fica sob as condições Amedrontada e Incapacitada por 1 minuto.",
      "has_usage_limit": true,
      "has_dice_increase": true,
      "initial_dice": "1d8",
      "dice_increases": [
        {"level": 7, "dice": "2d8"},
        {"level": 13, "dice": "3d8"},
        {"level": 18, "dice": "4d8"}
      ],
      "manual_level_increases": [
        {"level": 6, "increase": 3},
        {"level": 18, "increase": 4}
      ],
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Clérigo",
      "level": 3,
      "description": "Você ganha uma subclasse de Clérigo à sua escolha. Uma subclasse é uma especialização que lhe concede características em determinados níveis de Clérigo. Pelo resto da sua carreira, você ganha cada uma das características da sua subclasse que sejam do seu nível de Clérigo ou inferior.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha para o qual você se qualifique. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Clérigo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Queimar Mortos-Vivos",
      "level": 5,
      "description": "Sempre que usar Expulsar Mortos-Vivos, você pode rolar um número de d8s igual ao seu modificador de Sabedoria (mínimo de 1d8) e somar os resultados. Cada Morto-Vivo que falhar em seu teste de resistência contra esse uso de Expulsar Mortos-Vivos recebe dano Radiante igual ao total do teste. Este dano não encerra o efeito do turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua Subclasse de Clérigo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Abençoados",
      "level": 7,
      "description": "Poder divino infunde você em batalha. Você ganha uma das seguintes opções à sua escolha.\n\nAtaque Divino: Uma vez em cada um dos seus turnos, ao atingir uma criatura com uma jogada de ataque usando uma arma, você pode fazer com que o alvo receba 1d8 de dano Necrótico ou Radiante adicional (à sua escolha).\n\nConjuração Potente: Adicione seu modificador de Sabedoria ao dano causado com qualquer truque de Clérigo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na pontuação de habilidade",
      "level": 8,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Intervenção Divina",
      "level": 10,
      "usage_type": "Por Nível",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Você pode invocar sua divindade ou panteão para intervir em seu favor. Como uma ação de Magia, escolha qualquer magia de Clérigo de nível 5 ou inferior que não exija uma Reação para ser conjurada. Como parte da mesma ação, você conjura aquela magia sem gastar um espaço de magia ou precisar de componentes materiais. Você não pode usar esta habilidade novamente até terminar um Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na Pontuação de Habilidade",
      "level": 12,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Abençoados Aprimorados",
      "level": 14,
      "description": "A opção que você escolheu para Ataques Abençoados fica mais poderosa.\n\nGolpe Divino: O dano extra do seu Golpe Divino aumenta para 2d8.\n\nConjuração Potente: Ao conjurar um truque de Clérigo e causar dano a uma criatura com ele, você pode conceder vitalidade a si mesmo ou a outra criatura a até 18 metros de distância, concedendo uma quantidade de Pontos de Vida Temporários igual ao dobro do seu modificador de Sabedoria.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria na Pontuação de Habilidade",
      "level": 16,
      "description": "Você ganha o talento Melhoria no Valor de Habilidade ou outro talento de sua escolha para o qual você se qualifica.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 17,
      "description": "Você ganha uma característica da sua Subclasse de Clérigo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha para o qual você se qualifique. Dádiva do Destino é recomendado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Intervenção Divina Maior",
      "level": 20,
      "description": "Você pode invocar uma intervenção divina ainda mais poderosa. Ao usar sua habilidade Intervenção Divina, você pode escolher Desejo ao selecionar uma magia. Se fizer isso, não poderá usar Intervenção Divina novamente até terminar 2d4 Descansos Longos.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
  '[
    {"level": 1, "cantrips": 3, "known_spells": 4},
    {"level": 2, "cantrips": 3, "known_spells": 5},
    {"level": 3, "cantrips": 3, "known_spells": 6},
    {"level": 4, "cantrips": 4, "known_spells": 7},
    {"level": 5, "cantrips": 4, "known_spells": 9},
    {"level": 6, "cantrips": 4, "known_spells": 10},
    {"level": 7, "cantrips": 4, "known_spells": 11},
    {"level": 8, "cantrips": 4, "known_spells": 12},
    {"level": 9, "cantrips": 4, "known_spells": 14},
    {"level": 10, "cantrips": 5, "known_spells": 15},
    {"level": 11, "cantrips": 5, "known_spells": 16},
    {"level": 12, "cantrips": 5, "known_spells": 16},
    {"level": 13, "cantrips": 5, "known_spells": 17},
    {"level": 14, "cantrips": 5, "known_spells": 17},
    {"level": 15, "cantrips": 5, "known_spells": 18},
    {"level": 16, "cantrips": 5, "known_spells": 18},
    {"level": 17, "cantrips": 5, "known_spells": 19},
    {"level": 18, "cantrips": 5, "known_spells": 20},
    {"level": 19, "cantrips": 5, "known_spells": 21},
    {"level": 20, "cantrips": 5, "known_spells": 22}
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
      "name": "Domínio da Vida",
      "description": "Alivie as mágoas do mundo. O Domínio da Vida concentra-se na energia positiva que ajuda a sustentar toda a vida no multiverso. Clérigos que acessam este domínio são mestres da cura, usando essa força vital para curar muitas feridas.",
      "features": [
        {
          "name": "Magias do Domínio da Vida",
          "level": 3,
          "description": "Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas. Ao atingir um nível de Clérigo especificado, você sempre terá as magias listadas preparadas:\n\nNível 3: Ajuda, Abençoa, Cura Feridas, Restauração Menor\nNível 5: Palavra de Cura em Massa, Revivificar\nNível 7: Aura da Vida, Proteção da Morte\nNível 9: Maior restauração, cura em massa de feridas",
          "isPassive": true
        },
        {
          "name": "Discípulo da Vida",
          "level": 3,
          "description": "Quando uma magia que você conjura com um espaço de magia restaura Pontos de Vida de uma criatura, essa criatura recupera Pontos de Vida adicionais no turno em que você conjura a magia. Os Pontos de Vida adicionais equivalem a 2 mais o nível do espaço de magia.",
          "isPassive": true
        },
        {
          "name": "Preservar a Vida",
          "level": 3,
          "description": "Como uma ação de Magia, você apresenta seu Símbolo Sagrado e gasta um uso de Canalizar Divindade para evocar energia de cura que pode restaurar uma quantidade de Pontos de Vida igual a cinco vezes o seu nível de Clérigo. Escolha criaturas Ensanguentadas a até 9 metros de você (o que pode incluir você) e divida esses Pontos de Vida entre elas. Esta habilidade pode restaurar uma criatura a, no máximo, metade do seu máximo de Pontos de Vida.",
          "isPassive": false
        },
        {
          "name": "Curandeiro Abençoado",
          "level": 6,
          "description": "As magias de cura que você conjura em outros curam você também. Imediatamente após conjurar uma magia com um espaço de magia que restaura Pontos de Vida para uma criatura diferente de você, você recupera Pontos de Vida iguais a 2 mais o nível do espaço de magia.",
          "isPassive": true
        },
        {
          "name": "Cura Suprema",
          "level": 17,
          "description": "Quando você normalmente rola um ou mais dados para restaurar os Pontos de Vida de uma criatura com uma magia ou Canalizar Divindade, não role esses dados para a cura; em vez disso, use o maior número possível para cada dado. Por exemplo, em vez de restaurar 2d6 Pontos de Vida de uma criatura com uma magia, você restaura 12.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Domínio da Luz",
      "description": "Traga a luz para banir a escuridão. O Domínio da Luz enfatiza o poder divino de trazer fogo ardente e revelação. Os clérigos que exercem esse poder são almas iluminadas, imbuídas de radiância e do poder da visão perspicaz de suas divindades.",
      "features": [
        {
          "name": "Magias do Domínio da Luz",
          "level": 3,
          "description": "Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas:\n\nNível 3: Mãos Ardentes, Fogo de Fada, Raio Escaldante, Ver Invisibilidade\nNível 5: Luz do dia, bola de fogo\nNível 7: Olho Arcano, Parede de Fogo\nNível 9: Ataque de Chamas, Vidência",
          "isPassive": true
        },
        {
          "name": "Radiância do Amanhecer",
          "level": 3,
          "description": "Como uma ação de Magia, você apresenta seu Símbolo Sagrado e gasta um uso de seu Canalizar Divindade para emitir um clarão de luz em uma Emanação de 9 metros originada de você. Qualquer Escuridão mágica naquela área é dissipada. Além disso, cada criatura à sua escolha naquela área deve realizar um teste de resistência de Constituição, sofrendo dano Radiante igual a 2d10 mais seu nível de Clérigo em uma falha ou metade do dano em um sucesso.",
          "isPassive": false
        },
        {
          "name": "Sinalizador de Proteção",
          "level": 3,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Quando uma criatura que você pode ver a até 9 metros de você faz uma jogada de ataque, você pode usar uma Reação para impor Desvantagem na jogada de ataque, fazendo com que a luz brilhe antes de atingir ou errar.\n\nVocê pode usar esta habilidade um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Sinalizador de Proteção Aprimorado",
          "level": 6,
          "description": "Você recupera todos os usos gastos do seu Sinalizador de Proteção quando termina um Descanso Curto ou Longo.\n\nAlém disso, sempre que você usar Sinalizador de Proteção, você pode dar ao alvo do ataque desencadeador uma quantidade de Pontos de Vida Temporários igual a 2d6 mais seu modificador de Sabedoria.",
          "isPassive": true
        },
        {
          "name": "Coroa de Luz",
          "level": 17,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Com uma ação de Magia, você emite uma aura de luz solar que dura 1 minuto ou até que você a dissipe (nenhuma ação necessária). Você emite Luz Brilhante em um raio de 18 metros e Luz Penumbra por mais 9 metros. Seus inimigos na Luz Brilhante têm Desvantagem em testes de resistência contra seu Resplendor da Aurora e qualquer magia que cause dano de Fogo ou Radiante.\n\nVocê pode usar esse recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez) e você recupera todos os usos gastos quando termina um Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Domínio da Trapaça",
      "description": "Faça travessuras e desafie a autoridade. O Domínio da Trapaça oferece magia de engano, ilusão e furtividade. Clérigos que empunham essa magia são uma força perturbadora no mundo, ferindo o orgulho, zombando de tiranos, libertando cativos e desrespeitando tradições vazias.",
      "features": [
        {
          "name": "Magias de Domínio da Trapaça",
          "level": 3,
          "description": "Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas:\n\nNível 3: Encantar Pessoa, Disfarçar-se, Invisibilidade, Passar Sem Rastros\nNível 5: Padrão hipnótico, não detecção\nNível 7: Confusão, Porta Dimensional\nNível 9: Dominar Pessoa, Modificar Memória",
          "isPassive": true
        },
        {
          "name": "Bênção do Trapaceiro",
          "level": 3,
          "description": "Como uma ação de Magia, você pode escolher a si mesmo ou a uma criatura disposta a até 9 metros de você para ter Vantagem em testes de Destreza (Furtividade). Esta bênção dura até você terminar um Descanso Longo ou usar esta habilidade novamente.",
          "isPassive": false
        },
        {
          "name": "Invocar Duplicidade",
          "level": 3,
          "description": "Como uma Ação Bônus, você pode gastar um uso de Canalizar Divindade para criar uma ilusão visual perfeita de si mesmo em um espaço desocupado que você possa ver a até 9 metros de distância. A ilusão dura 1 minuto e oferece os seguintes benefícios:\n\nLançar Feitiços: Você pode lançar feitiços como se estivesse no espaço da ilusão.\n\nDistrair: Quando você e sua ilusão estiverem a até 1,5 metro de uma criatura, você terá Vantagem em jogadas de ataque contra essa criatura.\n\nMover: Como uma Ação Bônus, você pode mover a ilusão até 9 metros.",
          "isPassive": false
        },
        {
          "name": "Transposição do Trapaceiro",
          "level": 6,
          "description": "Sempre que você realizar a Ação Bônus para criar ou mover a ilusão da sua Invocação de Duplicidade, você pode se teletransportar, trocando de lugar com a ilusão.",
          "isPassive": true
        },
        {
          "name": "Duplicidade Aprimorada",
          "level": 17,
          "description": "A ilusão da sua Invocação de Duplicidade se tornou mais poderosa:\n\nDistração Compartilhada: Quando você e seus aliados realizam jogadas de ataque contra uma criatura a até 1,5 metro da ilusão, as jogadas de ataque têm Vantagem.\n\nIlusão de Cura: Quando a ilusão termina, você ou uma criatura à sua escolha a até 1,5 metro dela recupera uma quantidade de Pontos de Vida igual ao seu nível de Clérigo.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Domínio de Guerra",
      "description": "Inspire Valor e Destrua Inimigos. A guerra tem muitas manifestações. Clérigos que se valem da magia do Domínio da Guerra se destacam em batalha, inspirando outros a lutar o bem ou oferecendo atos de violência como preces.",
      "features": [
        {
          "name": "Magias de Domínio de Guerra",
          "level": 3,
          "description": "Sua conexão com este domínio divino garante que você sempre tenha certas magias prontas:\n\nNível 3: Raio Guia, Arma Mágica, Escudo da Fé, Arma Espiritual\nNível 5: Manto do Cruzado, Guardiões Espirituais\nNível 7: Escudo de Fogo, Liberdade de Movimento\nNível 9: Segure Monstro, Golpe de Vento de Aço",
          "isPassive": true
        },
        {
          "name": "Sacerdote de Guerra",
          "level": 3,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Curto ou Longo",
          "description": "Como Ação Bônus, você pode realizar um ataque com uma arma ou um Ataque Desarmado. Você pode usar esta Ação Bônus um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um Descanso Curto ou Longo.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Ataque Guiado",
          "level": 3,
          "description": "Quando você ou uma criatura a até 9 metros de você erra uma jogada de ataque, você pode gastar um uso da sua Canalização Divina e dar a essa jogada um bônus de +10, potencialmente fazendo com que ela acerte. Quando você usa essa habilidade para beneficiar a jogada de ataque de outra criatura, você precisa realizar uma Reação para isso.",
          "isPassive": false
        },
        {
          "name": "Bênção do Deus da Guerra",
          "level": 6,
          "description": "Você pode gastar um uso de Canalizar Divindade para conjurar Escudo da Fé ou Arma Espiritual em vez de gastar um espaço de magia. Ao conjurar qualquer uma das magias dessa forma, a magia não requer Concentração. Em vez disso, a magia dura 1 minuto, mas termina mais cedo se você conjurar a magia novamente, ficar na condição Incapacitado ou morrer.",
          "isPassive": false
        },
        {
          "name": "Avatar da Batalha",
          "level": 17,
          "description": "Você ganha Resistência a danos de Concussão, Perfuração e Corte.",
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
    {"name": "Camisa de malha", "cost": "50.0", "weight": "20.0", "category": "Armadura", "quantity": 1},
    {"name": "Escudo", "cost": "10.0", "weight": "6.0", "category": "Armadura", "quantity": 1},
    {"name": "Maça", "cost": "5.0", "weight": "4.0", "category": "Arma", "quantity": 1},
    {"name": "Símbolo sagrado", "cost": "5.0", "weight": "1.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do sacerdote", "cost": "33.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  7,
  110,
  '[]'::jsonb
);

