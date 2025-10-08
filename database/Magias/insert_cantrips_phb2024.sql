-- ============================================================
-- TRUQUES (CANTRIPS) - PHB 2024
-- ============================================================
-- Total: 30 truques essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (2 truques)
-- ============================================================

-- Proteção da Lâmina
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Proteção da Lâmina',
  0,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 1 minuto',
  'Sempre que uma criatura faz uma jogada de ataque contra você antes que a magia termine, o atacante subtrai 1d4 da jogada de ataque.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Resistência
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Resistência',
  0,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 minuto',
  'Você toca uma criatura disposta e escolhe um tipo de dano: Ácido, Contundente, Frio, Fogo, Relâmpago, Necrótico, Perfurante, Venenoso, Radiante, Cortante ou Trovejante. Quando a criatura sofre dano do tipo escolhido antes do fim da magia, ela reduz o dano total recebido em 1d4. Uma criatura pode se beneficiar desta magia apenas uma vez por turno.',
  'PHB 2024',
  'Artífice, Clérigo, Druida',
  false,
  true
);

-- ============================================================
-- ADIVINHAÇÃO (2 truques)
-- ============================================================

-- Orientação
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Orientação',
  0,
  'Adivinhação',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 minuto',
  'Você toca uma criatura disposta e escolhe uma perícia. Até que a magia termine, a criatura adiciona 1d4 a qualquer teste de habilidade que use a perícia escolhida.',
  'PHB 2024',
  'Artífice, Clérigo, Druida',
  false,
  true
);

-- Golpe Verdadeiro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Golpe Verdadeiro',
  0,
  'Adivinhação',
  'Ação',
  'Próprio',
  'S, M (uma arma com a qual você tem proficiência e que vale 1+ CP)',
  'Instantânea',
  'Guiado por um lampejo de percepção mágica, você realiza um ataque com a arma usada na conjuração da magia. O ataque usa sua habilidade de conjuração para as jogadas de ataque e dano, em vez de usar Força ou Destreza. Se o ataque causar dano, ele pode ser dano Radiante ou o tipo de dano normal da arma (à sua escolha).

Melhoria de Truque. Não importa se você causa dano Radiante ou o tipo de dano normal da arma, o ataque causa dano Radiante extra quando você atinge os níveis 5 (1d6), 11 (2d6) e 17 (3d6).',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  'Radiante',
  '[{"level": 5, "dice": "1d6"}, {"level": 11, "dice": "2d6"}, {"level": 17, "dice": "3d6"}]'::jsonb
);

-- ============================================================
-- CONJURAÇÃO (2 truques)
-- ============================================================

-- Mão de Mago
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mão de Mago',
  0,
  'Conjuração',
  'Ação',
  '30 pés',
  'V, S',
  '1 minuto',
  'Uma mão espectral flutuante aparece em um ponto à sua escolha dentro do alcance. A mão permanece ativa enquanto durar o efeito. A mão desaparece se estiver a mais de 9 metros de distância de você ou se você conjurar esta magia novamente.

Ao lançar o feitiço, você pode usar a mão para manipular um objeto, abrir uma porta ou recipiente destrancado, guardar ou recuperar um item de um recipiente aberto ou despejar o conteúdo de um frasco.

Com uma ação de Magia nos seus turnos posteriores, você pode controlar a mão novamente. Como parte dessa ação, você pode mover a mão até 9 metros.

A mão não pode atacar, ativar itens mágicos ou carregar mais de 4,5 kg.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Produzir Chama
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Produzir Chama',
  0,
  'Conjuração',
  'Ação Bônus',
  'Próprio',
  'V, S',
  '10 minutos',
  'Uma chama bruxuleante aparece na sua mão e permanece lá enquanto durar o efeito. Enquanto estiver lá, a chama não emite calor nem acende nada, além de emitir Luz Brilhante em um raio de 6 metros e Luz Fraca por mais 6 metros. A magia termina se você conjurá-la novamente.

Até o fim da magia, você pode realizar uma ação de Magia para lançar fogo em uma criatura ou objeto a até 18 metros de distância. Faça um ataque mágico à distância. Ao acertar, o alvo sofre 1d8 de dano de Fogo.

