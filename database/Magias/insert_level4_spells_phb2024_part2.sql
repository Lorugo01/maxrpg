-- ============================================================
-- MAGIAS DE 4º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: Conjuração, Encantamento, Evocação
-- ============================================================

-- ============================================================
-- CONJURAÇÃO (11 magias)
-- ============================================================

-- Porta Dimensional
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Porta Dimensional',
  4,
  'Conjuração',
  'Ação',
  '500 pés',
  'V',
  'Instantânea',
  'Você se teletransporta para um local dentro do alcance. Você chega exatamente ao ponto desejado. Pode ser um lugar que você possa ver, visualizar ou descrever, indicando distância e direção, como "60 metros em linha reta para baixo" ou "90 metros para cima, a noroeste, em um ângulo de 45 graus".

Você também pode teletransportar uma criatura disposta. A criatura deve estar a até 1,5 metro de você quando você se teletransportar, e ela se teletransportará para um espaço a até 1,5 metro do seu espaço de destino.

Se você, a outra criatura ou ambos chegarem em um espaço ocupado por uma criatura ou completamente preenchido por um ou mais objetos, você e qualquer criatura viajando com você sofrerão 4d6 de dano de Força cada, e o teletransporte falhará.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Conjurar Elementais Menores
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Elementais Menores',
  4,
  'Conjuração',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura espíritos dos Planos Elementais que flutuam ao seu redor em uma Emanação de 4,5 metros enquanto durar a magia. Até o fim da magia, qualquer ataque que você fizer causa 2d8 de dano extra ao atingir uma criatura na Emanação. Esse dano pode ser Ácido, Frio, Fogo ou Relâmpago (à sua escolha ao realizar o ataque).

Além disso, o terreno na Emanação é um terreno difícil para seus inimigos.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Mago',
  false,
  true,
  'damage',
  '2d8',
  'Variável',
  '1d8'
);

-- Conjurar Seres da Floresta
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Seres da Floresta',
  4,
  'Conjuração',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura espíritos da natureza que flutuam ao seu redor em uma Emanação de 3 metros durante a duração. Sempre que a Emanação entrar no espaço de uma criatura que você possa ver e sempre que uma criatura que você possa ver entrar na Emanação ou terminar seu turno lá, você pode forçar essa criatura a realizar um teste de resistência de Sabedoria. A criatura sofre 5d8 de dano de Força em uma falha ou metade desse dano em um sucesso. Uma criatura realiza esse teste apenas uma vez por turno.

Além disso, você pode realizar a ação Desengajar como uma Ação Bônus durante a duração da magia.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true,
  'damage',
  '5d8',
  'Força',
  '1d8'
);

-- Tentáculos Negros de Evard
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Tentáculos Negros de Evard',
  4,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um tentáculo)',
  'Concentração, até 1 minuto',
  'Tentáculos de ébano se contorcendo preenchem um quadrado de 6 metros no chão que você pode ver dentro do alcance. Enquanto durar, esses tentáculos transformam o chão naquela área em Terreno Difícil.

Cada criatura naquela área realiza um teste de resistência de Força. Em caso de falha, ela sofre 3d6 de dano de Concussão e permanece na condição de Reprimido até o fim da magia. Uma criatura também realiza esse teste se entrar na área ou terminar seu turno ali. Uma criatura realiza esse teste apenas uma vez por turno.

Uma criatura contida pode realizar uma ação para fazer um teste de Força (Atletismo) contra sua CD de resistência à magia, encerrando a condição em si mesma em caso de sucesso.',
  'PHB 2024',
  'Mago',
  false,
  true,
  'damage',
  '3d6',
  'Concussão'
);

-- Inseto Gigante
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Inseto Gigante',
  4,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você invoca uma centopeia, aranha ou vespa gigante (escolhida ao conjurar a magia). Ela se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Inseto Gigante. A forma escolhida determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Druida',
  false,
  true
);

-- Videira Agarradora
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Videira Agarradora',
  4,
  'Conjuração',
  'Ação Bônus',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Você conjura uma videira que brota de uma superfície em um espaço desocupado que você possa ver dentro do alcance. A videira dura enquanto durar o efeito.

