-- ============================================================
-- MAGIAS DE 3º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final: Evocação, Ilusão, Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- EVOCAÇÃO (5 magias)
-- ============================================================

-- Bola de Fogo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Bola de Fogo',
  3,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (uma bola de guano de morcego e enxofre)',
  'Instantânea',
  'Um raio brilhante pisca de você para um ponto que você escolher dentro do alcance e então floresce com um rugido baixo em uma explosão flamejante. Cada criatura em uma Esfera de 6 metros de raio centrada naquele ponto realiza um teste de resistência de Destreza, sofrendo 8d6 de dano de Fogo em caso de falha ou metade desse dano em caso de sucesso.

Objetos inflamáveis na área que não estejam sendo usados ou carregados começam a queimar.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '8d6',
  'Fogo',
  '1d6'
);

-- Relâmpago
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Relâmpago',
  3,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S, M (um pedaço de pelo e uma haste de cristal)',
  'Instantânea',
  'Um raio, formando uma Linha de 30 metros de comprimento e 1,5 metro de largura, parte de você na direção que você escolher. Cada criatura na Linha realiza um teste de resistência de Destreza, sofrendo 8d6 de dano de Raio em caso de falha ou metade desse dano em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '8d6',
  'Elétrico',
  '1d6'
);

-- Luz do Dia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Luz do Dia',
  3,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S',
  '1 hora',
  'Durante a duração, a luz solar se espalha de um ponto dentro do alcance e preenche uma Esfera de 18 metros de raio. A área da luz solar é Luz Brilhante e emite Luz Fraca por mais 18 metros.

Alternativamente, você lança a magia em um objeto que não está sendo usado ou carregado, fazendo com que a luz do sol preencha uma Emanação de 18 metros originada daquele objeto. Cobrir esse objeto com algo opaco, como uma tigela ou elmo, bloqueia a luz do sol.

Se qualquer área desta magia se sobrepuser a uma área de Escuridão criada por uma magia de nível 3 ou inferior, essa outra magia será dissipada.',
  'PHB 2024',
  'Clérigo, Druida, Paladino, Patrulheiro, Feiticeiro',
  false,
  false
);

-- A Pequena Cabana de Leomund
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'A Pequena Cabana de Leomund',
  3,
  'Evocação',
  '1 minuto',
  'Próprio',
  'V, S, M (uma conta de cristal)',
  '8 horas',
  'Uma Emanação de 3 metros surge ao seu redor e permanece imóvel enquanto durar o efeito. A magia falha ao ser conjurada se a Emanação não for grande o suficiente para encapsular completamente todas as criaturas em sua área.

Criaturas e objetos dentro da Emanação podem se mover livremente quando você conjura a magia. Todas as outras criaturas e objetos são impedidos de passar por ela. Magias de nível 3 ou inferior não podem ser conjuradas através dela, e os efeitos de tais magias não podem se estender para dentro dela.

A atmosfera dentro da Emanação é confortável e seca, independentemente do clima externo. Até o fim do feitiço, você pode comandar o interior para ter Luz Fraca ou Escuridão (nenhuma ação necessária). A Emanação é opaca por fora e de qualquer cor que você escolher, mas é transparente por dentro.

O feitiço termina mais cedo se você deixar a Emanação ou se conjurá-lo novamente.',
  'PHB 2024',
  'Bardo, Mago',
  true,
  false
);

-- Parede de Vento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Parede de Vento',
  3,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (um leque e uma pena)',
  'Concentração, até 1 minuto',
  'Uma parede de vento forte se ergue do chão em um ponto à sua escolha, dentro do alcance. Você pode construir a parede com até 15 metros de comprimento, 4,5 metros de altura e 30 centímetros de espessura. Você pode moldar a parede da forma que quiser, desde que ela crie um caminho contínuo ao longo do chão. A parede dura enquanto durar.

Quando a parede aparece, cada criatura em sua área faz um teste de resistência de Força, sofrendo 4d8 de dano de Concussão em uma falha ou metade do dano em uma sucesso.

