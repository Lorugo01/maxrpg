-- Inserir classe Patrulheiro/Guardião (PHB 2024)
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
  'Patrulheiro',
  10,
  'Destreza e Sabedoria',
  'Força, Destreza',
  'Adestrar Animais, Atletismo, Intuição, Investigação, Natureza, Percepção, Furtividade, Sobrevivência',
  null,
  null,
  '{"ability": "Sabedoria", "type": "half"}',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Médias, Escudos',
  'Armas Simples, Armas Marciais',
  '',
  '[
    {
      "name": "Mestre das Feras",
      "description": "Um Mestre das Feras cria um vínculo místico com um animal especial, recorrendo à magia primitiva e a uma profunda conexão com o mundo natural.",
      "features": [
        {
          "name": "Companheiro Primordial",
          "level": 3,
          "description": "Você invoca magicamente uma fera primitiva (Besta da Terra, Besta do Mar ou Besta do Céu). A fera é amigável e obedece seus comandos.\\n\\nA Besta em Combate: Age durante seu turno. Pode mover-se e usar Reação, mas só realiza ação Esquiva, a menos que você use Ação Bônus para comandá-la.\\n\\nRestaurando: Se morreu na última hora, você pode tocá-la e gastar espaço de magia para revivê-la após 1 minuto.\\n\\nAo terminar Descanso Longo, pode invocar fera diferente.",
          "isPassive": true
        },
        {
          "name": "Treinamento Excepcional",
          "level": 7,
          "description": "Quando você realiza Ação Bônus para comandar sua besta, você também pode comandá-la a realizar Disparar, Desvencilhar, Esquivar ou Ajudar.\\n\\nAlém disso, sempre que ela acerta e causa dano, pode causar dano de Força ou seu tipo normal.",
          "isPassive": true
        },
        {
          "name": "Fúria Bestial",
          "level": 11,
          "description": "Quando você comanda sua besta para Ataque da Besta, ela pode usá-lo duas vezes.\\n\\nAlém disso, na primeira vez em cada turno que ela atingir criatura sob efeito da sua Marca do Caçador, causa dano de Força extra igual ao dano bônus daquela magia.",
          "isPassive": true
        },
        {
          "name": "Compartilhar Feitiços",
          "level": 15,
          "description": "Ao conjurar magia direcionada a si mesmo, você também pode afetar sua besta Companheira Primordial se ela estiver a até 9 metros de você.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Errante Feérico",
      "description": "Uma mística feérica o cerca, graças à dádiva de uma arquifada ou a um local na Agrestia Feérica que o transformou. Seu riso alegre ilumina os corações dos oprimidos, e sua destreza marcial infunde terror em seus inimigos.",
      "features": [
        {
          "name": "Ataques Terríveis",
          "level": 3,
          "description": "Você pode aprimorar golpes da sua arma com magia destruidora de mentes. Ao atingir criatura com arma, você pode causar 1d4 de dano Psíquico adicional ao alvo (uma vez por turno).\\n\\nO dano adicional aumenta para 1d6 no nível 11.",
          "isPassive": true
        },
        {
          "name": "Magias do Errante Feérico",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Pessoa Encantadora\\nNível 5: Passo Nebuloso\\nNível 9: Invocar Fadas\\nNível 13: Porta Dimensional\\nNível 17: Enganar\\n\\nVocê também possui uma bênção feérica (borboletas ilusórias, flores no cabelo, cheiro de especiarias, sombra dançante, chifres/galhadas, ou pele/cabelo que muda de cor).",
          "isPassive": true
        },
        {
          "name": "Glamour sobrenatural",
          "level": 3,
          "description": "Sempre que você faz teste de Carisma, ganha bônus igual ao seu modificador de Sabedoria (mínimo +1).\\n\\nVocê também ganha proficiência em uma dessas habilidades: Engano, Performance ou Persuasão.",
          "isPassive": true
        },
        {
          "name": "Reviravolta Sedutora",
          "level": 7,
          "description": "Você tem Vantagem em testes de resistência para evitar ou encerrar condição Encantado ou Amedrontado.\\n\\nAlém disso, sempre que você ou criatura a até 36m obtiver sucesso em teste para evitar/encerrar Encantado/Amedrontado, você pode usar Reação para forçar criatura diferente a até 36m a fazer teste de Sabedoria contra sua CD. Em falha, alvo fica Encantado ou Amedrontado (sua escolha) por 1 minuto. Alvo repete teste ao final de cada turno.",
          "isPassive": true
        },
        {
          "name": "Reforços Feéricos",
          "level": 11,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode conjurar Invocar Fada sem componente Material. Também pode conjurá-la uma vez sem espaço de magia (recupera em Descanso Longo).\\n\\nSempre que começar a conjurar, pode modificá-la para não exigir Concentração. Se fizer isso, duração será 1 minuto.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Misty Wanderer",
          "level": 15,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Você pode conjurar Passo Nebuloso sem gastar espaço de magia. Usos = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.\\n\\nAlém disso, sempre que conjurar Passo Nebuloso, pode trazer consigo criatura disposta a até 1,5m. Essa criatura se teletransporta para espaço desocupado a até 1,5m do seu destino.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Perseguidor da Escuridão",
      "description": "Os Perseguidores da Escuridão se sentem em casa nos lugares mais escuros, usando magia vinda do Pendor das Sombras para combater inimigos que espreitam na escuridão.",
      "features": [
        {
          "name": "Emboscador Terrível",
          "level": 3,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Sabedoria",
          "usage_recovery": "Descanso Longo",
          "description": "Você dominou a arte de criar emboscadas assustadoras:\\n\\nSalto do Emboscador: No início do seu primeiro turno de cada combate, sua Velocidade aumenta em 3m até o final daquele turno.\\n\\nGolpe Terrível: Ao atacar e atingir com arma, você pode causar 2d6 de dano Psíquico adicional. Pode usar uma vez por turno, número de vezes = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.\\n\\nBônus de Iniciativa: Ao rolar Iniciativa, pode adicionar modificador de Sabedoria ao teste.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Feitiços do Perseguidor da Escuridão",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Disfarce-se\\nNível 5: Truque de corda\\nNível 9: Temer\\nNível 13: Maior Invisibilidade\\nNível 17: Aparente",
          "isPassive": true
        },
        {
          "name": "Visão Umbral",
          "level": 3,
          "description": "Você ganha Visão no Escuro com alcance de 18m. Se já tiver Visão no Escuro, alcance aumenta em 18m.\\n\\nVocê também é hábil em escapar de criaturas que dependem de Visão no Escuro. Enquanto estiver completamente na Escuridão, você tem condição Invisível para qualquer criatura que dependa de Visão no Escuro.",
          "isPassive": true
        },
        {
          "name": "Mente de Ferro",
          "level": 7,
          "description": "Você aprimorou sua capacidade de resistir a poderes que alteram a mente. Você ganha proficiência em testes de resistência de Sabedoria. Se já tiver, ganha proficiência em testes de Inteligência ou Carisma (sua escolha).",
          "isPassive": true
        },
        {
          "name": "Rajada do Perseguidor",
          "level": 11,
          "description": "O dano psíquico do seu Golpe Terrível se torna 2d8. Além disso, ao usar Golpe Terrível, você pode causar um dos seguintes efeitos adicionais:\\n\\nAtaque Súbito: Você pode realizar outro ataque com mesma arma contra criatura diferente a até 1,5m do alvo original.\\n\\nMedo em Massa: O alvo e cada criatura a até 3m dele devem realizar teste de Sabedoria contra sua CD. Em falha, criatura fica Amedrontada até início do seu próximo turno.",
          "isPassive": true
        },
        {
          "name": "Esquiva Sombria",
          "level": 15,
          "description": "Quando criatura faz jogada de ataque contra você, você pode usar Reação para impor Desvantagem. Independentemente de acertar ou errar, você pode se teletransportar até 9m para espaço desocupado que possa ver.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Caçador",
      "description": "Você persegue presas na natureza e em outros lugares, usando suas habilidades como caçador para proteger a natureza e as pessoas em todos os lugares de forças que as destruiriam.",
      "features": [
        {
          "name": "Presa do Caçador",
          "level": 3,
          "description": "Você ganha uma das seguintes opções. Sempre que terminar Descanso Curto ou Longo, pode substituir a opção escolhida pela outra:\\n\\nMatador de Colossos: Ao atingir criatura com arma, a arma causa 1d8 de dano extra ao alvo se estiver sem Pontos de Vida. Pode causar esse dano extra uma vez por turno.\\n\\nDestruidor de Hordas: Uma vez em cada turno, quando fizer ataque com arma, pode fazer outro ataque com mesma arma contra criatura diferente a até 1,5m do alvo original, dentro do alcance da arma e que você não tenha atacado neste turno.",
          "isPassive": true
        },
        {
          "name": "Conhecimento do Caçador",
          "level": 3,
          "description": "Você pode invocar forças da natureza para revelar pontos fortes e fracos da sua presa. Enquanto criatura estiver marcada pela sua Marca do Caçador, você saberá se ela possui Imunidades, Resistências ou Vulnerabilidades e, se tiver, você saberá quais são.",
          "isPassive": true
        },
        {
          "name": "Táticas Defensivas",
          "level": 7,
          "description": "Você ganha uma das seguintes opções. Sempre que terminar Descanso Curto ou Longo, pode substituir a opção escolhida pela outra:\\n\\nFuja da Horda: Ataques de Oportunidade têm Desvantagem contra você.\\n\\nDefesa de Ataques Múltiplos: Quando criatura atinge você com jogada de ataque, ela tem Desvantagem em todas as outras jogadas de ataque contra você neste turno.",
          "isPassive": true
        },
        {
          "name": "Presa do Caçador Superior",
          "level": 11,
          "description": "Uma vez por turno, quando você causa dano a criatura marcada pela sua Marca do Caçador, você também pode causar o dano extra daquela magia a criatura diferente que você possa ver a até 9m da primeira criatura.",
          "isPassive": true
        },
        {
          "name": "Defesa Superior do Caçador",
          "level": 15,
          "description": "Quando você sofre dano, você pode usar Reação para ganhar Resistência a esse dano e a qualquer outro dano do mesmo tipo até o final do turno atual.",
          "isPassive": false
        }
      ]
    }
  ]'::jsonb,
  'Guerreiros da natureza, os Patrulheiros são especialistas em rastrear inimigos, sobreviver em ambientes selvagens e proteger as fronteiras da civilização. Combinando habilidades marciais com magia druídica, eles são mestres em caçar suas presas favoritas e se adaptar a qualquer terreno.',
  '',
  '',
  '[
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Você aprendeu a canalizar a essência mágica da natureza para conjurar magias.\\n\\nEspaços de Magia: Recupera todos ao terminar Descanso Longo.\\n\\nMagias Preparadas de Nível 1+: Começa com duas magias de nível 1 (Curar Ferimentos e Ataque Enredador recomendados).\\n\\nAlterando Magias: Ao terminar Descanso Longo, pode substituir uma magia.\\n\\nHabilidade de Conjuração: Sabedoria.\\n\\nFoco em Conjuração: Foco Druídico.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Inimigo Favorito",
      "level": 1,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Longo",
      "description": "Você sempre tem a magia Marca do Caçador preparada. Você pode conjurá-la duas vezes sem gastar um espaço de magia e recupera todos os usos gastos ao terminar Descanso Longo.\\n\\nO número de vezes aumenta: 3 no nível 6, 4 no nível 14.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 6, "increase": 3},
        {"level": 14, "increase": 4}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Armas",
      "level": 1,
      "description": "Seu treinamento com armas permite que você use as propriedades de maestria de dois tipos de armas de sua escolha com as quais você tem proficiência (como arcos longos e espadas curtas).\\n\\nAo terminar Descanso Longo, você pode alterar os tipos de armas escolhidos.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Explorador Hábil",
      "level": 2,
      "description": "Graças às suas viagens, você ganha os seguintes benefícios:\\n\\nEspecialização: Escolha uma proficiência em perícia na qual você não possui Especialização. Você ganha Especialização nessa perícia.\\n\\nIdiomas: Você conhece dois idiomas de sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Estilo de Luta",
      "level": 2,
      "description": "Você ganha um talento de Estilo de Luta à sua escolha.\\n\\nGuerreiro Druídico: Você aprende dois truques de Druida (Orientação e Fogo-fátuo Estrelado recomendados). Os truques contam como magias de Patrulheiro para você, e Sabedoria é sua habilidade. Sempre que você ganha um nível, pode substituir um truque.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse Ranger",
      "level": 3,
      "description": "Você ganha uma subclasse de Patrulheiro à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Patrulheiro.",
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
      "name": "Itinerante",
      "level": 6,
      "description": "Sua Velocidade aumenta em 3 metros enquanto você não estiver usando armadura pesada. Você também tem uma Velocidade de Escalada e uma Velocidade de Natação iguais à sua Velocidade.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 7,
      "description": "Você ganha uma característica da sua Subclasse de Patrulheiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Especialização",
      "level": 9,
      "description": "Escolha duas das suas proficiências em perícias nas quais você não possui Perícia. Você ganha Perícia nessas perícias.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Incansável",
      "level": 10,
      "usage_type": "Por Modificador de Atributo",
      "usage_attribute": "Sabedoria",
      "usage_recovery": "Descanso Longo",
      "description": "As forças primordiais agora ajudam a impulsionar suas jornadas:\\n\\nPontos de Vida Temporários: Como ação de Magia, conceda a si mesmo 1d8 + Sabedoria PV Temporários. Usos = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.\\n\\nDiminua a Exaustão: Sempre que terminar Descanso Curto, seu nível de Exaustão diminui em 1.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 11,
      "description": "Você ganha uma característica da sua Subclasse de Patrulheiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Caçador Implacável",
      "level": 13,
      "description": "Receber dano não pode quebrar sua Concentração na Marca do Caçador.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Véu da Natureza",
      "level": 14,
      "usage_type": "Por Modificador de Atributo",
      "usage_attribute": "Sabedoria",
      "usage_recovery": "Descanso Longo",
      "description": "Você invoca espíritos da natureza para se esconder magicamente. Como Ação Bônus, você pode se conceder a condição Invisível até o final do seu próximo turno.\\n\\nUsos = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 15,
      "description": "Você ganha uma característica da sua Subclasse de Patrulheiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Caçador Preciso",
      "level": 17,
      "description": "Você tem Vantagem em jogadas de ataque contra a criatura atualmente marcada pela sua Marca do Caçador.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Sentidos Selvagens",
      "level": 18,
      "description": "Sua conexão com as forças da natureza lhe concede Visão às Cegas com um alcance de 9 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva de Viagem Dimensional é recomendada.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Matador de Inimigos",
      "level": 20,
      "description": "O dado de dano da sua Marca do Caçador é um d10 em vez de um d6.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
  '[
    {"level": 1, "cantrips": 0, "known_spells": 2},
    {"level": 2, "cantrips": 0, "known_spells": 2},
    {"level": 3, "cantrips": 0, "known_spells": 3},
    {"level": 4, "cantrips": 0, "known_spells": 3},
    {"level": 5, "cantrips": 0, "known_spells": 4},
    {"level": 6, "cantrips": 0, "known_spells": 4},
    {"level": 7, "cantrips": 0, "known_spells": 5},
    {"level": 8, "cantrips": 0, "known_spells": 5},
    {"level": 9, "cantrips": 0, "known_spells": 6},
    {"level": 10, "cantrips": 0, "known_spells": 6},
    {"level": 11, "cantrips": 0, "known_spells": 7},
    {"level": 12, "cantrips": 0, "known_spells": 7},
    {"level": 13, "cantrips": 0, "known_spells": 8},
    {"level": 14, "cantrips": 0, "known_spells": 8},
    {"level": 15, "cantrips": 0, "known_spells": 9},
    {"level": 16, "cantrips": 0, "known_spells": 9},
    {"level": 17, "cantrips": 0, "known_spells": 10},
    {"level": 18, "cantrips": 0, "known_spells": 10},
    {"level": 19, "cantrips": 0, "known_spells": 11},
    {"level": 20, "cantrips": 0, "known_spells": 11}
  ]'::jsonb,
  '[
    {"level": 1, "level_1": 0},
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
  '[]'::jsonb,
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
    {"name": "Armadura de Couro Cravejada", "cost": "45.0", "weight": "13.0", "category": "Armadura", "quantity": 1},
    {"name": "Cimitarra", "cost": "25.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Espada Curta", "cost": "10.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Arco Longo", "cost": "50.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Flecha", "cost": "0.05", "weight": "0.05", "category": "Munição", "quantity": 20},
    {"name": "Aljava", "cost": "1.0", "weight": "1.0", "category": "Equipamento", "quantity": 1},
    {"name": "Foco Druídico (ramo de visco)", "cost": "1.0", "weight": "0.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do Explorador", "cost": "10.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  7,
  150,
  '[]'::jsonb
);
