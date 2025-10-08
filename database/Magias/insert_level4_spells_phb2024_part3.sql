-- ============================================================
-- MAGIAS DE 4º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final: Evocação, Ilusão, Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- EVOCAÇÃO (5 magias)
-- ============================================================

-- Escudo de Fogo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Escudo de Fogo',
  4,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S, M (um pouco de fósforo ou um vaga-lume)',
  '10 minutos',
  'Chamas tênues envolvem seu corpo durante todo o efeito, emitindo Luz Brilhante em um raio de 3 metros e Luz Fraca por mais 3 metros.

As chamas fornecem um escudo de calor ou um escudo de frio, conforme você escolher. O escudo de calor concede resistência a dano de frio, e o escudo de frio concede resistência a dano de fogo.

Além disso, sempre que uma criatura a até 1,5 metro de você o atingir com um ataque corpo a corpo, o escudo explode em chamas. O atacante sofre 2d8 de dano de Fogo de um escudo quente ou 2d8 de dano de Gelo de um escudo frio.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '2d8',
  'Fogo/Frio'
);

-- Fonte do Luar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Fonte do Luar',
  4,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Uma luz fria envolve seu corpo durante todo o efeito, emitindo Luz Brilhante em um raio de 6 metros e Luz Fraca por mais 6 metros.

Até o fim da magia, você tem Resistência a dano Radiante, e seus ataques corpo a corpo causam 2d6 de dano Radiante extra em um acerto.

Além disso, imediatamente após sofrer dano de uma criatura visível a até 18 metros de distância, você pode usar uma Reação para forçar a criatura a realizar um teste de resistência de Constituição. Em caso de falha, a criatura fica cega até o final do seu próximo turno.',
  'PHB 2024',
  'Bardo, Druida',
  false,
  true,
  'damage',
  '2d6',
  'Radiante'
);

-- Tempestade de Gelo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Tempestade de Gelo',
  4,
  'Evocação',
  'Ação',
  '300 pés',
  'V, S, M (uma luva)',
  'Instantânea',
  'Granizo cai em um Cilindro de 6 metros de raio e 12 metros de altura, centrado em um ponto dentro do alcance. Cada criatura no Cilindro realiza um teste de resistência de Destreza. Uma criatura sofre 2d10 de dano de Concussão e 4d6 de dano de Gelo em uma falha na resistência, ou metade desse dano em um sucesso.

Granizo transforma o solo do Cilindro em Terreno Difícil até o final do seu próximo turno.

Usando um Espaço de Magia de Nível Superior. O dano de Concussão aumenta em 1d10 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '2d10 + 4d6',
  'Concussão/Frio',
  '1d10'
);

-- Esfera Vitriólica
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Esfera Vitriólica',
  4,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (uma gota de bile)',
  'Instantânea',
  'Você aponta para um local dentro do alcance, e uma bola brilhante de ácido, com 30 centímetros de diâmetro, dispara até lá e explode em uma Esfera de 6 metros de raio. Cada criatura naquela área realiza um teste de resistência de Destreza. Em caso de falha, a criatura sofre 10d4 de dano de Ácido e mais 5d4 de dano de Ácido no final do seu próximo turno. Em caso de sucesso, a criatura sofre apenas metade do dano inicial.

Usando um Espaço de Magia de Nível Superior. O dano inicial aumenta em 2d4 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '10d4 + 5d4',
  'Ácido',
  '2d4'
);

-- Muro de Fogo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Muro de Fogo',
  4,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (um pedaço de carvão)',
  'Concentração, até 1 minuto',
  'Você cria uma parede de fogo em uma superfície sólida dentro do alcance. Você pode fazer a parede com até 18 metros de comprimento, 6 metros de altura e 30 centímetros de espessura, ou uma parede anelar com até 6 metros de diâmetro, 6 metros de altura e 30 centímetros de espessura. A parede é opaca e dura enquanto durar o efeito.

Quando a parede aparece, cada criatura em sua área faz um teste de resistência de Destreza, sofrendo 5d8 de dano de Fogo em uma falha ou metade desse dano em uma sucesso.

