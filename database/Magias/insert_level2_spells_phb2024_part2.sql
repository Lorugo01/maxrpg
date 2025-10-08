-- ============================================================
-- MAGIAS DE 2º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação das magias de 2º círculo
-- ============================================================

-- ============================================================
-- ENCANTAMENTO (6 magias)
-- ============================================================

-- Emoções Calmas (já implementado no 1º círculo, mas é 2º círculo)
DELETE FROM "public"."spells" WHERE name = 'Emoções Calmas' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Emoções Calmas',
  2,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Cada Humanoide em uma Esfera de 6 metros de raio centrada em um ponto escolhido dentro do alcance deve ser bem-sucedido em um teste de resistência de Carisma ou será afetado por um dos seguintes efeitos (escolha para cada criatura):

A criatura tem imunidade às condições Encantada e Amedrontada até o fim da magia. Se a criatura já estiver Encantada ou Amedrontada, essas condições serão suprimidas durante o período.

A criatura se torna Indiferente em relação a criaturas à sua escolha com as quais ela é Hostil. Essa indiferença termina se o alvo sofrer dano ou testemunhar seus aliados sofrendo dano. Quando a magia termina, a atitude da criatura retorna ao normal.',
  'PHB 2024',
  'Bardo, Clérigo',
  false,
  true
);

-- Encantar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Encantar',
  2,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  '1 minuto',
  'Você tece uma sequência de palavras que distrai, fazendo com que criaturas à sua escolha, visíveis dentro do alcance, realizem um teste de resistência de Sabedoria. Qualquer criatura contra a qual você ou seus companheiros estejam lutando é automaticamente bem-sucedida neste teste. Em caso de falha, o alvo sofre uma penalidade de -10 nos testes de Sabedoria (Percepção) e Percepção Passiva até o fim da magia.',
  'PHB 2024',
  'Bardo, Bruxo',
  false,
  false
);

-- Segurar Pessoa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Segurar Pessoa',
  2,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S, M (um pedaço reto de ferro)',
  'Concentração, até 1 minuto',
  'Escolha um Humanoide que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou ficará paralisado durante toda a duração. Ao final de cada um dos seus turnos, o alvo repete o teste, encerrando a magia sobre si mesmo em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. Você pode escolher um Humanoide adicional para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Sugestão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Sugestão',
  2,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, M (uma gota de mel)',
  'Concentração, até 8 horas',
  'Você sugere uma linha de ação — descrita em no máximo 25 palavras — para uma criatura que você possa ver dentro do alcance e que possa ouvi-lo e entendê-lo. A sugestão deve parecer realizável e não envolver nada que obviamente cause dano ao alvo ou seus aliados. Por exemplo, você pode dizer: "Pegue a chave do cofre do tesouro do culto e me dê a chave". Ou pode dizer: "Parem de lutar, saiam desta biblioteca em paz e não retornem".

O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição Encantado pela duração ou até que você ou seus aliados causem dano ao alvo. O alvo Encantado segue a sugestão da melhor maneira possível. A atividade sugerida pode continuar por toda a duração, mas se a atividade sugerida puder ser concluída em um tempo menor, a magia termina para o alvo ao completá-la.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Zona da Verdade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Zona da Verdade',
  2,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  '10 minutos',
  'Você cria uma zona mágica que protege contra enganos em uma Esfera de 4,5 metros de raio centrada em um ponto dentro do alcance. Até o fim da magia, uma criatura que entra na área da magia pela primeira vez em um turno ou inicia seu turno lá realiza um teste de resistência de Carisma. Em caso de falha, uma criatura não pode mentir deliberadamente enquanto estiver dentro do raio. Você sabe se uma criatura obteve sucesso ou fracasso neste teste.

Uma criatura afetada está ciente da magia e pode evitar responder a perguntas às quais normalmente responderia com uma mentira. Tal criatura pode ser evasiva, mas deve ser sincera.',
  'PHB 2024',
  'Bardo, Clérigo, Paladino',
  false,
  false
);

