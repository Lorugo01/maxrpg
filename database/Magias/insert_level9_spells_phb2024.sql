-- ============================================================
-- MAGIAS DE 9º CÍRCULO - PHB 2024
-- ============================================================
-- Total: 15 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (2 magias)
-- ============================================================

-- Prisão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Prisão',
  9,
  'Abjuração',
  '1 minuto',
  '30 pés',
  'V, S, M (uma estatueta do alvo valendo mais de 5.000 GP)',
  'Até ser dissipado',
  'Você cria uma restrição mágica para prender uma criatura que você possa ver dentro do alcance. O alvo deve realizar um teste de resistência de Sabedoria. Em caso de sucesso, o alvo não é afetado e fica imune a esta magia pelas próximas 24 horas. Em caso de falha, o alvo é aprisionado. Enquanto aprisionado, o alvo não precisa respirar, comer ou beber, e não envelhece. Magias de Adivinhação não podem localizar ou perceber o alvo aprisionado, e o alvo não pode se teletransportar.

Até que a magia termine, o alvo também é afetado por um dos seguintes efeitos à sua escolha:

Enterro. O alvo é sepultado sob a terra em um globo oco de poder mágico, grande o suficiente para contê-lo. Nada pode entrar ou sair do globo.

Correntes. Correntes firmemente enraizadas no chão mantêm o alvo no lugar. O alvo tem a condição de Contido e não pode ser movido de forma alguma.

Prisão Protegida. O alvo fica preso em um semiplano protegido contra teletransporte e viagens planares. O semiplano pode ser um labirinto, uma gaiola, uma torre ou algo parecido.

Contenção Mínima. O alvo atinge 2,5 cm de altura e fica preso dentro de uma gema indestrutível ou objeto similar. A luz pode atravessar a gema (permitindo que o alvo veja o exterior e outras criaturas vejam o interior), mas nada mais pode passar por ela, de forma alguma.

Sono. O alvo está inconsciente e não pode ser despertado.

Fim do Feitiço. Ao conjurar o feitiço, especifique um gatilho que o encerrará. O gatilho pode ser tão simples ou elaborado quanto você escolher, mas o Mestre deve concordar que há uma alta probabilidade de acontecer na próxima década.

Uma magia Dissipar Magia só pode encerrar a magia se for conjurada com um espaço de magia de nível 9, tendo como alvo a prisão ou o componente usado para criá-la.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  false
);

-- Cura em Massa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Cura em Massa',
  9,
  'Abjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Uma torrente de energia curativa flui de você para as criaturas ao seu redor. Você restaura até 700 Pontos de Vida, divididos como quiser entre qualquer número de criaturas que você possa ver dentro do alcance. Criaturas curadas por esta magia também têm as condições Cego, Surdo e Envenenado removidas.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (1 magia)
-- ============================================================

-- Previsão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Previsão',
  9,
  'Adivinhação',
  '1 minuto',
  'Toque',
  'V, S, M (uma pena de beija-flor)',
  '8 horas',
  'Você toca uma criatura disposta e concede uma habilidade limitada de prever o futuro imediato. Durante a duração, o alvo tem Vantagem em Testes de D20, e outras criaturas têm Desvantagem em jogadas de ataque contra ele. A magia termina mais cedo se você conjurá-la novamente.',
  'PHB 2024',
  'Bardo, Druida, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- CONJURAÇÃO (3 magias)
-- ============================================================

-- Portão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Portão',
  9,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (um diamante que vale mais de 5.000 GP)',
  'Concentração, até 1 minuto',
  'Você conjura um portal que liga um espaço desocupado visível dentro do alcance a um local preciso em um plano de existência diferente. O portal é uma abertura circular, que pode ter de 1,5 a 6 metros de diâmetro. Você pode orientar o portal em qualquer direção que escolher. O portal dura enquanto durar, e o destino do portal é visível através dele.

O portal tem uma frente e um verso em cada plano onde aparece. Viajar através do portal só é possível movendo-se pela sua frente. Qualquer coisa que o faça é instantaneamente transportada para o outro plano, aparecendo no espaço desocupado mais próximo do portal.

Divindades e outros governantes planares podem impedir que portais criados por esta magia se abram em sua presença ou em qualquer lugar dentro de seus domínios.