Melhoria de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  'PHB 2024',
  'Druida',
  false,
  false,
  'damage',
  '1d8',
  'Fogo',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- ============================================================
-- ENCANTAMENTO (3 truques)
-- ============================================================

-- Amigos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Amigos',
  0,
  'Encantamento',
  'Ação',
  '10 pés',
  'P, M (alguma maquiagem)',
  'Concentração, até 1 minuto',
  'Você emana magicamente um sentimento de amizade por uma criatura que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou ter a condição Encantado durante a duração. O alvo obtém sucesso automaticamente se não for um Humanoide, se você estiver lutando contra ele ou se você tiver conjurado esta magia nele nas últimas 24 horas.

A magia termina mais cedo se o alvo sofrer dano ou se você fizer uma jogada de ataque, causar dano ou forçar alguém a fazer um teste de resistência. Quando a magia termina, o alvo sabe que foi enfeitiçado por você.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Lasca Mental
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Lasca Mental',
  0,
  'Encantamento',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Você tenta fragmentar temporariamente a mente de uma criatura que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Inteligência ou sofrer 1d6 de dano Psíquico e subtrair 1d4 do próximo teste de resistência que fizer antes do final do seu próximo turno.

Melhoria de Truque. O dano aumenta em 1d6 quando você atinge os níveis 5 (2d6), 11 (3d6) e 17 (4d6).',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '1d6',
  'Psíquico',
  '[{"level": 5, "dice": "2d6"}, {"level": 11, "dice": "3d6"}, {"level": 17, "dice": "4d6"}]'::jsonb
);

-- Zombaria Cruel (já existe, mas vou incluir para completude)
-- Nota: Verificar se já existe antes de executar

-- ============================================================
-- EVOCAÇÃO (9 truques)
-- ============================================================

-- Respingo Ácido
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Respingo Ácido',
  0,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você cria uma bolha ácida em um ponto dentro do alcance, onde ela explode em uma Esfera de 1,5 metro de raio. Cada criatura naquela Esfera deve ser bem-sucedida em um teste de resistência de Destreza ou sofrerá 1d6 de dano de Ácido.

Melhoria de Truque. O dano aumenta em 1d6 quando você atinge os níveis 5 (2d6), 11 (3d6) e 17 (4d6).',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '1d6',
  'Ácido',
  '[{"level": 5, "dice": "2d6"}, {"level": 11, "dice": "3d6"}, {"level": 17, "dice": "4d6"}]'::jsonb
);

-- Raio de Fogo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Raio de Fogo',
  0,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você arremessa uma partícula de fogo em uma criatura ou objeto dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 1d10 de dano de Fogo. Um objeto inflamável atingido por esta magia começa a queimar se não estiver sendo usado ou carregado.

Melhoria de Truque. O dano aumenta em 1d10 quando você atinge os níveis 5 (2d10), 11 (3d10) e 17 (4d10).',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '1d10',
  'Fogo',
  '[{"level": 5, "dice": "2d10"}, {"level": 11, "dice": "3d10"}, {"level": 17, "dice": "4d10"}]'::jsonb
);

-- Luz
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Luz',
  0,
  'Evocação',
  'Ação',
  'Toque',
  'V, M (um vaga-lume ou musgo fosforescente)',
  '1 hora',
  'Você toca em um objeto grande ou menor que não esteja sendo usado ou carregado por outra pessoa. Até o fim do feitiço, o objeto emite Luz Brilhante em um raio de 6 metros e Luz Fraca por mais 6 metros. A luz pode ser colorida como você quiser.

Cobrir o objeto com algo opaco bloqueia a luz. O feitiço termina se você conjurá-lo novamente.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Feiticeiro, Mago',
  false,
  false
);

-- Raio de Gelo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Raio de Gelo',
  0,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Um feixe gélido de luz azul-esbranquiçada dispara em direção a uma criatura dentro do alcance. Faça um ataque mágico à distância contra o alvo. Ao acertar, ele sofre 1d8 de dano de Frio e sua Velocidade é reduzida em 3 metros até o início do seu próximo turno.