O vento forte mantém a neblina, a fumaça e outros gases afastados. Criaturas ou objetos voadores, pequenos ou menores, não conseguem atravessar a muralha. Materiais leves e soltos trazidos para dentro da muralha voam para cima. Flechas, virotes e outros projéteis comuns lançados contra alvos atrás da muralha são desviados para cima e erram automaticamente. Pedregulhos lançados por Gigantes ou máquinas de cerco, e projéteis semelhantes, não são afetados. Criaturas em forma gasosa não conseguem atravessá-la.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true,
  'damage',
  '4d8',
  'Concussão'
);

-- ============================================================
-- ILUSÃO (5 magias)
-- ============================================================

-- Temer
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Temer',
  3,
  'Ilusão',
  'Ação',
  'Próprio',
  'V, S, M (uma pena branca)',
  'Concentração, até 1 minuto',
  'Cada criatura em um Cone de 9 metros deve ser bem-sucedida em um teste de resistência de Sabedoria ou largar o que estiver segurando e permanecer na condição Assustado durante o período.

Uma criatura Amedrontada realiza a ação de Disparada e se afasta de você pela rota mais segura em cada um dos seus turnos, a menos que não haja para onde se mover. Se a criatura terminar seu turno em um espaço onde não tenha linha de visão para você, ela realiza um teste de resistência de Sabedoria. Em caso de sucesso, a magia termina naquela criatura.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Padrão Hipnótico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Padrão Hipnótico',
  3,
  'Ilusão',
  'Ação',
  '120 pés',
  'S, M (uma pitada de confete)',
  'Concentração, até 1 minuto',
  'Você cria um padrão colorido retorcido em um Cubo de 9 metros dentro do alcance. O padrão aparece por um instante e desaparece. Cada criatura na área que puder ver o padrão deve ser bem-sucedida em um teste de resistência de Sabedoria ou ficará com a condição Encantado pela duração. Enquanto estiver Encantado, a criatura ficará com a condição Incapacitado e uma Deslocamento de 0.

A magia termina para uma criatura afetada se ela sofrer qualquer dano ou se outra pessoa usar uma ação para sacudir a criatura de seu estupor.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Imagem Principal
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Imagem Principal',
  3,
  'Ilusão',
  'Ação',
  '120 pés',
  'V, S, M (um pouco de lã)',
  'Concentração, até 10 minutos',
  'Você cria a imagem de um objeto, criatura ou outro fenômeno visível que não seja maior que um Cubo de 6 metros. A imagem aparece em um ponto visível dentro do alcance e permanece enquanto durar a imagem. Parece real, incluindo sons, cheiros e temperaturas apropriados para o objeto retratado, mas não pode causar dano nem causar condições.

Se você estiver dentro do alcance da ilusão, pode realizar uma ação de Magia para fazer com que a imagem se mova para qualquer outro ponto dentro do alcance. Conforme a imagem muda de local, você pode alterar sua aparência para que seus movimentos pareçam naturais para a imagem.

A interação física com a imagem revela que ela é uma ilusão, pois objetos podem passar por ela. Uma criatura que realiza uma ação de Estudo para examinar a imagem pode determinar que ela é uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra sua CD de resistência à magia. Se uma criatura discernir a ilusão pelo que ela é, ela pode ver através da imagem, e suas outras qualidades sensoriais se tornam tênues para ela.

Usando um Espaço de Magia de Nível Superior. A magia dura até ser dissipada, sem exigir Concentração, se conjurada com um espaço de magia de nível 4+.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Corcel Fantasma
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Corcel Fantasma',
  3,
  'Ilusão',
  '1 minuto',
  '30 pés',
  'V, S',
  '1 hora',
  'Uma criatura grande, quase real, semelhante a um cavalo, aparece no chão em um espaço desocupado à sua escolha, dentro do alcance. Você decide a aparência da criatura, e ela é equipada com sela, freio e rédea. Qualquer equipamento criado pela magia desaparece em uma nuvem de fumaça se for carregado a mais de 3 metros de distância do corcel.

Durante a duração da magia, você ou uma criatura à sua escolha pode montar o corcel. O corcel usa o bloco de atributos "Cavalo de Montaria", exceto que tem uma Velocidade de 30 metros e pode viajar 21 quilômetros em uma hora. Quando a magia termina, o corcel desaparece gradualmente, dando ao cavaleiro 1 minuto para desmontar. A magia termina mais cedo se o corcel sofrer algum dano.',
  'PHB 2024',
  'Mago',
  true,
  false
);