Ao conjurar esta magia, você pode falar o nome de uma criatura específica (pseudônimo, título ou apelido não funcionam). Se a criatura estiver em um plano diferente daquele em que você está, o portal se abre ao lado da criatura nomeada e a transporta para o espaço desocupado mais próximo do seu lado do portal. Você não ganha nenhum poder especial sobre a criatura, e ela é livre para agir como o Mestre julgar apropriado.',
  'PHB 2024',
  'Clérigo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Tempestade de Vingança
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Tempestade de Vingança',
  9,
  'Conjuração',
  'Ação',
  '1 milha',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma nuvem de tempestade se forma durante o período, centrada em um ponto dentro do alcance e se espalhando por um raio de 91 metros. Cada criatura sob a nuvem quando ela aparece deve ser bem-sucedida em um teste de resistência de Constituição ou sofrer 2d6 de dano de Trovão e permanecer na condição de Surdo durante o período.

No início de cada um dos seus turnos posteriores, a tempestade produz efeitos diferentes:

Turno 2. Chuva ácida cai. Cada criatura e objeto sob a nuvem sofre 4d6 de dano de Ácido.

Turno 3. Você invoca seis raios da nuvem para atingir seis criaturas ou objetos diferentes abaixo dela. Cada alvo realiza um teste de resistência de Destreza, sofrendo 10d6 de dano de Raio em caso de falha ou metade do dano em caso de sucesso.

Turno 4. Chove granizo. Cada criatura sob a nuvem sofre 2d6 de dano Contundente.

Turnos 5 a 10. Rajadas de vento e chuva congelante assolam a área sob a nuvem. Cada criatura ali sofre 1d6 de dano de Gelo. Até o fim da magia, a área é Terreno Difícil e Fortemente Obscurecida, ataques à distância com armas são impossíveis ali, e ventos fortes sopram pela área.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '2d6 + 4d6 + 10d6 + 2d6 + 1d6',
  'Trovão/Ácido/Raio/Contundente/Frio'
);

-- Desejar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Desejar',
  9,
  'Conjuração',
  'Ação',
  'Próprio',
  'V',
  'Instantânea',
  'O desejo é o feitiço mais poderoso que um mortal pode lançar. Simplesmente falando em voz alta, você pode alterar a própria realidade.

O uso básico desta magia é duplicar qualquer outra magia de nível 8 ou inferior. Se você usá-la dessa forma, não precisará atender a nenhum requisito para conjurá-la, incluindo componentes caros. A magia simplesmente faz efeito.

Como alternativa, você pode criar um dos seguintes efeitos de sua escolha:

Criação de Objetos. Você cria um objeto de até 25.000 GP de valor que não seja um item mágico. O objeto não pode ter mais de 90 metros em qualquer dimensão e aparece em um espaço desocupado que você possa ver no chão.

Saúde Instantânea. Você permite que você e até vinte criaturas que você possa ver recuperem todos os Pontos de Vida, e encerra todos os efeitos sobre elas listados na magia Restauração Maior.

Resistência. Você concede a até dez criaturas visíveis Resistência a um tipo de dano à sua escolha. Essa Resistência é permanente.

Imunidade a Magias. Você concede imunidade a até dez criaturas visíveis a uma única magia ou outro efeito mágico por 8 horas.

Aprendizado Súbito. Você substitui um dos seus talentos por outro talento para o qual você é elegível. Você perde todos os benefícios do talento antigo e ganha os benefícios do novo.

Refazer Rolagem. Você desfaz um único evento recente forçando uma nova rolagem de qualquer dado feito na última rodada (incluindo seu último turno). A realidade se remodela para acomodar o novo resultado.

Remodelar a Realidade. Você pode desejar algo não incluído em nenhum dos outros efeitos. Para isso, declare seu desejo ao Mestre com a maior precisão possível. O Mestre tem grande liberdade para decidir o que ocorre em tal caso; quanto maior o desejo, maior a probabilidade de algo dar errado.

O estresse de conjurar Desejo para produzir qualquer efeito que não seja duplicar outra magia enfraquece você. Após suportar esse estresse, cada vez que conjurar uma magia até terminar um Descanso Longo, você sofre 1d10 de dano Necrótico por nível daquela magia. Esse dano não pode ser reduzido ou prevenido de forma alguma. Além disso, seu valor de Força se torna 3 por 2d4 dias. Finalmente, há 33% de chance de você não conseguir conjurar Desejo novamente se sofrer esse estresse.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false
);

-- ============================================================
-- ENCANTAMENTO (2 magias)
-- ============================================================