Melhoria de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '1d8',
  'Frio',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- Chama Sagrada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Chama Sagrada',
  0,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Um brilho flamejante desce sobre uma criatura que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Destreza ou sofrer 1d8 de dano Radiante. O alvo não ganha benefício de Meia Cobertura ou Cobertura de Três Quartos para esta resistência.

Melhoria de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '1d8',
  'Radiante',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- Aperto Chocante
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Aperto Chocante',
  0,
  'Evocação',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Um raio é lançado de você para uma criatura que você tenta tocar. Faça um ataque mágico corpo a corpo contra o alvo. Ao acertar, o alvo sofre 1d8 de dano de Raio e não pode realizar Ataques de Oportunidade até o início do seu próximo turno.

Melhoria de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '1d8',
  'Elétrico',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- Fogo-fátuo Estrelado
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Fogo-fátuo Estrelado',
  0,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você lança um grão de luz em uma criatura ou objeto dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 1d8 de dano Radiante e, até o final do seu próximo turno, emite Luz Fraca em um raio de 3 metros e não pode se beneficiar da condição Invisível.

Melhoria de Truque. O dano aumenta em 1d8 quando você atinge os níveis 5 (2d8), 11 (3d8) e 17 (4d8).',
  'PHB 2024',
  'Bardo, Druida',
  false,
  false,
  'damage',
  '1d8',
  'Radiante',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- Trovão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Trovão',
  0,
  'Evocação',
  'Ação',
  'Próprio',
  'S',
  'Instantânea',
  'Cada criatura em uma Emanação de 1,5 metro originada de você deve ser bem-sucedida em um teste de resistência de Constituição ou sofrer 1d6 de dano de Trovão. O som estrondoso da magia pode ser ouvido a até 30 metros de distância.

Melhoria de Truque. O dano aumenta em 1d6 quando você atinge os níveis 5 (2d6), 11 (3d6) e 17 (4d6).',
  'PHB 2024',
  'Artífice, Bardo, Druida, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '1d6',
  'Trovejante',
  '[{"level": 5, "dice": "2d6"}, {"level": 11, "dice": "3d6"}, {"level": 17, "dice": "4d6"}]'::jsonb
);

-- Palavra de Radiância
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Palavra de Radiância',
  0,
  'Evocação',
  'Ação',
  'Próprio',
  'V, M (um token de explosão solar)',
  'Instantânea',
  'Um brilho ardente irrompe de você em uma Emanação de 1,5 metro. Cada criatura à sua escolha que você puder ver nela deve ser bem-sucedida em um teste de resistência de Constituição ou sofrer 1d6 de dano Radiante.

Melhoria de Truque. O dano aumenta em 1d6 quando você atinge os níveis 5 (2d6), 11 (3d6) e 17 (4d6).',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '1d6',
  'Radiante',
  '[{"level": 5, "dice": "2d6"}, {"level": 11, "dice": "3d6"}, {"level": 17, "dice": "4d6"}]'::jsonb
);

-- ============================================================
-- ILUSÃO (2 truques)
-- ============================================================

-- Luzes Dançantes
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Luzes Dançantes',
  0,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S, M (um pouco de fósforo)',
  'Concentração, até 1 minuto',
  'Você cria até quatro luzes do tamanho de tochas dentro do alcance, fazendo-as parecer tochas, lanternas ou orbes brilhantes que pairam durante a duração. Alternativamente, você combina as quatro luzes em uma forma Média brilhante que lembra vagamente a humana. Qualquer que seja a forma escolhida, cada luz emite Luz Fraca em um raio de 3 metros.

Como uma Ação Bônus, você pode mover as luzes até 18 metros para um espaço dentro do alcance. Uma luz deve estar a até 6 metros de outra luz criada por esta magia, e uma luz desaparece se exceder o alcance da magia.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Ilusão Menor
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ilusão Menor',
  0,
  'Ilusão',
  'Ação',
  '30 pés',
  'P, M (um pouco de lã)',
  '1 minuto',
  'Você cria um som ou uma imagem de um objeto dentro do alcance que dura enquanto durar a magia. Veja as descrições abaixo para os efeitos de cada um. A ilusão termina se você conjurar esta magia novamente.

