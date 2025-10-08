-- Inserir classe Bruxo/Warlock (PHB 2024)
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
  'Bruxo',
  8,
  'Carisma',
  'Sabedoria, Carisma',
  'Arcanismo, Enganação, História, Intimidação, Investigação, Natureza, Religião',
  null,
  null,
  '{"ability": "Carisma", "type": "pact"}',
  now(),
  now(),
  'PHB 2024',
  'Armaduras Leves',
  'Armas Simples',
  '',
  '[
    {
      "name": "Patrono Archfey",
      "description": "Seu pacto se baseia no poder da Agrestia das Fadas. Você pode fazer acordo com arquifada, como Príncipe do Gelo; Rainha do Ar e da Escuridão; Titânia da Corte do Verão; ou bruxa ancestral.",
      "features": [
        {
          "name": "Magias de Arquifadas",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Emoções Calmas, Fogo de Fada, Passo Nebuloso, Força Fantasmagórica, Sono\\nNível 5: Pisque, Crescimento de Plantas\\nNível 7: Dominar Besta, Invisibilidade Maior\\nNível 9: Dominar Pessoa, Aparentando",
          "isPassive": true
        },
        {
          "name": "Passos das Fadas",
          "level": 3,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Carisma",
          "usage_recovery": "Descanso Longo",
          "description": "Seu patrono lhe concede habilidade de se mover entre limites dos planos. Você pode conjurar Passo Nebuloso sem gastar espaço de magia número de vezes = modificador de Carisma (mínimo 1). Recupera todos em Descanso Longo.\\n\\nAlém disso, sempre que conjurar essa magia, você pode escolher um dos seguintes efeitos adicionais:\\n\\nEtapa de Renovação: Imediatamente após se teletransportar, você ou criatura que você possa ver a até 3m ganha 1d10 PV Temporários.\\n\\nPasso Provocador: Criaturas a até 1,5m do espaço que você deixou devem ser bem-sucedidas em teste de Sabedoria contra sua CD ou terão Desvantagem em jogadas de ataque contra criaturas que não sejam você até início do seu próximo turno.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Fuga da Neblina",
          "level": 6,
          "description": "Você pode conjurar Passo Nebuloso como Reação em resposta ao dano sofrido.\\n\\nAlém disso, os seguintes efeitos agora estão entre suas opções de Passos das Fadas:\\n\\nPasso de Desaparecimento: Você tem condição Invisível até início do seu próximo turno ou até imediatamente após realizar jogada de ataque, causar dano ou conjurar magia.\\n\\nPasso Terrível: Criaturas a até 1,5m do espaço que você deixou ou do espaço em que você apareceu (sua escolha) devem ser bem-sucedidas em teste de Sabedoria contra sua CD ou sofrerão 2d10 de dano Psíquico.",
          "isPassive": false
        },
        {
          "name": "Defesas Enganosas",
          "level": 10,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Seu patrono lhe ensina a proteger sua mente e seu corpo. Você é imune à condição Encantado.\\n\\nAlém disso, imediatamente após criatura que você vê atingi-lo com jogada de ataque, você pode usar Reação para reduzir dano recebido pela metade (arredondado para baixo) e forçar atacante a realizar teste de Sabedoria contra sua CD. Em falha, atacante recebe dano Psíquico = dano que você recebeu. Depois de usar esta Reação, não poderá usá-la novamente até terminar Descanso Longo, a menos que gaste espaço de magia de Pacto Mágico para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Magia Encantadora",
          "level": 14,
          "description": "Seu patrono lhe concede habilidade de tecer sua magia com teletransporte. Imediatamente após conjurar magia de Encantamento ou Ilusão usando ação e espaço de magia, você pode conjurar Passo Nebuloso como parte da mesma ação e sem gastar espaço de magia.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Patrono Celestial",
      "description": "Seu pacto se baseia nos Planos Superiores, os reinos da bem-aventurança eterna. Você pode firmar acordo com empíreo, couatl, esfinge, unicórnio ou outra entidade celestial.",
      "features": [
        {
          "name": "Feitiços Celestiais",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Ajuda, Cura de Feridas, Raio Guia, Restauração Menor, Luz, Chama Sagrada\\nNível 5: Luz do dia, Revitalizar\\nNível 7: Guardião da Fé, Muro de Fogo\\nNível 9: Restauração Maior, Invocação Celestial",
          "isPassive": true
        },
        {
          "name": "Luz de Cura",
          "level": 3,
          "usage_type": "Manual por Nível",
          "initial_dice": "1d6",
          "description": "Você ganha habilidade de canalizar energia celestial para curar ferimentos. Você tem conjunto de d6s para alimentar essa cura. O número de dados no conjunto = 1 + seu nível de Bruxo.\\n\\nComo Ação Bônus, você pode curar a si mesmo ou criatura que você possa ver a até 18m, gastando dados da reserva. O número máximo de dados que você pode gastar de uma vez = modificador de Carisma (mínimo 1 dado). Role os dados que você gastar e restaure quantidade de PV = total da rolagem. Sua reserva recupera todos os dados gastos quando você termina Descanso Longo.",
          "has_usage_limit": true,
          "has_dice_increase": true,
          "manual_level_increases": [
            {"level": 1, "increase": 2},
            {"level": 2, "increase": 3},
            {"level": 3, "increase": 4},
            {"level": 4, "increase": 5},
            {"level": 5, "increase": 6},
            {"level": 6, "increase": 7},
            {"level": 7, "increase": 8},
            {"level": 8, "increase": 9},
            {"level": 9, "increase": 10},
            {"level": 10, "increase": 11},
            {"level": 11, "increase": 12},
            {"level": 12, "increase": 13},
            {"level": 13, "increase": 14},
            {"level": 14, "increase": 15},
            {"level": 15, "increase": 16},
            {"level": 16, "increase": 17},
            {"level": 17, "increase": 18},
            {"level": 18, "increase": 19},
            {"level": 19, "increase": 20},
            {"level": 20, "increase": 21}
          ],
          "isPassive": false
        },
        {
          "name": "Alma Radiante",
          "level": 6,
          "description": "Sua ligação com seu patrono permite que você sirva como condutor de energia radiante. Você tem Resistência a dano Radiante. Uma vez por turno, quando magia que você conjurar causar dano Radiante ou de Fogo, você pode adicionar seu modificador de Carisma ao dano daquela magia contra um dos alvos da magia.",
          "isPassive": true
        },
        {
          "name": "Resiliência Celestial",
          "level": 10,
          "description": "Você ganha PV Temporários sempre que usa sua habilidade Astúcia Mágica ou conclui Descanso Curto ou Longo. Esses PV Temporários = seu nível de Bruxo + modificador de Carisma. Além disso, escolha até cinco criaturas que você possa ver ao ganhar os pontos. Cada uma dessas criaturas ganha PV Temporários = metade do seu nível de Bruxo + modificador de Carisma.",
          "isPassive": true
        },
        {
          "name": "Vingança Cauterizante",
          "level": 14,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Quando você ou aliado a até 18m estiver prestes a realizar Salvaguarda contra Morte, você pode liberar energia radiante para salvar criatura. A criatura recupera PV = metade do seu máximo de PV e pode encerrar condição Caído em si mesma. Cada criatura à sua escolha que estiver a até 9m da criatura sofre dano Radiante = 2d8 + modificador de Carisma, e cada uma permanece na condição Cego até final do turno atual.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Patrono Demônio",
      "description": "Seu pacto se baseia nos Planos Inferiores, os reinos da perdição. Você pode forjar acordo com lorde demônio como Demogorgon ou Orcus; arquidiabo como Asmodeus; ou demônio do abismo, balor, yugoloth ou bruxa da noite especialmente poderoso.",
      "features": [
        {
          "name": "Feitiços Demoníacos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Mãos Ardentes, Comando, Raio Escaldante, Sugestão\\nNível 5: Bola de fogo, nuvem fedorenta\\nNível 7: Escudo de Fogo, Parede de Fogo\\nNível 9: Geas, Praga de Insetos",
          "isPassive": true
        },
        {
          "name": "Bênção do Escuro",
          "level": 3,
          "description": "Ao reduzir inimigo a 0 PV, você ganha PV Temporários = modificador de Carisma + nível de Bruxo (mínimo 1 PV Temporário). Você também ganha esse benefício se outra pessoa reduzir inimigo a até 3m de você a 0 PV.",
          "isPassive": true
        },
        {
          "name": "A própria sorte do Dark One",
          "level": 6,
          "usage_type": "Por Modificador de Atributo",
          "usage_attribute": "Carisma",
          "usage_recovery": "Descanso Longo",
          "description": "Você pode invocar seu patrono diabólico para alterar destino a seu favor. Ao fazer teste de habilidade ou salvaguarda, você pode usar essa habilidade para adicionar 1d10 à sua rolagem. Você pode fazer isso após ver rolagem, mas antes que qualquer efeito da rolagem ocorra.\\n\\nVocê pode usar número de vezes = modificador de Carisma (mínimo 1), mas não pode usá-la mais de uma vez por rolagem. Recupera todos os usos em Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Resiliência Diabólica",
          "level": 10,
          "description": "Escolha tipo de dano, diferente de Força, sempre que terminar Descanso Curto ou Longo. Você tem Resistência a esse tipo de dano até escolher um diferente com esta característica.",
          "isPassive": true
        },
        {
          "name": "Arremessar pelo Inferno",
          "level": 14,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Uma vez por turno, ao atingir criatura com jogada de ataque, você pode tentar transportar alvo instantaneamente através dos Planos Inferiores. O alvo deve ser bem-sucedido em teste de Carisma contra sua CD, ou desaparecerá e se lançará por paisagem de pesadelo. O alvo sofre 8d10 de dano Psíquico se não for Demônio e permanece na condição Incapacitado até final do seu próximo turno, quando retornará ao espaço que ocupava anteriormente ou ao espaço desocupado mais próximo.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Longo, a menos que gaste espaço de magia Pacto Mágico para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        }
      ]
    },
    {
      "name": "Grande Ancião Patrono",
      "description": "Você pode se vincular a ser indizível do Reino Distante ou a deus ancião — ser como Tharizdun, Deus Acorrentado; Zargon, Retornador; Hadar, Fome Sombria; ou Grande Cthulhu.",
      "features": [
        {
          "name": "Grandes Feitiços Antigos",
          "level": 3,
          "description": "Você sempre tem as seguintes magias preparadas:\\n\\nNível 3: Detectar Pensamentos, Sussurros Dissonantes, Força Fantasmagórica, Risada Hedionda de Tasha\\nNível 5: Clarividência, Fome de Hadar\\nNível 7: Confusão, Invocar Aberração\\nNível 9: Modificar memória, telecinese",
          "isPassive": true
        },
        {
          "name": "Mente Desperta",
          "level": 3,
          "description": "Você pode formar conexão telepática entre sua mente e mente de outra pessoa. Como Ação Bônus, escolha criatura que você possa ver a até 9m. Você e criatura escolhida podem se comunicar telepaticamente enquanto estiverem a distância de quilômetros = modificador de Carisma (mínimo 1,6km). Para se entenderem, cada um deve usar mentalmente língua que o outro conheça.\\n\\nA conexão telepática dura número de minutos = seu nível de Bruxo. Ela termina mais cedo se você usar esse recurso para se conectar com criatura diferente.",
          "isPassive": false
        },
        {
          "name": "Feitiços Psíquicos",
          "level": 3,
          "description": "Ao conjurar magia de Bruxo que causa dano, você pode alterar seu tipo de dano para Psíquico. Além disso, ao conjurar magia de Bruxo que seja Encantamento ou Ilusão, você pode fazê-lo sem componentes Verbais ou Somáticos.",
          "isPassive": true
        },
        {
          "name": "Combatente Clarividente",
          "level": 6,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Curto ou Longo",
          "description": "Ao formar vínculo telepático com criatura usando sua Mente Desperta, você pode forçar essa criatura a realizar teste de Sabedoria contra sua CD. Em falha, criatura tem Desvantagem em jogadas de ataque contra você, e você tem Vantagem em jogadas de ataque contra essa criatura enquanto durar vínculo.\\n\\nDepois de usar, não poderá usar novamente até terminar Descanso Curto ou Longo, a menos que gaste espaço de magia Pacto Mágico para restaurar uso.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Maldição Sobrenatural",
          "level": 10,
          "description": "Seu patrono alienígena lhe concede maldição poderosa. Você sempre tem magia Hex preparada. Ao conjurar Hex e escolher habilidade, alvo também recebe Desvantagem em testes de resistência da habilidade escolhida enquanto durar magia.",
          "isPassive": true
        },
        {
          "name": "Escudo de Pensamento",
          "level": 10,
          "description": "Seus pensamentos não podem ser lidos por telepatia ou outros meios, a menos que você permita. Você também tem Resistência a Dano Psíquico e, sempre que criatura lhe causa Dano Psíquico, ela sofre mesma quantidade de dano que você.",
          "isPassive": true
        },
        {
          "name": "Criar Escravo",
          "level": 14,
          "description": "Ao conjurar Invocar Aberração, você pode modificá-la para que não exija Concentração. Se fizer isso, duração da magia passa a ser de 1 minuto para essa conjuração e, ao ser invocada, Aberração tem quantidade de PV Temporários = seu nível de Bruxo + modificador de Carisma.\\n\\nAlém disso, na primeira vez em que Aberração atinge criatura sob efeito do seu Feitiço, ela causa dano Psíquico extra ao alvo = dano bônus daquela magia.",
          "isPassive": true
        }
      ]
    }
  ]'::jsonb,
  'Bruxos são conjuradores que firmaram pacto com entidade misteriosa para obter poderes mágicos. Através de Invocações Sobrenaturais e magia de pacto, eles moldam sua magia de formas únicas. Diferente de outros conjuradores, Bruxos recuperam espaços de magia em Descansos Curtos.',
  '',
  '',
  '[
    {
      "name": "Invocações Sobrenaturais",
      "level": 1,
      "description": "Você desenterrou Invocações Sobrenaturais, fragmentos de conhecimento proibido que lhe conferem habilidade mágica duradoura ou outras lições. Você ganha uma invocação à sua escolha.\\n\\nPré-requisitos: Se invocação tiver pré-requisito, você deverá atendê-lo para aprendê-la.\\n\\nSubstituindo e Obtendo Invocações: Sempre que você ganha nível de Bruxo, você pode substituir uma de suas invocações por outra para qual você se qualifica. Você não pode substituir invocação se ela for pré-requisito para outra invocação que você já tenha.\\n\\nQuando você ganha certos níveis de Bruxo, você ganha mais invocações de sua escolha, como mostrado na coluna Invocações da tabela Recursos do Bruxo.\\n\\nVocê não pode escolher mesma invocação mais de uma vez, a menos que sua descrição diga o contrário.\\n\\nOPÇÕES DE INVOCAÇÃO:\\n\\n• Explosão Agonizante (Nível 2+, truque que causa dano): Escolha truque de Bruxo que cause dano. Você pode adicionar modificador de Carisma às jogadas de dano daquela magia. Repetível.\\n\\n• Armadura das Sombras: Você pode conjurar Armadura de Mago em si mesmo sem gastar espaço de magia.\\n\\n• Passo Ascendente (Nível 5+): Você pode conjurar Levitar em si mesmo sem gastar espaço de magia.\\n\\n• Visão do Diabo (Nível 2+): Você pode enxergar normalmente em penumbra e escuridão —mágicas e não mágicas— a até 36m.\\n\\n• Lâmina Devoradora (Nível 12+, Lâmina Sedenta): O Ataque Extra da sua invocação Lâmina Sedenta confere dois ataques extras em vez de um.\\n\\n• Mente Sobrenatural: Você tem Vantagem em testes de Constituição para manter Concentração.\\n\\n• Golpe Sobrenatural (Nível 5+, Pacto da Lâmina): Uma vez por turno, ao atingir criatura com sua arma de pacto, você pode gastar espaço de magia de Pacto para causar 1d8 de dano de Força extra ao alvo, mais 1d8 por nível do espaço, e você pode dar ao alvo condição Prone se ele for Enorme ou menor.\\n\\n• Lança Sobrenatural (Nível 2+, truque que causa dano): Escolha truque de Bruxo que cause dano e tenha alcance de 3m ou mais. Ao conjurar essa magia, seu alcance aumenta em metros = 30 × seu nível de Bruxo. Repetível.\\n\\n• Vigor diabólico (Nível 2+): Você pode conjurar Vida Falsa em si mesmo sem gastar espaço de magia. Ao conjurar com esta habilidade, você não rola dado para PV Temporários; você obtém automaticamente maior número no dado.\\n\\n• Olhar de Duas Mentes (Nível 5+): Você pode usar Ação Bônus para tocar criatura disposta e perceber através dos seus sentidos até final do seu próximo turno. Enquanto criatura estiver no mesmo plano que você, você pode realizar Ação Bônus nos turnos subsequentes para manter essa conexão.\\n\\n• Presente das Profundezas (Nível 5+): Você pode respirar debaixo d'água e ganha Velocidade de Natação = sua Velocidade. Você também pode conjurar Respiração Aquática uma vez sem gastar espaço de magia. Recupera habilidade em Descanso Longo.\\n\\n• Presente dos Protetores (Nível 9+, Pacto do Tomo): Nova página aparece no seu Livro das Sombras. Com sua permissão, criatura pode escrever seu nome naquela página, que pode conter número de nomes = modificador de Carisma (mínimo 1). Quando qualquer criatura cujo nome esteja na página for reduzida a 0 PV, mas não for morta imediatamente, criatura magicamente cai para 1 PV. Uma vez que esta magia é ativada, nenhuma criatura pode se beneficiar dela até que você termine Descanso Longo.\\n\\n• Investimento do Mestre da Cadeia (Nível 5+, Pacto da Corrente): Ao conjurar Encontrar Familiar, você infunde familiar invocado com medida do seu poder sobrenatural.\\n\\n• Lições dos Primeiros (Nível 2+): Você recebeu conhecimento de entidade anciã do multiverso, permitindo que você ganhe talento de Origem de sua escolha. Repetível.\\n\\n• Bebedor de vida (Nível 9+, Pacto da Lâmina): Uma vez por turno, ao atingir criatura com sua arma de pacto, você pode causar 1d6 de dano Necrótico, Psíquico ou Radiante extra (sua escolha) à criatura, e pode gastar um de seus Dados de PV para rolá-lo e recuperar número de PV = resultado + modificador de Constituição (mínimo 1 PV).\\n\\n• Máscara de Muitas Faces (Nível 2+): Você pode conjurar Disfarçar-se sem gastar espaço de magia.\\n\\n• Mestre das Miríades de Formas (Nível 5+): Você pode conjurar Alterar-se sem gastar espaço de magia.\\n\\n• Visões nebulosas (Nível 2+): Você pode conjurar Imagem Silenciosa sem gastar espaço de magia.\\n\\n• Um com Sombras (Nível 5+): Enquanto estiver em área de Penumbra ou Escuridão, você pode lançar Invisibilidade em si mesmo sem gastar espaço de magia.\\n\\n• Salto sobrenatural (Nível 2+): Você pode conjurar Pular em si mesmo sem gastar espaço de magia.\\n\\n• Pacto da Lâmina: Como Ação Bônus, você pode conjurar arma de pacto em sua mão — arma Corpo a Corpo Simples ou Marcial de sua escolha com qual você se vincula — ou criar vínculo com arma mágica que você tocar.\\n\\n• Pacto da Corrente: Você aprende magia Encontrar Familiar e pode conjurá-la como ação de Magia sem gastar espaço de magia.\\n\\n• Pacto do Tomo: Costurando fios de sombra, você conjura livro em sua mão ao final de Descanso Curto ou Longo. Este Livro das Sombras contém magia sobrenatural que só você pode acessar.\\n\\n• Explosão Repelente (Nível 2+, truque que causa dano por jogada de ataque): Escolha truque de Bruxo que exija jogada de ataque. Ao atingir criatura Grande ou menor com esse truque, você pode empurrá-la até 3m para longe de você. Repetível.\\n\\n• Lâmina Sedenta (Nível 5+, Pacto da Lâmina): Você ganha habilidade Ataque Extra apenas para sua arma de pacto.\\n\\n• Visões de Reinos Distantes (Nível 9+): Você pode conjurar Olho Arcano sem gastar espaço de magia.\\n\\n• Sussurros do Túmulo (Nível 7+): Você pode conjurar Falar com os Mortos sem gastar espaço de magia.\\n\\n• Visão de Bruxa (Nível 15+): Você tem Truesight com alcance de 9m.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Pacto Mágico",
      "level": 1,
      "description": "Por meio de cerimônia oculta, você firmou pacto com entidade misteriosa para obter poderes mágicos.\\n\\nTruques: Você conhece dois truques de Bruxo (Explosão Sobrenatural e Prestidigitação recomendados). Sempre que ganhar nível, pode substituir um truque. Nos níveis 4 e 10, aprende outro truque.\\n\\nEspaços de Magia: Todos os espaços são do mesmo nível. Você recupera todos ao terminar Descanso Curto ou Longo.\\n\\nMagias Preparadas de Nível 1+: Começa com duas magias de nível 1 (Encantar Pessoa e Maldição recomendadas).\\n\\nAlterando Magias: Sempre que ganhar nível, pode substituir uma magia.\\n\\nHabilidade de Conjuração: Carisma.\\n\\nFoco: Foco Arcano.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Astúcia Mágica",
      "level": 2,
      "usage_type": "Fixo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Você pode realizar rito esotérico por 1 minuto. Ao final, você recupera espaços de magia de Pacto gastos, mas não mais do que número = metade do seu máximo (arredondado para cima). Depois de usar, não poderá fazê-la novamente até terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse de Bruxo",
      "level": 3,
      "description": "Você ganha uma subclasse de Bruxo à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Bruxo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua subclasse de Bruxo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Contate o Patrono",
      "level": 9,
      "usage_type": "Fixo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "No passado, você geralmente contatava seu patrono por meio de intermediários. Agora você pode se comunicar diretamente; você sempre tem magia Contatar Outro Plano preparada. Com esta habilidade, você pode conjurar magia sem gastar espaço de magia para contatar seu patrono, e você obtém sucesso automático no teste de resistência da magia.\\n\\nDepois de lançar magia com essa característica, não poderá fazê-lo novamente dessa forma até terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 10,
      "description": "Você ganha uma característica da sua subclasse de Bruxo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Arcano Místico",
      "level": 11,
      "description": "Seu patrono lhe concede segredo mágico chamado arcano. Escolha magia de Bruxo de nível 6 como este arcano.\\n\\nVocê pode conjurar sua magia de arcano uma vez sem gastar espaço de magia, e deve terminar Descanso Longo antes de poder conjurá-la dessa forma novamente.\\n\\nConforme mostrado na tabela, você ganha outra magia de Bruxo à sua escolha, que pode ser conjurada dessa forma, ao atingir níveis 13 (magia de nível 7), 15 (magia de nível 8) e 17 (magia de nível 9) de Bruxo. Você recupera todos os usos do seu Arcano Místico ao terminar Descanso Longo.\\n\\nSempre que você ganha nível de Bruxo, você pode substituir uma de suas magias de arcano por outra magia de Bruxo do mesmo nível.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 14,
      "description": "Você ganha uma característica da sua subclasse de Bruxo.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva do Destino é recomendado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Mestre Eldritch",
      "level": 20,
      "description": "Ao usar sua habilidade Astúcia Mágica, você recupera todos os seus espaços de magia de Pacto gastos.",
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
    {"level": 4, "cantrips": 3, "known_spells": 5},
    {"level": 5, "cantrips": 3, "known_spells": 6},
    {"level": 6, "cantrips": 3, "known_spells": 7},
    {"level": 7, "cantrips": 3, "known_spells": 8},
    {"level": 8, "cantrips": 3, "known_spells": 9},
    {"level": 9, "cantrips": 3, "known_spells": 10},
    {"level": 10, "cantrips": 4, "known_spells": 10},
    {"level": 11, "cantrips": 4, "known_spells": 11},
    {"level": 12, "cantrips": 4, "known_spells": 11},
    {"level": 13, "cantrips": 4, "known_spells": 12},
    {"level": 14, "cantrips": 4, "known_spells": 12},
    {"level": 15, "cantrips": 4, "known_spells": 13},
    {"level": 16, "cantrips": 4, "known_spells": 13},
    {"level": 17, "cantrips": 4, "known_spells": 14},
    {"level": 18, "cantrips": 4, "known_spells": 14},
    {"level": 19, "cantrips": 4, "known_spells": 15},
    {"level": 20, "cantrips": 4, "known_spells": 15}
  ]'::jsonb,
  '[
    {"level": 1, "level_1": 1, "slot_level": 1},
    {"level": 2, "level_1": 2, "slot_level": 1},
    {"level": 3, "level_2": 2, "slot_level": 2},
    {"level": 4, "level_2": 2, "slot_level": 2},
    {"level": 5, "level_3": 2, "slot_level": 3},
    {"level": 6, "level_3": 2, "slot_level": 3},
    {"level": 7, "level_4": 2, "slot_level": 4},
    {"level": 8, "level_4": 2, "slot_level": 4},
    {"level": 9, "level_5": 2, "slot_level": 5},
    {"level": 10, "level_5": 2, "slot_level": 5},
    {"level": 11, "level_5": 3, "slot_level": 5},
    {"level": 12, "level_5": 3, "slot_level": 5},
    {"level": 13, "level_5": 3, "slot_level": 5},
    {"level": 14, "level_5": 3, "slot_level": 5},
    {"level": 15, "level_5": 3, "slot_level": 5},
    {"level": 16, "level_5": 3, "slot_level": 5},
    {"level": 17, "level_5": 4, "slot_level": 5},
    {"level": 18, "level_5": 4, "slot_level": 5},
    {"level": 19, "level_5": 4, "slot_level": 5},
    {"level": 20, "level_5": 4, "slot_level": 5}
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
    {"name": "Armadura de couro", "cost": "5.0", "weight": "10.0", "category": "Armadura", "quantity": 1},
    {"name": "Foice", "cost": "1.0", "weight": "2.0", "category": "Arma", "quantity": 1},
    {"name": "Adaga", "cost": "2.0", "weight": "1.0", "category": "Arma", "quantity": 2},
    {"name": "Foco arcano (orbe)", "cost": "20.0", "weight": "3.0", "category": "Foco", "quantity": 1},
    {"name": "Livro (conhecimento oculto)", "cost": "25.0", "weight": "5.0", "category": "Equipamento", "quantity": 1},
    {"name": "Pacote do estudioso", "cost": "40.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  15,
  100,
  '[]'::jsonb
);