Faça um ataque mágico corpo a corpo contra uma criatura a até 9 metros da videira. Ao acertar, o alvo sofre 4d8 de dano Contundente e é puxado até 9 metros em direção à videira; se o alvo for Enorme ou menor, ele tem a condição Agarrado (CD de fuga igual à sua CD de resistência à magia). A videira pode agarrar apenas uma criatura por vez, e você pode fazer com que ela solte uma criatura Agarrada (nenhuma ação necessária).

Como uma Ação Bônus em seus turnos posteriores, você pode repetir o ataque contra uma criatura a até 9 metros da videira.

Usando um Espaço de Magia de Nível Superior. O número de criaturas que a videira pode agarrar aumenta em um para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true,
  'damage',
  '4d8',
  'Contundente',
  '1 criatura'
);

-- Guardião da Fé
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "damage_type"
) VALUES (
  'Guardião da Fé',
  4,
  'Conjuração',
  'Ação',
  '30 pés',
  'V',
  '8 horas',
  'Um guardião espectral Grande aparece e paira durante a duração em um espaço desocupado que você possa ver dentro do alcance. O guardião ocupa esse espaço e é invulnerável, aparecendo em uma forma apropriada para sua divindade ou panteão.

Qualquer inimigo que se mova para um espaço a até 3 metros do guardião pela primeira vez em um turno ou inicie seu turno ali realiza um teste de resistência de Destreza, sofrendo 20 de dano Radiante em caso de falha ou metade desse dano em caso de sucesso. O guardião desaparece quando tiver causado um total de 60 de dano.',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  'Radiante'
);

-- Baú Secreto de Leomund
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Baú Secreto de Leomund',
  4,
  'Conjuração',
  'Ação',
  'Toque',
  'V, S, M (um baú de 90 cm x 60 cm x 60 cm, construído com materiais raros que valem mais de 5.000 GP, e uma réplica minúscula do baú feita com os mesmos materiais que vale mais de 50 GP)',
  'Até ser dissipado',
  'Você esconde um baú e todo o seu conteúdo no Plano Etéreo. Você deve tocar no baú e na réplica em miniatura que servem como componentes materiais para a magia. O baú pode conter até 3,6 metros cúbicos de matéria inanimada (90 cm x 60 cm x 60 cm).

Enquanto o baú permanecer no Plano Etéreo, você pode realizar uma ação de Magia e tocar na réplica para chamá-lo de volta. Ele aparece em um espaço desocupado no chão a até 1,5 metro de você. Você pode enviar o baú de volta ao Plano Etéreo realizando uma ação de Magia para tocar no baú e na réplica.

Após 60 dias, há uma chance cumulativa de 5% de que a magia termine ao final de cada dia. A magia também termina se você conjurar esta magia novamente ou se o baú réplica minúsculo for destruído. Se a magia terminar e o baú maior estiver no Plano Etéreo, o baú permanece lá para você ou outra pessoa encontrar.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  false
);

-- O Cão Fiel de Mordenkainen
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "damage_type"
) VALUES (
  'O Cão Fiel de Mordenkainen',
  4,
  'Conjuração',
  'Ação',
  '30 pés',
  'V, S, M (um apito prateado)',
  '8 horas',
  'Você conjura um cão de guarda fantasma em um espaço desocupado que você possa ver dentro do alcance. O cão permanece ali enquanto durar a ação ou até que vocês dois estejam a mais de 90 metros de distância um do outro.

Ninguém além de você pode ver o cão, e ele é intangível e invulnerável. Quando uma criatura pequena ou maior se aproxima a 9 metros dele sem primeiro dizer a senha que você especificou ao conjurar esta magia, o cão começa a latir alto. O cão possui Visão Verdadeira com alcance de 9 metros.

No início de cada um dos seus turnos, o cão tenta morder um inimigo a até 1,5 metro de distância. Esse inimigo deve ser bem-sucedido em um teste de resistência de Destreza ou sofrer 4d8 de dano de Força.

Em seus turnos posteriores, você pode realizar uma ação de Magia para mover o cão até 9 metros.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  false,
  'damage',
  'Força'
);

-- Invocar Aberração
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Aberração',
  4,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um tentáculo em conserva e um globo ocular em um frasco incrustado de platina que vale mais de 400 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito aberrante. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Aberrante. Ao conjurar a magia, escolha Beholderkin, Devorador de Mentes ou Slaad. A criatura se assemelha a uma Aberração desse tipo, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, ela compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true
);