-- ============================================================
-- NECROMANCIA (4 magias)
-- ============================================================

-- Fingir Morte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Fingir Morte',
  3,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S, M (uma pitada de terra de cemitério)',
  '1 hora',
  'Você toca uma criatura disposta e a coloca em um estado cataléptico que é indistinguível da morte.

Durante a duração, o alvo parece morto à inspeção externa e aos feitiços usados ​​para determinar seu status. O alvo apresenta as condições Cego e Incapacitado, e sua Velocidade é 0.

O alvo também tem Resistência a todos os danos, exceto dano Psíquico, e tem Imunidade à condição Envenenado.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Mago',
  true,
  false
);

-- Revivificar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Revivificar',
  3,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S, M (um diamante que vale mais de 300 GP, que a magia consome)',
  'Instantânea',
  'Você toca uma criatura que morreu no último minuto. Essa criatura revive com 1 Ponto de Vida. Esta magia não pode reviver uma criatura que morreu de velhice, nem restaura quaisquer partes perdidas do corpo.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Paladino, Patrulheiro',
  false,
  false
);

-- Falar com os Mortos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Falar com os Mortos',
  3,
  'Necromancia',
  'Ação',
  '10 pés',
  'V, S, M (queima de incenso)',
  '10 minutos',
  'Você concede a aparência de vida a um cadáver à sua escolha dentro do alcance, permitindo que ele responda às suas perguntas. O cadáver deve ter uma boca, e esta magia falha se a criatura falecida era morta-viva quando morreu. A magia também falha se o cadáver foi alvo desta magia nos últimos 10 dias.

Até o fim do feitiço, você pode fazer até cinco perguntas ao cadáver. O cadáver sabe apenas o que sabia em vida, incluindo os idiomas que conhecia. As respostas geralmente são breves, enigmáticas ou repetitivas, e o cadáver não é obrigado a oferecer uma resposta verdadeira se você for antagônico a ele ou se ele o reconhecer como inimigo. Este feitiço não devolve a alma da criatura ao seu corpo, apenas o espírito que a anima. Assim, o cadáver não pode aprender novas informações, não compreende nada do que aconteceu desde sua morte e não pode especular sobre eventos futuros.',
  'PHB 2024',
  'Bardo, Clérigo, Mago',
  false,
  false
);

-- Toque Vampírico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Toque Vampírico',
  3,
  'Necromancia',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 1 minuto',
  'O toque da sua mão envolta em sombras pode sugar força vital de outras pessoas para curar seus ferimentos. Faça um ataque mágico corpo a corpo contra uma criatura ao seu alcance. Ao acertar, o alvo sofre 3d6 de dano Necrótico e você recupera Pontos de Vida equivalentes à metade do dano Necrótico causado.

Até que a magia termine, você pode fazer o ataque novamente em cada um dos seus turnos como uma ação de Magia, tendo como alvo a mesma criatura ou uma diferente.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true,
  'damage',
  '3d6',
  'Necrótico',
  '1d6'
);

-- ============================================================
-- TRANSMUTAÇÃO (12 magias)
-- ============================================================

-- Arma Elemental
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Arma Elemental',
  3,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 hora',
  'Uma arma não mágica que você tocar se torna uma arma mágica. Escolha um dos seguintes tipos de dano: Ácido, Frio, Fogo, Relâmpago ou Trovão. Durante a duração, a arma tem um bônus de +1 nas jogadas de ataque e causa 1d4 de dano extra do tipo escolhido ao atingir.

Usando um Espaço de Magia de Nível Superior. Se você usar um espaço de magia de nível 5-6, o bônus nas jogadas de ataque aumenta para +2 e o dano extra aumenta para 2d4. Se você usar um espaço de magia de nível 7+, o bônus aumenta para +3 e o dano extra aumenta para 3d4.',
  'PHB 2024',
  'Artífice, Druida, Paladino, Patrulheiro',
  false,
  true,
  'damage',
  '1d4',
  'Variável'
);

