-- ============================================================
-- MAGIAS DE 8º CÍRCULO - PHB 2024 (PARTE 1)
-- ============================================================
-- Total: 20 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (3 magias)
-- ============================================================

-- Campo Antimagia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Campo Antimagia',
  8,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S, M (limalha de ferro)',
  'Concentração, até 1 hora',
  'Uma aura de antimagia envolve você em Emanação de 3 metros. Ninguém pode conjurar magias, realizar ações mágicas ou criar outros efeitos mágicos dentro da aura, e essas coisas não podem ter como alvo ou afetar nada dentro dela. As propriedades mágicas de itens mágicos não funcionam dentro da aura ou em nada dentro dela.

Áreas de efeito criadas por magias ou outras magias não podem se estender para dentro da aura, e ninguém pode se teletransportar para dentro ou para fora dela, nem usar viagens planares. Portais fecham temporariamente enquanto estiver na aura.

Feitiços em andamento, exceto aqueles lançados por um Artefato ou uma divindade, são suprimidos na área. Enquanto um efeito estiver suprimido, ele não funciona, mas o tempo que ele permanece suprimido conta para sua duração.

Dissipar Magia não tem efeito na aura, e as auras criadas por diferentes magias de Campo Antimagia não anulam umas às outras.',
  'PHB 2024',
  'Clérigo, Mago',
  false,
  true
);

-- Aura Sagrada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aura Sagrada',
  8,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S, M (um relicário que vale mais de 1.000 GP)',
  'Concentração, até 1 minuto',
  'Durante a duração, você emite uma aura em uma Emanação de 9 metros. Enquanto estiver na aura, criaturas à sua escolha têm Vantagem em todos os testes de resistência, e outras criaturas têm Desvantagem em jogadas de ataque contra elas. Além disso, quando um Demônio ou um Morto-vivo atinge uma criatura afetada com um ataque corpo a corpo, o atacante deve ser bem-sucedido em um teste de resistência de Constituição ou ficará na condição de Cego até o final do seu próximo turno.',
  'PHB 2024',
  'Clérigo',
  false,
  true
);

-- Mente em Branco
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mente em Branco',
  8,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  '24 horas',
  'Até o fim da magia, uma criatura voluntária que você tocar terá Imunidade a dano Psíquico e a condição Encantado. O alvo também não é afetado por nada que possa sentir suas emoções ou alinhamento, ler seus pensamentos ou detectar magicamente sua localização, e nenhuma magia — nem mesmo Desejo — pode coletar informações sobre o alvo, observá-lo remotamente ou controlar sua mente.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (1 magia)
-- ============================================================

-- Telepatia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Telepatia',
  8,
  'Adivinhação',
  'Ação',
  'Ilimitado',
  'V, S, M (um par de anéis de prata interligados)',
  '24 horas',
  'Você cria um vínculo telepático entre você e uma criatura disposta com a qual esteja familiarizado. A criatura pode estar em qualquer lugar no mesmo plano de existência que você. A magia termina se você ou o alvo não estiverem mais no mesmo plano.

Até o fim da magia, você e o alvo podem compartilhar instantaneamente palavras, imagens, sons e outras mensagens sensoriais entre si através do vínculo, e o alvo reconhece você como a criatura com a qual está se comunicando. A magia permite que a criatura entenda o significado das suas palavras e de quaisquer mensagens sensoriais que você enviar a ela.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- ============================================================
-- CONJURAÇÃO (4 magias)
-- ============================================================

-- Semiplano
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Semiplano',
  8,
  'Conjuração',
  'Ação',
  '60 pés',
  'S',
  '1 hora',
  'Você cria uma porta Média sombria em uma superfície plana e sólida, visível dentro do alcance. Essa porta pode ser aberta e fechada e leva a um semiplano, que é uma sala vazia com 9 metros de comprimento em cada dimensão, feita de madeira ou pedra (à sua escolha).

Quando a magia termina, a porta desaparece, e quaisquer objetos dentro do semiplano permanecem lá. Quaisquer criaturas dentro também permanecem, a menos que optem por ser empurradas através da porta conforme ela desaparece, aterrissando com a condição Prona nos espaços desocupados mais próximos do antigo espaço da porta.

Cada vez que você conjurar esta magia, você pode criar um novo semiplano ou conectar a porta sombria a um semiplano que você criou com uma conjuração anterior desta magia. Além disso, se você souber a natureza e o conteúdo de um semiplano criado pela conjuração desta magia por outra criatura, você pode conectar a porta sombria a esse semiplano.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Labirinto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Labirinto',
  8,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você bane uma criatura que você possa ver dentro do alcance para um semiplano labiríntico. O alvo permanece lá enquanto durar o efeito ou até escapar do labirinto.

O alvo pode realizar uma ação de Estudo para tentar escapar. Ao fazê-lo, realiza um teste de Inteligência CD 20 (Investigação). Se for bem-sucedido, escapa e a magia termina.

Quando a magia termina, o alvo reaparece no espaço que deixou ou, se esse espaço estiver ocupado, no espaço desocupado mais próximo.',
  'PHB 2024',
  'Mago',
  false,
  true
);

-- Nuvem Incendiária
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Nuvem Incendiária',
  8,
  'Conjuração',
  'Ação',
  '150 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma nuvem rodopiante de brasas e fumaça preenche uma Esfera de 6 metros de raio centrada em um ponto dentro do alcance. A área da nuvem fica Fortemente Obscura. Ela dura enquanto durar ou até que um vento forte (como o criado por Rajada de Vento) a disperse.

Quando a nuvem aparece, cada criatura nela realiza um teste de resistência de Destreza, sofrendo 10d8 de dano de Fogo em caso de falha ou metade desse dano em caso de sucesso. Uma criatura também deve realizar esse teste quando a Esfera se move para o seu espaço e quando ela entra na Esfera ou termina seu turno ali. Uma criatura realiza esse teste apenas uma vez por turno.

A nuvem se move 3 metros para longe de você na direção que você escolher no início de cada um dos seus turnos.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '10d8',
  'Fogo'
);

-- Tsunami
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Tsunami',
  8,
  'Conjuração',
  '1 minuto',
  '1 milha',
  'V, S',
  'Concentração, até 6 rodadas',
  'Uma muralha de água surge em um ponto escolhido dentro do alcance. Você pode construir uma muralha com até 90 metros de comprimento, 90 metros de altura e 15 metros de espessura. A muralha dura enquanto durar o efeito.

Quando a parede aparece, cada criatura em sua área faz um teste de resistência de Força, sofrendo 6d10 de dano de Concussão em uma falha ou metade do dano em um sucesso.

No início de cada um dos seus turnos após o aparecimento da muralha, ela, juntamente com quaisquer criaturas nela, se move 15 metros para longe de você. Qualquer criatura Enorme ou menor dentro da muralha ou em cujo espaço a muralha entre ao se mover deve ser bem-sucedida em um teste de resistência de Força ou sofrerá 5d10 de dano de Concussão. Uma criatura pode sofrer esse dano apenas uma vez por rodada. No final do turno, a altura da muralha é reduzida em 15 metros, e o dano causado pela muralha nas rodadas seguintes é reduzido em 1d10. Quando a muralha atingir 0 metros de altura, a magia termina.

Uma criatura presa na parede pode se mover nadando. No entanto, devido à força da onda, a criatura precisa ser bem-sucedida em um teste de Força (Atletismo) contra sua CD de resistência à magia para se mover. Se falhar no teste, não poderá se mover. Uma criatura que se mova para fora da parede cai no chão.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '6d10 + 5d10',
  'Concussão'
);

-- Continua na parte 2...
