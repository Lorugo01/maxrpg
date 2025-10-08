-- Inserir classe Mago/Wizard (PHB 2024)
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
  'Mago',
  6,
  'Inteligência',
  'Inteligência, Sabedoria',
  'Arcanismo, História, Intuição, Investigação, Medicina, Religião',
  null,
  null,
  '{"ability": "Inteligência", "type": "full"}',
  now(),
  now(),
  'PHB 2024',
  '',
  'Armas Simples',
  '',
  '[
    {
      "name": "Abjurador",
      "description": "Seu estudo de magia concentra-se em magias que bloqueiam, banem ou protegem — eliminando efeitos nocivos, banindo influências malignas e protegendo os fracos.",
      "features": [
        {
          "name": "Sábio da Abjuração",
          "level": 3,
          "description": "Escolha duas magias de Mago da escola de Abjuração, cada uma das quais não deve ser superior a nível 2, e adicione-as ao seu grimório gratuitamente.\\n\\nAlém disso, sempre que você ganhar acesso a novo nível de espaços de magia nesta classe, poderá adicionar magia de Mago da escola de Abjuração ao seu grimório gratuitamente. A magia escolhida deve ser de nível para qual você tenha espaços de magia.",
          "isPassive": true
        },
        {
          "name": "Proteção Arcana",
          "level": 3,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Longo",
          "description": "Você pode tecer magia ao seu redor para proteção. Quando você conjura magia de Abjuração com espaço de magia, você pode usar simultaneamente fio da magia da magia para criar proteção mágica em si mesmo que dura até você terminar Descanso Longo. A proteção tem PV máximo = dobro do seu nível de Mago + modificador de Inteligência. Sempre que você sofre dano, proteção sofre dano em vez disso, e se você tiver quaisquer Resistências ou Vulnerabilidades, aplique-as antes de reduzir PV da proteção. Se dano reduzir proteção a 0 PV, você sofre qualquer dano restante.\\n\\nSempre que você conjura magia de Abjuração com espaço de magia, protegido recupera quantidade de PV = dobro do nível do espaço de magia. Alternativamente, como Ação Bônus, você pode gastar espaço de magia, e protegido recupera quantidade de PV = dobro do nível do espaço gasto.\\n\\nDepois de criar proteção, não poderá criá-la novamente até terminar Descanso Longo.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Ala Projetada",
          "level": 6,
          "description": "Quando criatura visível a até 9m de você sofre dano, você pode usar Reação para fazer com que sua Proteção Arcana absorva esse dano. Se esse dano reduzir proteção a 0 PV, criatura protegida sofre dano restante. Se criatura tiver Resistências ou Vulnerabilidades, aplique-as antes de reduzir PV da proteção.",
          "isPassive": false
        },
        {
          "name": "Quebrador de Feitiços",
          "level": 10,
          "description": "Você sempre tem magias Contramagia e Dissipar Magia preparadas. Além disso, você pode conjurar Dissipar Magia como Ação Bônus e adicionar seu Bônus de Proficiência ao teste de habilidade.\\n\\nQuando você conjura qualquer uma das magias com espaço de magia, esse espaço não é gasto se magia não conseguir parar outra magia.",
          "isPassive": true
        },
        {
          "name": "Resistência à Magia",
          "level": 14,
          "description": "Você tem Vantagem em testes de resistência contra magias e Resistência ao dano de magias.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Adivinho",
      "description": "O conselho de um Adivinho é procurado por aqueles que desejam compreensão mais clara do passado, presente e futuro. Como Adivinho, você se esforça para romper véus do espaço, do tempo e da consciência.",
      "features": [
        {
          "name": "Adivinhação Sábia",
          "level": 3,
          "description": "Escolha duas magias de Mago da escola de Adivinhação, cada uma das quais não deve ser superior a nível 2, e adicione-as ao seu grimório gratuitamente.\\n\\nAlém disso, sempre que você ganhar acesso a novo nível de espaços de magia nesta classe, poderá adicionar magia de Mago da escola de Adivinhação ao seu grimório gratuitamente. A magia escolhida deve ser de nível para qual você tenha espaços de magia.",
          "isPassive": true
        },
        {
          "name": "Portento",
          "level": 3,
          "description": "Vislumbres do futuro começam a pressionar sua consciência. Sempre que terminar Descanso Longo, role dois d20s e registre resultados. Você pode substituir qualquer Teste D20 feito por você ou por criatura que você possa ver por uma dessas jogadas de previsão. Você deve escolher fazer isso antes da jogada, e só pode substituir jogada dessa forma uma vez por turno.\\n\\nCada teste de previsão pode ser usado apenas uma vez. Ao terminar Descanso Longo, você perde todos os testes de previsão não utilizados.",
          "isPassive": false
        },
        {
          "name": "Adivinhação Especializada",
          "level": 6,
          "description": "Conjurar magias de Adivinhação é tão fácil que consome apenas fração dos seus esforços de conjuração. Ao conjurar magia de Adivinhação usando espaço de magia de nível 2+, você recupera espaço de magia gasto. O espaço recuperado deve ser de nível inferior ao espaço gasto e não pode ser superior a 5.",
          "isPassive": true
        },
        {
          "name": "O Terceiro Olho",
          "level": 10,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Curto ou Longo",
          "description": "Você pode aumentar seus poderes de percepção. Como Ação Bônus, escolha um dos seguintes benefícios, que dura até você iniciar Descanso Curto ou Longo. Você não pode usar esta habilidade novamente até terminar Descanso Curto ou Longo.\\n\\nVisão no Escuro: Você ganha Visão no Escuro com alcance de 36m.\\n\\nMaior compreensão: Você pode ler em qualquer idioma.\\n\\nVer Invisibilidade: Você pode conjurar Ver Invisibilidade sem gastar espaço de magia.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Grande Portento",
          "level": 14,
          "description": "As visões em seus sonhos se intensificam e pintam imagem mais precisa em sua mente do que está por vir. Role três d20s para sua habilidade de Portento em vez de dois.",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Evocador",
      "description": "Seus estudos se concentram em magia que cria poderosos efeitos elementais, como frio intenso, chamas abrasadoras, trovões estrondosos, relâmpagos crepitantes e ácido ardente.",
      "features": [
        {
          "name": "Sábio da Evocação",
          "level": 3,
          "description": "Escolha duas magias de Mago da escola de Evocação, cada uma das quais não deve ser superior a nível 2, e adicione-as ao seu grimório gratuitamente.\\n\\nAlém disso, sempre que você ganhar acesso a novo nível de espaços de magia nesta classe, poderá adicionar magia de Mago da escola de Evocação ao seu grimório gratuitamente. A magia escolhida deve ser de nível para qual você tenha espaços de magia.",
          "isPassive": true
        },
        {
          "name": "Truque Potente",
          "level": 3,
          "description": "Seus truques de dano afetam até mesmo criaturas que evitam impacto do efeito. Quando você conjura truque em criatura e erra jogada de ataque ou alvo obtém sucesso em teste de resistência contra truque, alvo sofre metade do dano do truque (se houver), mas não sofre nenhum efeito adicional do truque.",
          "isPassive": true
        },
        {
          "name": "Esculpir Feitiços",
          "level": 6,
          "description": "Você pode criar bolsões de relativa segurança dentro dos efeitos de suas evocações. Ao conjurar magia de Evocação que afeta outras criaturas visíveis, você pode escolher número delas = 1 + nível da magia. As criaturas escolhidas são automaticamente bem-sucedidas em seus testes de resistência contra magia e não sofrem dano se normalmente sofreriam metade do dano em teste bem-sucedido.",
          "isPassive": true
        },
        {
          "name": "Evocação Empoderada",
          "level": 10,
          "description": "Sempre que você conjura magia de Mago da escola de Evocação, você pode adicionar seu modificador de Inteligência a uma jogada de dano daquela magia.",
          "isPassive": true
        },
        {
          "name": "Overchannel",
          "level": 14,
          "description": "Você pode aumentar poder das suas magias. Ao conjurar magia de Mago com espaço de magia de níveis 1 a 5 que cause dano, você pode causar dano máximo com essa magia no turno em que conjurar.\\n\\nNa primeira vez que fizer isso, você não sofrerá nenhum efeito adverso. Se usar esta habilidade novamente antes de terminar Descanso Longo, você sofrerá 2d12 de dano Necrótico para cada nível do espaço de magia imediatamente após conjurá-la. Este dano ignora Resistência e Imunidade.\\n\\nCada vez que você usar esse recurso novamente antes de terminar Descanso Longo, dano Necrótico por nível de magia aumenta em 1d12.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Ilusionista",
      "description": "Você é especialista em magia que deslumbra os sentidos e engana a mente, e as ilusões que você cria fazem o impossível parecer real.",
      "features": [
        {
          "name": "Sábio da Ilusão",
          "level": 3,
          "description": "Escolha duas magias de Mago da escola de Ilusão, cada uma das quais não deve ser superior a nível 2, e adicione-as ao seu grimório gratuitamente.\\n\\nAlém disso, sempre que você ganhar acesso a novo nível de espaços de magia nesta classe, poderá adicionar magia de Mago da escola de Ilusão ao seu grimório gratuitamente. A magia escolhida deve ser de nível para qual você tenha espaços de magia.",
          "isPassive": true
        },
        {
          "name": "Ilusões Aprimoradas",
          "level": 3,
          "description": "Você pode conjurar magias de Ilusão sem fornecer componentes Verbais e, se magia de Ilusão que você conjurar tiver alcance de 3m ou mais, alcance aumenta em 18m.\\n\\nVocê também conhece truque de Ilusão Menor. Se já o conhece, você aprende truque de Mago diferente à sua escolha. O truque não conta para seu número de truques conhecidos. Você pode criar som e imagem com única conjuração de Ilusão Menor, e pode conjurá-la como Ação Bônus.",
          "isPassive": true
        },
        {
          "name": "Criaturas Fantasmagóricas",
          "level": 6,
          "usage_type": "Fixo",
          "usage_value": 2,
          "usage_recovery": "Descanso Longo",
          "description": "Você sempre tem magias Invocar Besta e Invocar Fada preparadas. Sempre que conjurar qualquer uma delas, você pode mudar sua escola para Ilusão, o que faz com que criatura invocada pareça espectral. Você pode conjurar versão Ilusão de cada magia sem gastar espaço de magia, mas conjurá-la sem espaço reduz pela metade PV da criatura. Depois de conjurar qualquer uma das magias sem espaço de magia, você deve concluir Descanso Longo antes de poder conjurar magia dessa forma novamente.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Eu Ilusório",
          "level": 10,
          "usage_type": "Fixo",
          "usage_value": 1,
          "usage_recovery": "Descanso Curto ou Longo",
          "description": "Quando criatura o atinge com jogada de ataque, você pode usar Reação para interpor duplicata ilusória de si mesmo entre você e atacante. O ataque erra você automaticamente, e então ilusão se dissipa.\\n\\nApós usar esta habilidade, não poderá usá-la novamente até terminar Descanso Curto ou Longo. Você também pode restaurar seu uso gastando espaço de magia de nível 2+.",
          "has_usage_limit": true,
          "isPassive": false
        },
        {
          "name": "Realidade Ilusória",
          "level": 14,
          "description": "Você aprendeu a incorporar magia sombria às suas ilusões para dar-lhes semirrealidade. Ao conjurar magia de Ilusão com espaço de magia, você pode escolher objeto inanimado e não mágico que faça parte da ilusão e torná-lo real. Você pode fazer isso no seu turno como Ação Bônus enquanto magia estiver em andamento. O objeto permanece real por 1 minuto, durante o qual não pode causar dano nem impor quaisquer condições. Por exemplo, você pode criar ilusão de ponte sobre abismo e, em seguida, torná-la real e atravessá-la.",
          "isPassive": false
        }
      ]
    }
  ]'::jsonb,
  'Magos são estudiosos da magia arcana que dominam magias através de estudo intenso e prática disciplinada. Com seus grimórios contendo vasto conhecimento mágico, eles são os conjuradores mais versáteis, capazes de preparar diferentes combinações de magias para cada situação.',
  '',
  '',
  '[
    {
      "name": "Conjuração",
      "level": 1,
      "description": "Como estudante de magia arcana, você aprendeu a conjurar magias.\\n\\nTruques: Você conhece três truques de Mago (Luz, Mão de Mago e Raio de Gelo recomendados). Sempre que terminar Descanso Longo, pode substituir um truque. Nos níveis 4 e 10, aprende outro truque.\\n\\nLivro de Feitiços: Seu aprendizado mágico culminou na criação de livro único: seu livro de feitiços. É objeto minúsculo que pesa 1,3kg, contém 100 páginas e pode ser lido apenas por você ou por alguém que esteja conjurando Identificar. O livro contém magias de nível 1+ que você conhece. Começa com seis magias de Mago de nível 1 (Detectar Magia, Queda de Penas, Armadura de Mago, Míssil Mágico, Sono e Onda Trovejante recomendadas).\\n\\nSempre que você ganhar nível de Mago após 1, adicione duas magias de Mago à sua escolha ao seu grimório. Cada uma dessas magias deve ser de nível para qual você tenha espaços de magia.\\n\\nEspaços de Magia: Recupera todos ao terminar Descanso Longo.\\n\\nMagias Preparadas de Nível 1+: Para isso, escolha quatro magias do seu grimório. As magias escolhidas devem ser de nível para qual você tenha espaços de magia.\\n\\nAlterando Magias: Sempre que terminar Descanso Longo, pode alterar sua lista de magias preparadas, substituindo qualquer uma delas por magias do seu grimório.\\n\\nHabilidade de Conjuração: Inteligência.\\n\\nFoco: Foco Arcano ou seu grimório.\\n\\nExpandindo e substituindo livro de feitiços:\\n\\nCopiando Magia para Livro: Ao encontrar magia de Mago nível 1+, você pode copiá-la para seu grimório, desde que seja de nível que você possa preparar e tenha tempo para copiá-la. Para cada nível da magia, transcrição leva 2 horas e custa 50 GP.\\n\\nCopiando Livro: Você pode copiar magia do seu grimório para outro livro. Você precisa gastar apenas 1 hora e 10 GP para cada nível da magia copiada.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Adepto Ritual",
      "level": 1,
      "description": "Você pode conjurar qualquer magia como Ritual, desde que ela tenha etiqueta Ritual e esteja no seu grimório. Você não precisa ter magia preparada, mas precisa ler livro para conjurar magia dessa forma.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Recuperação Arcana",
      "level": 1,
      "usage_type": "Fixo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Você pode recuperar parte da sua energia mágica estudando seu grimório. Ao terminar Descanso Curto, você pode escolher espaços de magia gastos para recuperar. Os espaços de magia podem ter nível combinado = no máximo, metade do seu nível de Mago (arredondado para cima), e nenhum dos espaços pode ser de nível 6 ou superior. Por exemplo, se você for Mago de nível 4, poderá recuperar até dois níveis de espaços de magia, recuperando espaço de magia de nível 2 ou dois espaços de magia de nível 1.\\n\\nDepois de usar, não poderá fazê-lo novamente até terminar Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Acadêmico",
      "level": 2,
      "description": "Enquanto estudava magia, você também se especializou em outra área de estudo. Escolha uma das seguintes perícias nas quais você tenha proficiência: Arcanismo, História, Investigação, Medicina, Natureza ou Religião. Você possui Perícia na perícia escolhida.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": true,
      "proficiency_skill_count": 1
    },
    {
      "name": "Subclasse de Mago",
      "level": 3,
      "description": "Você ganha uma subclasse de Mago à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis de Mago 8, 12 e 16.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Memorizar Feitiço",
      "level": 5,
      "description": "Sempre que você terminar Descanso Curto, você pode estudar seu livro de magias e substituir uma das magias de Mago de nível 1+ que você preparou para sua habilidade de Conjuração por outra magia de nível 1+ do livro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua Subclasse de Mago.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 10,
      "description": "Você ganha uma característica da sua Subclasse de Mago.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 14,
      "description": "Você ganha uma característica da sua Subclasse de Mago.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Maestria em Magia",
      "level": 18,
      "description": "Você alcançou tal maestria em certas magias que pode conjurá-las à vontade. Escolha magia de nível 1 e uma de nível 2 em seu grimório que tenham tempo de conjuração de uma ação. Você sempre tem essas magias preparadas e pode conjurá-las em seu nível mais baixo sem gastar espaço de magia. Para conjurar qualquer uma das magias em nível mais alto, você precisa gastar espaço de magia.\\n\\nSempre que você terminar Descanso Longo, você pode estudar seu livro de magias e substituir uma dessas magias por magia elegível do mesmo nível do livro.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva de Recordação de Magia é recomendada.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Feitiços de Assinatura",
      "level": 20,
      "usage_type": "Fixo",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Escolha duas magias de nível 3 do seu grimório como suas magias características. Você sempre tem essas magias preparadas e pode conjurar cada uma delas uma vez no nível 3 sem gastar espaço de magia. Ao fazer isso, você não poderá conjurá-las dessa forma novamente até terminar Descanso Curto ou Longo. Para conjurar qualquer uma das magias em nível superior, você precisa gastar espaço de magia.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  true,
  '[
    {"level": 1, "cantrips": 3, "known_spells": 6},
    {"level": 2, "cantrips": 3, "known_spells": 8},
    {"level": 3, "cantrips": 3, "known_spells": 10},
    {"level": 4, "cantrips": 4, "known_spells": 12},
    {"level": 5, "cantrips": 4, "known_spells": 14},
    {"level": 6, "cantrips": 4, "known_spells": 16},
    {"level": 7, "cantrips": 4, "known_spells": 18},
    {"level": 8, "cantrips": 4, "known_spells": 20},
    {"level": 9, "cantrips": 4, "known_spells": 22},
    {"level": 10, "cantrips": 5, "known_spells": 24},
    {"level": 11, "cantrips": 5, "known_spells": 26},
    {"level": 12, "cantrips": 5, "known_spells": 28},
    {"level": 13, "cantrips": 5, "known_spells": 30},
    {"level": 14, "cantrips": 5, "known_spells": 32},
    {"level": 15, "cantrips": 5, "known_spells": 34},
    {"level": 16, "cantrips": 5, "known_spells": 36},
    {"level": 17, "cantrips": 5, "known_spells": 38},
    {"level": 18, "cantrips": 5, "known_spells": 40},
    {"level": 19, "cantrips": 5, "known_spells": 42},
    {"level": 20, "cantrips": 5, "known_spells": 44}
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
    {"name": "Adaga", "cost": "2.0", "weight": "1.0", "category": "Arma", "quantity": 2},
    {"name": "Foco Arcano (Cajado)", "cost": "5.0", "weight": "4.0", "category": "Foco", "quantity": 1},
    {"name": "Robe", "cost": "1.0", "weight": "4.0", "category": "Roupa", "quantity": 1},
    {"name": "Livro de Feitiços", "cost": "50.0", "weight": "3.0", "category": "Equipamento", "quantity": 1},
    {"name": "Pacote do Estudioso", "cost": "40.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  5,
  55,
  '[]'::jsonb
);
