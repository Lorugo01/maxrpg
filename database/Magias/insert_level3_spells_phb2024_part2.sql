-- ============================================================
-- MAGIAS DE 3º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: 40 magias adicionais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (4 magias adicionais)
-- ============================================================

-- Dissipar Magia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dissipar Magia',
  3,
  'Abjuração',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Escolha uma criatura, objeto ou efeito mágico dentro do alcance. Qualquer magia em andamento de nível 3 ou inferior no alvo termina. Para cada magia em andamento de nível 4 ou superior no alvo, faça um teste de habilidade usando sua habilidade de conjuração (CD 10 mais o nível da magia). Em caso de sucesso, a magia termina.

Usando um Espaço de Magia de Nível Superior. Você encerra automaticamente uma magia no alvo se o nível da magia for igual ou inferior ao nível do espaço de magia que você usa.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Paladino, Patrulheiro, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Círculo Mágico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Círculo Mágico',
  3,
  'Abjuração',
  '1 minuto',
  '10 pés',
  'V, S, M (sal e prata em pó valendo mais de 100 GP, que a magia consome)',
  '1 hora',
  'Você cria um Cilindro de energia mágica com 3 metros de raio e 6 metros de altura, centrado em um ponto no chão visível ao seu alcance. Runas brilhantes aparecem onde quer que o Cilindro intersecte o chão ou outra superfície.

Escolha um ou mais dos seguintes tipos de criaturas: Celestiais, Elementais, Fadas, Demônios ou Mortos-vivos. O círculo afeta uma criatura do tipo escolhido das seguintes maneiras:

- A criatura não pode entrar no Cilindro por meios não mágicos. Se a criatura tentar usar teletransporte ou viagem interplanar para isso, ela deve primeiro obter sucesso em um teste de resistência de Carisma.
- A criatura tem Desvantagem em jogadas de ataque contra alvos dentro do Cilindro.
- Alvos dentro do Cilindro não podem ser possuídos ou receber a condição Encantado ou Assustado da criatura.

Cada vez que você conjura esta magia, você pode fazer com que sua magia opere na direção reversa, impedindo que uma criatura do tipo especificado saia do Cilindro e protegendo alvos fora dele.

Usando um Espaço de Magia de Nível Superior. A duração aumenta em 1 hora para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Clérigo, Paladino, Bruxo, Mago',
  false,
  false,
  '1 hora'
);

-- Não Detecção
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Não Detecção',
  3,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (uma pitada de pó de diamante que vale mais de 25 GP, que a magia consome)',
  '8 horas',
  'Durante a duração, você oculta um alvo que tocar de magias de Adivinhação. O alvo pode ser uma criatura disposta ou um lugar ou objeto com no máximo 3 metros de altura em qualquer dimensão. O alvo não pode ser alvo de nenhuma magia de Adivinhação nem ser percebido por sensores de vidência mágica.',
  'PHB 2024',
  'Bardo, Patrulheiro, Mago',
  false,
  false
);

-- Proteção contra Energia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Proteção contra Energia',
  3,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 hora',
  'Durante a duração, a criatura voluntária que você tocar terá Resistência a um tipo de dano de sua escolha: Ácido, Frio, Fogo, Relâmpago ou Trovão.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  true
);

-- Remover Maldição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Remover Maldição',
  3,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Ao seu toque, todas as maldições que afetam uma criatura ou objeto cessam. Se o objeto for um item mágico amaldiçoado, sua maldição permanece, mas a magia quebra a Sintonização do seu dono com o objeto, permitindo que ele seja removido ou descartado.',
  'PHB 2024',
  'Clérigo, Paladino, Bruxo, Mago',
  false,
  false
);

