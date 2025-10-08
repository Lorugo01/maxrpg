-- ============================================================
-- MAGIAS DE 1º CÍRCULO - PHB 2024
-- ============================================================
-- Total: 60+ magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (8 magias)
-- ============================================================

-- Alarme
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Alarme',
  1,
  'Abjuração',
  '1 minuto',
  '30 pés',
  'V, S, M (um sino e um fio de prata)',
  '8 horas',
  'Você define um alarme contra intrusão. Escolha uma porta, uma janela ou uma área dentro do alcance que não seja maior que um Cubo de 6 metros. Até o fim da magia, um alarme o alerta sempre que uma criatura tocar ou entrar na área protegida. Ao conjurar a magia, você pode designar criaturas que não dispararão o alarme. Você também escolhe se o alarme será audível ou mental:

Alarme sonoro. O alarme emite o som de uma campainha por 10 segundos a uma distância de até 18 metros da área protegida.

Alarme Mental. Você é alertado por um sinal mental se estiver a menos de 1,6 km da área protegida. Este sinal o desperta se você estiver dormindo.',
  'PHB 2024',
  'Artífice, Patrulheiro, Mago',
  true,
  false
);

-- Curar Feridas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Curar Feridas',
  1,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Uma criatura que você tocar recupera um número de Pontos de Vida igual a 2d8 mais seu modificador de habilidade de conjuração.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 2d8 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Paladino, Patrulheiro',
  false,
  false,
  'healing',
  '2d8',
  true,
  '2d8'
);

-- Palavra de Cura
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Palavra de Cura',
  1,
  'Abjuração',
  'Ação Bônus',
  '60 pés',
  'V',
  'Instantânea',
  'Uma criatura de sua escolha que você possa ver dentro do alcance recupera Pontos de Vida iguais a 2d4 mais seu modificador de habilidade de conjuração.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 2d4 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Clérigo, Druida',
  false,
  false,
  'healing',
  '2d4',
  true,
  '2d4'
);

-- Proteção contra o Mal e o Bem
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Proteção contra o Mal e o Bem',
  1,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (um frasco de Água Benta que vale 25+ GP, que a magia consome)',
  'Concentração, até 10 minutos',
  'Até o fim da magia, uma criatura voluntária que você tocar estará protegida contra criaturas que sejam Aberrações, Celestiais, Elementais, Fadas, Demônios ou Mortos-vivos. A proteção concede vários benefícios. Criaturas desses tipos têm Desvantagem em jogadas de ataque contra o alvo. O alvo também não pode ser possuído por eles ou ganhar as condições Encantado ou Amedrontado por eles. Se o alvo já estiver possuído, Encantado ou Amedrontado por tal criatura, ele terá Vantagem em qualquer novo teste de resistência contra o efeito relevante.',
  'PHB 2024',
  'Clérigo, Druida, Paladino, Bruxo, Mago',
  false,
  true
);

-- Santuário
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Santuário',
  1,
  'Abjuração',
  'Ação Bônus',
  '30 pés',
  'V, S, M (um caco de vidro de um espelho)',
  '1 minuto',
  'Você protege uma criatura dentro do alcance. Até o fim da magia, qualquer criatura que tenha como alvo a criatura protegida com uma jogada de ataque ou uma magia de dano deve ser bem-sucedida em um teste de resistência de Sabedoria ou escolher um novo alvo ou perder o ataque ou a magia. Esta magia não protege a criatura protegida de áreas de efeito.

A magia termina se a criatura protegida fizer uma jogada de ataque, conjurar uma magia ou causar dano.',
  'PHB 2024',
  'Artífice, Clérigo',
  false,
  false
);

-- Escudo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Escudo',
  1,
  'Abjuração',
  'Reação',
  'Próprio',
  'V, S',
  '1 rodada',
  'Uma barreira imperceptível de força mágica protege você. Até o início do seu próximo turno, você tem um bônus de +5 na CA, incluindo contra o ataque desencadeador, e não sofre dano de Míssil Mágico.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false
);

