-- ============================================================
-- MAGIAS DE 6º CÍRCULO - PHB 2024 (PARTE 1)
-- ============================================================
-- Total: 40 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (5 magias)
-- ============================================================

-- Contingência
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Contingência',
  6,
  'Abjuração',
  '10 minutos',
  'Próprio',
  'V, S, M (uma estatueta sua incrustada de pedras preciosas que vale mais de 1.500 GP)',
  '10 dias',
  'Escolha uma magia de nível 5 ou inferior que você possa conjurar, que tenha um tempo de conjuração de uma ação e que possa ter você como alvo. Você conjura essa magia — chamada de magia contingente — como parte da conjuração de Contingência, gastando espaços de magia para ambas, mas a magia contingente não entra em vigor. Em vez disso, ela entra em vigor quando um determinado gatilho ocorre.

A magia contingente entra em vigor imediatamente após o gatilho ocorrer pela primeira vez, quer você queira ou não, e então a Contingência termina.

A magia de contingência só tem efeito em você, mesmo que normalmente possa atingir outros. Você só pode usar uma magia de contingência por vez.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- Proibição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "damage_type"
) VALUES (
  'Proibição',
  6,
  'Abjuração',
  '10 minutos',
  'Toque',
  'V, S, M (pó de rubi no valor de mais de 1.000 GP)',
  '1 dia',
  'Você cria uma proteção contra viagens mágicas que protege até 3.700 metros quadrados de espaço a uma altura de 9 metros acima do solo. Durante a duração da proteção, as criaturas não podem se teletransportar para a área nem usar portais para entrar na área. A magia torna a área à prova de viagens planares.

Além disso, a magia causa dano a tipos de criaturas que você escolher ao conjurá-la. Escolha um ou mais: Aberrações, Celestiais, Elementais, Fadas, Demônios e Mortos-vivos. Quando uma criatura de um tipo escolhido entra na área pela primeira vez em um turno ou termina seu turno lá, a criatura sofre 5d10 de dano Radiante ou Necrótico (à sua escolha).

Você pode definir uma senha. Uma criatura que diga a senha não sofre dano.

Se você conjurar Proibição todos os dias durante 30 dias no mesmo local, a magia durará até ser dissipada.',
  'PHB 2024',
  'Clérigo',
  true,
  false,
  'damage',
  'Radiante/Necrótico'
);

-- Globo de Invulnerabilidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Globo de Invulnerabilidade',
  6,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S, M (uma conta de vidro)',
  'Concentração, até 1 minuto',
  'Uma barreira imóvel e brilhante aparece em uma Emanação de 3 metros ao seu redor e permanece enquanto durar.

Qualquer magia de nível 5 ou inferior conjurada de fora da barreira não pode afetar nada dentro dela. Tal magia pode ter como alvo criaturas e objetos dentro da barreira, mas não tem efeito sobre eles. Da mesma forma, a área dentro da barreira é excluída das áreas de efeito criadas por tais magias.

Usando um Espaço de Magia de Nível Superior. A barreira bloqueia magias de 1 nível acima para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  true
);

-- Guardas e Pupilos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Guardas e Pupilos',
  6,
  'Abjuração',
  '1 hora',
  'Toque',
  'V, S, M (uma vara de prata que vale mais de 10 GP)',
  '24 horas',
  'Crie uma proteção que proteja até 230 metros quadrados de área útil. A área protegida pode ter até 6 metros de altura.

Ao conjurar esta magia, você pode especificar indivíduos que não são afetados. Você também pode especificar uma senha que torna quem a conjura imune aos seus efeitos.

A magia cria os efeitos abaixo:

Corredores. A neblina preenche todos os corredores, tornando-os Extremamente Obscuros. Há 50% de chance de criaturas acreditarem estar indo na direção oposta.

Portas. Todas as portas são trancadas magicamente como Trava Arcana. Você pode cobrir até dez portas com ilusões.

Escadas. Teias preenchem todas as escadas como no feitiço Teia.

Outro Efeito Mágico. Coloque Luzes Dançantes, Magic Mouth, Nuvem Fedorenta, Rajada de Vento ou Sugestão.

Se você conjurar a magia todos os dias durante 365 dias, a magia subsequente durará até que todos os seus efeitos sejam dissipados.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  false
);

-- Curar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "upcast_dice_per_level"
) VALUES (
  'Curar',
  6,
  'Abjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Escolha uma criatura que você possa ver dentro do alcance. Energia positiva flui através do alvo, restaurando 70 Pontos de Vida. Esta magia também encerra as condições Cego, Surdo e Envenenado no alvo.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 10 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Clérigo, Druida',
  false,
  false,
  'healing',
  '10'
);

-- ============================================================
-- ADIVINHAÇÃO (2 magias)
-- ============================================================

-- Encontre o Caminho
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Encontre o Caminho',
  6,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V, S, M (um conjunto de ferramentas de adivinhação que valem mais de 100 GP)',
  'Concentração, até 1 dia',
  'Você sente magicamente a rota física mais direta para um local que você nomeia. Você precisa estar familiarizado com o local, e a magia falha se você nomear um destino em outro plano de existência, um destino móvel ou um destino inespecífico.