Se uma criatura realizar uma ação de Estudo para examinar o som ou a imagem, ela poderá determinar que se trata de uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra sua CD de resistência à magia. Se uma criatura discernir a ilusão pelo que ela é, ela se tornará tênue para a criatura.

Som. Se você criar um som, seu volume pode variar de um sussurro a um grito. Pode ser a sua voz, a voz de outra pessoa, o rugido de um leão, o rufar de tambores ou qualquer outro som que você escolher. O som continua ininterrupto durante toda a duração, ou você pode emitir sons discretos em momentos diferentes antes do fim do feitiço.

Imagem. Se você criar uma imagem de um objeto — como uma cadeira, pegadas na lama ou um pequeno baú — ela não deve ser maior que um cubo de 1,5 metro. A imagem não pode criar som, luz, cheiro ou qualquer outro efeito sensorial. A interação física com a imagem revela que ela é uma ilusão, já que objetos podem passar por ela.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- NECROMANCIA (4 truques)
-- ============================================================

-- Toque Frio
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Toque Frio',
  0,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Canalizando o frio da sepultura, faça um ataque mágico corpo a corpo contra um alvo ao seu alcance. Ao acertar, o alvo sofre 1d10 de dano Necrótico e não pode recuperar Pontos de Vida até o final do seu próximo turno.

Melhoria de Truque. O dano aumenta em 1d10 quando você atinge os níveis 5 (2d10), 11 (3d10) e 17 (4d10).',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '1d10',
  'Necrótico',
  '[{"level": 5, "dice": "2d10"}, {"level": 11, "dice": "3d10"}, {"level": 17, "dice": "4d10"}]'::jsonb
);

-- Spray de Veneno
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Spray de Veneno',
  0,
  'Necromancia',
  'Ação',
  '30 pés',
  'V, S',
  'Instantânea',
  'Você lança névoa tóxica em uma criatura dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 1d12 de dano de Veneno.

Melhoria de Truque. O dano aumenta em 1d12 quando você atinge os níveis 5 (2d12), 11 (3d12) e 17 (4d12).',
  'PHB 2024',
  'Artífice, Druida, Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '1d12',
  'Veneno',
  '[{"level": 5, "dice": "2d12"}, {"level": 11, "dice": "3d12"}, {"level": 17, "dice": "4d12"}]'::jsonb
);

-- Poupe os Moribundos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Poupe os Moribundos',
  0,
  'Necromancia',
  'Ação',
  '15 pés',
  'V, S',
  'Instantânea',
  'Escolha uma criatura dentro do alcance que tenha 0 Pontos de Vida e não esteja morta. A criatura se torna Estável.

Melhoria de Truque. O alcance dobra ao atingir os níveis 5 (9 metros), 11 (18 metros) e 17 (36 metros).',
  'PHB 2024',
  'Artífice, Clérigo, Druida',
  false,
  false
);

-- Toll the Dead
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Toll the Dead',
  0,
  'Necromancia',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você aponta para uma criatura visível dentro do alcance, e o toque único de um sino doloroso é audível a até 3 metros do alvo. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou sofrerá 1d8 de dano Necrótico. Se o alvo não tiver nenhum Ponto de Vida, ele sofrerá 1d12 de dano Necrótico.

Melhoria de Truque. O dano aumenta em um dado quando você atinge os níveis 5 (2d8 ou 2d12), 11 (3d8 ou 3d12) e 17 (4d8 ou 4d12).',
  'PHB 2024',
  'Clérigo, Bruxo, Mago',
  false,
  false,
  'damage',
  '1d8',
  'Necrótico',
  '[{"level": 5, "dice": "2d8"}, {"level": 11, "dice": "3d8"}, {"level": 17, "dice": "4d8"}]'::jsonb
);

-- ============================================================
-- TRANSMUTAÇÃO (7 truques)
-- ============================================================

-- Druidismo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Druidismo',
  0,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S',
  'Instantânea',
  'Sussurrando aos espíritos da natureza, você cria um dos seguintes efeitos dentro do alcance.