-- Palavra de Poder Cura
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Palavra de Poder Cura',
  9,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Uma onda de energia curativa atinge uma criatura visível dentro do alcance. O alvo recupera todos os seus Pontos de Vida. Se a criatura estiver nas condições Encantado, Assustado, Paralisado, Envenenado ou Atordoado, a condição termina. Se a criatura estiver na condição Caído, ela pode usar sua Reação para se levantar.',
  'PHB 2024',
  'Bardo, Clérigo',
  false,
  false
);

-- Palavra de Poder Matar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Palavra de Poder Matar',
  9,
  'Encantamento',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Você força uma criatura visível dentro do alcance a morrer. Se o alvo tiver 100 Pontos de Vida ou menos, ele morre. Caso contrário, sofre 12d12 de dano Psíquico.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '12d12',
  'Psíquico'
);

-- ============================================================
-- EVOCAÇÃO (2 magias)
-- ============================================================

-- Enxame de Meteoros
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Enxame de Meteoros',
  9,
  'Evocação',
  'Ação',
  '1 milha',
  'V, S',
  'Instantânea',
  'Orbes flamejantes de fogo despencam no chão em quatro pontos diferentes que você pode ver dentro do alcance. Cada criatura em uma Esfera de 12 metros de raio centrada em cada um desses pontos realiza um teste de resistência de Destreza. Uma criatura sofre 20d6 de dano de Fogo e 20d6 de dano de Concussão em uma falha ou metade do dano em um sucesso. Uma criatura na área de mais de uma Esfera de fogo é afetada apenas uma vez.

Um objeto não mágico que não esteja sendo usado ou carregado também sofre dano se estiver na área da magia, e o objeto começa a queimar se for inflamável.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '20d6 + 20d6',
  'Fogo/Concussão'
);

-- Parede Prismática
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Parede Prismática',
  9,
  'Abjuração',
  'Ação',
  '60 pés',
  'V, S',
  '10 minutos',
  'Um plano de luz brilhante e multicolorido forma uma parede vertical opaca — com até 27 metros de comprimento, 9 metros de altura e 2,5 centímetros de espessura — centrada em um ponto dentro do alcance. Alternativamente, você pode moldar a parede em um globo de até 9 metros de diâmetro centrado em um ponto dentro do alcance. A parede dura enquanto durar. Se você posicionar a parede em um espaço ocupado por uma criatura, a magia termina instantaneamente, sem efeito.

A parede emite Luz Brilhante em um raio de 30 metros e Luz Fraca por mais 30 metros. Você e as criaturas que você designar ao conjurar a magia podem atravessar e ficar perto da parede sem sofrer danos. Se outra criatura que possa ver a parede se mover a até 6 metros dela ou começar seu turno ali, a criatura deve ser bem-sucedida em um teste de resistência de Constituição ou ficará na condição de Cego por 1 minuto.

A parede consiste em sete camadas, cada uma com uma cor diferente. Quando uma criatura alcança ou atravessa a parede, ela o faz camada por camada, passando por todas as camadas. Cada camada força a criatura a realizar um teste de resistência de Destreza ou será afetada pelas propriedades daquela camada:

1 - Vermelho: 12d6 de dano de Fogo
2 - Laranja: 12d6 de dano de Ácido
3 - Amarelo: 12d6 de dano de Raio
4 - Verde: 12d6 de dano de Veneno
5 - Azul: 12d6 de dano de Gelo
6 - Índigo: Restringido, depois Petrificado
7 - Violeta: Cego, depois teletransportado

A parede, que tem CA 10, pode ser destruída uma camada de cada vez, em ordem do vermelho ao violeta, por meios específicos para cada camada. Campo Antimagia não tem efeito na parede, e Dissipar Magia pode afetar apenas a camada violeta.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  false,
  'damage',
  '12d6',
  'Variável'
);

-- ============================================================
-- ILUSÃO (1 magia)
-- ============================================================

-- Esquisito
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Esquisito',
  9,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Você tenta criar terrores ilusórios na mente dos outros. Cada criatura à sua escolha em uma Esfera de 9 metros de raio centrada em um ponto dentro do alcance realiza um teste de resistência de Sabedoria. Em caso de falha, o alvo sofre 10d10 de dano Psíquico e permanece na condição Amedrontado enquanto durar o teste. Em caso de sucesso, o alvo sofre apenas metade do dano.

Um alvo Amedrontado realiza um teste de resistência de Sabedoria ao final de cada um dos seus turnos. Em caso de falha, ele sofre 5d10 de dano Psíquico. Em caso de sucesso, a magia termina naquele alvo.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true,
  'damage',
  '10d10 + 5d10',
  'Psíquico'
);