-- Invocar Construto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Construto',
  4,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um cofre que vale mais de 400 GP)',
  'Concentração, até 1 hora',
  'Você invoca o espírito de um Construto. Ele se manifesta em um espaço desocupado que você possa ver dentro do alcance e usa o bloco de atributos Espírito do Construto. Ao conjurar a magia, escolha um material: Argila, Metal ou Pedra. A criatura se assemelha a uma estátua animada (você determina a aparência) feita do material escolhido, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  true
);

-- Invocar Elemental
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Elemental',
  4,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (ar, uma pedra, cinzas e água dentro de um frasco incrustado de ouro que vale mais de 400 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito Elemental. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Elemental. Ao conjurar a magia, escolha um elemento: Ar, Terra, Fogo ou Água. A criatura se assemelha a uma forma bípede envolta no elemento escolhido, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Druida, Patrulheiro, Mago',
  false,
  true
);

-- ============================================================
-- ENCANTAMENTO (4 magias)
-- ============================================================

-- Monstro Encantado
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Monstro Encantado',
  4,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S',
  '1 hora',
  'Uma criatura que você possa ver dentro do alcance realiza um teste de resistência de Sabedoria. Ele o faz com Vantagem se você ou seus aliados estiverem lutando contra ela. Em caso de falha, o alvo permanece na condição Encantado até que a magia termine ou até que você ou seus aliados causem dano a ela. A criatura Encantada é Amistosa com você. Quando a magia termina, o alvo sabe que foi Encantado por você.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Bardo, Druida, Feiticeiro, Bruxo, Mago',
  false,
  false,
  '1 criatura'
);

-- Compulsão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Compulsão',
  4,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Cada criatura de sua escolha que você puder ver dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria ou permanecer na condição Encantado até que a magia termine.

Durante a duração, você pode realizar uma Ação Bônus para designar uma direção horizontal em relação a você. Cada alvo Encantado deve usar o máximo de seu movimento possível para se mover nessa direção no próximo turno, seguindo a rota mais segura. Após se mover dessa maneira, o alvo repete o teste de resistência, encerrando a magia sobre si mesmo em caso de sucesso.',
  'PHB 2024',
  'Bardo',
  false,
  true
);

-- Confusão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Confusão',
  4,
  'Encantamento',
  'Ação',
  '90 pés',
  'V, S, M (três cascas de nozes)',
  'Concentração, até 1 minuto',
  'Cada criatura em uma Esfera de 3 metros de raio centrada em um ponto escolhido dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria, ou o alvo não pode realizar Ações ou Reações Bônus e deve rolar 1d10 no início de cada um de seus turnos para determinar seu comportamento naquele turno.

1d10 | Comportamento
1 | O alvo não realiza nenhuma ação e usa todo o seu movimento para se movimentar aleatoriamente.
2-6 | O alvo não se move nem realiza nenhuma ação.
7-8 | O alvo realiza a ação de Ataque contra uma criatura aleatória ao seu alcance.
9-10 | O alvo escolhe seu comportamento.

No final de cada um dos seus turnos, um alvo afetado repete a defesa, encerrando a magia sobre si mesmo em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. O raio da Esfera aumenta em 1,5 metro para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Bardo, Druida, Feiticeiro, Mago',
  false,
  true
);

-- Dominar a Besta
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dominar a Besta',
  4,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma Besta visível dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria ou permanecer na condição Encantado durante o período. O alvo tem Vantagem no teste se você ou seus aliados estiverem lutando contra ele. Sempre que o alvo sofrer dano, ele repete o teste, encerrando a magia sobre si mesmo em caso de sucesso.

Você tem um vínculo telepático com o alvo Encantado enquanto ambos estiverem no mesmo plano de existência. No seu turno, você pode usar esse vínculo para emitir comandos ao alvo (nenhuma ação necessária), como "Ataque aquela criatura", "Vá até lá" ou "Pegue aquele objeto". O alvo faz o possível para obedecer no seu turno.

Você pode comandar o alvo para realizar uma Reação, mas deve realizar sua própria Reação para fazer isso.

Usando um Espaço de Magia de Nível Superior. Sua Concentração pode durar mais com um espaço de magia de nível 5 (até 10 minutos), 6 (até 1 hora) ou 7+ (até 8 horas).',
  'PHB 2024',
  'Druida, Patrulheiro, Feiticeiro',
  false,
  true
);

-- Continua na parte 3...