-- Coroa da Loucura (já implementado no 1º círculo, mas é 2º círculo)
DELETE FROM "public"."spells" WHERE name = 'Coroa da Loucura' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Coroa da Loucura',
  2,
  'Encantamento',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma criatura que você possa ver dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria ou permanecer na condição Encantado durante o período. A criatura obtém sucesso automaticamente se não for Humanoide.

Uma coroa espectral aparece na cabeça do alvo Encantado, e ele deve usar sua ação antes de se mover em cada um de seus turnos para realizar um ataque corpo a corpo contra uma criatura que você escolher mentalmente, além de si mesmo. O alvo pode agir normalmente em seu turno se você não escolher nenhuma criatura ou se nenhuma criatura estiver ao seu alcance. O alvo repete o teste de resistência ao final de cada um de seus turnos, encerrando a magia contra si mesmo em caso de sucesso.

Em seus turnos posteriores, você deve realizar a ação de Magia para manter o controle do alvo, ou a magia termina.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- ============================================================
-- EVOCAÇÃO (8 magias)
-- ============================================================

-- Escuridão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Escuridão',
  2,
  'Evocação',
  'Ação',
  '60 pés',
  'V, M (pele de morcego e um pedaço de carvão)',
  'Concentração, até 10 minutos',
  'Durante a duração, a Escuridão mágica se espalha a partir de um ponto dentro do alcance e preenche uma Esfera de 4,5 metros de raio. A Visão no Escuro não consegue ver através dela, e a luz não mágica não consegue iluminá-la.

Alternativamente, você conjura a magia em um objeto que não esteja sendo usado ou carregado, fazendo com que a Escuridão preencha uma Emanação de 4,5 metros originada daquele objeto. Cobrir o objeto com algo opaco, como uma tigela ou elmo, bloqueia a Escuridão.

Se qualquer área desta magia se sobrepuser a uma área de Luz Brilhante ou Luz Penumbra criada por uma magia de nível 2 ou inferior, essa outra magia será dissipada.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Lâmina de Chamas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Lâmina de Chamas',
  2,
  'Evocação',
  'Ação Bônus',
  'Próprio',
  'V, S, M (uma folha de sumagre)',
  'Concentração, até 10 minutos',
  'Você evoca uma lâmina flamejante na sua mão livre. A lâmina tem tamanho e formato semelhantes aos de uma cimitarra e dura a duração. Se você soltar a lâmina, ela desaparece, mas você pode evocá-la novamente como uma Ação Bônus.

Como uma ação de Magia, você pode realizar um ataque mágico corpo a corpo com a lâmina flamejante. Ao acertar, o alvo recebe dano de Fogo igual a 3d6 mais o seu modificador de habilidade de conjuração.

A lâmina flamejante emite Luz Brilhante em um raio de 3 metros e Luz Fraca por mais 3 metros.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Druida, Feiticeiro',
  false,
  true,
  'damage',
  '3d6',
  true,
  'Fogo',
  '1d6'
);

-- Rajada de Vento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Rajada de Vento',
  2,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S, M (uma semente de leguminosa)',
  'Concentração, até 1 minuto',
  'Uma Linha de vento forte de 18 metros de comprimento e 3 metros de largura sopra de você na direção que você escolher durante o período. Cada criatura na Linha deve ser bem-sucedida em um teste de resistência de Força ou será empurrada 4,5 metros para longe de você na direção que segue a Linha. Uma criatura que termine seu turno na Linha deve fazer o mesmo teste.

Qualquer criatura na Linha deve gastar 2 pés de movimento para cada 1 pé que ela se move ao se aproximar de você.

A rajada dispersa gás ou vapor e apaga velas e chamas semelhantes desprotegidas na área. Ela faz com que chamas protegidas, como as de lanternas, dancem descontroladamente, com 50% de chance de apagá-las.

Como uma Ação Bônus em seus turnos posteriores, você pode mudar a direção em que a Linha explode de você.',
  'PHB 2024',
  'Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  true
);