-- ============================================================
-- NECROMANCIA (2 magias)
-- ============================================================

-- Projeção Astral
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Projeção Astral',
  9,
  'Necromancia',
  '1 hora',
  '10 pés',
  'V, S, M (para cada alvo da magia, um jacinto que vale mais de 1.000 GP e uma barra de prata que vale mais de 100 GP, todos consumidos pela magia)',
  'Até ser dissipado',
  'Você e até oito criaturas voluntárias dentro do alcance projetam seus corpos astrais para o Plano Astral (a magia termina instantaneamente se você já estiver naquele plano). O corpo de cada alvo é deixado para trás em um estado de animação suspensa; ele tem a condição Inconsciente, não precisa de comida ou ar e não envelhece.

A forma astral do alvo se assemelha ao seu corpo em quase todos os aspectos, replicando suas estatísticas de jogo e posses. A principal diferença é a adição de um cordão prateado que se estende entre as omoplatas da forma astral. O cordão desaparece de vista após 30 centímetros. Se o cordão for cortado — o que acontece apenas quando um efeito indica que ele o fará — tanto o corpo quanto a forma astral do alvo morrem.

A forma astral de um alvo pode viajar através do Plano Astral. No momento em que uma forma astral deixa esse plano, o corpo e os pertences do alvo viajam ao longo do cordão prateado, fazendo com que o alvo reentre em seu corpo no novo plano.

Qualquer dano ou outros efeitos aplicados a uma forma astral não afetam o corpo do alvo e vice-versa. Se o corpo ou a forma astral de um alvo caírem para 0 Pontos de Vida, a magia termina para aquele alvo. A magia termina para todos os alvos se você realizar uma ação de Magia para dispensá-la.

Quando o feitiço termina para um alvo que não está morto, o alvo reaparece em seu corpo e sai do estado de animação suspensa.',
  'PHB 2024',
  'Clérigo, Bruxo, Mago',
  false,
  false
);

-- Verdadeira Ressurreição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Verdadeira Ressurreição',
  9,
  'Necromancia',
  '1 hora',
  'Toque',
  'V, S, M (diamantes que valem mais de 25.000 GP, que a magia consome)',
  'Instantânea',
  'Você toca em uma criatura que esteja morta há no máximo 200 anos e que tenha morrido por qualquer motivo, exceto velhice. A criatura é revivida com todos os seus Pontos de Vida.

Este feitiço fecha todos os ferimentos, neutraliza qualquer veneno, cura todos os contágios mágicos e anula quaisquer maldições que afetassem a criatura quando ela morreu. O feitiço substitui órgãos e membros danificados ou ausentes. Se a criatura era morta-viva, ela é restaurada à sua forma não-morta-viva.

A magia pode fornecer um novo corpo se o original não existir mais. Nesse caso, você deve dizer o nome da criatura. A criatura então aparece em um espaço desocupado escolhido por você, a até 3 metros de distância.',
  'PHB 2024',
  'Clérigo, Druida',
  false,
  false
);

-- ============================================================
-- TRANSMUTAÇÃO (2 magias)
-- ============================================================

-- Mudança de Forma
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mudança de Forma',
  9,
  'Transmutação',
  'Ação',
  'Próprio',
  'V, S, M (um diadema que vale mais de 1.500 GP)',
  'Concentração, até 1 hora',
  'Você se transforma em outra criatura enquanto durar ou até realizar uma ação de Magia para se transformar em uma forma elegível diferente. A nova forma deve ser de uma criatura com Nível de Desafio não superior ao seu nível ou Nível de Desafio. Você deve ter visto esse tipo de criatura antes, e ela não pode ser um Construto ou um Morto-vivo.

Ao conjurar a magia, você ganha uma quantidade de Pontos de Vida Temporários igual aos Pontos de Vida da primeira forma em que se metamorfoseia. Esses Pontos de Vida Temporários desaparecem, se ainda houver algum, quando a magia termina.

Suas estatísticas de jogo são substituídas pelo bloco de estatísticas da forma escolhida, mas você mantém seu tipo de criatura; alinhamento; personalidade; valores de Inteligência, Sabedoria e Carisma; Pontos de Vida; Dados de Pontos de Vida; proficiências; e capacidade de comunicação. Se você tiver a habilidade Conjuração de Magias, você também a mantém.