Sensor de Clima. Você cria um pequeno efeito sensorial inofensivo que prevê como estará o clima em sua localização nas próximas 24 horas. O efeito pode se manifestar como uma esfera dourada para céu limpo, uma nuvem para chuva, flocos de neve caindo para neve e assim por diante. Este efeito persiste por 1 rodada.

Florescer. Você faz uma flor desabrochar instantaneamente, uma vagem de semente se abrir ou um broto de folha florescer.

Efeito Sensorial. Você cria um efeito sensorial inofensivo, como folhas caindo, fadas dançando espectralmente, uma brisa suave, o som de um animal ou o leve odor de gambá. O efeito deve caber em um Cubo de 1,5 m.

Brincadeira com fogo. Você acende ou apaga uma vela, uma tocha ou uma fogueira.',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- Elementalismo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Elementalismo',
  0,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S',
  'Instantânea',
  'Você exerce controle sobre os elementos, criando um dos seguintes efeitos dentro do alcance.

Chamar o Ar. Você cria uma brisa forte o suficiente para ondular tecidos, levantar poeira, farfalhar folhas e fechar portas e venezianas, tudo em um Cubo de 1,5 m. Portas e venezianas mantidas abertas por alguém ou algo não são afetadas.

Acene para a Terra. Você cria uma fina camada de poeira ou areia que cobre superfícies em uma área de 1,5 metro quadrado, ou faz com que uma única palavra apareça em sua caligrafia em um pedaço de terra ou areia.

Chamar Fogo. Você cria uma nuvem fina de brasas inofensivas e fumaça colorida e perfumada em um Cubo de 1,5 m. Você escolhe a cor e o aroma, e as brasas podem acender velas, tochas ou lamparinas naquela área. O aroma da fumaça permanece por 1 minuto.

Água de Chamado. Você cria um jato de névoa fria que umedece levemente criaturas e objetos em um Cubo de 1,5 m. Alternativamente, você cria 1 xícara de água limpa em um recipiente aberto ou em uma superfície, e a água evapora em 1 minuto.

Esculpir Elemento. Você faz com que terra, areia, fogo, fumaça, névoa ou água que caibam em um Cubo de 30 cm assuma uma forma rudimentar (como a de uma criatura) por 1 hora.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  false
);

-- Remendando
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Remendando',
  0,
  'Transmutação',
  '1 minuto',
  'Toque',
  'V, S, M (duas pedras-ímã)',
  'Instantânea',
  'Esta magia repara uma única quebra ou rasgo em um objeto que você tocar, como um elo de corrente quebrado, duas metades de uma chave quebrada, uma capa rasgada ou um odre com vazamento. Contanto que a quebra ou rasgo não seja maior que 30 centímetros em qualquer dimensão, você o conserta, sem deixar vestígios do dano anterior.

Este feitiço pode reparar fisicamente um item mágico, mas não pode restaurar a magia de tal objeto.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Feiticeiro, Mago',
  false,
  false
);

-- Mensagem
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mensagem',
  0,
  'Transmutação',
  'Ação',
  '120 pés',
  'S, M (um fio de cobre)',
  '1 rodada',
  'Você aponta para uma criatura dentro do alcance e sussurra uma mensagem. O alvo (e somente ele) ouve a mensagem e pode responder em um sussurro que só você consegue ouvir.

Você pode lançar este feitiço através de objetos sólidos se estiver familiarizado com o alvo e souber que ele está além da barreira. Silêncio mágico; 30 centímetros de pedra, metal ou madeira; ou uma fina camada de chumbo bloqueiam o feitiço.',
  'PHB 2024',
  'Artífice, Bardo, Druida, Feiticeiro, Mago',
  false,
  false
);

-- Prestidigitação
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Prestidigitação',
  0,
  'Transmutação',
  'Ação',
  '10 pés',
  'V, S',
  '1 hora',
  'Você cria um efeito mágico dentro do alcance. Escolha o efeito entre as opções abaixo. Se você conjurar esta magia várias vezes, poderá ter até três de seus efeitos não instantâneos ativos simultaneamente.

