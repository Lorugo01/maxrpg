-- Inserir classe Feiticeiro/Sorcerer (PHB 2024)
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
  'Feiticeiro',
  6,
  'Carisma',
  'Constituição, Carisma',
  'Arcanismo, Enganação, Intuição, Intimidação, Persuasão, Religião',
  null,
  null,
  '{"ability": "Carisma", "type": "full"}',
  now(),
  now(),
  'PHB 2024',
  '',
  'Armas Simples',
  '',
  '[
    {
      "name": "Feitiçaria Aberrante",
      "description": "Uma influência alienígena envolveu sua mente com seus tentáculos, concedendo-lhe poder psiônico. Agora você pode tocar outras mentes com esse poder e alterar o mundo ao seu redor.",
      "features": [
        {
          "name": "Feitiços Psiônicos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Braços de Hadar, Emoções calmas, Detectar pensamentos, Sussurros dissonantes, Fragmento mental\\nNível 5: Fome de Hadar, Enviando\\nNível 7: Tentáculos Negros de Evard, Invocar Aberração\\nNível 9: Vínculo Telepático de Rary, Telecinese",
          "isPassive": true
        },
        {
          "name": "Fala Telepática",
          "level": 3,
          "description": "Você pode formar conexão telepática entre sua mente e mente de outra pessoa. Como Ação Bônus, escolha criatura que você possa ver a até 9m. Você e criatura escolhida podem se comunicar telepaticamente enquanto estiverem a distância de quilômetros = modificador de Carisma (mínimo 1,6km). Para se entenderem, cada um deve usar mentalmente língua que o outro conheça.\\n\\nA conexão telepática dura número de minutos = seu nível de Feiticeiro. Ela termina mais cedo se você usar esta habilidade para formar conexão com criatura diferente.",
          "isPassive": false
        },
        {
          "name": "Feitiçaria Psiônica",
          "level": 6,
          "description": "Ao conjurar qualquer magia de nível 1+ da sua habilidade Magias Psiônicas, você pode conjurá-la gastando espaço de magia normalmente ou gastando quantidade de Pontos de Feitiçaria = nível da magia. Se você conjurar magia usando Pontos de Feitiçaria, ela não requer componentes Verbais ou Somáticos, nem componentes Materiais, a menos que sejam consumidos pela magia ou tenham custo especificado nela.",
          "isPassive": true
        },
        {
          "name": "Defesas Psíquicas",
          "level": 6,
          "description": "Você tem Resistência a dano Psíquico e tem Vantagem em testes de resistência para evitar ou encerrar condição Encantado ou Amedrontado.",
          "isPassive": true
        },
        {
          "name": "Revelação em Carne",
          "level": 14,
          "description": "Você pode revelar verdade aberrante escondida dentro de si. Como Ação Bônus, você pode gastar 1 Ponto de Feitiçaria ou mais para alterar magicamente seu corpo por 10 minutos. Para cada Ponto gasto, você ganha um dos seguintes benefícios:\\n\\nAdaptação Aquática: Você ganha Velocidade de Natação = dobro da sua Velocidade e pode respirar debaixo d'água. Brânquias crescem no seu pescoço ou se alargam atrás das orelhas, e seus dedos se tornam palmados ou você desenvolve cílios que se contorcem.\\n\\nVoo Brilhante: Você ganha Velocidade de Voo = sua Velocidade e pode pairar. Ao voar, sua pele brilha com muco ou luz sobrenatural.\\n\\nVeja o Invisível: Você pode ver qualquer criatura Invisível a até 18m que não esteja atrás da Cobertura Total. Seus olhos também ficam pretos ou se transformam em tentáculos sensoriais retorcidos.\\n\\nMovimento Vermiforme: Seu corpo, assim como qualquer equipamento que você esteja vestindo ou carregando, torna-se viscoso e maleável. Você pode se mover por qualquer espaço com até 2,5cm de largura e pode gastar 1,5m de movimento para escapar de amarras não mágicas ou da condição Agarrado.",
          "isPassive": false
        },
        {
          "name": "Implosão de Deformação",
          "level": 18,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode desencadear anomalia que distorce espaço. Com ação de Magia, você se teletransporta para espaço desocupado que possa ver a até 36m. Imediatamente após desaparecer, cada criatura a até 9m do espaço que você deixou deve realizar teste de Força contra sua CD de magia. Em falha, criatura sofre 3d10 de dano de Força e é puxada diretamente para espaço que você deixou, terminando em espaço desocupado o mais próximo possível. Em sucesso, criatura sofre apenas metade do dano.\\n\\nDepois de usar, não poderá fazê-lo novamente até terminar Descanso Longo, a menos que gaste 5 Pontos de Feitiçaria para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Feitiçaria Mecânica",
      "description": "A força cósmica da ordem o impregnou com magia. Esse poder surge de Mechanus ou de um reino semelhante — um plano de existência moldado inteiramente pela eficiência mecânica.",
      "features": [
        {
          "name": "Feitiços Mecânicos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Ajuda, Alarme, Restauração Menor, Proteção contra o Mal e o Bem\\nNível 5: Dissipar magia, proteção contra energia\\nNível 7: Liberdade de Movimento, Invocar Construto\\nNível 9: Restauração Maior, Muralha de Força\\n\\nAlém disso, sua conexão com ordem se manifesta enquanto você estiver conjurando qualquer de suas magias de Feiticeiro (engrenagens espectrais pairam, ponteiros de relógio giram em seus olhos, pele brilha com brilho acobreado, equações flutuantes cobrem corpo, Foco assume forma de mecanismo de relógio, ou tique-taque de engrenagens pode ser ouvido).",
          "isPassive": true
        },
        {
          "name": "Restaurar o equilíbrio",
          "level": 3,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Carisma",
          "usage_recovery": "Descanso Longo",
          "description": "Sua conexão com plano da ordem absoluta permite que você equilibre momentos caóticos. Quando criatura que você possa ver a até 18m estiver prestes a rolar d20 com Vantagem ou Desvantagem, você pode usar Reação para evitar que rolagem seja afetada por Vantagem e Desvantagem.\\n\\nVocê pode usar número de vezes = modificador de Carisma (mínimo 1). Recupera todos em Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Bastião da Lei",
          "level": 6,
          "description": "Você pode recorrer à grande equação da existência para imbuir criatura com escudo cintilante de ordem. Com ação de Magia, você pode gastar de 1 a 5 Pontos de Feitiçaria para criar proteção mágica ao seu redor ou a outra criatura que você possa ver a até 9m. A proteção é representada por número de d8s = número de Pontos gastos para criá-la. Quando criatura protegida sofre dano, ela pode gastar número desses dados, rolá-los e reduzir dano recebido pelo total rolado.\\n\\nA proteção dura até você terminar Descanso Longo ou até usar esse recurso novamente.",
          "isPassive": false
        },
        {
          "name": "Transe de Ordem",
          "level": 14,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você ganha habilidade de alinhar sua consciência com cálculos infinitos de Mechanus. Como Ação Bônus, você pode entrar neste estado por 1 minuto. Durante duração, jogadas de ataque contra você não podem se beneficiar de Vantagem, e sempre que fizer Teste D20, você pode considerar jogada de 9 ou menos no d20 como 10.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Longo, a menos que gaste 5 Pontos de Feitiçaria para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Cavalgada Mecânica",
          "level": 18,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você invoca momentaneamente espíritos da ordem para expurgar desordem ao seu redor. Com ação de Magia, você invoca espíritos em Cubo de 9m originado de você. Os espíritos se parecem com modrons ou outros Construtos à sua escolha. Os espíritos são intangíveis e invulneráveis, e criam efeitos abaixo dentro do Cubo antes de desaparecerem:\\n\\nCura: Os espíritos restauram até 100 Pontos de Vida, divididos conforme você escolher entre qualquer número de criaturas de sua escolha no Cubo.\\n\\nReparo: Quaisquer objetos danificados que estejam inteiramente no Cubo serão reparados instantaneamente.\\n\\nDissipar: Todas as magias de nível 6 ou inferior terminam em criaturas e objetos de sua escolha no Cubo.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Longo, a menos que gaste 7 Pontos de Feitiçaria para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Feitiçaria Dracônica",
      "description": "Sua magia inata vem do dom de um dragão. Talvez um dragão ancestral, enfrentando a morte, tenha legado parte de seu poder mágico a você ou ao seu ancestral. Você pode ter absorvido magia de um local infundido com poder de dragão.",
      "features": [
        {
          "name": "Resiliência Dracônica",
          "level": 3,
          "description": "A magia em seu corpo manifesta características físicas do seu dom dracônico. Seus Pontos de Vida máximos aumentam em 3 e aumentam em 1 sempre que você ganha outro nível de Feiticeiro.\\n\\nPartes de você também são cobertas por escamas semelhantes às de um dragão. Enquanto você não estiver usando armadura, sua Classe de Armadura base será igual a 10 + modificadores de Destreza e Carisma.",
          "isPassive": true,
          "unarmored_defense": {
            "base": 10,
            "abilities": ["Destreza", "Carisma"],
            "allows_shield": false
          }
        },
        {
          "name": "Feitiços Dracônicos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Alter Self, Orbe Cromático, Comando, Sopro do Dragão\\nNível 5: Medo, Voe\\nNível 7: Olho Arcano, Monstro Encantado\\nNível 9: Lenda, Conhecimento, Invocar Dragão",
          "isPassive": true
        },
        {
          "name": "Afinidade Elemental",
          "level": 6,
          "description": "Sua magia dracônica tem afinidade com tipo de dano associado a dragões. Escolha um desses tipos: Ácido, Frio, Fogo, Relâmpago ou Veneno.\\n\\nVocê tem Resistência a esse tipo de dano e, quando conjura magia que causa dano desse tipo, você pode adicionar seu modificador de Carisma a uma jogada de dano dessa magia.",
          "isPassive": true
        },
        {
          "name": "Asas de Dragão",
          "level": 14,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Como Ação Bônus, você pode fazer com que asas dracônicas apareçam nas suas costas. As asas duram 1 hora ou até você dispensá-las. Enquanto durar, você terá Velocidade de Voo de 18m.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Longo, a menos que gaste 3 Pontos de Feitiçaria para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Companheiro Dragão",
          "level": 18,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode conjurar Invocar Dragão sem componente Material. Você também pode conjurá-lo uma vez sem espaço de magia (recupera em Descanso Longo).\\n\\nSempre que você começar a conjurar feitiço, poderá modificá-lo para que não exija Concentração. Se fizer isso, duração do feitiço será de 1 minuto para aquela conjuração.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Feitiçaria Mágica Selvagem",
      "description": "Sua magia inata provém das forças do caos que fundamentam a ordem da criação. Você ou um ancestral pode ter sido exposto à magia bruta, talvez através de um portal planar que levasse ao Limbo ou aos Planos Elementais.",
      "features": [
        {
          "name": "Surto de Magia Selvagem",
          "level": 3,
          "description": "Sua conjuração pode liberar ondas de magia indomável. Uma vez por turno, você pode rolar 1d20 imediatamente após conjurar magia de Feiticeiro com espaço de magia. Se tirar 20, role na tabela de Onda de Magia Selvagem para criar efeito mágico.\\n\\nSe efeito mágico for magia, ela é muito selvagem para ser afetada pela sua Metamagia.",
          "isPassive": true
        },
        {
          "name": "Marés do Caos",
          "level": 3,
          "description": "Você pode manipular o próprio caos para obter Vantagem em Teste de D20 antes de rolar d20. Depois disso, você deve conjurar magia de Feiticeiro com espaço de magia ou concluir Descanso Longo antes de poder usar essa habilidade novamente.\\n\\nSe você conjurar magia de Feiticeiro com espaço de magia antes de terminar Descanso Longo, você automaticamente rola na tabela Surto de Magia Selvagem.",
          "isPassive": false
        },
        {
          "name": "Dobre a Sorte",
          "level": 6,
          "description": "Você tem habilidade de distorcer destino usando sua magia selvagem. Imediatamente após outra criatura que você possa ver rolar d20 para Teste D20, você pode realizar Reação e gastar 1 Ponto de Feitiçaria para rolar 1d4 e aplicar número obtido como bônus ou penalidade (à sua escolha) ao resultado do d20.",
          "isPassive": false
        },
        {
          "name": "Caos Controlado",
          "level": 14,
          "description": "Você ganha mínimo de controle sobre surtos de sua magia selvagem. Sempre que rolar na tabela Surto de Magia Selvagem, você pode rolar duas vezes e usar qualquer um dos números.",
          "isPassive": true
        },
        {
          "name": "Surto Domado",
          "level": 18,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Imediatamente após conjurar magia de Feiticeiro com espaço de magia, você pode criar efeito de sua escolha na tabela Surto de Magia Selvagem, em vez de rolar nessa tabela. Você pode escolher qualquer efeito na tabela, exceto última linha, e se efeito escolhido envolver rolagem, você deve fazê-la.\\n\\nDepois de usar, não poderá fazê-lo novamente até terminar Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    }
  ]'::jsonb,
  'Feiticeiros são conjuradores que carregam magia inata em suas veias, concedida por linhagem exótica, influência mística ou evento cósmico. Ao contrário de Magos que estudam grimórios, Feiticeiros manipulam sua magia bruta através de força de vontade e carisma, moldando magias de maneiras únicas através de Metamagia.',
  '',
  '',
  '[
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Usando sua magia inata, você pode conjurar magias.\\n\\nTruques: Você conhece quatro truques de Feiticeiro (Luz, Prestidigitação, Agarramento Chocante e Explosão de Feiticeiro recomendados). Sempre que ganhar nível, pode substituir um truque. Nos níveis 4 e 10, aprende outro truque.\\n\\nEspaços de Magia: Recupera todos ao terminar Descanso Longo.\\n\\nMagias Preparadas de Nível 1+: Começa com duas magias de nível 1 (Mãos Ardentes e Detectar Magia recomendadas).\\n\\nAlterando Magias: Sempre que ganhar nível, pode substituir uma magia.\\n\\nHabilidade de Conjuração: Carisma.\\n\\nFoco: Foco Arcano.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Feitiçaria Inata",
      "level": 1,
      "usage_type": "Fixo",
      "usage_value": 2,
      "usage_recovery": "Descanso Longo",
      "description": "Um evento do seu passado deixou marca indelével em você, infundindo-lhe magia latente. Com Ação Bônus, você pode liberar essa magia por 1 minuto, durante o qual você ganha seguintes benefícios:\\n\\n• A CD de resistência à magia das suas magias de Feiticeiro aumenta em 1.\\n• Você tem vantagem nas jogadas de ataque de magias de Feiticeiro que você conjura.\\n\\nVocê pode usar esse recurso duas vezes e recuperar todos os usos gastos ao terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Fonte da Magia",
      "level": 2,
      "usage_type": "Manual por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Longo",
      "description": "Você pode acessar fonte de magia dentro de si. Essa fonte é representada pelos Pontos de Feitiçaria.\\n\\nVocê tem 2 Pontos de Feitiçaria e ganha mais à medida que avança de nível. Você não pode ter mais Pontos do que o número mostrado na tabela para seu nível. Você recupera todos os Pontos gastos ao terminar Descanso Longo.\\n\\nVocê pode usar seus Pontos para:\\n\\nConvertendo Espaços em Pontos: Você pode gastar espaço de magia para ganhar quantidade de Pontos = nível do espaço.\\n\\nCriando Espaços: Como Ação Bônus, você pode transformar Pontos não gastos em espaço de magia. Custo: Nível 1 = 2 pontos, Nível 2 = 3 pontos, Nível 3 = 5 pontos, Nível 4 = 6 pontos, Nível 5 = 7 pontos. Qualquer espaço criado desaparece quando você termina Descanso Longo.",
      "has_usage_limit": true,
      "manual_level_increases": [
        {"level": 2, "increase": 2},
        {"level": 3, "increase": 3},
        {"level": 4, "increase": 4},
        {"level": 5, "increase": 5},
        {"level": 6, "increase": 6},
        {"level": 7, "increase": 7},
        {"level": 8, "increase": 8},
        {"level": 9, "increase": 9},
        {"level": 10, "increase": 10},
        {"level": 11, "increase": 11},
        {"level": 12, "increase": 12},
        {"level": 13, "increase": 13},
        {"level": 14, "increase": 14},
        {"level": 15, "increase": 15},
        {"level": 16, "increase": 16},
        {"level": 17, "increase": 17},
        {"level": 18, "increase": 18},
        {"level": 19, "increase": 19},
        {"level": 20, "increase": 20}
      ],
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Metamagia",
      "level": 2,
      "description": "Como sua magia flui de dentro, você pode alterar suas magias para atender às suas necessidades; você ganha duas opções de Metamagia à sua escolha.\\n\\nVocê pode usar apenas uma opção de Metamagia em magia ao conjurá-la, a menos que haja alguma indicação em contrário.\\n\\nAo atingir nível de Feiticeiro, você pode substituir uma das suas opções por uma que você não conhece. Você ganha mais duas opções no nível 10 e mais duas no nível 17.\\n\\nOpções de Metamagia:\\n\\n• Feitiço Cuidadoso (1 Ponto): Ao conjurar magia que força criaturas a realizar teste de resistência, você pode proteger algumas dessas criaturas. Gaste 1 Ponto e escolha número de criaturas = modificador de Carisma (mínimo 1). Criatura escolhida obtém sucesso automático no teste e não sofre dano se normalmente receberia metade em sucesso.\\n\\n• Feitiço Distante (1 Ponto): Ao conjurar magia com alcance de pelo menos 1,5m, você pode gastar 1 Ponto para dobrar alcance da magia. Ou, ao conjurar magia com alcance de Toque, pode gastar 1 Ponto para aumentar alcance para 9m.\\n\\n• Feitiço Fortalecido (1 Ponto): Ao rolar dano de magia, você pode gastar 1 Ponto para rolar novamente número de dados de dano até seu modificador de Carisma (mínimo 1), e você deve usar novas rolagens. Você pode usar Magia Fortalecida mesmo que já tenha usado opção de Metamagia diferente durante lançamento da magia.\\n\\n• Feitiço Estendido (1 Ponto): Ao conjurar magia com duração de 1 minuto ou mais, você pode gastar 1 Ponto para dobrar sua duração até duração máxima de 24 horas. Se magia afetada exigir Concentração, você terá Vantagem em qualquer teste de resistência que fizer para manter essa Concentração.\\n\\n• Feitiço Intensificado (2 Pontos): Quando você conjura magia que força criatura a fazer teste de resistência, você pode gastar 2 Pontos para dar a um alvo da magia Desvantagem em testes de resistência contra magia.\\n\\n• Feitiço Acelerado (2 Pontos): Ao conjurar magia cujo tempo de conjuração é ação, você pode gastar 2 Pontos para transformar tempo de conjuração em Ação Bônus para essa conjuração. Você não pode modificar magia dessa forma se já tiver conjurado magia de nível 1+ no turno atual, nem pode conjurar magia de nível 1+ neste turno após modificar magia dessa forma.\\n\\n• Feitiço de Busca (1 Ponto): Se você fizer jogada de ataque para magia e errar, você pode gastar 1 Ponto para rolar novamente d20 e deve usar nova jogada. Você pode usar Magia de Busca mesmo que já tenha usado opção de Metamagia diferente durante lançamento da magia.\\n\\n• Feitiço Sutil (1 Ponto): Ao conjurar magia, você pode gastar 1 Ponto para conjurá-la sem nenhum componente Verbal, Somático ou Material, exceto componentes Materiais que são consumidos pela magia ou que têm custo especificado na magia.\\n\\n• Feitiço Transmutado (1 Ponto): Ao conjurar magia que causa tipo de dano da lista a seguir, você pode gastar 1 Ponto para mudar esse tipo de dano para um dos outros tipos listados: Ácido, Frio, Fogo, Relâmpago, Veneno, Trovão.\\n\\n• Feitiço Gêmeo (1 Ponto): Quando você conjura magia, como Encantar Pessoa, que pode ser conjurada com espaço de magia de nível mais alto para atingir criatura adicional, você pode gastar 1 Ponto para aumentar nível efetivo da magia em 1.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Feiticeiro",
      "level": 3,
      "description": "Você ganha uma subclasse de Feiticeiro à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Feiticeiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Restauração Feiticeira",
      "level": 5,
      "usage_type": "Fixo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Ao terminar Descanso Curto, você pode recuperar Pontos de Feitiçaria gastos, mas não mais do que número = metade do seu nível de Feiticeiro (arredondado para baixo). Depois de usar, não poderá fazê-lo novamente até terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua subclasse Feiticeiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Feitiçaria Encarnada",
      "level": 7,
      "description": "Se você não tiver mais usos para Feitiçaria Inata, poderá usá-la se gastar 2 Pontos de Feitiçaria ao realizar Ação Bônus para ativá-la.\\n\\nAlém disso, enquanto sua habilidade Feitiçaria Inata estiver ativa, você pode usar até duas de suas opções de Metamagia em cada magia que conjurar.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Metamagia",
      "level": 10,
      "description": "Você ganha duas opções de Metamagia adicionais de sua escolha. Sempre que você ganha nível de Feiticeiro, você pode substituir uma de suas opções de Metamagia por uma que você não conhece.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 14,
      "description": "Você ganha uma característica da sua subclasse Feiticeiro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Metamagia",
      "level": 17,
      "description": "Você ganha duas opções de Metamagia adicionais de sua escolha. Sempre que você ganha nível de Feiticeiro, você pode substituir uma de suas opções de Metamagia por uma que você não conhece.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 18,
      "description": "Você ganha uma característica da sua subclasse Feiticeiro.",
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
      "name": "Apoteose Arcana",
      "level": 20,
      "description": "Enquanto sua habilidade Feitiçaria Inata estiver ativa, você pode usar uma opção de Metamagia em cada um dos seus turnos sem gastar Pontos de Feitiçaria nela.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
  '[
    {"level": 1, "cantrips": 4, "known_spells": 2},
    {"level": 2, "cantrips": 4, "known_spells": 2},
    {"level": 3, "cantrips": 4, "known_spells": 4},
    {"level": 4, "cantrips": 5, "known_spells": 5},
    {"level": 5, "cantrips": 5, "known_spells": 6},
    {"level": 6, "cantrips": 5, "known_spells": 7},
    {"level": 7, "cantrips": 5, "known_spells": 8},
    {"level": 8, "cantrips": 5, "known_spells": 9},
    {"level": 9, "cantrips": 5, "known_spells": 10},
    {"level": 10, "cantrips": 6, "known_spells": 11},
    {"level": 11, "cantrips": 6, "known_spells": 12},
    {"level": 12, "cantrips": 6, "known_spells": 12},
    {"level": 13, "cantrips": 6, "known_spells": 13},
    {"level": 14, "cantrips": 6, "known_spells": 13},
    {"level": 15, "cantrips": 6, "known_spells": 14},
    {"level": 16, "cantrips": 6, "known_spells": 14},
    {"level": 17, "cantrips": 6, "known_spells": 15},
    {"level": 18, "cantrips": 6, "known_spells": 15},
    {"level": 19, "cantrips": 6, "known_spells": 15},
    {"level": 20, "cantrips": 6, "known_spells": 15}
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
  '[]'::jsonb,
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
    {"name": "Lança", "cost": "1.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Adaga", "cost": "2.0", "weight": "1.0", "category": "Arma", "quantity": 2},
    {"name": "Foco Arcano (cristal)", "cost": "10.0", "weight": "1.0", "category": "Foco", "quantity": 1},
    {"name": "Pacote do Dungeon", "cost": "12.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  28,
  50,
  '[]'::jsonb
);