-- Raio de Luar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Raio de Luar',
  2,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (uma folha de semente da lua)',
  'Concentração, até 1 minuto',
  'Um feixe prateado de luz pálida brilha em um Cilindro de 1,5 metro de raio e 12 metros de altura, centrado em um ponto dentro do alcance. Até o fim da magia, Luz Fraca preenche o Cilindro, e você pode realizar uma ação de Magia em turnos posteriores para mover o Cilindro até 18 metros.

Quando o Cilindro aparece, cada criatura nele realiza um teste de resistência de Constituição. Em caso de falha, a criatura sofre 2d10 de dano Radiante e, se for transformada (como resultado da magia Polimorfia, por exemplo), ela retorna à sua forma original e não pode se transformar até deixar o Cilindro. Em caso de sucesso, a criatura sofre apenas metade do dano. Uma criatura também realiza esse teste quando a área da magia se move para o seu espaço e quando ela entra na área da magia ou termina seu turno lá. Uma criatura realiza esse teste apenas uma vez por turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '2d10',
  'Radiante',
  '1d10'
);

-- Raio Escaldante
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Raio Escaldante',
  2,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você lança três raios flamejantes. Você pode lançá-los em um alvo dentro do alcance ou em vários. Faça um ataque mágico à distância para cada raio. Ao acertar, o alvo sofre 2d6 de dano de Fogo.

Usando um Espaço de Magia de Nível Superior. Você cria um raio adicional para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '2d6',
  'Fogo',
  '1 raio'
);

-- Quebrar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Quebrar',
  2,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S, M (um chip de mica)',
  'Instantânea',
  'Um barulho alto irrompe de um ponto à sua escolha dentro do alcance. Cada criatura em uma Esfera de 3 metros de raio centrada ali realiza um teste de resistência de Constituição, sofrendo 3d8 de dano de Trovão em uma falha ou metade desse dano em um sucesso. Um Construto tem Desvantagem no teste.

Um objeto não mágico que não esteja sendo usado ou carregado também sofre dano se estiver na área da magia.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '3d8',
  'Trovejante',
  '1d8'
);

-- Arma Espiritual
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Arma Espiritual',
  2,
  'Evocação',
  'Ação Bônus',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Você cria uma força espectral flutuante que se assemelha a uma arma à sua escolha e dura enquanto durar o efeito. A força aparece dentro do alcance, em um espaço à sua escolha, e você pode realizar imediatamente um ataque mágico corpo a corpo contra uma criatura a até 1,5 metro da força. Ao acertar, o alvo recebe dano de Força igual a 1d8 mais o seu modificador de habilidade de conjuração.

Como uma Ação Bônus em seus turnos posteriores, você pode mover a força até 6 metros e repetir o ataque contra uma criatura a até 1,5 metro dela.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço acima de 2.',
  'PHB 2024',
  'Clérigo',
  false,
  true,
  'damage',
  '1d8',
  true,
  'Força',
  '1d8'
);

-- Flecha Ácida de Melf
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Flecha Ácida de Melf',
  2,
  'Evocação',
  'Ação',
  '90 pés',
  'V, S, M (folha de ruibarbo em pó)',
  'Instantânea',
  'Uma flecha verde brilhante dispara em direção a um alvo dentro do alcance e explode em um jato de ácido. Faça um ataque mágico à distância contra o alvo. Se acertar, o alvo sofre 4d4 de dano de Ácido e 2d4 de dano de Ácido ao final do próximo turno. Se errar, a flecha atinge o alvo com ácido, causando apenas metade do dano inicial.

Usando um Espaço de Magia de Nível Superior. O dano (inicial e posterior) aumenta em 1d4 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Mago',
  false,
  false,
  'damage',
  '4d4 + 2d4',
  'Ácido',
  '1d4 + 1d4'
);

-- ============================================================
-- ILUSÃO (5 magias)
-- ============================================================

-- Invisibilidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Invisibilidade',
  2,
  'Ilusão',
  'Ação',
  'Toque',
  'V, S, M (um cílio em goma arábica)',
  'Concentração, até 1 hora',
  'Uma criatura que você tocar permanecerá invisível até que a magia termine. A magia termina imediatamente após o alvo fazer uma jogada de ataque, causar dano ou conjurar uma magia.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Imagem Espelhada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Imagem Espelhada',
  2,
  'Ilusão',
  'Ação',
  'Próprio',
  'V, S',
  '1 minuto',
  'Três cópias ilusórias de você aparecem no seu espaço. Até o fim do feitiço, as cópias se movem com você e imitam suas ações, mudando de posição, tornando impossível rastrear qual imagem é real.