Um lado da parede, selecionado por você ao conjurar esta magia, causa 5d8 de dano de Fogo a cada criatura que terminar seu turno a até 3 metros daquele lado ou dentro da parede. Uma criatura sofre o mesmo dano quando entra na parede pela primeira vez em um turno ou termina seu turno ali. O outro lado da parede não causa dano.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '5d8',
  'Fogo',
  '1d8'
);

-- ============================================================
-- ILUSÃO (3 magias)
-- ============================================================

-- Invisibilidade Maior
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invisibilidade Maior',
  4,
  'Ilusão',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma criatura que você tocar tem a condição Invisível até que a magia termine.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Terreno Alucinatório
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Terreno Alucinatório',
  4,
  'Ilusão',
  '10 minutos',
  '300 pés',
  'V, S, M (um cogumelo)',
  '24 horas',
  'Você faz com que terrenos naturais em um Cubo de 45 metros de alcance pareçam, soem e cheirem como outro tipo de terreno natural. Assim, campos abertos ou uma estrada podem ser transformados em pântanos, colinas, fendas ou algum outro terreno difícil ou intransitável. Um lago pode ser transformado em um prado gramado, um precipício em uma encosta suave ou uma ravina rochosa em uma estrada larga e plana. Estruturas, equipamentos e criaturas manufaturadas dentro da área não são alterados.

As características táteis do terreno permanecem inalteradas, então criaturas que entram na área provavelmente notarão a ilusão. Se a diferença não for óbvia ao toque, uma criatura que examine a ilusão pode realizar a ação Estudar para realizar um teste de Inteligência (Investigação) contra sua CD de magia para desacreditá-la. Se uma criatura perceber que o terreno é ilusório, ela verá uma imagem vaga sobreposta ao terreno real.',
  'PHB 2024',
  'Bardo, Druida, Bruxo, Mago',
  false,
  false
);

-- Assassino Fantasmal
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Assassino Fantasmal',
  4,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Você acessa os pesadelos de uma criatura visível dentro do alcance e cria uma ilusão de seus medos mais profundos, visível apenas para aquela criatura. O alvo realiza um teste de resistência de Sabedoria. Em caso de falha, o alvo sofre 4d10 de dano Psíquico e tem Desvantagem em testes de habilidade e jogadas de ataque enquanto durar o teste. Em caso de sucesso, o alvo sofre metade do dano e a magia termina.

Durante a duração, o alvo realiza um teste de resistência de Sabedoria ao final de cada um dos seus turnos. Em caso de falha, ele sofre o dano Psíquico novamente. Em caso de sucesso, a magia termina.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  true,
  'damage',
  '4d10',
  'Psíquico',
  '1d10'
);

-- ============================================================
-- NECROMANCIA (1 magia)
-- ============================================================

-- Praga
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Praga',
  4,
  'Necromancia',
  'Ação',
  '30 pés',
  'V, S',
  'Instantânea',
  'Uma criatura que você possa ver dentro do alcance faz um teste de resistência de Constituição, sofrendo 8d8 de dano Necrótico em caso de falha ou metade desse dano em caso de sucesso. Uma criatura Planta falha automaticamente no teste.

Alternativamente, escolha uma planta não mágica que não seja uma criatura, como uma árvore ou arbusto. Ela não garante uma defesa; ela simplesmente murcha e morre.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '8d8',
  'Necrótico',
  '1d8'
);

-- ============================================================
-- TRANSMUTAÇÃO (6 magias)
-- ============================================================

-- Controle de Água
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Controle de Água',
  4,
  'Transmutação',
  'Ação',
  '300 pés',
  'V, S, M (uma mistura de água e poeira)',
  'Concentração, até 10 minutos',
  'Até o fim da magia, você controla qualquer água dentro de uma área escolhida que seja um Cubo de até 30 metros de lado, usando um dos seguintes efeitos. Como uma ação de Magia nos seus turnos posteriores, você pode repetir o mesmo efeito ou escolher um diferente.

Inundação. Você faz com que o nível de toda a água parada na área suba em até 6 metros.

Parte Água. Você divide a água na área e cria uma trincheira.

Redirecionar Fluxo. Você faz com que a água corrente na área se mova na direção que você escolher.