-- Voar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Voar',
  3,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (uma pena)',
  'Concentração, até 10 minutos',
  'Você toca uma criatura disposta. Durante a duração, o alvo ganha Velocidade de Voo de 18 metros e pode pairar. Quando a magia termina, o alvo cai se ainda estiver no ar, a menos que consiga impedir a queda.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Artífice, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Forma Gasosa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Forma Gasosa',
  3,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (um pouco de gaze)',
  'Concentração, até 1 hora',
  'Uma criatura voluntária que você tocar se transforma, junto com tudo o que estiver vestindo e carregando, em uma nuvem enevoada durante a duração. A magia termina no alvo se ele cair para 0 Pontos de Vida ou se ele precisar de uma ação de Magia para encerrar a magia em si mesmo.

Nesta forma, o único método de movimento do alvo é uma Velocidade de Voo de 3 metros, e ele pode pairar. O alvo pode entrar e ocupar o espaço de outra criatura. O alvo tem Resistência a Concussão, Perfuração e Corte; tem Imunidade à condição Caído; e tem Vantagem em testes de resistência de Força, Destreza e Constituição. O alvo pode passar por aberturas estreitas, mas trata líquidos como se fossem superfícies sólidas.

O alvo não pode falar nem manipular objetos, e quaisquer objetos que ele esteja carregando ou segurando não podem ser derrubados, usados ​​ou com os quais se possa interagir de qualquer outra forma. Por fim, o alvo não pode atacar nem conjurar magias.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Pressa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Pressa',
  3,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma lasca de raiz de alcaçuz)',
  'Concentração, até 1 minuto',
  'Escolha uma criatura disposta que você possa ver dentro do alcance. Até o fim da magia, a Velocidade do alvo é dobrada, ele ganha +2 de bônus na Classe de Armadura, tem Vantagem em testes de resistência de Destreza e ganha uma ação adicional em cada um dos seus turnos. Essa ação pode ser usada para realizar apenas as ações de Ataque (apenas um ataque), Disparada, Desengajar, Esconder-se ou Utilizar.

Quando a magia termina, o alvo fica Incapacitado e tem Velocidade 0 até o final do próximo turno, enquanto uma onda de letargia o atinge.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  true
);

-- Lentidão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Lentidão',
  3,
  'Transmutação',
  'Ação',
  '120 pés',
  'V, S, M (uma gota de melaço)',
  'Concentração, até 1 minuto',
  'Você altera o tempo em até seis criaturas à sua escolha em um Cubo de 12 metros dentro do alcance. Cada alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou será afetado pela magia enquanto durar.

A Velocidade do alvo afetado é reduzida pela metade, ele sofre uma penalidade de -2 nos testes de resistência de CA e Destreza e não pode realizar Reações. Em seus turnos, ele pode realizar uma ação ou uma Ação Bônus, não ambas, e pode realizar apenas um ataque se realizar a ação de Ataque. Se ele conjurar uma magia com componente Somático, há 25% de chance de a magia falhar devido ao alvo fazer os gestos da magia muito lentamente.

Um alvo afetado repete a defesa no final de cada um dos seus turnos, encerrando a magia sobre si mesmo em caso de sucesso.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Palavra de Cura em Massa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Palavra de Cura em Massa',
  3,
  'Abjuração',
  'Ação Bônus',
  '60 pés',
  'V',
  'Instantânea',
  'Até seis criaturas de sua escolha que você possa ver dentro do alcance recuperam Pontos de Vida iguais a 2d4 mais seu modificador de habilidade de conjuração.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 1d4 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Bardo, Clérigo',
  false,
  false,
  'healing',
  '2d4',
  true,
  '1d4'
);

-- Fundir-se na Pedra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Fundir-se na Pedra',
  3,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S',
  '8 horas',
  'Você pisa em um objeto ou superfície de pedra grande o suficiente para conter completamente seu corpo, fundindo você e seu equipamento com a pedra durante o efeito. Você precisa tocar a pedra para fazer isso. Nada da sua presença permanece visível ou detectável por sentidos não mágicos.

Enquanto estiver fundido com a pedra, você não pode ver o que acontece fora dela, e quaisquer testes de Sabedoria (Percepção) que você fizer para ouvir sons externos são realizados com Desvantagem. Você permanece ciente da passagem do tempo e pode conjurar magias em si mesmo enquanto estiver fundido na pedra. Você pode usar 1,5 metro de movimento para sair da pedra onde entrou, o que encerra a magia. Caso contrário, você não pode se mover.