-- Glifo de Proteção
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Glifo de Proteção',
  3,
  'Abjuração',
  '1 hora',
  'Toque',
  'V, S, M (diamante em pó que vale mais de 200 GP, que a magia consome)',
  'Até ser dissipado ou acionado',
  'Você inscreve um glifo que posteriormente libera um efeito mágico. Você o inscreve em uma superfície (como uma mesa ou um pedaço de chão) ou dentro de um objeto que possa ser fechado (como um livro ou um baú) para ocultar o glifo. O glifo pode cobrir uma área de até 3 metros de diâmetro. Se a superfície ou o objeto for movido a mais de 3 metros de onde você conjurou a magia, o glifo é quebrado e a magia termina sem ser ativada.

O glifo é quase imperceptível e requer um teste bem-sucedido de Sabedoria (Percepção) contra sua CD de resistência à magia para ser notado.

Ao inscrever o glifo, você define seu gatilho e escolhe se ele é uma runa explosiva ou um glifo de feitiço.

Runa Explosiva. Quando acionada, o glifo irrompe com energia mágica em uma Esfera de 6 metros de raio centrada no glifo. Cada criatura na área realiza um teste de resistência de Destreza. Uma criatura sofre 5d8 de dano de Ácido, Frio, Fogo, Raio ou Trovão (à sua escolha ao criar o glifo) em uma falha na resistência ou metade desse dano em um sucesso.

Glifo de Magia. Você pode armazenar uma magia preparada de nível 3 ou inferior no glifo, conjurando-a como parte da criação do glifo.

Usando um Espaço de Magia de Nível Superior. O dano de uma runa explosiva aumenta em 1d8 para cada nível de espaço de magia acima de 3. Se você criar um glifo de magia, poderá armazenar qualquer magia de até o mesmo nível do espaço de magia usado para o Glifo de Proteção.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Mago',
  false,
  false,
  'damage',
  '5d8',
  'Variável',
  '1d8'
);

-- ============================================================
-- ADIVINHAÇÃO (2 magias adicionais)
-- ============================================================

-- Enviando
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Enviando',
  3,
  'Adivinhação',
  'Ação',
  'Ilimitado',
  'V, S, M (um fio de cobre)',
  'Instantânea',
  'Você envia uma mensagem curta de 25 palavras ou menos para uma criatura que você conheceu ou para uma criatura descrita a você por alguém que a conheceu. O alvo ouve a mensagem em sua mente, reconhece você como o remetente, se o conhece, e pode responder da mesma forma imediatamente. A magia permite que os alvos entendam o significado da sua mensagem.

Você pode enviar a mensagem a qualquer distância e até mesmo para outros planos de existência, mas se o alvo estiver em um plano diferente do seu, há 5% de chance de a mensagem não chegar. Você sabe se a entrega falha.

Ao receber sua mensagem, uma criatura pode bloquear sua habilidade de contatá-la novamente com esta magia por 8 horas. Se você tentar enviar outra mensagem durante esse período, descobrirá que está bloqueado e a magia falhará.',
  'PHB 2024',
  'Bardo, Clérigo, Mago',
  false,
  false
);

-- Línguas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Línguas',
  3,
  'Adivinhação',
  'Ação',
  'Toque',
  'V, M (um zigurate em miniatura)',
  '1 hora',
  'Esta magia concede à criatura que você tocar a habilidade de entender qualquer língua falada ou de sinais que ela ouça ou veja. Além disso, quando o alvo se comunica falando ou gesticulando, qualquer criatura que conheça pelo menos um idioma pode entendê-lo se puder ouvir a fala ou ver a linguagem de sinais.',
  'PHB 2024',
  'Bardo, Clérigo, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- CONJURAÇÃO (6 magias adicionais)
-- ============================================================

-- Criar Comida e Água
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Criar Comida e Água',
  3,
  'Conjuração',
  'Ação',
  '30 pés',
  'V, S',
  'Instantânea',
  'Você cria 20 kg de comida e 125 litros de água fresca no chão ou em recipientes ao seu alcance — ambos úteis para evitar os perigos da desnutrição e da desidratação. A comida é insossa, mas nutritiva, e parece um alimento de sua escolha, e a água é limpa. A comida estraga após 24 horas se não for consumida.',
  'PHB 2024',
  'Artífice, Clérigo, Paladino',
  false,
  false
);

