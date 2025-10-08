-- ============================================================
-- MAGIAS DE 7º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: Encantamento, Evocação, Ilusão, Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- ENCANTAMENTO (1 magia)
-- ============================================================

-- Palavra de Poder Fortificar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Palavra de Poder Fortificar',
  7,
  'Encantamento',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Você fortifica até seis criaturas visíveis dentro do alcance. A magia concede 120 Pontos de Vida Temporários, que você divide entre os destinatários da magia.',
  'PHB 2024',
  'Bardo, Clérigo',
  false,
  false
);

-- ============================================================
-- EVOCAÇÃO (6 magias)
-- ============================================================

-- Bola de Fogo de Explosão Retardada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Bola de Fogo de Explosão Retardada',
  7,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (uma bola de guano de morcego e enxofre)',
  'Concentração, até 1 minuto',
  'Um feixe de luz amarela emana de você e se condensa em um ponto escolhido dentro do alcance como uma esfera brilhante durante a duração da magia. Quando a magia termina, a esfera explode e cada criatura em uma Esfera de 6 metros de raio centrada naquele ponto realiza um teste de resistência de Destreza. Uma criatura sofre dano de Fogo igual ao dano acumulado total em uma falha ou metade do dano em um sucesso.

O dano base da magia é 12d6, e o dano aumenta em 1d6 sempre que seu turno termina e a magia não terminou.

Se uma criatura tocar a conta brilhante antes do fim da magia, ela realiza um teste de resistência de Destreza. Em caso de falha, a magia termina, fazendo com que a conta exploda. Em caso de sucesso, a criatura pode arremessar a conta a até 12 metros de distância. Se a conta arremessada entrar no espaço da criatura ou colidir com um objeto sólido, a magia termina e a conta explode.

Quando a conta explode, objetos inflamáveis na explosão que não estão sendo usados ou carregados começam a queimar.

Usando um Espaço de Magia de Nível Superior. O dano base aumenta em 1d6 para cada nível de espaço de magia acima de 7.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  true,
  'damage',
  '12d6',
  'Fogo',
  '1d6'
);

-- Palavra Divina
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Palavra Divina',
  7,
  'Evocação',
  'Ação Bônus',
  '30 pés',
  'V',
  'Instantânea',
  'Você pronuncia uma palavra imbuída de poder dos Planos Superiores. Cada criatura à sua escolha dentro do alcance realiza um teste de resistência de Carisma. Em caso de falha, um alvo com 50 Pontos de Vida ou menos sofre um efeito baseado em seus Pontos de Vida atuais:

0-20: O alvo morre.
21-30: O alvo fica cego, surdo e atordoado por 1 hora.
31-40: O alvo fica cego e surdo por 10 minutos.
41-50: O alvo fica surdo por 1 minuto.

Independentemente de seus Pontos de Vida, um alvo Celestial, Elemental, Fada ou Demônio que falhar no teste de resistência é forçado a retornar ao seu plano de origem (se ainda não estiver lá) e não pode retornar ao plano atual por 24 horas por qualquer meio que não seja a magia Desejo.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- Tempestade de Fogo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Tempestade de Fogo',
  7,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S',
  'Instantânea',
  'Uma tempestade de fogo surge dentro do alcance. A área da tempestade consiste em até dez Cubos de 3 metros, que você organiza como quiser. Cada Cubo deve ser contíguo a pelo menos um outro Cubo. Cada criatura na área realiza um teste de resistência de Destreza, sofrendo 7d10 de dano de Fogo em caso de falha ou metade desse dano em caso de sucesso.

Objetos inflamáveis na área que não estão sendo usados ou carregados começam a queimar.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro',
  false,
  false,
  'damage',
  '7d10',
  'Fogo'
);

-- Gaiola de Força
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Gaiola de Força',
  7,
  'Evocação',
  'Ação',
  '100 pés',
  'V, S, M (pó de rubi no valor de 1.500+ GP, que a magia consome)',
  'Concentração, até 1 hora',
  'Uma prisão imóvel, invisível e em forma de cubo, composta de força mágica, surge ao redor de uma área à sua escolha dentro do alcance. A prisão pode ser uma gaiola ou uma caixa sólida, conforme você escolher.

Uma prisão em forma de gaiola pode ter até 6 metros de lado e é feita de barras de 1,25 cm de diâmetro espaçadas a 1,25 cm. Uma prisão em forma de caixa pode ter até 3 metros de lado, criando uma barreira sólida que impede a passagem de qualquer matéria e bloqueia qualquer feitiço lançado para dentro ou para fora da área.

Ao conjurar a magia, qualquer criatura que esteja completamente dentro da área da jaula fica presa. Criaturas que estejam apenas parcialmente dentro da área, ou aquelas grandes demais para caber nela, são empurradas para longe do centro da área até que estejam completamente fora dela.

Uma criatura dentro da gaiola não pode sair dela por meios não mágicos. Se a criatura tentar usar teletransporte ou viagem interplanar para sair, ela deve primeiro realizar um teste de resistência de Carisma. Em caso de sucesso, a criatura pode usar essa magia para sair da gaiola. Em caso de falha, a criatura não sai da gaiola e desperdiça a magia ou efeito. A gaiola também se estende para o Plano Etéreo, bloqueando a viagem etérea.

Este feitiço não pode ser dissipado por Dissipar Magia.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  false,
  true
);