Danos físicos leves à pedra não causam dano a você, mas sua destruição parcial ou uma mudança em sua forma (a ponto de você não caber mais nela) expulsa você e causa 6d6 de dano de Força. A destruição completa da pedra (ou transmutação em uma substância diferente) expulsa você e causa 50 de dano de Força. Se expulso, você se move para um espaço desocupado mais próximo de onde entrou pela primeira vez e fica com a condição Caído.',
  'PHB 2024',
  'Clérigo, Druida, Patrulheiro',
  true,
  false
);

-- Crescimento das Plantas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Crescimento das Plantas',
  3,
  'Transmutação',
  'Ação (Crescimento excessivo) ou 8 horas (Enriquecimento)',
  '150 pés',
  'V, S',
  'Instantânea',
  'Este feitiço canaliza vitalidade para as plantas. O tempo de conjuração que você usa determina se o feitiço tem o efeito de Crescimento Excessivo ou Enriquecimento, conforme descrito abaixo.

Crescimento excessivo. Escolha um ponto dentro do alcance. Todas as plantas normais em uma Esfera de 30 metros de raio centrada naquele ponto tornam-se densas e cobertas de vegetação. Uma criatura que se mova por essa área deve gastar 1,2 metro de movimento para cada 30 centímetros que se move. Você pode excluir uma ou mais áreas de qualquer tamanho dentro da área da magia de serem afetadas.

Enriquecimento. Todas as plantas em um raio de 800 metros centralizadas em um ponto dentro do alcance são enriquecidas por 365 dias. As plantas produzem o dobro da quantidade normal de alimento quando colhidas. Elas podem se beneficiar de apenas um Crescimento Vegetal por ano.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro',
  false,
  false
);

-- Falar com as Plantas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Falar com as Plantas',
  3,
  'Transmutação',
  'Ação',
  'Próprio',
  'V, S',
  '10 minutos',
  'Você imbui plantas em uma Emanação imóvel de 9 metros com consciência e animação limitadas, dando a elas a capacidade de se comunicar com você e seguir seus comandos simples. Você pode questionar plantas sobre eventos ocorridos na área da magia no último dia, obtendo informações sobre criaturas que já passaram, clima e outras circunstâncias.

Você também pode transformar terrenos difíceis causados ​​pelo crescimento de plantas (como matagais e vegetação rasteira) em terrenos comuns que duram a duração. Ou você pode transformar terrenos comuns com plantas em terrenos difíceis que duram a duração.

O feitiço não permite que as plantas se desenraízem e se movam, mas elas podem mover seus galhos, gavinhas e caules para você.

Se uma criatura Planta estiver na área, você pode se comunicar com ela como se vocês compartilhassem uma língua comum.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro',
  false,
  false
);

-- Respiração Aquática
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Respiração Aquática',
  3,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma palheta curta)',
  '24 horas',
  'Esta magia concede a até dez criaturas voluntárias à sua escolha, dentro do alcance, a capacidade de respirar debaixo d''água até o fim da magia. As criaturas afetadas também mantêm seu modo normal de respiração.',
  'PHB 2024',
  'Artífice, Druida, Patrulheiro, Feiticeiro, Mago',
  true,
  false
);

-- Caminhada Aquática
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Caminhada Aquática',
  3,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (um pedaço de cortiça)',
  '1 hora',
  'Esta magia concede a habilidade de se mover sobre qualquer superfície líquida — como água, ácido, lama, neve, areia movediça ou lava — como se fosse solo sólido e inofensivo (criaturas que atravessam lava derretida ainda podem sofrer dano do calor). Até dez criaturas voluntárias à sua escolha dentro do alcance ganham esta habilidade enquanto durar a magia.

Um alvo afetado deve realizar uma Ação Bônus para passar da superfície do líquido para o próprio líquido e vice-versa, mas se o alvo cair no líquido, ele passa pela superfície para o líquido abaixo.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Patrulheiro, Feiticeiro',
  true,
  false
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 3º círculo foram inseridas
SELECT 
  'Magias de 3º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 3 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 3 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- ============================================================
-- FIM DO SCRIPT - 3º CÍRCULO COMPLETO
-- ============================================================