-- Tempestade de Granizo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Tempestade de Granizo',
  3,
  'Conjuração',
  'Ação',
  '150 pés',
  'V, S, M (um guarda-chuva em miniatura)',
  'Concentração, até 1 minuto',
  'Até o fim do feitiço, granizo cai em um Cilindro de 12 metros de altura e 6 metros de raio, centrado em um ponto à sua escolha dentro do alcance. A área fica Fortemente Obscura e as chamas expostas são apagadas.

O Terreno no Cilindro é um Terreno Difícil. Quando uma criatura entra no Cilindro pela primeira vez em um turno ou inicia seu turno lá, ela deve ser bem-sucedida em um teste de resistência de Destreza ou terá a condição Caído e perderá Concentração.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true
);

-- Guardiões Espirituais
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Guardiões Espirituais',
  3,
  'Conjuração',
  'Ação',
  'Próprio',
  'V, S, M (um pergaminho de oração)',
  'Concentração, até 10 minutos',
  'Espíritos protetores flutuam ao seu redor em uma Emanação de 4,5 metros durante a duração. Se você for bom ou neutro, a forma espectral deles parecerá angelical ou feérica (à sua escolha). Se você for mau, eles parecerão diabólicos.

Ao conjurar esta magia, você pode designar criaturas para não serem afetadas por ela. A Velocidade de qualquer outra criatura é reduzida pela metade na Emanação, e sempre que a Emanação entrar no espaço de uma criatura e sempre que uma criatura entrar na Emanação ou terminar seu turno lá, a criatura deve realizar um teste de resistência de Sabedoria. Em caso de falha, a criatura sofre 3d8 de dano Radiante (se você for bom ou neutro) ou 3d8 de dano Necrótico (se você for mau). Em caso de sucesso, a criatura sofre metade do dano. Uma criatura realiza este teste apenas uma vez por turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Clérigo',
  false,
  true,
  'damage',
  '3d8',
  'Radiante/Necrótico',
  '1d8'
);

-- Nuvem Fedorenta
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Nuvem Fedorenta',
  3,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (um ovo podre)',
  'Concentração, até 1 minuto',
  'Você cria uma Esfera de gás amarelo e nauseante com 6 metros de raio, centrada em um ponto dentro do alcance. A nuvem fica Fortemente Obscura. A nuvem permanece no ar enquanto durar o efeito ou até que um vento forte (como o criado por Rajada de Vento) a disperse.

Cada criatura que inicia seu turno na Esfera deve ser bem-sucedida em um teste de resistência de Constituição ou permanecerá na condição Envenenada até o final do turno atual. Enquanto estiver Envenenada dessa forma, a criatura não pode realizar nenhuma ação ou Ação Bônus.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Invocar Fadas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Fadas',
  3,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (uma flor dourada que vale mais de 300 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito Feérico. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Feérico. Ao conjurar a magia, escolha um humor: Furioso, Alegre ou Astuto. A criatura se assemelha a uma criatura Feérica de sua escolha, marcada pelo humor escolhido, que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Druida, Patrulheiro, Bruxo, Mago',
  false,
  true
);

-- Invocar Mortos-Vivos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Mortos-Vivos',
  3,
  'Necromancia',
  'Ação',
  '90 pés',
  'V, S, M (uma caveira dourada que vale mais de 300 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito morto-vivo. Ele se manifesta em um espaço desocupado visível ao seu alcance e usa o bloco de atributos Espírito Morto-Vivo. Ao conjurar a magia, escolha a forma da criatura: Fantasmagórica, Pútrida ou Esquelética. O espírito se assemelha a uma criatura morta-viva com a forma escolhida, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true
);

-- Continua na próxima parte...
