-- Inserir classe Guerreiro (PHB 2024)
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
  'Guerreiro',
  10,
  'Força ou Destreza',
  'Força, Constituição',
  'Acrobacia, Adestrar Animais, Atletismo, História, Intuição, Intimidação, Persuasão, Percepção, Sobrevivência',
  null,
  null,
  '""',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Médias, Pesadas, Escudos',
  'Armas Simples, Armas Marciais',
  '',
  '',
  'Mestres do combate marcial, os Guerreiros são especialistas em técnicas de batalha, estilos de luta e maestria com armas. Seja um cavaleiro nobre, um mercenário experiente ou um soldado disciplinado, os Guerreiros dominam o campo de batalha com sua versatilidade e resistência incomparáveis.',
  'Escolha A',
  'Escolha B',
  '[
    {
      "name": "Estilo de Luta",
      "level": 1,
      "description": "Você aprimorou sua destreza marcial e ganhou um talento de Estilo de Luta à sua escolha. Defesa é recomendada.\n\nSempre que você ganha um nível de Guerreiro, você pode substituir o talento escolhido por um talento de Estilo de Luta diferente.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Segundo Fôlego",
      "level": 1,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Você tem uma reserva limitada de resistência física e mental da qual pode se valer. Como uma Ação Bônus, você pode usá-la para recuperar Pontos de Vida equivalentes a 1d10 mais o seu nível de Guerreiro.\n\nVocê pode usar este recurso duas vezes. Você recupera um uso gasto ao terminar um Descanso Curto e recupera todos os usos gastos ao terminar um Descanso Longo.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 6, "increase": 3},
        {"level": 10, "increase": 4},
        {"level": 14, "increase": 5},
        {"level": 18, "increase": 6}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Armas",
      "level": 1,
      "description": "Seu treinamento com armas permite que você use as propriedades de maestria de três tipos de armas Simples ou Marciais à sua escolha. Sempre que terminar um Descanso Longo, você pode praticar exercícios de armas e mudar uma dessas escolhas.\n\nAo atingir certos níveis de Lutador, você ganha a habilidade de usar as propriedades de maestria de mais tipos de armas (4 no nível 4, 5 no nível 9).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Surto de Ação",
      "level": 2,
      "usage_type": "Descanso Curto ou Longo",
      "usage_value": 1,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Você pode ir além dos seus limites normais por um momento. No seu turno, você pode realizar uma ação adicional, exceto a ação de Magia.\n\nDepois de usar esta habilidade, você não poderá usá-la novamente até terminar um Descanso Curto ou Longo. A partir do nível 17, você pode usá-la duas vezes antes de um descanso, mas apenas uma vez por turno.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 17, "increase": 2}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mente Tática",
      "level": 2,
      "description": "Você tem uma mente para táticas dentro e fora do campo de batalha. Ao falhar em um teste de habilidade, você pode gastar um uso do seu Fôlego Renovado para se impulsionar rumo ao sucesso. Em vez de recuperar Pontos de Vida, você rola 1d10 e adiciona o número rolado ao teste de habilidade, potencialmente transformando-o em um sucesso. Se o teste ainda falhar, este uso do Fôlego Renovado não é gasto.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Guerreiro",
      "level": 3,
      "description": "Você ganha uma subclasse de Guerreiro à sua escolha. Uma subclasse é uma especialização que lhe concede características em determinados níveis de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha para o qual você se qualifique. Você ganha essa característica novamente nos níveis 6, 8, 12, 14 e 16 de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataque Extra",
      "level": 5,
      "description": "Você pode atacar duas vezes em vez de uma sempre que realizar a ação Atacar no seu turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mudança Tática",
      "level": 5,
      "description": "Sempre que você ativar seu Segundo Fôlego com uma Ação Bônus, você pode se mover até metade de sua Velocidade sem provocar Ataques de Oportunidade.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 7,
      "description": "Você ganha uma característica da sua Subclasse de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Indomável",
      "level": 9,
      "usage_type": "Manual por Nível",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Se falhar em um teste de resistência, você pode repeti-lo com um bônus igual ao seu nível de Guerreiro. Você deve usar o novo teste e não pode usar esta habilidade novamente até terminar um Descanso Longo.\n\nVocê pode usar esse recurso duas vezes antes de um Descanso Longo começando no nível 13, e três vezes começando no nível 17.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 13, "increase": 2},
        {"level": 17, "increase": 3}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mestre Tático",
      "level": 9,
      "description": "Quando você ataca com uma arma cuja propriedade de maestria você pode usar, você pode substituir essa propriedade pela propriedade Empurrar, Desacelerar ou Lentidão para esse ataque.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 10,
      "description": "Você ganha uma característica da sua Subclasse de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Dois Ataques Extras",
      "level": 11,
      "description": "Você pode atacar três vezes em vez de uma sempre que realizar a ação Atacar no seu turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Estudados",
      "level": 13,
      "description": "Você estuda seus oponentes e aprende com cada ataque que faz. Se fizer uma jogada de ataque contra uma criatura e errar, você terá Vantagem na sua próxima jogada de ataque contra aquela criatura antes do final do seu próximo turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 15,
      "description": "Você ganha uma característica da sua Subclasse de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 18,
      "description": "Você ganha uma característica da sua Subclasse de Guerreiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha para o qual você se qualifique. Dádiva de Proeza em Combate é recomendada.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Três Ataques Extras",
      "level": 20,
      "description": "Você pode atacar quatro vezes em vez de uma vez sempre que realizar a ação Atacar no seu turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  false,
  '[]'::jsonb,
  '[]'::jsonb,
  '[
    {
      "name": "Mestre da Batalha",
      "description": "Domine manobras de batalha sofisticadas. Mestres de Batalha são estudantes da arte da batalha, aprendendo técnicas marciais transmitidas de geração em geração. Os Mestres de Batalha mais talentosos são figuras completas que combinam suas habilidades de combate cuidadosamente aprimoradas com estudos acadêmicos.",
      "features": [
        {
          "name": "Superioridade em Combate",
          "level": 3,
          "description": "Sua experiência no campo de batalha refinou suas técnicas de luta. Você aprende manobras que são impulsionadas por dados especiais chamados Dados de Superioridade.\n\nManobras: Você aprende três manobras à sua escolha. Você aprende duas manobras adicionais nos níveis 7, 10 e 15.\n\nDado de Superioridade: Você tem quatro Dados de Superioridade (d8). Você ganha um adicional no nível 7 (cinco dados) e 15 (seis dados). O dado se torna d10 no nível 10 e d12 no nível 18.\n\nTestes de Resistência: CD = 8 + modificador de For/Des + Bônus de Proficiência.",
          "isPassive": false
        },
        {
          "name": "Estudante de Guerra",
          "level": 3,
          "description": "Você ganha proficiência com um tipo de Ferramentas de Artesão de sua escolha e ganha proficiência em uma habilidade de sua escolha dentre as habilidades disponíveis para Guerreiros no nível 1.",
          "isPassive": true
        },
        {
          "name": "Conheça seu inimigo",
          "level": 7,
          "description": "Como uma Ação Bônus, você pode discernir certos pontos fortes e fracos de uma criatura a até 9m. Você sabe se aquela criatura tem alguma Imunidade, Resistência ou Vulnerabilidade.\n\nDepois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Longo. Você também pode restaurar o uso gastando um Dado de Superioridade.",
          "isPassive": false
        },
        {
          "name": "Superioridade de Combate Aprimorada",
          "level": 10,
          "description": "Seu Dado de Superioridade se torna um d10.",
          "isPassive": true
        },
        {
          "name": "Implacável",
          "level": 15,
          "description": "Uma vez por turno, quando você usa uma manobra, você pode rolar 1d8 e usar o número rolado em vez de gastar um Dado de Superioridade.",
          "isPassive": true
        },
        {
          "name": "Superioridade Máxima em Combate",
          "level": 18,
          "description": "Seu Dado de Superioridade se torna um d12.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Campeão",
      "description": "Busque a excelência física no combate. Um Campeão se concentra no desenvolvimento de proezas marciais em uma busca incansável pela vitória. Campeões combinam treinamento rigoroso com excelência física para desferir golpes devastadores.",
      "features": [
        {
          "name": "Crítico Aprimorado",
          "level": 3,
          "description": "Seus ataques com armas e Ataques Desarmados podem resultar em um Acerto Crítico com um resultado de 19 ou 20 no d20.",
          "isPassive": true
        },
        {
          "name": "Atleta Notável",
          "level": 3,
          "description": "Graças ao seu atletismo, você tem Vantagem em testes de Iniciativa e Força (Atletismo).\n\nAlém disso, imediatamente após você conseguir um Acerto Crítico, você pode aumentar até metade sua Velocidade sem provocar Ataques de Oportunidade.",
          "isPassive": true
        },
        {
          "name": "Estilo de luta adicional",
          "level": 7,
          "description": "Você ganha outro talento de Estilo de Luta à sua escolha.",
          "isPassive": true
        },
        {
          "name": "Guerreiro Heroico",
          "level": 10,
          "description": "A emoção da batalha impulsiona você em direção à vitória. Durante o combate, você pode se conceder Inspiração Heroica sempre que começar seu turno sem ela.",
          "isPassive": true
        },
        {
          "name": "Crítico Superior",
          "level": 15,
          "description": "Seus ataques com armas e Ataques Desarmados agora podem resultar em um Acerto Crítico em um resultado de 18–20 no d20.",
          "isPassive": true
        },
        {
          "name": "Sobrevivente",
          "level": 18,
          "description": "Você atinge o ápice da resiliência em batalha:\n\nDesafie a Morte: Vantagem em Testes de Resistência contra Morte. Ao tirar 18–20, você ganha o benefício de tirar 20.\n\nRally Heroico: No início de cada turno, você recupera PV iguais a 5 + modificador de Con se estiver Ensanguentado e tiver pelo menos 1 PV.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Cavaleiro Eldritch",
      "description": "Apoie habilidades de combate com magia arcana. Os Cavaleiros Eldritch combinam a maestria marcial comum a todos os Guerreiros com um estudo cuidadoso da magia.",
      "features": [
        {
          "name": "Conjuração",
          "level": 3,
          "description": "Você aprendeu a conjurar magias de Mago.\n\nTruques: Você conhece dois truques de Mago (Raio de Gelo e Agarramento Chocante recomendados). Aprende um terceiro no nível 10.\n\nEspaços de Magia: Recupera todos ao terminar Descanso Longo.\n\nMagias Preparadas: Começa com três magias de nível 1 (Mãos Ardentes, Salto e Escudo recomendados).\n\nHabilidade de Conjuração: Inteligência.\n\nFoco de Conjuração: Foco Arcano.",
          "isPassive": true
        },
        {
          "name": "Vínculo de Guerra",
          "level": 3,
          "description": "Você aprende um ritual que cria um vínculo mágico entre você e uma arma (1 hora, pode ser em Descanso Curto). Depois de vincular:\n\n- Você não pode ser desarmado dessa arma\n- Você pode invocá-la como Ação Bônus se estiver no mesmo plano\n- Você pode ter até duas armas vinculadas, mas só pode invocar uma por vez",
          "isPassive": false
        },
        {
          "name": "Magia de Guerra",
          "level": 7,
          "description": "Quando você realiza a ação de Ataque no seu turno, você pode substituir um dos ataques por um lançamento de um dos seus truques de Mago que tenha um tempo de lançamento de uma ação.",
          "isPassive": true
        },
        {
          "name": "Ataque Sobrenatural",
          "level": 10,
          "description": "Quando você atinge uma criatura com um ataque usando uma arma, essa criatura tem Desvantagem no próximo teste de resistência que fizer contra uma magia que você conjurar antes do final do seu próximo turno.",
          "isPassive": true
        },
        {
          "name": "Carga Arcana",
          "level": 15,
          "description": "Ao usar seu Surto de Ação, você pode se teletransportar até 9 metros para um espaço desocupado visível. Você pode se teletransportar antes ou depois da ação adicional.",
          "isPassive": true
        },
        {
          "name": "Magia de Guerra Aprimorada",
          "level": 18,
          "description": "Quando você realiza a ação de Ataque no seu turno, você pode substituir dois dos ataques por uma conjuração de uma de suas magias de Mago de nível 1 ou 2 que tenha um tempo de conjuração de uma ação.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Guerreiro Psi",
      "description": "Aumente a força física com poder psiônico. Guerreiros Psi despertam o poder de suas mentes para aumentar seu poder físico. Eles utilizam esse poder psiônico para infundir seus ataques com armas, lançar energia telecinética e criar barreiras de força mental.",
      "features": [
        {
          "name": "Poder Psiônico",
          "level": 3,
          "description": "Você abriga uma fonte de energia psiônica representada por Dados de Energia Psiônica (4d6 no nível 3, aumenta com nível).\n\nCampo Protetor: Reação para gastar um dado e reduzir dano (dado + Int).\n\nAtaque Psiônico: Uma vez por turno, após acertar, gaste um dado para causar dano de Força extra (dado + Int).\n\nMovimento Telecinético: Ação de Magia para mover objeto/criatura até 9m. Restaura uso gastando um dado.",
          "isPassive": false
        },
        {
          "name": "Adepto Telecinético",
          "level": 7,
          "description": "Você dominou novas maneiras de usar suas habilidades telecinéticas:\n\nSalto Psiônico: Ação Bônus para ganhar Velocidade de Voo = 2x Velocidade até o fim do turno.\n\nImpulso Telecinético: Ao causar dano com Ataque Psiônico, força teste de For (CD 8 + Int + Prof). Falha: Caído ou empurrado 3m.",
          "isPassive": false
        },
        {
          "name": "Mente Protegida",
          "level": 10,
          "description": "Você tem Resistência a Dano Psíquico. Além disso, se você começar seu turno Encantado ou Amedrontado, pode gastar um Dado de Energia Psiônica para encerrar todos os efeitos que lhe derem essas condições.",
          "isPassive": true
        },
        {
          "name": "Baluarte da Força",
          "level": 15,
          "description": "Como Ação Bônus, escolha criaturas (incluindo você) a até 9m, até um número igual ao seu modificador de Int (mínimo 1). Cada uma tem Meia Cobertura por 1 minuto ou até você ficar Incapacitado.\n\nDepois de usar, não pode usar novamente até Descanso Longo, a menos que gaste um Dado de Energia Psiônica.",
          "isPassive": false
        },
        {
          "name": "Mestre Telecinético",
          "level": 18,
          "description": "Você sempre tem a magia Telecinese preparada. Você pode conjurá-la sem espaço de magia ou componentes (Int como habilidade). Em cada turno enquanto mantiver Concentração, você pode realizar um ataque com arma como Ação Bônus.\n\nDepois de conjurar com essa característica, não pode usar novamente até Descanso Longo, a menos que gaste um Dado de Energia Psiônica.",
          "isPassive": false
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
    {"name": "Cota de malha", "cost": "75.0", "weight": "55.0", "category": "Armadura", "quantity": 1},
    {"name": "Espada larga", "cost": "50.0", "weight": "6.0", "category": "Arma", "quantity": 1},
    {"name": "Mangual", "cost": "10.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Dardo", "cost": "0.05", "weight": "0.25", "category": "Arma", "quantity": 8},
    {"name": "Pacote do Dungeon", "cost": "12.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[
    {"name": "Armadura de couro cravejada", "cost": "45.0", "weight": "13.0", "category": "Armadura", "quantity": 1},
    {"name": "Cimitarra", "cost": "25.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Espada curta", "cost": "10.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Arco longo", "cost": "50.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Flecha", "cost": "0.05", "weight": "0.05", "category": "Munição", "quantity": 20},
    {"name": "Aljava", "cost": "1.0", "weight": "1.0", "category": "Equipamento", "quantity": 1},
    {"name": "Pacote do Dungeon", "cost": "12.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  4,
  11,
  '[]'::jsonb
);