Redemoinho. Você faz com que um redemoinho se forme no centro da área. O redemoinho tem 1,5 metro de largura na base, até 15 metros de largura no topo e 7,5 metros de altura. Criaturas na água sofrem 2d8 de dano de Concussão ao entrar ou terminar seu turno no redemoinho.',
  'PHB 2024',
  'Clérigo, Druida, Mago',
  false,
  true,
  'damage',
  '2d8',
  'Concussão'
);

-- Fabricar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Fabricar',
  4,
  'Transmutação',
  '10 minutos',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você converte matérias-primas em produtos do mesmo material. Por exemplo, você pode fabricar uma ponte de madeira a partir de um aglomerado de árvores, uma corda a partir de um pedaço de cânhamo ou roupas a partir de linho ou lã.

Escolha matérias-primas que você possa ver dentro do alcance. Você pode fabricar um objeto Grande ou menor (contido em um Cubo de 3 metros ou oito Cubos de 1,5 metros conectados) desde que tenha uma quantidade suficiente de material. Se estiver trabalhando com metal, pedra ou outra substância mineral, no entanto, o objeto fabricado não pode ser maior que Médio (contido em um Cubo de 1,5 metro). A qualidade de qualquer objeto fabricado depende da qualidade das matérias-primas.

Criaturas e itens mágicos não podem ser criados com esta magia. Você também não pode usá-la para criar itens que exijam um alto grau de habilidade — como armas e armaduras — a menos que tenha proficiência no tipo de Ferramentas de Artesão usadas para criar tais objetos.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  false
);

-- Polimorfo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Polimorfo',
  4,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S, M (um casulo de lagarta)',
  'Concentração, até 1 hora',
  'Você tenta transformar uma criatura visível dentro do alcance em uma Besta. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou mudar de forma para a forma de Besta durante o período. Essa forma pode ser qualquer Besta que você escolher que tenha um Nível de Desafio igual ou inferior ao do alvo (ou ao nível do alvo, se não tiver um Nível de Desafio). As estatísticas de jogo do alvo são substituídas pelo bloco de estatísticas da Besta escolhida, mas o alvo mantém seu alinhamento, personalidade, tipo de criatura, Pontos de Vida e Dados de Ponto de Vida.

O alvo ganha uma quantidade de Pontos de Vida Temporários igual aos Pontos de Vida da forma Bestial. Esses Pontos de Vida Temporários desaparecem se ainda houver algum quando a magia termina. A magia termina precocemente para o alvo se ele não tiver mais Pontos de Vida Temporários.

O alvo é limitado nas ações que pode realizar pela anatomia de sua nova forma, e não pode falar nem lançar magias.

O equipamento do alvo se funde à nova forma. A criatura não pode usar nem se beneficiar de nenhum desses equipamentos.',
  'PHB 2024',
  'Bardo, Druida, Feiticeiro, Mago',
  false,
  true
);

-- Forma de Pedra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Forma de Pedra',
  4,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (argila macia)',
  'Instantânea',
  'Você toca em um objeto de pedra de tamanho Médio ou menor, ou em um pedaço de pedra com no máximo 1,5 metro de qualquer dimensão, e o molda no formato que desejar. Por exemplo, você pode moldar uma pedra grande em uma arma, estátua ou cofre, ou pode fazer uma pequena passagem através de uma parede com 1,5 metro de espessura. Você também pode moldar uma porta de pedra ou sua moldura para fechá-la. O objeto criado pode ter até duas dobradiças e uma trava, mas detalhes mecânicos mais precisos não são possíveis.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Mago',
  false,
  false
);

-- Pele de Pedra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Pele de Pedra',
  4,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (pó de diamante que vale mais de 100 GP, que a magia consome)',
  'Concentração, até 1 hora',
  'Até que a magia termine, uma criatura disposta que você tocar terá Resistência a dano Contundente, Perfurante e Cortante.',
  'PHB 2024',
  'Artífice, Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  true
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 4º círculo foram inseridas
SELECT 
  'Magias de 4º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 4 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 4 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral (0º a 4º)
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 4
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - 4º CÍRCULO COMPLETO
-- ============================================================
