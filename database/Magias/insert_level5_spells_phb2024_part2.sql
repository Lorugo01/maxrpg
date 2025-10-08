-- ============================================================
-- MAGIAS DE 5º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: Conjuração, Encantamento, Evocação
-- ============================================================

-- ============================================================
-- CONJURAÇÃO (11 magias)
-- ============================================================

-- Nuvem Matadora
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Nuvem Matadora',
  5,
  'Conjuração',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você cria uma Esfera de névoa verde-amarelada com 6 metros de raio, centrada em um ponto dentro do alcance. A névoa dura enquanto durar a magia ou até que um vento forte a disperse, encerrando-a. Sua área é Fortemente Obscura.

Cada criatura na Esfera realiza um teste de resistência de Constituição, sofrendo 5d8 de dano de Veneno em caso de falha ou metade desse dano em caso de sucesso. Uma criatura também deve realizar esse teste quando a Esfera se move para o seu espaço e quando entra na Esfera ou termina seu turno ali. Uma criatura realiza esse teste apenas uma vez por turno.

A Esfera se move 3 metros para longe de você no início de cada um dos seus turnos.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  true,
  'damage',
  '5d8',
  'Veneno',
  '1d8'
);

-- Conjurar Elemental
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Elemental',
  5,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura um espírito Grande e intangível dos Planos Elementais que aparece em um espaço desocupado dentro do alcance. Escolha o elemento do espírito, que determina seu tipo de dano: ar (Relâmpago), terra (Trovão), fogo (Fogo) ou água (Frio). O espírito dura enquanto durar.

Sempre que uma criatura que você possa ver entrar no espaço do espírito ou começar seu turno a até 1,5 metro do espírito, você pode forçar essa criatura a realizar um teste de resistência de Destreza. Em caso de falha, o alvo sofre 8d8 de dano do tipo do espírito e permanece na condição Reprimido até o fim da magia. No início de cada um de seus turnos, o alvo Reprimido repete o teste. Em caso de falha, sofre 4d8 de dano do tipo do espírito.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Druida, Mago',
  false,
  true,
  'damage',
  '8d8',
  'Variável',
  '1d8'
);

-- Praga de Insetos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Praga de Insetos',
  5,
  'Conjuração',
  'Ação',
  '300 pés',
  'V, S, M (um gafanhoto)',
  'Concentração, até 10 minutos',
  'Enxames de gafanhotos preenchem uma Esfera de 6 metros de raio centrada em um ponto à sua escolha dentro do alcance. A Esfera permanece enquanto durar o efeito, e sua área é Terreno Levemente Obscurecido e Difícil.

Quando o enxame aparece, cada criatura nele faz um teste de resistência de Constituição, sofrendo 4d10 de dano Perfurante em caso de falha ou metade desse dano em caso de sucesso. Uma criatura também faz esse teste quando entra na área da magia pela primeira vez em um turno ou termina seu turno lá. Uma criatura faz esse teste apenas uma vez por turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro',
  false,
  true,
  'damage',
  '4d10',
  'Perfurante',
  '1d10'
);

-- Golpe de Vento de Aço
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Golpe de Vento de Aço',
  5,
  'Conjuração',
  'Ação',
  '30 pés',
  'S, M (uma arma corpo a corpo que vale 1+ SP)',
  'Instantânea',
  'Você brande a arma usada na conjuração e então desaparece para atacar como o vento. Escolha até cinco criaturas que você possa ver dentro do alcance. Faça um ataque mágico corpo a corpo contra cada alvo. Ao acertar, o alvo sofre 6d10 de dano de Força.

Em seguida, você se teletransporta para um espaço desocupado que você possa ver a até 1,5 metro de um dos alvos.',
  'PHB 2024',
  'Patrulheiro, Mago',
  false,
  false,
  'damage',
  '6d10',
  'Força'
);

-- Invocar Celestial
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Celestial',
  5,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um relicário que vale mais de 500 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito celestial. Ele se manifesta em forma angelical em um espaço desocupado que você possa ver dentro do alcance e usa o bloco de estatísticas Espírito Celestial. Ao conjurar a magia, escolha Vingador ou Defensor. Sua escolha determina certos detalhes em seu bloco de estatísticas. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária).

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Invocar Dragão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Dragão',
  5,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (um objeto com a imagem de um dragão gravada que vale mais de 500 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito de Dragão. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Dracônico. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária).

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Mago',
  false,
  true
);

-- Círculo de Teletransporte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Círculo de Teletransporte',
  5,
  'Conjuração',
  '1 minuto',
  '10 pés',
  'V, M (tintas raras que valem mais de 50 GP, que a magia consome)',
  '1 rodada',
  'Ao conjurar a magia, você desenha um círculo de 1,5 metro de raio no chão, inscrito com sigilos que ligam sua localização a um círculo de teletransporte permanente de sua escolha, cuja sequência de sigilos você conhece e que esteja no mesmo plano de existência que você. Um portal brilhante se abre dentro do círculo que você desenhou e permanece aberto até o final do seu próximo turno. Qualquer criatura que entrar no portal aparece instantaneamente a até 1,5 metro do círculo de destino.

Muitos templos importantes, guildas e outros locais importantes possuem círculos de teletransporte permanentes. Cada círculo inclui uma sequência única de sigilos.

