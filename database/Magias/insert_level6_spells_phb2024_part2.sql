-- ============================================================
-- MAGIAS DE 6º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: Conjuração, Encantamento, Evocação, Ilusão
-- ============================================================

-- ============================================================
-- CONJURAÇÃO (continuação - 6 magias)
-- ============================================================

-- Invocar Demônio
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Demônio',
  6,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um frasco sangrento que vale mais de 600 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito demoníaco. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Demoníaco. Ao conjurar a magia, escolha Demônio, Diabo ou Yugoloth. A criatura se assemelha a um Demônio do tipo escolhido, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true
);

-- O Caldeirão Borbulhante de Tasha
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'O Caldeirão Borbulhante de Tasha',
  6,
  'Conjuração',
  'Ação',
  '5 pés',
  'V, S, M (uma concha dourada que vale 500 + GP)',
  '10 minutos',
  'Você conjura um caldeirão com pés em forma de garra, cheio de um líquido borbulhante. O caldeirão aparece em um espaço desocupado no chão a até 1,5 metro de você e dura enquanto durar a magia. O caldeirão não pode ser movido e desaparece quando a magia termina, junto com o líquido borbulhante dentro dele.

O líquido no caldeirão duplica as propriedades de uma poção Comum ou Incomum à sua escolha (como uma Poção de Cura). Com uma Ação Bônus, você ou um aliado pode alcançar o caldeirão e retirar uma poção daquele tipo. O caldeirão pode produzir um número dessas poções igual ao seu modificador de habilidade de conjuração (mínimo 1). Quando a última dessas poções for retirada do caldeirão, o caldeirão desaparece e a magia termina.

Poções obtidas do caldeirão que não são consumidas desaparecem quando você conjura este feitiço novamente.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  false
);

-- Transporte via Plantas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Transporte via Plantas',
  6,
  'Conjuração',
  'Ação',
  '10 pés',
  'V, S',
  '10 minutos',
  'Esta magia cria um elo mágico entre uma planta inanimada Grande ou maior dentro do alcance e outra planta, a qualquer distância, no mesmo plano de existência. Você deve ter visto ou tocado a planta de destino pelo menos uma vez. Durante a duração, qualquer criatura pode entrar na planta alvo e sair dela usando 1,5 metro de movimento.',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- Palavra de Recordação
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Palavra de Recordação',
  6,
  'Conjuração',
  'Ação',
  '5 pés',
  'V',
  'Instantânea',
  'Você e até cinco criaturas dispostas a um raio de 1,5 metro de distância se teletransportam instantaneamente para um santuário previamente designado. Você e quaisquer criaturas que se teletransportarem com você aparecem no espaço desocupado mais próximo do local que você designou ao preparar seu santuário. Se você conjurar esta magia sem primeiro preparar um santuário, ela não terá efeito.

Você deve designar um local, como um templo, como um santuário, lançando este feitiço lá.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- Muro de Espinhos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Muro de Espinhos',
  6,
  'Conjuração',
  'Ação',
  '120 pés',
  'V, S, M (um punhado de espinhos)',
  'Concentração, até 10 minutos',
  'Você cria uma parede de arbustos emaranhados, eriçados de espinhos afiados como agulhas. A parede aparece dentro do alcance em uma superfície sólida e dura enquanto durar o efeito. Você escolhe fazer a parede com até 18 metros de comprimento, 3 metros de altura e 1,5 metro de espessura, ou um círculo com 6 metros de diâmetro, 6 metros de altura e 1,5 metro de espessura. A parede bloqueia a linha de visão.

Quando a parede aparece, cada criatura em sua área faz um teste de resistência de Destreza, sofrendo 7d8 de dano Perfurante em uma falha ou metade do dano em um sucesso.

Uma criatura pode atravessar a parede, ainda que lenta e dolorosamente. Para cada 30 centímetros que uma criatura atravessa a parede, ela precisa gastar 1,2 metro de movimento. Além disso, na primeira vez que uma criatura entra em um espaço na parede em um turno ou termina seu turno ali, ela faz um teste de resistência de Destreza, sofrendo 7d8 de dano Cortante em uma falha ou metade desse dano em um sucesso.

Usando um Espaço de Magia de Nível Superior. Ambos os tipos de dano aumentam em 1d8 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '7d8',
  'Perfurante/Cortante',
  '1d8'
);