-- Escudo da Fé
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Escudo da Fé',
  1,
  'Abjuração',
  'Ação Bônus',
  '60 pés',
  'V, S, M (um pergaminho de oração)',
  'Concentração, até 10 minutos',
  'Um campo brilhante envolve uma criatura de sua escolha dentro do alcance, concedendo a ela um bônus de +2 na CA durante a duração.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Armadura de Mago
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Armadura de Mago',
  1,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (um pedaço de couro curado)',
  '8 horas',
  'Você toca uma criatura disposta que não esteja usando armadura. Até que a magia termine, a CA base do alvo se torna 13 mais seu modificador de Destreza. A magia termina mais cedo se o alvo vestir armadura.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (6 magias)
-- ============================================================

-- Compreender Idiomas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Compreender Idiomas',
  1,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (uma pitada de fuligem e sal)',
  '1 hora',
  'Durante a duração, você entende o significado literal de qualquer idioma que ouvir ou ver em sinais. Você também entende qualquer idioma escrito que vir, mas precisa tocar a superfície onde as palavras estão escritas. Leva cerca de 1 minuto para ler uma página de texto. Este feitiço não decodifica símbolos ou mensagens secretas.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  true,
  false
);

-- Detectar o Mal e o Bem
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Detectar o Mal e o Bem',
  1,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Durante a duração, você sente a localização de qualquer Aberração, Celestial, Elemental, Feérico, Demônio ou Morto-vivo a até 9 metros de você. Você também sente se o feitiço Consagração está ativo ali e, em caso afirmativo, onde.

O feitiço é bloqueado por 30 cm de pedra, terra ou madeira; 2,5 cm de metal; ou uma fina folha de chumbo.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Detectar Magia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Detectar Magia',
  1,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Durante a duração, você sente a presença de efeitos mágicos a até 9 metros de você. Se sentir tais efeitos, você pode realizar a ação de Magia para ver uma aura tênue ao redor de qualquer criatura ou objeto visível na área que contenha a magia e, se um efeito foi criado por uma magia, você aprende a escola de magia da magia.

O feitiço é bloqueado por 30 cm de pedra, terra ou madeira; 2,5 cm de metal; ou uma fina folha de chumbo.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Paladino, Patrulheiro, Feiticeiro, Bruxo, Mago',
  true,
  true
);

-- Detectar Venenos e Doenças
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Detectar Venenos e Doenças',
  1,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V, S, M (uma folha de teixo)',
  'Concentração, até 10 minutos',
  'Durante a duração, você sente a localização de venenos, criaturas venenosas ou peçonhentas e contágios mágicos a até 9 metros de você. Você sente o tipo de veneno, criatura ou contágio em cada caso.

O feitiço é bloqueado por 30 cm de pedra, terra ou madeira; 2,5 cm de metal; ou uma fina folha de chumbo.',
  'PHB 2024',
  'Clérigo, Druida, Paladino, Patrulheiro',
  true,
  true
);

-- Identify
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Identify',
  1,
  'Adivinhação',
  '1 minuto',
  'Toque',
  'V, S, M (uma pérola que vale 100+ GP)',
  'Instantânea',
  'Você toca um objeto durante toda a conjuração da magia. Se o objeto for um item mágico ou algum outro objeto mágico, você aprende suas propriedades e como usá-las, se requer Sintonização e quantas cargas possui, se houver. Você aprende se alguma magia em andamento está afetando o item e quais são. Se o item foi criado por uma magia, você aprende o nome dessa magia.

Se você tocar uma criatura durante toda a conjuração, você aprende quais magias em andamento, se houver, estão afetando-a atualmente.',
  'PHB 2024',
  'Artífice, Bardo, Mago',
  true,
  false
);

-- Falar com os Animais
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Falar com os Animais',
  1,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S',
  '10 minutos',
  'Durante esse período, você pode compreender e se comunicar verbalmente com Feras, e pode usar qualquer uma das opções de habilidade da ação Influência com elas.