Você pode criar um círculo de teletransporte permanente lançando este feitiço no mesmo local todos os dias durante 365 dias.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Passo da Árvore
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Passo da Árvore',
  5,
  'Conjuração',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 1 minuto',
  'Você ganha a habilidade de entrar em uma árvore e se mover de dentro dela para dentro de outra árvore do mesmo tipo em um raio de 150 metros. Ambas as árvores devem estar vivas e ter pelo menos o mesmo tamanho que você. Você deve usar 1,5 metro de movimento para entrar em uma árvore. Você sabe instantaneamente a localização de todas as outras árvores do mesmo tipo em um raio de 150 metros.

Você pode usar esta habilidade de transporte apenas uma vez em cada um dos seus turnos. Você deve terminar cada turno fora de uma árvore.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true
);

-- ============================================================
-- ENCANTAMENTO (7 magias)
-- ============================================================

-- Dominar Pessoa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dominar Pessoa',
  5,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Um humanoide visível dentro do alcance deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição de Encantado durante o período. O alvo tem Vantagem no teste se você ou seus aliados estiverem lutando contra ele. Sempre que o alvo sofrer dano, ele repete o teste, encerrando a magia sobre si mesmo em caso de sucesso.

Você tem um vínculo telepático com o alvo Encantado enquanto ambos estiverem no mesmo plano de existência. No seu turno, você pode usar esse vínculo para emitir comandos ao alvo (nenhuma ação necessária). O alvo faz o possível para obedecer no seu turno.

Usando um Espaço de Magia de Nível Superior. Sua Concentração pode durar mais com um espaço de magia de nível 6 (até 10 minutos), 7 (até 1 hora) ou 8+ (até 8 horas).',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Geas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Geas',
  5,
  'Encantamento',
  '1 minuto',
  '60 pés',
  'V',
  '30 dias',
  'Você dá um comando verbal a uma criatura que você possa ver dentro do alcance, ordenando que ela realize algum serviço ou se abstenha de uma ação ou curso de atividade conforme você decidir. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição Encantado durante a duração do comando.

Enquanto estiver Encantado, a criatura sofre 5d10 de dano Psíquico se agir de forma diretamente contrária ao seu comando. Ela sofre esse dano no máximo uma vez por dia.

Uma magia Remover Maldição, Restauração Maior ou Desejo encerra esta magia.

Usando um Espaço de Magia de Nível Superior. Se você usar um espaço de magia de nível 7 ou 8, a duração será de 365 dias. Se você usar um espaço de magia de nível 9, a magia durará até ser finalizada.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Paladino, Mago',
  false,
  false,
  'damage',
  '5d10',
  'Psíquico'
);

-- Segure o Monstro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Segure o Monstro',
  5,
  'Encantamento',
  'Ação',
  '90 pés',
  'V, S, M (um pedaço reto de ferro)',
  'Concentração, até 1 minuto',
  'Escolha uma criatura que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou ficará paralisado durante toda a duração. Ao final de cada um dos seus turnos, o alvo repete o teste, encerrando a magia sobre si mesmo em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Modificar Memória
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Modificar Memória',
  5,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Você tenta remodelar as memórias de outra criatura. Uma criatura que você possa ver dentro do alcance faz um teste de resistência de Sabedoria. Se você estiver lutando contra a criatura, ela terá Vantagem na resistência. Em caso de falha, o alvo fica com a condição Encantado pela duração. Enquanto estiver Encantado dessa forma, o alvo também fica com a condição Incapacitado.

Enquanto este feitiço durar, você pode afetar a memória do alvo de um evento que ele vivenciou nas últimas 24 horas e que durou no máximo 10 minutos. Você pode eliminar permanentemente toda a memória do evento, permitir que o alvo se lembre do evento com perfeita clareza, alterar sua memória dos detalhes do evento ou criar uma memória de algum outro evento.

Uma magia Remover Maldição ou Restauração Maior lançada no alvo restaura a verdadeira memória da criatura.

Usando um Espaço de Magia de Nível Superior. Você pode alterar memórias de até 7 dias atrás (nível 6), 30 dias (nível 7), 365 dias (nível 8) ou qualquer momento (nível 9).',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true
);

-- Estática Sináptica
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Estática Sináptica',
  5,
  'Encantamento',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você faz com que energia psíquica irrompa em um ponto dentro do alcance. Cada criatura em uma Esfera de 6 metros de raio centrada naquele ponto realiza um teste de resistência de Inteligência, sofrendo 8d6 de dano Psíquico em caso de falha ou metade do dano em caso de sucesso.

Em caso de falha, o alvo também fica com os pensamentos confusos por 1 minuto. Durante esse tempo, ele subtrai 1d6 de todas as suas jogadas de ataque e testes de habilidade, bem como de quaisquer testes de resistência de Constituição para manter a Concentração. O alvo realiza um teste de resistência de Inteligência ao final de cada um de seus turnos, encerrando o efeito sobre si mesmo em caso de sucesso.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '8d6',
  'Psíquico'
);

-- Presença Real de Yolande
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Presença Real de Yolande',
  5,
  'Encantamento',
  'Ação',
  'Próprio',
  'V, S, M (uma tiara em miniatura)',
  'Concentração, até 1 minuto',
  'Você se cerca de uma majestade sobrenatural em uma Emanação de 3 metros. Sempre que a Emanação entrar no espaço de uma criatura que você possa ver e sempre que uma criatura que você possa ver entrar na Emanação ou terminar seu turno lá, você pode forçar essa criatura a realizar um teste de resistência de Sabedoria. Em caso de falha, o alvo sofre 4d6 de dano Psíquico e fica com a condição Caído, e você pode empurrá-lo a até 3 metros de distância. Em caso de sucesso, o alvo sofre apenas metade do dano. Uma criatura realiza esse teste apenas uma vez por turno.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true,
  'damage',
  '4d6',
  'Psíquico'
);

-- Continua na parte 3...
