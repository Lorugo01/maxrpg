-- Inserir classe Ladino/Rogue (PHB 2024)
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
  'Ladino',
  8,
  'Destreza',
  'Destreza, Inteligência',
  'Acrobacia, Atletismo, Enganação, Percepção, Intimidação, Investigação, Percepção, Persuasão, Prestidigitação, Furtividade',
  null,
  null,
  null,
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves',
  'Armas Simples, Armas Marciais com Finesse ou Light',
  'Ferramentas de Ladrão',
  '[
    {
      "name": "Trapaceiro Arcano",
      "description": "Alguns Ladinos aprimoram suas habilidades de furtividade e agilidade com magias, aprendendo truques mágicos que os auxiliam em seu ofício.",
      "features": [
        {
          "name": "Conjuração",
          "level": 3,
          "description": "Você aprendeu a conjurar magias.\\n\\nTruques: Você conhece três truques: Mão Mágica e dois outros de Mago (Lasca Mental e Ilusão Menor recomendados). Sempre que ganhar nível, pode substituir um truque (exceto Mão de Mago). No nível 10, aprende outro truque.\\n\\nEspaços de Magia: Recupera todos em Descanso Longo.\\n\\nMagias Preparadas de Nível 1+: Começa com três magias de Mago de nível 1 (Encantar Pessoa, Disfarçar-se e Nuvem de Névoa recomendadas).\\n\\nAlterando Magias: Sempre que ganhar nível, pode substituir uma magia.\\n\\nHabilidade de Conjuração: Inteligência.\\n\\nFoco: Foco Arcano.",
          "isPassive": true
        },
        {
          "name": "Legerdemain da Mão Maga",
          "level": 3,
          "description": "Ao conjurar Mão Mágica, você pode conjurá-la como Ação Bônus e tornar a mão espectral Invisível. Você pode controlar a mão como Ação Bônus e, por meio dela, pode realizar testes de Destreza (Prestidigitação).",
          "isPassive": true
        },
        {
          "name": "Emboscada Mágica",
          "level": 9,
          "description": "Se você tiver condição Invisível ao conjurar magia em criatura, ela terá Desvantagem em qualquer teste de resistência que fizer contra a magia no mesmo turno.",
          "isPassive": true
        },
        {
          "name": "Trapaceiro Versátil",
          "level": 13,
          "description": "Você ganha habilidade de distrair alvos com sua Mão Mágica. Ao usar opção Desastrar do seu Ataque Astuto em criatura, você também pode usar essa opção em outra criatura a até 1,5m da mão espectral.",
          "isPassive": true
        },
        {
          "name": "Ladrão de Feitiços",
          "level": 17,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Imediatamente após criatura conjurar magia que o tenha como alvo ou o inclua em sua área, você pode usar Reação para forçar criatura a realizar teste de Inteligência. CD = sua CD de magia. Em falha, você nega efeito da magia contra você e rouba conhecimento da magia se ela for pelo menos nível 1 e de nível que você possa conjurar. Pelas próximas 8 horas, você tem a magia preparada. A criatura não pode conjurá-la até que as 8 horas tenham passado.\\n\\nDepois de roubar magia, não poderá usar novamente até terminar Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Assassino",
      "description": "O treinamento de um Assassino concentra-se no uso de furtividade, veneno e disfarce para eliminar inimigos com eficiência letal.",
      "features": [
        {
          "name": "Assassinar",
          "level": 3,
          "description": "Você é especialista em emboscar um alvo:\\n\\nIniciativa: Você tem Vantagem em testes de Iniciativa.\\n\\nAtaques Surpreendentes: Durante primeira rodada de cada combate, você tem Vantagem em jogadas de ataque contra qualquer criatura que não tenha jogado turno. Se seu Ataque Furtivo atingir qualquer alvo durante a rodada, o alvo sofre dano extra do tipo da arma igual ao seu nível de Ladino.",
          "isPassive": true
        },
        {
          "name": "Ferramentas do Assassino",
          "level": 3,
          "description": "Você ganha Kit de Disfarce e Kit de Envenenador e tem proficiência neles.",
          "isPassive": true
        },
        {
          "name": "Especialização em Infiltração",
          "level": 9,
          "description": "Você é especialista nas seguintes técnicas:\\n\\nMímica Magistral: Você consegue imitar com precisão fala, caligrafia ou ambos de outra pessoa, desde que tenha dedicado pelo menos 1 hora ao estudo.\\n\\nMira Móvel: Sua Velocidade não é reduzida a 0 ao usar Mira Firme.",
          "isPassive": true
        },
        {
          "name": "Armas Envenenadas",
          "level": 13,
          "description": "Ao usar opção Veneno do seu Ataque Astuto, o alvo também sofre 2d6 de dano de Veneno sempre que falhar no teste de resistência. Este dano ignora Resistência a dano de Veneno.",
          "isPassive": true
        },
        {
          "name": "Golpe Mortal",
          "level": 17,
          "description": "Quando você acerta com seu Ataque Furtivo na primeira rodada de combate, o alvo deve ser bem-sucedido em teste de Constituição (CD 8 + modificador de Destreza + Bônus de Proficiência), ou o dano do ataque é dobrado contra o alvo.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Soulknife",
      "description": "Uma Faca Espiritual ataca com a mente, rompendo barreiras físicas e psíquicas. Esses Ladinos descobrem poder psiônico dentro de si e o canalizam para realizar seus trabalhos desonestos.",
      "features": [
        {
          "name": "Poder Psiônico",
          "level": 3,
          "usage_type": "Manual por Nível",
          "initial_dice": "1d6",
          "dice_increases": [
            {"level": 5, "dice": "1d8"},
            {"level": 11, "dice": "1d10"},
            {"level": 17, "dice": "1d12"}
          ],
          "description": "Você abriga fonte de energia psiônica. Ela é representada pelos seus Dados de Energia Psiônica:\\n\\nNível 3: 4 dados de d6\\nNível 5: 6 dados de d8\\nNível 9: 8 dados de d8\\nNível 11: 8 dados de d10\\nNível 13: 10 dados de d10\\nNível 17: 12 dados de d12\\n\\nVocê recupera um dado gasto ao terminar Descanso Curto e todos ao terminar Descanso Longo.\\n\\nHabilidade Psi-Reforçada: Se falhar em teste de habilidade usando perícia/ferramenta com proficiência, pode rolar Dado de Energia Psiônica e adicionar ao teste, potencialmente transformando falha em sucesso. Dado é gasto somente se teste for bem-sucedido.\\n\\nSussurros Psíquicos: Como ação de Magia, escolha uma ou mais criaturas (até Bônus de Proficiência) e role Dado. Por número de horas = número rolado, criaturas escolhidas podem falar telepaticamente com você (até 1,6km). Na primeira vez após cada Descanso Longo, não gasta dado.",
          "has_usage_limit": true,
          "has_dice_increase": true,
          "manual_level_increases": [
            {"level": 3, "increase": 4},
            {"level": 5, "increase": 6},
            {"level": 9, "increase": 8},
            {"level": 13, "increase": 10},
            {"level": 17, "increase": 12}
          ],
          "isPassive": false
        },
        {
          "name": "Lâminas Psíquicas",
          "level": 3,
          "description": "Você pode manifestar lâminas brilhantes de energia psíquica. Sempre que realizar ação de Ataque ou Ataque de Oportunidade, você pode manifestar Lâmina Psíquica na sua mão livre e realizar ataque com essa lâmina. A lâmina mágica: 1d6 Psíquico, Finesse, Arremessada (60/120 pés), Maestria: Vex.\\n\\nA lâmina desaparece imediatamente após atingir ou errar alvo.\\n\\nApós atacar com lâmina no seu turno, pode realizar ataque corpo a corpo ou à distância com segunda lâmina psíquica como Ação Bônus no mesmo turno, se outra mão estiver livre. Dado de dano deste ataque bônus é 1d4 em vez de 1d6.",
          "isPassive": true
        },
        {
          "name": "Lâminas de Alma",
          "level": 9,
          "description": "Agora você pode usar os seguintes poderes com suas Lâminas Psíquicas:\\n\\nGolpes Teleguiados: Se você fizer jogada de ataque com Lâmina Psíquica e errar alvo, pode rolar Dado de Energia Psiônica e adicionar ao ataque. Se isso fizer ataque acertar, dado é gasto.\\n\\nTeletransporte Psíquico: Como Ação Bônus, você manifesta Lâmina Psíquica, gasta Dado de Energia Psiônica, rola-o e arremessa lâmina em espaço desocupado que possa ver a até distância de metros = 10 × número rolado. Você então se teletransporta para esse espaço, e lâmina desaparece.",
          "isPassive": true
        },
        {
          "name": "Véu Psíquico",
          "level": 13,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode tecer véu de estática psíquica para se mascarar. Com ação de Magia, você ganha condição Invisível por 1 hora ou até dispensar efeito. Essa invisibilidade termina imediatamente após você causar dano a criatura ou forçar criatura a realizar teste de resistência.\\n\\nDepois de usar, não poderá fazê-lo novamente até terminar Descanso Longo, a menos que gaste Dado de Energia Psiônica para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Rasgar Mente",
          "level": 17,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode varrer mente de criatura com suas Lâminas Psíquicas. Ao usar suas Lâminas Psíquicas para causar dano de Ataque Furtivo a criatura, você pode forçar alvo a realizar teste de Sabedoria (CD 8 + modificador de Destreza + Bônus de Proficiência). Se falhar, alvo fica atordoado por 1 minuto. Alvo atordoado repete teste ao final de cada turno, encerrando efeito em sucesso.\\n\\nDepois de usar, não poderá fazê-lo novamente até terminar Descanso Longo, a menos que gaste três Dados de Energia Psiônica para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Ladrão",
      "description": "Uma mistura de ladrão, caçador de tesouros e explorador, você é o epítome do aventureiro. Além de aprimorar sua agilidade e furtividade, você ganha habilidades úteis para escavar ruínas e aproveitar ao máximo os itens mágicos que encontrar lá.",
      "features": [
        {
          "name": "Mãos Rápidas",
          "level": 3,
          "description": "Como Ação Bônus, você pode fazer uma das seguintes ações:\\n\\nPrestidigitação: Faça teste de Destreza (Prestidigitação) para arrombar fechadura ou desarmar armadilha com Ferramentas de Ladrão ou para furtar bolso.\\n\\nUsar um Objeto: Execute ação Utilizar ou ação Magia para usar item mágico que exija essa ação.",
          "isPassive": true
        },
        {
          "name": "Trabalho do Segundo Andar",
          "level": 3,
          "description": "Você treinou para chegar a lugares especialmente difíceis de alcançar:\\n\\nEscalador: Você ganha Velocidade de Escalada igual à sua Velocidade.\\n\\nSaltador: Você pode determinar distância do seu salto usando sua Destreza em vez de sua Força.",
          "isPassive": true
        },
        {
          "name": "Esgueirar-se Supremo",
          "level": 9,
          "description": "Você ganha seguinte opção de Ataque Astuto:\\n\\nAtaque Furtivo (Custo: 1d6): Se você tiver condição Invisível da ação Esconder-se, este ataque não encerra essa condição em você se você terminar turno atrás de Cobertura de Três Quartos ou Cobertura Total.",
          "isPassive": true
        },
        {
          "name": "Usar Dispositivo Mágico",
          "level": 13,
          "description": "Você aprendeu como maximizar uso de itens mágicos:\\n\\nSintonização: Você pode sintonizar até quatro itens mágicos ao mesmo tempo.\\n\\nCargas: Sempre que você usar propriedade de item mágico que gaste cargas, role 1d6. Com resultado de 6, você usa propriedade sem gastar cargas.\\n\\nPergaminhos: Você pode usar qualquer Pergaminho de Magia, usando Inteligência como habilidade de conjuração. Se magia for truque ou nível 1, você pode conjurá-la com segurança. Se pergaminho contiver magia de nível superior, você deve primeiro obter sucesso em teste de Inteligência (Arcana) (CD 10 + nível da magia). Em sucesso, você conjura magia do pergaminho. Em falha, pergaminho se desintegra.",
          "isPassive": true
        },
        {
          "name": "Reflexos de Ladrão",
          "level": 17,
          "description": "Você é especialista em armar emboscadas e escapar rapidamente do perigo. Você pode fazer dois turnos durante primeiro turno de qualquer combate. Você faz primeiro turno com sua Iniciativa normal e segundo turno com sua Iniciativa menos 10.",
          "isPassive": true
        }
      ]
    }
  ]'::jsonb,
  'Mestres da furtividade e especialistas em explorar fraquezas, os Ladinos são aventureiros versáteis que confiam em habilidades refinadas e táticas astutas. Seja como ladrões, espiões, detetives ou assassinos, eles usam sua agilidade e inteligência para superar desafios.',
  '',
  '',
  '[
    {
      "name": "Especialização",
      "level": 1,
      "description": "Você ganha Perícia em duas das suas proficiências de perícia à sua escolha (Prestidigitação e Furtividade recomendadas se tiver proficiência).\\n\\nNo nível 6, você ganha Perícia em mais duas de suas proficiências de perícia.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": true,
      "proficiency_skill_count": 2,
      "manual_level_increases": [
        {"level": 6, "increase": 4}
      ]
    },
    {
      "name": "Ataque furtivo",
      "level": 1,
      "initial_dice": "1d6",
      "dice_increases": [
        {"level": 3, "dice": "2d6"},
        {"level": 5, "dice": "3d6"},
        {"level": 7, "dice": "4d6"},
        {"level": 9, "dice": "5d6"},
        {"level": 11, "dice": "6d6"},
        {"level": 13, "dice": "7d6"},
        {"level": 15, "dice": "8d6"},
        {"level": 17, "dice": "9d6"},
        {"level": 19, "dice": "10d6"}
      ],
      "description": "Você sabe como atacar sutilmente e explorar distração do inimigo. Uma vez por turno, você pode causar 1d6 de dano extra a criatura atingida em jogada de ataque se tiver Vantagem na jogada e ataque usar arma de Refinamento ou de Longo Alcance. O tipo de dano extra é o mesmo da arma.\\n\\nVocê não precisa de Vantagem se pelo menos um dos seus aliados estiver a até 1,5m do alvo, o aliado não tiver condição Incapacitado e você não tiver Desvantagem.\\n\\nO dano extra aumenta à medida que você ganha níveis de Ladino.",
      "has_usage_limit": false,
      "has_dice_increase": true,
      "has_proficiency_doubling": false
    },
    {
      "name": "Gíria dos Ladrões",
      "level": 1,
      "description": "Você aprendeu vários idiomas nas comunidades onde exercia seus talentos de ladino. Você conhece a Gíria dos Ladrões e um outro idioma de sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Armas",
      "level": 1,
      "description": "Seu treinamento com armas permite que você use as propriedades de maestria de dois tipos de armas de sua escolha com as quais você tem proficiência (como Adagas e Arcos Curtos).\\n\\nAo terminar Descanso Longo, você pode alterar os tipos de armas escolhidos.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ação Astuta",
      "level": 2,
      "description": "Seu raciocínio rápido e agilidade permitem que você se mova e aja rapidamente. No seu turno, você pode realizar uma das seguintes ações como Ação Bônus: Disparar, Desengajar ou Esconder-se.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Ladino",
      "level": 3,
      "description": "Você ganha uma subclasse de Ladino à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mira Firme",
      "level": 3,
      "description": "Como Ação Bônus, você se concede Vantagem na sua próxima jogada de ataque no turno atual. Você só pode usar esta habilidade se não tiver se movido durante este turno e, após usá-la, sua Velocidade será 0 até o final do turno atual.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 10, 12 e 16 de Ladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataque Astuto",
      "level": 5,
      "description": "Você desenvolveu maneiras astutas de usar seu Ataque Furtivo. Ao causar dano de Ataque Furtivo, você pode adicionar um dos seguintes efeitos. Cada efeito tem custo de dado, que é número de dados de dano de Ataque Furtivo que você deve abrir mão. Você remove dado antes de rolar, e efeito ocorre imediatamente após dano do ataque ser causado.\\n\\nSe efeito exigir teste de resistência, CD = 8 + modificador de Destreza + Bônus de Proficiência.\\n\\nVeneno (Custo: 1d6): Você adiciona toxina ao seu golpe, forçando alvo a realizar teste de Constituição. Em falha, alvo permanece na condição Envenenado por 1 minuto. Ao final de cada turno, alvo Envenenado repete teste, encerrando efeito em sucesso. Para usar, você deve ter Kit de Envenenamento consigo.\\n\\nTropeçar (Custo: 1d6): Se alvo for Grande ou menor, ele deve ser bem-sucedido em teste de Destreza ou estar na condição Caído.\\n\\nRetirar (Custo: 1d6): Imediatamente após ataque, você se move até metade da sua Velocidade sem provocar Ataques de Oportunidade.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Esquiva Sobrenatural",
      "level": 5,
      "description": "Quando atacante que você pode ver lhe acerta com jogada de ataque, você pode usar Reação para reduzir pela metade o dano do ataque contra você (arredondado para baixo).",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Evasão",
      "level": 7,
      "description": "Você pode se esquivar agilmente de certos perigos. Quando você é submetido a efeito que lhe permite fazer teste de resistência de Destreza para receber apenas metade do dano, você não recebe dano se for bem-sucedido no teste e apenas metade do dano se falhar. Você não pode usar esta habilidade se tiver condição Incapacitado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Talento Confiável",
      "level": 7,
      "description": "Sempre que você fizer teste de habilidade que use uma de suas proficiências em perícias ou ferramentas, você pode tratar resultado de 9 ou menos no d20 como 10.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 9,
      "description": "Você ganha uma característica da sua Subclasse de Ladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataque Astuto Aprimorado",
      "level": 11,
      "description": "Você pode usar até dois efeitos de Ataque Astuto quando causar dano de Ataque Furtivo, pagando o custo de dado para cada efeito.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 13,
      "description": "Você ganha uma característica da sua Subclasse de Ladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Desonestos",
      "level": 14,
      "description": "Você praticou novas maneiras de usar seu Ataque Furtivo de forma ardilosa. Os seguintes efeitos agora estão entre suas opções de Ataque Astuto:\\n\\nAtordoar (Custo: 2d6): O alvo deve ser bem-sucedido em teste de Constituição ou, no próximo turno, poderá realizar apenas uma das seguintes ações: mover-se ou realizar ação ou Ação Bônus.\\n\\nNocaute (Custo: 6d6): O alvo deve ser bem-sucedido em teste de Constituição, ou ficará inconsciente por 1 minuto ou até sofrer qualquer dano. Alvo inconsciente repete teste ao final de cada turno, encerrando efeito em sucesso.\\n\\nObscuro (Custo: 3d6): O alvo deve ser bem-sucedido em teste de Destreza, ou ficará cego até o final do próximo turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mente Escorregadia",
      "level": 15,
      "description": "Sua mente astuta é excepcionalmente difícil de controlar. Você ganha proficiência em testes de resistência de Sabedoria e Carisma.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 17,
      "description": "Você ganha uma característica da sua Subclasse de Ladino.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Elusivo",
      "level": 18,
      "description": "Você é tão evasivo que os atacantes raramente têm vantagem contra você. Nenhuma jogada de ataque pode ter Vantagem contra você, a menos que você tenha condição Incapacitado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva do Espírito Noturno é recomendado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Golpe de Sorte",
      "level": 20,
      "usage_type": "Fixo",
      "usage_value": 1,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Você tem talento incrível para ter sucesso quando necessário. Se você falhar em Teste D20, poderá transformar o resultado em 20.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Curto ou Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  false,
  null,
  null,
  '[]'::jsonb,
  4,
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
    {"name": "Armadura de couro", "cost": "5.0", "weight": "10.0", "category": "Armadura", "quantity": 1},
    {"name": "Adaga", "cost": "2.0", "weight": "1.0", "category": "Arma", "quantity": 2},
    {"name": "Espada curta", "cost": "10.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Arco curto", "cost": "25.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Flecha", "cost": "0.05", "weight": "0.05", "category": "Munição", "quantity": 20},
    {"name": "Aljava", "cost": "1.0", "weight": "1.0", "category": "Equipamento", "quantity": 1},
    {"name": "Ferramentas de ladrão", "cost": "25.0", "weight": "1.0", "category": "Ferramenta", "quantity": 1},
    {"name": "Pacote de ladrão", "cost": "16.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  8,
  100,
  '[]'::jsonb
);