-- Espada de Mordenkainen
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod", "damage_type"
) VALUES (
  'Espada de Mordenkainen',
  7,
  'Evocação',
  'Ação',
  '90 pés',
  'V, S, M (uma espada em miniatura que vale mais de 250 GP)',
  'Concentração, até 1 minuto',
  'Você cria uma espada espectral que paira dentro do alcance. Ela dura enquanto durar o efeito.

Quando a espada aparece, você realiza um ataque mágico corpo a corpo contra um alvo a até 1,5 metro da espada. Ao acertar, o alvo recebe dano de Força igual a 4d12 mais o seu modificador de habilidade de conjuração.

Em seus turnos posteriores, você pode realizar uma Ação Bônus para mover a espada até 9 metros para um local que você possa ver e repetir o ataque contra o mesmo alvo ou um diferente.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true,
  'damage',
  '4d12',
  true,
  'Força'
);

-- Spray Prismático
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Spray Prismático',
  7,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S',
  'Instantânea',
  'Oito raios de luz saem de você em um cone de 18 metros. Cada criatura no cone realiza um teste de resistência de Destreza. Para cada alvo, role 1d8 para determinar qual raio de cor o afeta:

1 - Vermelho: 12d6 de dano de Fogo
2 - Laranja: 12d6 de dano de Ácido
3 - Amarelo: 12d6 de dano elétrico
4 - Verde: 12d6 de dano de Veneno
5 - Azul: 12d6 de dano de Gelo
6 - Índigo: Restringido, depois Petrificado
7 - Violeta: Cego, depois teletransportado
8 - Especial: Atingido por dois raios

Cada raio causa metade do dano em caso de sucesso na resistência.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '12d6',
  'Variável'
);

-- ============================================================
-- ILUSÃO (3 magias)
-- ============================================================

-- Miragem Arcana
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Miragem Arcana',
  7,
  'Ilusão',
  '10 minutos',
  'Visão',
  'V, S',
  '10 dias',
  'Você faz com que um terreno em uma área de até 1,6 km² pareça, soe, cheire e até mesmo sinta como se fosse outro tipo de terreno. Campos abertos ou uma estrada podem ser transformados em pântanos, colinas, fendas ou algum outro terreno acidentado ou intransitável. Um lago pode ser transformado em um prado gramado, um precipício em uma encosta suave ou uma ravina rochosa em uma estrada larga e plana.

Da mesma forma, você pode alterar a aparência de estruturas ou adicioná-las onde não houver nenhuma. A magia não disfarça, oculta ou adiciona criaturas.

A ilusão inclui elementos sonoros, visuais, táteis e olfativos, podendo transformar terreno limpo em terreno difícil (ou vice-versa) ou impedir o movimento pela área. Qualquer pedaço do terreno ilusório (como uma pedra ou um graveto) removido da área da magia desaparece imediatamente.

Criaturas com Visão Verdadeira podem ver através da ilusão a verdadeira forma do terreno; no entanto, todos os outros elementos da ilusão permanecem, então, enquanto a criatura estiver ciente da presença da ilusão, ela ainda pode interagir fisicamente com a ilusão.',
  'PHB 2024',
  'Bardo, Druida, Mago',
  false,
  false
);

-- Imagem do Projeto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Imagem do Projeto',
  7,
  'Ilusão',
  'Ação',
  '500 milhas',
  'V, S, M (uma estatueta sua que vale 5+ GP)',
  'Concentração, até 1 dia',
  'Você cria uma cópia ilusória de si mesmo que dura enquanto durar a magia. A cópia pode aparecer em qualquer local dentro do alcance que você já tenha visto, independentemente de obstáculos. A ilusão se parece e soa como você, mas é intangível. Se a ilusão sofrer dano, ela desaparece e a magia termina.

Você pode ver através dos olhos da ilusão e ouvir através de seus ouvidos como se estivesse em seu espaço. Com uma ação de Magia, você pode movê-la até 18 metros e fazê-la gesticular, falar e se comportar da maneira que você escolher. Ela imita seus maneirismos perfeitamente.

A interação física com a imagem revela que ela é ilusória, já que objetos podem atravessá-la. Uma criatura que realiza a ação Estudar para examinar a imagem pode determinar que se trata de uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra sua CD de resistência à magia. Se uma criatura discernir a ilusão pelo que ela é, ela pode ver através da imagem, e qualquer ruído que ela emita soa oco para ela.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true
);

-- Simulacro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Simulacro',
  7,
  'Ilusão',
  '12 horas',
  'Toque',
  'V, S, M (rubi em pó que vale mais de 1.500 GP, que a magia consome)',
  'Até ser dissipado',
  'Você cria um simulacro de uma Besta ou Humanoide que esteja a até 3 metros de você durante toda a conjuração da magia. Você finaliza a conjuração tocando na criatura e em uma pilha de gelo ou neve do mesmo tamanho daquela criatura, e a pilha se transforma no simulacro, que é uma criatura. Ele usa as estatísticas de jogo da criatura original no momento da conjuração, exceto que é um Construto, seu Ponto de Vida máximo é a metade e ela não pode conjurar esta magia.

O simulacro é amigável a você e às criaturas que você designar. Ele obedece aos seus comandos e age no seu turno de combate. O simulacro não pode ganhar níveis e não pode fazer Descansos Curtos ou Longos.

Se o simulacro sofrer dano, a única maneira de restaurar seus Pontos de Vida é repará-lo com um Descanso Longo, durante o qual você gasta componentes que valem 100 GP por Ponto de Vida restaurado. O simulacro deve permanecer a até 1,5 metro de você para o reparo.

O simulacro dura até chegar a 0 Pontos de Vida, momento em que reverte para neve e derrete. Se você conjurar esta magia novamente, qualquer simulacro que você tenha criado com esta magia será destruído instantaneamente.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- Continua na parte 3...