Ao mudar de forma, você determina se seu equipamento cai no chão ou muda de tamanho e forma para se ajustar à nova forma enquanto você estiver nele.',
  'PHB 2024',
  'Druida, Mago',
  false,
  true
);

-- Polimorfo Verdadeiro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Polimorfo Verdadeiro',
  9,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma gota de mercúrio, uma colherada de goma arábica e uma nuvem de fumaça)',
  'Concentração, até 1 hora',
  'Escolha uma criatura ou objeto não mágico que você possa ver dentro do alcance. A criatura se transforma em uma criatura diferente ou em um objeto não mágico, ou o objeto se transforma em uma criatura (o objeto não pode ser usado nem carregado). A transformação dura enquanto durar o efeito ou até que o alvo morra ou seja destruído, mas se você mantiver a Concentração nesta magia por toda a duração, a magia dura até ser dissipada.

Uma criatura relutante pode fazer um teste de resistência de Sabedoria e, se for bem-sucedida, não será afetada pela magia.

Criatura em Criatura. Se você transformar uma criatura em outro tipo de criatura, a nova forma pode ser qualquer tipo que você escolher, com Nível de Desafio igual ou inferior ao Nível de Desafio ou Nível do alvo. As estatísticas de jogo do alvo são substituídas pelo bloco de estatísticas da nova forma, mas ela mantém seus Pontos de Vida, Dados de Pontos de Vida, alinhamento e personalidade.

O alvo ganha uma quantidade de Pontos de Vida Temporários igual aos Pontos de Vida da nova forma. Esses Pontos de Vida Temporários desaparecem se ainda houver algum quando a magia termina. A magia termina precocemente para o alvo se ele não tiver mais Pontos de Vida Temporários.

O alvo é limitado nas ações que pode realizar pela anatomia de sua nova forma, e não pode falar nem lançar magias.

O equipamento do alvo se funde à nova forma. A criatura não pode usar nem se beneficiar de nenhum desses equipamentos.

Objeto em Criatura. Você pode transformar um objeto em qualquer tipo de criatura, desde que o tamanho da criatura não seja maior que o do objeto e que a criatura tenha um Nível de Desafio de 9 ou menos. A criatura é amigável a você e seus aliados. Em combate, ela realiza seus turnos imediatamente após o seu e obedece aos seus comandos.

Se a magia durar mais de uma hora, você não controla mais a criatura. Ela pode permanecer amigável a você, dependendo de como você a tratou.

Criatura em Objeto. Se você transformar uma criatura em um objeto, ela se transforma, junto com tudo o que estiver vestindo e carregando, naquela forma, desde que o tamanho do objeto não seja maior que o da própria criatura. As estatísticas da criatura se tornam as do objeto, e a criatura não tem memória do tempo que passou nessa forma após o fim da magia e ela retorna ao normal.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  false,
  true
);

-- Parada do Tempo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Parada do Tempo',
  9,
  'Transmutação',
  'Ação',
  'Próprio',
  'V',
  'Instantânea',
  'Você interrompe brevemente o fluxo do tempo para todos, exceto para si mesmo. O tempo não passa para outras criaturas, enquanto você joga 1d4 + 1 turnos seguidos, durante os quais pode usar ações e se mover normalmente.

Esta magia termina se uma das ações que você usar durante este período, ou quaisquer efeitos que você criar durante ele, afetar uma criatura que não seja você ou um objeto que esteja sendo usado ou carregado por alguém que não seja você. Além disso, a magia termina se você se mover para um local a mais de 300 metros do local onde a conjurou.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false
);

-- ============================================================
-- VERIFICAÇÃO FINAL COMPLETA
-- ============================================================

-- Verificar quantas magias de 8º e 9º círculo foram inseridas
SELECT 
  'Magias de 8º e 9º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level IN (8, 9) 
  AND source = 'PHB 2024';

-- Ver por nível
SELECT 
  level,
  COUNT(*) as quantidade
FROM spells 
WHERE level IN (8, 9) 
  AND source = 'PHB 2024'
GROUP BY level
ORDER BY level;

-- Ver por escola (8º e 9º)
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level IN (8, 9) 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral COMPLETO (0º a 9º)
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
    WHEN level = 5 THEN '5º Círculo'
    WHEN level = 6 THEN '6º Círculo'
    WHEN level = 7 THEN '7º Círculo'
    WHEN level = 8 THEN '8º Círculo'
    WHEN level = 9 THEN '9º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 9
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - SISTEMA COMPLETO (0º a 9º CÍRCULO)
-- ============================================================
