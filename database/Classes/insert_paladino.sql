-- Inserir classe Paladino (PHB 2024)
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
  'Paladino',
  10,
  'Força e Carisma',
  'Sabedoria, Carisma',
  'Atletismo, Percepção, Intimidação, Medicina, Persuasão, Religião',
  null,
  null,
  '{"ability": "Carisma", "type": "half"}',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves, Médias, Pesadas, Escudos',
  'Armas Simples, Armas Marciais',
  '',
  '',
  'Guerreiros sagrados vinculados por juramentos solenes, os Paladinos combinam proezas marciais com magia divina. Eles canalizam poder dos Planos Exteriores para curar aliados, proteger os inocentes e punir os malfeitores. Cada Paladino é definido por seu juramento sagrado, um compromisso com ideais de justiça, glória, natureza ou vingança.',
  '',
  '',
  '[
    {
      "name": "Imposição de Mãos",
      "level": 1,
      "description": "Seu toque abençoado pode curar feridas. Você tem uma reserva de poder de cura = 5x seu nível de Paladino. Recupera ao terminar Descanso Longo.\\n\\nComo Ação Bônus, toque uma criatura (pode ser você) e restaure PV da reserva.\\n\\nVocê também pode gastar 5 PV da reserva para remover a condição Envenenado da criatura (não restaura PV).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Você aprendeu a conjurar magias por meio de orações e meditação.\\n\\nEspaços de Magia: Recupera todos ao terminar Descanso Longo.\\n\\nMagias Preparadas de Nível 1+: Começa com duas magias de nível 1 (Heroísmo e Punição Cauterizante recomendadas).\\n\\nAlterando Magias: Ao terminar Descanso Longo, pode substituir uma magia.\\n\\nHabilidade de Conjuração: Carisma.\\n\\nFoco de Conjuração: Símbolo Sagrado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Armas",
      "level": 1,
      "description": "Seu treinamento com armas permite que você use as propriedades de maestria de dois tipos de armas de sua escolha com as quais você tem proficiência (como Espadas Longas e Dardos).\\n\\nAo terminar Descanso Longo, você pode alterar os tipos de armas escolhidos.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Estilo de Luta",
      "level": 2,
      "description": "Você ganha um talento de Estilo de Luta à sua escolha.\\n\\nGuerreiro Abençoado: Você aprende dois truques de Clérigo (Orientação e Chama Sagrada recomendados). Os truques contam como magias de Paladino para você, e Carisma é sua habilidade. Sempre que você ganha um nível de Paladino, pode substituir um truque.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Golpe do Paladino",
      "level": 2,
      "usage_type": "Descanso Longo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Você sempre tem a magia Punição Divina preparada. Além disso, você pode conjurá-la sem gastar um espaço de magia, mas precisa terminar um Descanso Longo antes de poder conjurá-la dessa forma novamente.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Canalizar Divindade",
      "level": 3,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Você pode canalizar energia divina diretamente dos Planos Exteriores. Você começa com Sentido Divino. Outras características oferecem opções adicionais.\\n\\nVocê pode usar Canalizar Divindade duas vezes. Recupera um uso em Descanso Curto e todos em Descanso Longo. Ganha um uso adicional no nível 11.\\n\\nSentido Divino: Como Ação Bônus, detecte Celestiais, Demônios e Mortos-vivos a até 18m por 10 minutos. Sabe localização e tipo. Também detecta lugares consagrados/profanados.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 11, "increase": 3}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Paladino",
      "level": 3,
      "description": "Você ganha uma subclasse de Paladino à sua escolha (Juramento). Uma subclasse é uma especialização que lhe concede características em determinados níveis.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Paladino.",
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
      "name": "Corcel Fiel",
      "level": 5,
      "usage_type": "Descanso Longo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Você pode invocar a ajuda de um corcel sobrenatural. Você sempre tem o feitiço Encontrar Corcel preparado.\\n\\nVocê também pode conjurar a magia uma vez sem gastar um espaço de magia e recuperar a habilidade ao terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aura de Proteção",
      "level": 6,
      "description": "Você irradia uma aura protetora e invisível em uma Emanação de 3 metros que se origina de você. A aura fica inativa enquanto você estiver Incapacitado.\\n\\nVocê e seus aliados na aura ganham um bônus em testes de resistência = seu modificador de Carisma (mínimo +1).\\n\\nSe outro Paladino estiver presente, uma criatura pode se beneficiar de apenas uma Aura de Proteção por vez.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 7,
      "description": "Você ganha uma característica da sua Subclasse de Paladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Abjurar Inimigos",
      "level": 9,
      "description": "Como ação de Magia, gaste um uso de Canalizar Divindade para subjugar inimigos. Apresente seu Símbolo Sagrado ou arma e escolha número de criaturas = modificador de Carisma (mínimo 1) que você possa ver a até 18m.\\n\\nCada alvo: teste de resistência de Sabedoria ou Amedrontado por 1 minuto (ou até sofrer dano). Enquanto Amedrontado, pode apenas mover-se, realizar ação ou Ação Bônus.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Aura de Coragem",
      "level": 10,
      "description": "Você e seus aliados têm imunidade à condição Amedrontado enquanto estiverem na sua Aura de Proteção. Se um aliado Amedrontado entrar na aura, essa condição não terá efeito sobre ele enquanto estiver lá.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Radiantes",
      "level": 11,
      "description": "Seus golpes agora carregam poder sobrenatural. Ao atingir um alvo com uma jogada de ataque usando uma arma corpo a corpo ou um Ataque Desarmado, o alvo sofre 1d8 de dano Radiante adicional.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Restaurando o Toque",
      "level": 14,
      "description": "Ao usar Imposição de Mãos em uma criatura, você também pode remover uma ou mais condições: Cegueira, Encantada, Surda, Assustada, Paralisada ou Atordoada. Você deve gastar 5 PV da reserva de Imposição de Mãos para cada condição removida (esses pontos não restauram PV).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 15,
      "description": "Você ganha uma característica da sua Subclasse de Paladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Expansão de Aura",
      "level": 18,
      "description": "Sua Aura de Proteção agora é uma Emanação de 9 metros.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 18,
      "description": "Dependendo da sua escolha de subclasse, você pode ganhar certos recursos de subclasse neste nível.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva da Visão Verdadeira é recomendado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 20,
      "description": "Você ganha uma característica da sua Subclasse de Paladino.",
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
  '[
    {
      "name": "Juramento de Devoção",
      "description": "Defender os ideais de justiça e ordem. O Juramento de Devoção vincula os Paladinos aos ideais de justiça e ordem. Esses Paladinos correspondem ao arquétipo do cavaleiro de armadura brilhante.\\n\\nPrincípios: Deixe que sua palavra seja sua promessa. Proteja os fracos. Que suas ações honrosas sejam um exemplo.",
      "features": [
        {
          "name": "Feitiços de Juramento de Devoção",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\nNível 3: Proteção contra o mal e o bem, Escudo da fé\\nNível 5: Ajuda, Zona da Verdade\\nNível 9: Farol da Esperança, Dissipar Magia\\nNível 13: Liberdade de Movimento, Guardião da Fé\\nNível 17: Comuna, Greve de Chamas",
          "isPassive": true
        },
        {
          "name": "Arma Sagrada",
          "level": 3,
          "description": "Ao realizar ação de Ataque, gaste um uso de Canalizar Divindade para imbuir arma corpo a corpo com energia positiva por 10 minutos. Você adiciona modificador de Carisma às jogadas de ataque (mínimo +1) e pode causar dano Radiante em vez do tipo normal.\\n\\nA arma emite Luz Brilhante em 6m e Luz Fraca por mais 6m.\\n\\nVocê pode encerrar antecipadamente (nenhuma ação). Termina se você não portar a arma.",
          "isPassive": false
        },
        {
          "name": "Aura de Devoção",
          "level": 7,
          "description": "Você e seus aliados têm imunidade à condição Encantado enquanto estiverem na sua Aura de Proteção. Se um aliado Encantado entrar na aura, essa condição não terá efeito sobre ele enquanto estiver lá.",
          "isPassive": true
        },
        {
          "name": "Golpe de Proteção",
          "level": 15,
          "description": "Seu Golpe Mágico agora irradia energia protetora. Sempre que você conjurar Golpe Divino, você e seus aliados terão Meia Cobertura enquanto estiverem sob sua Aura de Proteção. A aura terá esse benefício até o início do seu próximo turno.",
          "isPassive": true
        },
        {
          "name": "Nimbo Sagrado",
          "level": 20,
          "description": "Como Ação Bônus, imbua sua Aura de Proteção com poder sagrado por 10 minutos. Após usar, não pode usar novamente até Descanso Longo (ou gaste espaço de magia de nível 5).\\n\\nProteção Sagrada: Vantagem em testes de resistência forçados por Demônio ou Morto-vivo.\\n\\nDano Radiante: Inimigos que iniciam turno na aura sofrem dano Radiante = Carisma + Bônus de Proficiência.\\n\\nLuz solar: A aura é preenchida com Luz Brilhante que é luz solar.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Juramento de Glória",
      "description": "Esforce-se para alcançar as alturas do heroísmo. Paladinos que fazem o Juramento da Glória acreditam que eles e seus companheiros estão destinados a alcançar a glória por meio de atos de heroísmo.\\n\\nPrincípios: Esforce-se para ser conhecido por suas ações. Enfrente as dificuldades com coragem. Inspire outros.",
      "features": [
        {
          "name": "Feitiços de Juramento de Glória",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\nNível 3: Parafuso Guia, Heroísmo\\nNível 5: Aprimorar habilidade, Arma mágica\\nNível 9: Pressa, Proteção contra Energia\\nNível 13: Compulsão, Liberdade de Movimento\\nNível 17: Lenda, Conhecimento, Presença Real de Yolande",
          "isPassive": true
        },
        {
          "name": "Golpe Inspirador",
          "level": 3,
          "description": "Imediatamente após conjurar Punição Divina, gaste um uso de Canalizar Divindade e distribua PV Temporários para criaturas à sua escolha a até 9m (pode incluir você). Total = 2d8 + nível de Paladino, divididos como preferir.",
          "isPassive": false
        },
        {
          "name": "Atleta Inigualável",
          "level": 3,
          "description": "Como Ação Bônus, gaste um uso de Canalizar Divindade para aumentar capacidade atlética por 1 hora. Você tem Vantagem em testes de Força (Atletismo) e Destreza (Acrobacia), e distância de Saltos em Distância e Altura aumenta em 3m.",
          "isPassive": false
        },
        {
          "name": "Aura de Vivacidade",
          "level": 7,
          "description": "Sua velocidade aumenta em 3m.\\n\\nAlém disso, sempre que um aliado entra na sua Aura de Proteção pela primeira vez em um turno ou começa seu turno lá, a Velocidade do aliado aumenta em 3m até o final do próximo turno.",
          "isPassive": true
        },
        {
          "name": "Defesa Gloriosa",
          "level": 15,
          "description": "Quando você ou criatura a até 3m for atingida por jogada de ataque, use Reação para conceder bônus à CA = modificador de Carisma (mínimo +1), potencialmente fazendo errar. Se errar, você pode realizar ataque com arma contra o atacante como parte desta Reação.\\n\\nUsos = modificador de Carisma (mínimo 1). Recupera todos em Descanso Longo.",
          "isPassive": false
        },
        {
          "name": "Lenda Viva",
          "level": 20,
          "description": "Como Ação Bônus, ganhe benefícios por 10 minutos. Após usar, não pode usar novamente até Descanso Longo (ou gaste espaço de nível 5).\\n\\nCarismático: Vantagem em todos os testes de Carisma.\\n\\nNova Jogada: Se falhar em teste de resistência, use Reação para repetir.\\n\\nAtaque Certeiro: Uma vez por turno, ao errar jogada de ataque com arma, faça acertar.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Juramento dos Antigos",
      "description": "Preserve a Vida e a Luz no Mundo. O Juramento dos Anciões é tão antigo quanto os primeiros elfos. Paladinos que o juram prezam a luz e amam as coisas belas e vivificantes do mundo.\\n\\nPrincípios: Acenda a luz da esperança. Vida em abrigo. Delicie-se com a arte e o riso.",
      "features": [
        {
          "name": "Magias do Juramento dos Antigos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\nNível 3: Ataque Enredador, Fale com Animais\\nNível 5: Passo Nebuloso, Raio de Lua\\nNível 9: Crescimento das plantas, Proteção contra energia\\nNível 13: Tempestade de Gelo, Pele de Pedra\\nNível 17: Comungue com a Natureza, Tree Stride",
          "isPassive": true
        },
        {
          "name": "Ira da Natureza",
          "level": 3,
          "description": "Como ação de Magia, gaste um uso de Canalizar Divindade para conjurar videiras espectrais. Cada criatura à sua escolha que você possa ver a até 4,5m deve fazer teste de resistência de Força ou ficar Restringido por 1 minuto. Criatura Restringida repete teste no final de cada turno, encerrando em sucesso.",
          "isPassive": false
        },
        {
          "name": "Aura de Proteção",
          "level": 7,
          "description": "A magia antiga recai tão fortemente sobre você que forma uma proteção sobrenatural; você e seus aliados têm Resistência a danos Necróticos, Psíquicos e Radiantes enquanto estiverem em sua Aura de Proteção.",
          "isPassive": true
        },
        {
          "name": "Sentinela Imortal",
          "level": 15,
          "description": "Quando você for reduzido a 0 PV e não for morto imediatamente, pode cair para 1 PV e recuperar PV = 3x nível de Paladino. Após usar, não pode usar novamente até Descanso Longo.\\n\\nAlém disso, você não pode envelhecer magicamente e deixa de envelhecer visivelmente.",
          "isPassive": false
        },
        {
          "name": "Campeão Ancião",
          "level": 20,
          "description": "Como Ação Bônus, imbua sua Aura de Proteção com poder primordial por 1 minuto. Após usar, não pode usar novamente até Descanso Longo (ou gaste espaço de nível 5).\\n\\nDiminua a Desafiação: Inimigos na aura têm Desvantagem em testes de resistência contra suas magias e Canalizar Divindade.\\n\\nRegeneração: No início de cada turno, recupera 10 PV.\\n\\nMagias Rápidas: Sempre que conjurar magia com tempo de conjuração de ação, pode conjurá-la usando Ação Bônus.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Juramento de Vingança",
      "description": "Punir os malfeitores a qualquer custo. O Juramento de Vingança é um compromisso solene de punir aqueles que cometeram atos terrivelmente malignos.\\n\\nPrincípios: Não tenha misericórdia dos maus. Combata a injustiça. Ajude aqueles prejudicados.",
      "features": [
        {
          "name": "Feitiços de Juramento de Vingança",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\nNível 3: Bane, Marca do Caçador\\nNível 5: Segure a pessoa, Misty Step\\nNível 9: Pressa, Proteção contra Energia\\nNível 13: Banimento, Porta Dimensional\\nNível 17: Segure Monstro, Vidência",
          "isPassive": true
        },
        {
          "name": "Voto de Inimizade",
          "level": 3,
          "description": "Ao realizar ação de Ataque, gaste um uso de Canalizar Divindade para proferir voto de inimizade contra criatura a até 9m. Você tem Vantagem em jogadas de ataque contra ela por 1 minuto (ou até usar novamente).\\n\\nSe a criatura cair para 0 PV antes do voto terminar, você pode transferir o voto para criatura diferente a até 9m (nenhuma ação).",
          "isPassive": false
        },
        {
          "name": "Vingador Implacável",
          "level": 7,
          "description": "Seu foco sobrenatural ajuda a bloquear a retirada de um inimigo. Ao atingir criatura com Ataque de Oportunidade, pode reduzir Velocidade da criatura a 0 até o final do turno. Você pode então se mover até metade da sua Velocidade como parte da mesma Reação. Este movimento não provoca Ataques de Oportunidade.",
          "isPassive": true
        },
        {
          "name": "Alma da Vingança",
          "level": 15,
          "description": "Imediatamente após criatura sob efeito do seu Voto de Inimizade acertar ou errar jogada de ataque, você pode usar Reação para fazer ataque corpo a corpo contra aquela criatura se ela estiver dentro do alcance.",
          "isPassive": true
        },
        {
          "name": "Anjo Vingador",
          "level": 20,
          "description": "Como Ação Bônus, ganhe benefícios por 10 minutos. Após usar, não pode usar novamente até Descanso Longo (ou gaste espaço de nível 5).\\n\\nVoo: Você cria asas espectrais, tem Velocidade de Voo de 18m e pode pairar.\\n\\nAura Assustadora: Sempre que inimigo inicia turno na sua Aura de Proteção, deve fazer teste de resistência de Sabedoria ou ficar Amedrontado por 1 minuto (ou até sofrer dano). Jogadas de ataque contra criatura Amedrontada têm Vantagem.",
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
    {"name": "Escudo", "cost": "10.0", "weight": "6.0", "category": "Armadura", "quantity": 1},
    {"name": "Espada longa", "cost": "15.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Dardo", "cost": "0.05", "weight": "0.25", "category": "Arma", "quantity": 6},
    {"name": "Símbolo sagrado", "cost": "5.0", "weight": "1.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do sacerdote", "cost": "33.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  9,
  150,
  '[]'::jsonb
);