-- ============================================================
-- ENCANTAMENTO (2 magias)
-- ============================================================

-- Sugestão em Massa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Sugestão em Massa',
  6,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, M (língua de cobra)',
  '24 horas',
  'Você sugere uma atividade — descrita em no máximo 25 palavras — para doze ou menos criaturas que você possa ver dentro do alcance e que possam ouvir e entender você. A sugestão deve parecer realizável e não envolver nada que obviamente cause dano a qualquer um dos alvos ou seus aliados.

Cada alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição Encantado pela duração ou até que você ou seus aliados causem dano ao alvo. Cada alvo Encantado segue a sugestão da melhor maneira possível. A atividade sugerida pode continuar por toda a duração, mas se a atividade sugerida puder ser concluída em um tempo menor, a magia termina para o alvo ao completá-la.

Usando um Espaço de Magia de Nível Superior. A duração é maior com um espaço de magia de nível 7 (10 dias), 8 (30 dias) ou 9 (366 dias).',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false
);

-- A Dança Irresistível de Otto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'A Dança Irresistível de Otto',
  6,
  'Encantamento',
  'Ação',
  '30 pés',
  'V',
  'Concentração, até 1 minuto',
  'Uma criatura que você possa ver dentro do alcance deve realizar um teste de resistência de Sabedoria. Em caso de sucesso, o alvo dança comicamente até o final do seu próximo turno, durante o qual deve gastar todo o seu movimento para dançar no mesmo lugar.

Em caso de falha na defesa, o alvo permanece na condição Encantado pela duração. Enquanto Encantado, o alvo dança comicamente, precisa usar todo o seu movimento para dançar no lugar e tem Desvantagem em testes de resistência de Destreza e jogadas de ataque, e outras criaturas têm Vantagem em jogadas de ataque contra ele. Em cada um dos seus turnos, o alvo pode realizar uma ação para se recompor e repetir a defesa, encerrando a magia em si mesmo em caso de sucesso.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true
);

-- ============================================================
-- EVOCAÇÃO (8 magias)
-- ============================================================

-- Barreira de Lâmina
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Barreira de Lâmina',
  6,
  'Evocação',
  'Ação',
  '90 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você cria uma muralha de lâminas giratórias feitas de energia mágica. A muralha aparece dentro do alcance e dura enquanto durar o efeito. Você cria uma muralha reta de até 30 metros de comprimento, 6 metros de altura e 1,5 metro de espessura, ou uma muralha circular de até 18 metros de diâmetro, 6 metros de altura e 1,5 metro de espessura. A muralha fornece Cobertura de Três Quartos e seu espaço é Terreno Difícil.

Qualquer criatura no espaço da muralha faz um teste de resistência de Destreza, sofrendo 6d10 de dano de Força em caso de falha ou metade desse dano em caso de sucesso. Uma criatura também faz esse teste se entrar no espaço da muralha ou terminar seu turno ali. Uma criatura faz esse teste apenas uma vez por turno.',
  'PHB 2024',
  'Clérigo',
  false,
  true,
  'damage',
  '6d10',
  'Força'
);

-- Relâmpagos em Cadeia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Relâmpagos em Cadeia',
  6,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (três pinos prateados)',
  'Instantânea',
  'Você lança um raio em direção a um alvo visível dentro do alcance. Três raios saltam desse alvo para até três outros alvos à sua escolha, cada um dos quais deve estar a até 9 metros do primeiro alvo. Um alvo pode ser uma criatura ou um objeto e pode ser alvo de apenas um dos raios.

Cada alvo faz um teste de resistência de Destreza, sofrendo 10d8 de dano de Raio em uma falha ou metade desse dano em uma sucesso.

Usando um Espaço de Magia de Nível Superior. Um raio adicional salta do primeiro alvo para outro alvo para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '10d8',
  'Relâmpago',
  '1 raio'
);

-- Esfera Congelante de Otiluke
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Esfera Congelante de Otiluke',
  6,
  'Evocação',
  'Ação',
  '300 pés',
  'V, S, M (uma esfera de cristal em miniatura)',
  'Instantânea',
  'Um globo gélido voa de você até um ponto à sua escolha dentro do alcance, onde explode em uma Esfera de 18 metros de raio. Cada criatura naquela área realiza um teste de resistência de Constituição, sofrendo 10d6 de dano de Gelo em caso de falha ou metade desse dano em caso de sucesso.