A maioria das Feras tem pouco a dizer sobre assuntos que não sejam relacionados à sobrevivência ou companheirismo, mas, no mínimo, uma Fera pode lhe dar informações sobre locais e monstros próximos, incluindo tudo o que ela percebeu no dia anterior.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro, Bruxo',
  true,
  false
);

-- ============================================================
-- CONJURAÇÃO (10 magias)
-- ============================================================

-- Emaranhado
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Emaranhado',
  1,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Plantas ágeis brotam do solo em um quadrado de 6 metros dentro do alcance. Enquanto durar, essas plantas transformam o solo da área em Terreno Difícil. Elas desaparecem quando a magia termina.

Cada criatura (exceto você) na área quando você conjurar a magia deve ser bem-sucedida em um teste de resistência de Força ou permanecerá na condição de Reprimido até o fim da magia. Uma criatura Reprimida pode realizar uma ação para realizar um teste de Força (Atletismo) contra sua CD de resistência à magia. Em caso de sucesso, ela se liberta das plantas ágeis e não é mais Reprimida por elas.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true
);

-- Encontrar Familiar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Encontrar Familiar',
  1,
  'Conjuração',
  '1 hora',
  '10 pés',
  'V, S, M (queima de incenso no valor de 10+ GP, que a magia consome)',
  'Instantânea',
  'Você ganha o serviço de um familiar, um espírito que assume a forma animal de sua escolha: Morcego, Gato, Sapo, Falcão, Lagarto, Polvo, Coruja, Rato, Corvo, Aranha, Doninha ou outra Besta com Nível de Desafio 0. Aparecendo em um espaço desocupado dentro do alcance, o familiar possui as estatísticas da forma escolhida, embora seja um Celestial, uma Fada ou um Demônio (à sua escolha) em vez de uma Besta. Seu familiar age independentemente de você, mas obedece aos seus comandos.

Conexão Telepática. Enquanto seu familiar estiver a até 30 metros de você, você pode se comunicar com ele telepaticamente. Além disso, como uma Ação Bônus, você pode ver através dos olhos do familiar e ouvir o que ele ouve até o início do seu próximo turno, ganhando os benefícios de quaisquer sentidos especiais que ele possua.

Por fim, quando você conjura uma magia com alcance de toque, seu familiar pode realizar o toque. Seu familiar deve estar a até 30 metros de você e precisa de uma Reação para realizar o toque quando você conjura a magia.

Combate. O familiar é um aliado seu e de seus aliados. Ele rola sua própria Iniciativa e age em seu próprio turno. Um familiar não pode atacar, mas pode realizar outras ações normalmente.

Desaparecimento do Familiar. Quando o familiar cai para 0 Pontos de Vida, ele desaparece. Ele reaparece após você conjurar esta magia novamente. Com uma ação de Magia, você pode dispensar temporariamente o familiar para uma dimensão de bolso. Alternativamente, você pode dispensá-lo para sempre. Com uma ação de Magia, enquanto ele estiver temporariamente dispensado, você pode fazê-lo reaparecer em um espaço desocupado a até 9 metros de você. Sempre que o familiar cai para 0 Pontos de Vida ou desaparece para a dimensão de bolso, ele deixa para trás em seu espaço tudo o que estava vestindo ou carregando.

Apenas um familiar. Você não pode ter mais de um familiar por vez. Se você conjurar esta magia enquanto tiver um familiar, você fará com que ele adote uma nova forma elegível.',
  'PHB 2024',
  'Mago',
  true,
  false
);

-- Nuvem de Neblina
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Nuvem de Neblina',
  1,
  'Conjuração',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 1 hora',
  'Você cria uma Esfera de neblina com 6 metros de raio, centrada em um ponto dentro do alcance. A Esfera fica Fortemente Obscura. Ela dura enquanto durar o efeito ou até que um vento forte (como o criado por Rajada de Vento) a disperse.

Usando um Espaço de Magia de Nível Superior. O raio da névoa aumenta em 6 metros para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  true,
  '6 metros'
);