Cada vez que uma criatura atingir você com uma jogada de ataque durante a duração da magia, role um d6 para cada uma das suas duplicatas restantes. Se qualquer um dos d6s rolar um 3 ou mais, uma das duplicatas é atingida em vez de você, e a duplicata é destruída. Caso contrário, as duplicatas ignoram todos os outros danos e efeitos. A magia termina quando todas as três duplicatas são destruídas.

Uma criatura não é afetada por esta magia se tiver a condição Cego, Visão às Cegas ou Visão Verdadeira.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Aura Mágica de Nystul
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aura Mágica de Nystul',
  2,
  'Ilusão',
  'Ação',
  'Toque',
  'V, S, M (um pequeno quadrado de seda)',
  '24 horas',
  'Com um toque, você coloca uma ilusão em uma criatura disposta ou em um objeto que não esteja sendo usado ou carregado. Uma criatura ganha o efeito Máscara abaixo, e um objeto ganha o efeito Aura Falsa abaixo. O efeito dura enquanto durar. Se você conjurar a magia no mesmo alvo todos os dias por 30 dias, a ilusão dura até ser dissipada.

Máscara (Criatura). Escolha um tipo de criatura diferente do tipo real do alvo. Magias e outros efeitos mágicos tratam o alvo como se fosse uma criatura do tipo escolhido.

Aura Falsa (Objeto). Você altera a aparência do alvo para magias e efeitos mágicos que detectam auras mágicas, como Detectar Magia. Você pode fazer um objeto não mágico parecer mágico, fazer um item mágico parecer não mágico ou alterar a aura do objeto para que ele pareça pertencer a uma escola de magia de sua escolha.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- Força Fantasmal
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Força Fantasmal',
  2,
  'Ilusão',
  'Ação',
  '60 pés',
  'V, S, M (um pouco de lã)',
  'Concentração, até 1 minuto',
  'Você tenta criar uma ilusão na mente de uma criatura que você possa ver dentro do alcance. O alvo realiza um teste de resistência de Inteligência. Em caso de falha, você cria um objeto, criatura ou outro fenômeno fantasmagórico que não seja maior que um Cubo de 3 metros e que seja perceptível apenas para o alvo durante a duração. O fantasma inclui som, temperatura e outros estímulos.

O alvo pode realizar uma ação de Estudo para examinar o fantasma com um teste de Inteligência (Investigação) contra sua CD de resistência à magia. Se o teste for bem-sucedido, o alvo percebe que o fantasma é uma ilusão e a magia termina.

Enquanto afetado pela magia, o alvo trata o fantasma como se fosse real e racionaliza quaisquer resultados ilógicos da interação com ele. Por exemplo, se o alvo atravessar uma ponte fantasmagórica e sobreviver à queda, ele acredita que a ponte existe e que algo mais a causou.

Um alvo afetado pode até sofrer dano da ilusão se o fantasma representar uma criatura ou perigo perigoso. Em cada um dos seus turnos, tal fantasma pode causar 2d8 de dano Psíquico ao alvo se ele estiver na área do fantasma ou a até 1,5 metro dele. O alvo percebe o dano como um tipo apropriado para a ilusão.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '2d8',
  'Psíquico'
);

-- Silêncio
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Silêncio',
  2,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Durante a duração, nenhum som pode ser criado ou atravessar uma Esfera de 6 metros de raio centrada em um ponto à sua escolha dentro do alcance. Qualquer criatura ou objeto inteiramente dentro da Esfera tem Imunidade a Dano de Trovão, e criaturas têm a condição Surdo enquanto estiverem inteiramente dentro dela. Conjurar uma magia que inclua um componente Verbal é impossível lá.',
  'PHB 2024',
  'Bardo, Clérigo, Patrulheiro',
  true,
  true
);

-- Continua...