Se o globo atingir um corpo d''água, ele congela a água a uma profundidade de 15 cm em uma área de 9 metros quadrados. Esse gelo dura 1 minuto. Criaturas que estavam nadando na superfície da água congelada ficam presas no gelo e têm a condição de Contido.

Você pode abster-se de disparar o globo após completar a conjuração. Se o fizer, um globo do tamanho de uma bala de funda aparece em sua mão. Você ou outra criatura pode arremessá-lo (alcance 12 metros) ou com funda. Após 1 minuto, se não se estilhaçar, ele explode.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '10d6',
  'Frio',
  '1d6'
);

-- Raio de Sol
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Raio de Sol',
  6,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S, M (uma lupa)',
  'Concentração, até 1 minuto',
  'Você lança um raio de sol em uma Linha de 1,5 metro de largura por 18 metros de comprimento. Cada criatura na Linha realiza um teste de resistência de Constituição. Em caso de falha, a criatura sofre 6d8 de dano Radiante e permanece na condição Cega até o início do seu próximo turno. Em caso de sucesso, ela sofre apenas metade do dano.

Até que o feitiço termine, você pode realizar uma ação de Magia para criar uma nova Linha de radiância.

Enquanto isso, um ponto de luz brilhante brilha acima de você. Ele emite Luz Brilhante em um raio de 9 metros e Luz Fraca por mais 9 metros. Essa luz é a luz do sol.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '6d8',
  'Radiante'
);

-- Muro de Gelo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Muro de Gelo',
  6,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (um pedaço de quartzo)',
  'Concentração, até 10 minutos',
  'Você cria uma parede de gelo sobre uma superfície sólida dentro do alcance. Você pode moldá-la em uma cúpula hemisférica ou em um globo com raio de até 3 metros, ou pode moldar uma superfície plana composta por dez painéis de 3 metros quadrados. Cada painel deve ser contíguo a outro painel. Em qualquer forma, a parede tem 30 centímetros de espessura.

Se a parede cortar o espaço de uma criatura quando ela aparecer, a criatura será empurrada para um lado da parede e fará um teste de resistência de Destreza, sofrendo 10d6 de dano de Frio em uma falha ou metade desse dano em uma falha.

A parede é um objeto que pode ser danificado. Ela tem CA 12 e 30 Pontos de Vida por seção de 3 metros, além de imunidade a danos de Frio, Veneno e Psíquico, além de vulnerabilidade a dano de Fogo. Reduzir uma seção a 0 Pontos de Vida a destrói e deixa uma camada de ar gélido.

Uma criatura que se move através do ar gelado pela primeira vez em um turno faz um teste de resistência de Constituição, sofrendo 5d6 de dano de Frio em uma falha ou metade do dano em uma sucesso.

Usando um Espaço de Magia de Nível Superior. O dano ao aparecer aumenta em 2d6 e o dano do ar gélido aumenta em 1d6 para cada nível acima de 6.',
  'PHB 2024',
  'Mago',
  false,
  true,
  'damage',
  '10d6 + 5d6',
  'Frio',
  '2d6 + 1d6'
);

-- ============================================================
-- ILUSÃO (1 magia)
-- ============================================================

-- Ilusão Programada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ilusão Programada',
  6,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S, M (pó de jade que vale mais de 25 GP)',
  'Até ser dissipado',
  'Você cria uma ilusão de um objeto, criatura ou outro fenômeno visível dentro do alcance que é ativado quando um gatilho específico ocorre. A ilusão é imperceptível até então. Ela não deve ser maior que um cubo de 9 metros, e você decide, ao conjurar a magia, como a ilusão se comporta e quais sons ela emite. Essa performance com script pode durar até 5 minutos.

Quando o gatilho que você especificou ocorre, a ilusão surge e se comporta da maneira que você descreveu. Assim que a ilusão termina de se comportar, ela desaparece e permanece adormecida por 10 minutos, após os quais pode ser ativada novamente.

O gatilho pode ser tão geral ou detalhado quanto você desejar, mas deve ser baseado em fenômenos visuais ou sonoros que ocorram a até 9 metros da área.

A interação física com a imagem revela que ela é ilusória. Uma criatura que realiza a ação Estudar pode determinar que se trata de uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra sua CD de resistência à magia.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  false
);

-- Continua na parte 3...