-- Goodberry
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Goodberry',
  1,
  'Conjuração',
  'Ação',
  'Toque',
  'V, S, M (um raminho de visco)',
  '24 horas',
  'Dez frutas aparecem na sua mão e são imbuídas de magia enquanto durarem. Uma criatura pode realizar uma Ação Bônus para comer uma fruta. Comer uma fruta restaura 1 Ponto de Vida, e a fruta fornece nutrição suficiente para sustentar a criatura por um dia.

As frutas não consumidas desaparecem quando o feitiço termina.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  false
);

-- Graxa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Graxa',
  1,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (um pouco de torresmo ou manteiga)',
  '1 minuto',
  'Graxa não inflamável cobre o chão em um quadrado de 3 metros centralizado em um ponto dentro do alcance e o transforma em Terreno Difícil durante a duração.

Quando a graxa aparece, cada criatura em sua área deve ser bem-sucedida em um teste de resistência de Destreza ou ficar Prostrada. Uma criatura que entra na área ou termina seu turno lá também deve ser bem-sucedida nesse teste ou ficará Prostrada.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false
);

-- Faca de Gelo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Faca de Gelo',
  1,
  'Conjuração',
  'Ação',
  '60 pés',
  'S, M (uma gota de água ou um pedaço de gelo)',
  'Instantânea',
  'Você cria um fragmento de gelo e o arremessa contra uma criatura dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 1d10 de dano Perfurante. Acertando ou errando, o fragmento explode. O alvo e cada criatura a até 1,5 metro dele devem ser bem-sucedidos em um teste de resistência de Destreza ou sofrerão 2d6 de dano de Frio.

Usando um Espaço de Magia de Nível Superior. O dano de Frio aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '1d10 + 2d6',
  'Frio',
  '1d6'
);

-- Servo Invisível
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Servo Invisível',
  1,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (um pedaço de barbante e de madeira)',
  '1 hora',
  'Esta magia cria uma força invisível, sem mente, sem forma e de tamanho médio, que realiza tarefas simples sob seu comando até o fim da magia. O servo surge em um espaço desocupado no chão, dentro do alcance. Ele tem CA 10, 1 Ponto de Vida e Força 2, e não pode atacar. Se cair para 0 Pontos de Vida, a magia termina.

Uma vez em cada um dos seus turnos, como uma Ação Bônus, você pode comandar mentalmente o servo a se mover até 4,5 metros e interagir com um objeto. O servo pode realizar tarefas simples que um humano faria, como buscar coisas, limpar, consertar, dobrar roupas, acender fogueiras, servir comida e servir bebidas. Após dar o comando, o servo executa a tarefa da melhor maneira possível até concluí-la e, então, aguarda seu próximo comando.

Se você ordenar que o servo execute uma tarefa que o mova a mais de 18 metros de distância de você, o feitiço termina.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  true,
  false
);

-- Disco Flutuante de Tenser
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Disco Flutuante de Tenser',
  1,
  'Conjuração',
  'Ação',
  '30 pés',
  'V, S, M (uma gota de mercúrio)',
  '1 hora',
  'Este feitiço cria um plano de força circular e horizontal, com 90 cm de diâmetro e 2,5 cm de espessura, que flutua 90 cm acima do solo em um espaço desocupado à sua escolha, visível ao seu alcance. O disco permanece ativo durante toda a duração do feitiço e pode suportar até 227 kg. Se mais peso for aplicado a ele, o feitiço termina e tudo o que estiver no disco cai no chão.

O disco permanece imóvel enquanto você estiver a menos de 6 metros dele. Se você se afastar mais de 6 metros, o disco o seguirá, permanecendo a menos de 6 metros de distância. Ele pode se mover por terrenos irregulares, subir ou descer escadas, ladeiras e similares, mas não pode atravessar uma mudança de elevação de 3 metros ou mais. Por exemplo, o disco não pode se mover por um poço de 3 metros de profundidade, nem poderia sair de tal poço se tivesse sido criado no fundo.

Se você se mover mais de 30 metros do disco (normalmente porque ele não consegue contornar um obstáculo para segui-lo), o feitiço termina.',
  'PHB 2024',
  'Mago',
  true,
  false
);

-- Continua no próximo arquivo (Parte 2)...