Enquanto você estiver no mesmo plano de existência do destino, saberá a que distância ele fica e em que direção. Sempre que tiver que escolher entre vários caminhos ao longo do caminho, saberá qual é o mais direto.',
  'PHB 2024',
  'Bardo, Clérigo, Druida',
  false,
  true
);

-- Visão Verdadeira
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Visão Verdadeira',
  6,
  'Adivinhação',
  'Ação',
  'Toque',
  'V, S, M (pó de cogumelo que vale 25+ GP, que a magia consome)',
  '1 hora',
  'Durante a duração, a criatura voluntária que você tocar terá Visão Verdadeira com um alcance de 36 metros.',
  'PHB 2024',
  'Bardo, Clérigo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- CONJURAÇÃO (11 magias)
-- ============================================================

-- Portão Arcano
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Portão Arcano',
  6,
  'Conjuração',
  'Ação',
  '500 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você cria portais de teletransporte interligados. Escolha dois espaços grandes e desocupados no chão que você possa ver, um espaço dentro do alcance e o outro a até 3 metros de você. Um portal circular se abre em cada um desses espaços e permanece ativo durante toda a duração.

Os portais são anéis brilhantes bidimensionais cheios de névoa que bloqueiam a visão. Eles pairam a centímetros do chão e são perpendiculares a ele.

Um portal é aberto apenas de um lado (você escolhe qual). Qualquer coisa que entre pelo lado aberto de um portal sai pelo lado aberto do outro portal, como se os dois fossem adjacentes. Como uma Ação Bônus, você pode mudar a direção dos lados abertos.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Conjurar Fey
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Fey',
  6,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura um espírito Médio da Agrestia das Fadas em um espaço desocupado visível dentro do seu alcance. O espírito permanece ativo enquanto durar a magia e se parece com uma criatura Fada à sua escolha. Quando o espírito aparece, você pode realizar um ataque mágico corpo a corpo contra uma criatura a até 1,5 metro dele. Ao acertar, o alvo sofre dano Psíquico igual a 3d12 mais o seu modificador de habilidade de conjuração, e o alvo permanece na condição Amedrontado até o início do seu próximo turno.

Como uma Ação Bônus em seus turnos posteriores, você pode teletransportar o espírito para um espaço desocupado que você possa ver a até 9 metros e fazer o ataque contra uma criatura a até 1,5 metro dele.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d12 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '3d12',
  true,
  'Psíquico',
  '1d12'
);

-- Invocação Instantânea de Drawmij
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocação Instantânea de Drawmij',
  6,
  'Conjuração',
  '1 minuto',
  'Toque',
  'V, S, M (uma safira que vale mais de 1.000 GP)',
  'Até ser dissipado',
  'Você toca a safira usada na conjuração e um objeto pesando 4,5 kg ou menos, cuja maior dimensão seja de 1,8 m ou menos. A magia deixa uma marca invisível no objeto e inscreve o nome do objeto na safira. Cada vez que você conjurar esta magia, deverá usar uma safira diferente.

Depois disso, você pode realizar uma ação de Magia para dizer o nome do objeto e esmagar a safira. O objeto aparece instantaneamente na sua mão, independentemente da distância física ou planar, e a magia termina.

Se outra criatura estiver segurando ou carregando o objeto, esmagar a safira não a transporta, mas você descobre quem é essa criatura e onde ela está localizada no momento.',
  'PHB 2024',
  'Mago',
  true,
  false
);

-- Festa dos Heróis
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Festa dos Heróis',
  6,
  'Conjuração',
  '10 minutos',
  'Próprio',
  'V, S, M (uma tigela incrustada de pedras preciosas que vale mais de 1.000 GP, que a magia consome)',
  'Instantânea',
  'Você conjura um banquete que aparece em uma superfície em um Cubo de 3 metros desocupado ao seu lado. O banquete leva 1 hora para ser consumido e desaparece ao final desse tempo, e os efeitos benéficos só se manifestam após essa hora. Até doze criaturas podem participar do banquete.

Uma criatura que participa ganha vários benefícios, que duram 24 horas. A criatura tem Resistência a dano de Veneno e Imunidade às condições Amedrontado e Envenenado. Seus Pontos de Vida máximos também aumentam em 2d10, e ela ganha o mesmo número de Pontos de Vida.',
  'PHB 2024',
  'Bardo, Clérigo, Druida',
  false,
  false
);

-- Aliado Planar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aliado Planar',
  6,
  'Conjuração',
  '10 minutos',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você implora a ajuda de uma entidade sobrenatural. O ser deve ser conhecido por você: um deus, um príncipe demônio ou algum outro ser de poder cósmico. Essa entidade envia um Celestial, um Elemental ou um Demônio leal a ela para ajudá-lo, fazendo com que a criatura apareça em um espaço desocupado dentro do alcance.

Você pode pedir que ela realize um serviço em troca de pagamento, mas ela não é obrigada a fazê-lo. O pagamento pode assumir diversas formas. Uma tarefa medida em minutos requer 100 GP por minuto. Uma tarefa medida em horas requer 1.000 GP por hora. E uma tarefa medida em dias (até 10 dias) requer 10.000 GP por dia.

Após a criatura completar a tarefa, ou quando a duração combinada do serviço expirar, a criatura retorna ao seu plano de origem.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- Continua na parte 2...