Efeito Sensorial. Você cria um efeito sensorial instantâneo e inofensivo, como uma chuva de faíscas, uma rajada de vento, notas musicais suaves ou um odor estranho.

Brincadeira com Fogo. Você acende ou apaga instantaneamente uma vela, uma tocha ou uma pequena fogueira.

Limpar ou Sujar. Você limpa ou suja instantaneamente um objeto de até 30 cm³.

Sensação Menor. Você resfria, aquece ou dá sabor a até 30 cm cúbicos de material inanimado por 1 hora.

Marca Mágica. Você faz uma cor, uma pequena marca ou um símbolo aparecer em um objeto ou superfície por 1 hora.

Criação Menor. Você cria um berloque não mágico ou uma imagem ilusória que cabe na sua mão. Ele dura até o final do seu próximo turno. Um berloque não causa dano e não tem valor monetário.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Shillelagh
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Shillelagh',
  0,
  'Transmutação',
  'Ação Bônus',
  'Próprio',
  'V, S, M (visco)',
  '1 minuto',
  'Uma clava ou cajado que você esteja segurando está imbuído do poder da natureza. Durante a duração, você pode usar sua habilidade de conjuração em vez de Força para as jogadas de ataque e dano de ataques corpo a corpo usando aquela arma, e o dado de dano da arma se torna um d8. Se o ataque causar dano, ele pode ser de Força ou do tipo de dano normal da arma (à sua escolha).

O feitiço termina mais cedo se você conjurá-lo novamente ou se soltar a arma.

Melhoria de Truque. O dado de dano muda quando você atinge os níveis 5 (d10), 11 (d12) e 17 (2d6).',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- Taumaturgia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Taumaturgia',
  0,
  'Transmutação',
  'Ação',
  '30 pés',
  'V',
  '1 minuto',
  'Você manifesta uma pequena maravilha dentro do alcance. Você cria um dos efeitos abaixo dentro do alcance. Se conjurar esta magia várias vezes, você pode ter até três dos seus efeitos de 1 minuto ativos simultaneamente.

Olhos Alterados. Você altera a aparência dos seus olhos por 1 minuto.

Voz Estrondosa. Sua voz fica até três vezes mais alta que o normal por 1 minuto. Durante esse tempo, você tem Vantagem em testes de Carisma (Intimidação).

Brincadeira com Fogo. Você faz as chamas piscarem, aumentarem de intensidade, diminuírem de intensidade ou mudarem de cor por 1 minuto.

Mão Invisível. Você faz com que uma porta ou janela destrancada se abra ou feche instantaneamente.

Som Fantasma. Você cria um som instantâneo que se origina de um ponto à sua escolha dentro do alcance, como o estrondo de um trovão, o grito de um corvo ou sussurros ameaçadores.

Tremores. Você causa tremores inofensivos no chão por 1 minuto.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- Chicote de Espinhos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "cantrip_dice_increases"
) VALUES (
  'Chicote de Espinhos',
  0,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (o caule de uma planta com espinhos)',
  'Instantânea',
  'Você cria um chicote em forma de videira coberto de espinhos que, ao seu comando, chicoteia em direção a uma criatura ao seu alcance. Realize um ataque mágico corpo a corpo contra o alvo. Ao acertar, o alvo sofre 1d6 de dano Perfurante e, se for Grande ou menor, você pode puxá-lo até 3 metros mais perto de você.

Melhoria de Truque. O dano aumenta em 1d6 quando você atinge os níveis 5 (2d6), 11 (3d6) e 17 (4d6).',
  'PHB 2024',
  'Artífice, Druida',
  false,
  false,
  'damage',
  '1d6',
  'Perfurante',
  '[{"level": 5, "dice": "2d6"}, {"level": 11, "dice": "3d6"}, {"level": 17, "dice": "4d6"}]'::jsonb
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantos truques foram inseridos
SELECT 
  'Truques inseridos com sucesso!' as status,
  COUNT(*) as total_truques
FROM spells 
WHERE level = 0 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 0 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- ============================================================
-- FIM DO SCRIPT
-- ============================================================
