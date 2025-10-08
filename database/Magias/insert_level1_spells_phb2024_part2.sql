-- ============================================================
-- MAGIAS DE 1º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação das magias de 1º círculo
-- ============================================================

-- ============================================================
-- ENCANTAMENTO (12 magias)
-- ============================================================

-- Amizade Animal
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Amizade Animal',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S, M (um pedaço de comida)',
  '24 horas',
  'Selecione uma Besta que você possa ver dentro do alcance. O alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição Encantado durante o período. Se você ou um de seus aliados causar dano ao alvo, a magia termina.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma Besta adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro',
  false,
  false,
  '1 criatura'
);

-- Maldição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Maldição',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S, M (uma gota de sangue)',
  'Concentração, até 1 minuto',
  'Até três criaturas à sua escolha que você possa ver dentro do alcance devem realizar um teste de resistência de Carisma. Sempre que um alvo que falhar neste teste fizer uma jogada de ataque ou um teste de resistência antes do fim da magia, o alvo deve subtrair 1d4 da jogada de ataque ou do teste de resistência.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Clérigo, Bruxo',
  false,
  true,
  '1 criatura'
);

-- Abençoar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Abençoar',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S, M (um Símbolo Sagrado que vale 5+ GP)',
  'Concentração, até 1 minuto',
  'Você abençoa até três criaturas dentro do alcance. Sempre que um alvo realiza uma jogada de ataque ou um teste de resistência antes do fim da magia, o alvo adiciona 1d4 à jogada de ataque ou teste de resistência.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true,
  '1 criatura'
);

-- Pessoa Encantadora
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Pessoa Encantadora',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S',
  '1 hora',
  'Um humanoide que você possa ver dentro do alcance realiza um teste de resistência de Sabedoria. Ele o faz com Vantagem se você ou seus aliados estiverem lutando contra ele. Em caso de falha, o alvo permanece na condição Encantado até que a magia termine ou até que você ou seus aliados causem dano a ele. A criatura Encantada é Amistosa com você. Quando a magia termina, o alvo sabe que foi Encantado por você.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Druida, Feiticeiro, Bruxo, Mago',
  false,
  false,
  '1 criatura'
);

-- Comando
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Comando',
  1,
  'Encantamento',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Você pronuncia um comando de uma palavra para uma criatura visível dentro do alcance. O alvo deve obter sucesso em um teste de resistência de Sabedoria ou seguir o comando no próximo turno. Escolha o comando entre estas opções:

Aproximação. O alvo se move em sua direção pela rota mais curta e direta, encerrando seu turno se se aproximar a menos de 1,5 metro de você.

Soltar. O alvo larga o que estiver segurando e termina seu turno.

Fugir. O alvo passa o turno se afastando de você da maneira mais rápida possível.

Rastejar. O alvo fica na condição Prone e então encerra seu turno.

Parar. No seu turno, o alvo não se move e não realiza nenhuma ação ou Ação Bônus.

Usando um Espaço de Magia de Nível Superior. Você pode afetar uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Clérigo, Paladino',
  false,
  false,
  '1 criatura'
);

-- Sussurros Dissonantes
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Sussurros Dissonantes',
  1,
  'Encantamento',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Uma criatura à sua escolha, visível dentro do alcance, ouve uma melodia dissonante em sua mente. O alvo realiza um teste de resistência de Sabedoria. Em caso de falha, ele sofre 3d6 de dano Psíquico e deve usar imediatamente sua Reação, se disponível, para se afastar o máximo possível de você, usando a rota mais segura. Em caso de sucesso, o alvo sofre apenas metade do dano.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo',
  false,
  false,
  'damage',
  '3d6',
  'Psíquico',
  '1d6'
);

-- Heroísmo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Heroísmo',
  1,
  'Encantamento',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 minuto',
  'Uma criatura voluntária que você tocar é imbuída de bravura. Até o fim da magia, a criatura fica imune à condição Amedrontado e ganha Pontos de Vida Temporários iguais ao seu modificador de habilidade de conjuração no início de cada um dos seus turnos.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Paladino',
  false,
  true,
  '1 criatura'
);

-- Dormir
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dormir',
  1,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S, M (uma pitada de areia ou pétalas de rosa)',
  'Concentração, até 1 minuto',
  'Cada criatura à sua escolha em uma Esfera de 1,5 metro de raio centrada em um ponto dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria ou ficará na condição Incapacitado até o final do seu próximo turno, momento em que deverá repetir o teste. Se o alvo falhar no segundo teste, ele ficará na condição Inconsciente enquanto durar. A magia termina em um alvo se ele sofrer dano ou se alguém a até 1,5 metro dele realizar uma ação para tirá-lo do efeito da magia.

Criaturas que não dormem, como elfos, ou que têm Imunidade à condição Exaustão, obtêm sucesso automaticamente em testes de resistência contra esta magia.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- A Risada Horrível de Tasha
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'A Risada Horrível de Tasha',
  1,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S, M (uma torta e uma pena)',
  'Concentração, até 1 minuto',
  'Uma criatura à sua escolha que você possa ver dentro do alcance realiza um teste de resistência de Sabedoria. Em caso de falha, ela fica sob as condições Prostrado e Incapacitado enquanto durar o teste. Durante esse tempo, ela ri incontrolavelmente se for capaz de rir, e não pode encerrar a condição Prostrado em si mesma.

Ao final de cada turno e sempre que sofrer dano, ele realiza outro teste de resistência de Sabedoria. O alvo tem Vantagem no teste se este for acionado por dano. Em caso de sucesso, a magia termina.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- ============================================================
-- EVOCAÇÃO (7 magias)
-- ============================================================

-- Mãos em Chamas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Mãos em Chamas',
  1,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S',
  'Instantânea',
  'Uma fina camada de chamas sai de você. Cada criatura em um cone de 4,5 metros faz um teste de resistência de Destreza, sofrendo 3d6 de dano de Fogo em caso de falha ou metade desse dano em caso de sucesso.

Objetos inflamáveis ​​no Cone que não estão sendo usados ​​ou carregados começam a queimar.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '3d6',
  'Fogo',
  '1d6'
);

-- Orbe Cromático
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Orbe Cromático',
  1,
  'Evocação',
  'Ação',
  '90 pés',
  'V, S, M (um diamante que vale mais de 50 GP)',
  'Instantânea',
  'Você arremessa um orbe de energia em um alvo dentro do alcance. Escolha Ácido, Frio, Fogo, Relâmpago, Veneno ou Trovão para o tipo de orbe que você cria e, em seguida, faça um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 3d8 de dano do tipo escolhido.

Se você rolar o mesmo número em dois ou mais d8s, o orbe salta para um alvo diferente à sua escolha a até 9 metros de distância. Faça uma jogada de ataque contra o novo alvo e uma nova jogada de dano. O orbe não pode saltar novamente, a menos que você conjure a magia com um espaço de magia de nível 2+.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 1. O orbe pode saltar um número máximo de vezes igual ao nível do espaço gasto, e uma criatura pode ser alvo apenas uma vez a cada conjuração desta magia.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '3d8',
  'Variável',
  '1d8'
);

-- Parafuso Guia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Parafuso Guia',
  1,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  '1 rodada',
  'Você lança um raio de luz em direção a uma criatura dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, ele sofre 4d6 de dano Radiante, e a próxima jogada de ataque contra ele antes do final do seu próximo turno tem Vantagem.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '4d6',
  'Radiante',
  '1d6'
);

-- Míssil Mágico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Míssil Mágico',
  1,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você cria três dardos brilhantes de força mágica. Cada dardo atinge uma criatura à sua escolha que você possa ver dentro do alcance. Um dardo causa 1d4 + 1 de dano de Força ao seu alvo. Os dardos atingem todos simultaneamente, e você pode direcioná-los para atingir uma ou várias criaturas.

Usando um Espaço de Magia de Nível Superior. A magia cria um dardo a mais para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '3d4+3',
  'Força',
  '1d4+1'
);

-- Onda de Trovão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Onda de Trovão',
  1,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S',
  'Instantânea',
  'Você libera uma onda de energia estrondosa. Cada criatura em um Cubo de 4,5 metros originado de você realiza um teste de resistência de Constituição. Em caso de falha, a criatura sofre 2d8 de dano de Trovão e é empurrada a 3 metros de distância de você. Em caso de sucesso, a criatura sofre apenas metade do dano.

Além disso, objetos soltos que estão totalmente dentro do Cubo são empurrados a 3 metros de distância de você, e um estrondo pode ser ouvido a até 91 metros.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Bardo, Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '2d8',
  'Trovejante',
  '1d8'
);

-- Parafuso de Bruxa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Parafuso de Bruxa',
  1,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S, M (um galho atingido por um raio)',
  'Concentração, até 1 minuto',
  'Um feixe de energia crepitante é lançado em direção a uma criatura dentro do alcance, formando um arco elétrico contínuo entre você e o alvo. Faça um ataque mágico à distância contra ele. Ao acertar, o alvo sofre 2d12 de dano elétrico.

Em cada um dos seus turnos subsequentes, você pode realizar uma Ação Bônus para causar 1d12 de dano de Relâmpago ao alvo automaticamente, mesmo que o primeiro ataque tenha errado.

A magia termina se o alvo estiver fora do alcance da magia ou se tiver Cobertura Total sua.

Usando um Espaço de Magia de Nível Superior. O dano inicial aumenta em 1d12 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true,
  'damage',
  '2d12',
  'Elétrico',
  '1d12'
);

-- Fogo de Fada
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Fogo de Fada',
  1,
  'Evocação',
  'Ação',
  '60 pés',
  'V',
  'Concentração, até 1 minuto',
  'Objetos em um Cubo de 6 metros dentro do alcance são contornados em luz azul, verde ou violeta (à sua escolha). Cada criatura no Cubo também é contornada se falhar em um teste de resistência de Destreza. Enquanto durar, objetos e criaturas afetadas emitem Luz Fraca em um raio de 3 metros e não podem se beneficiar da condição Invisível.

Rolagens de ataque contra uma criatura ou objeto afetado têm Vantagem se o atacante puder vê-lo.',
  'PHB 2024',
  'Artífice, Bardo, Druida',
  false,
  true
);

-- ============================================================
-- ILUSÃO (4 magias)
-- ============================================================

-- Spray de Cor
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Spray de Cor',
  1,
  'Ilusão',
  'Ação',
  'Próprio',
  'V, S, M (uma pitada de areia colorida)',
  'Instantânea',
  'Você lança uma série deslumbrante de luzes brilhantes e coloridas. Cada criatura em um cone de 4,5 metros originário de você deve ser bem-sucedida em um teste de resistência de Constituição ou ficará cega até o final do seu próximo turno.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false
);

-- Disfarçar-se
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Disfarçar-se',
  1,
  'Ilusão',
  'Ação',
  'Próprio',
  'V, S',
  '1 hora',
  'Você se transforma — incluindo suas roupas, armaduras, armas e outros pertences — até o fim do feitiço. Você pode parecer 30 centímetros mais baixo ou mais alto, e pode parecer mais pesado ou mais leve. Você deve adotar uma forma que tenha o mesmo arranjo básico de membros que você. Caso contrário, a extensão da ilusão fica a seu critério.

As mudanças causadas por este feitiço não resistem à inspeção física. Por exemplo, se você usar este feitiço para adicionar um chapéu à sua roupa, objetos passarão pelo chapéu e qualquer um que o tocar não sentirá nada.

Para discernir que você está disfarçado, uma criatura deve realizar a ação Estudar para inspecionar sua aparência e ter sucesso em um teste de Inteligência (Investigação) contra sua CD de resistência à magia.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Mago',
  false,
  false
);

-- Escrita Ilusória
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Escrita Ilusória',
  1,
  'Ilusão',
  '1 minuto',
  'Toque',
  'P, M (tinta que vale 10+ GP, que a magia consome)',
  '10 dias',
  'Você escreve em pergaminho, papel ou outro material adequado e o imbui com uma ilusão que perdura por toda a duração. Para você e quaisquer criaturas que você designar ao conjurar a magia, a escrita parece normal, parece ter sido escrita com a sua mão e transmite o significado que você pretendia ao escrever o texto. Para todos os outros, a escrita parece ter sido escrita em uma escrita desconhecida ou mágica, ininteligível. Alternativamente, a ilusão pode alterar o significado, a caligrafia e o idioma do texto, embora o idioma deva ser um que você conheça.

Se o feitiço for dissipado, tanto o script original quanto a ilusão desaparecem.

Uma criatura que possui Visão Verdadeira pode ler a mensagem oculta.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  true,
  false
);

-- Imagem Silenciosa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Imagem Silenciosa',
  1,
  'Ilusão',
  'Ação',
  '60 pés',
  'V, S, M (um pouco de lã)',
  'Concentração, até 10 minutos',
  'Você cria a imagem de um objeto, criatura ou outro fenômeno visível que não seja maior que um Cubo de 4,5 metros. A imagem aparece em um ponto dentro do alcance e permanece durante toda a duração. A imagem é puramente visual; não é acompanhada por som, cheiro ou outros efeitos sensoriais.

Com uma ação de Magia, você pode fazer com que a imagem se mova para qualquer ponto dentro do alcance. Conforme a imagem muda de lugar, você pode alterar sua aparência para que seus movimentos pareçam naturais para a imagem. Por exemplo, se você criar a imagem de uma criatura e movê-la, poderá alterar a imagem para que ela pareça estar caminhando.

A interação física com a imagem revela que ela é uma ilusão, já que objetos podem atravessá-la. Uma criatura que realiza uma ação de Estudo para examinar a imagem pode determinar que ela é uma ilusão com um teste bem-sucedido de Inteligência (Investigação) contra sua CD de resistência à magia. Se uma criatura discernir a ilusão pelo que ela é, ela poderá ver através da imagem.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- ============================================================
-- NECROMANCIA (3 magias)
-- ============================================================

-- Vida Falsa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Vida Falsa',
  1,
  'Necromancia',
  'Ação',
  'Próprio',
  'V, S, M (uma gota de álcool)',
  'Instantânea',
  'Você ganha 2d4 + 4 Pontos de Vida Temporários.

Usando um Espaço de Magia de Nível Superior. Você ganha 5 Pontos de Vida Temporários adicionais para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false,
  '5 PV'
);

-- Infligir Ferimentos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Infligir Ferimentos',
  1,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S',
  'Instantânea',
  'Uma criatura que você tocar faz um teste de resistência de Constituição, sofrendo 2d10 de dano Necrótico em uma falha ou metade desse dano em um sucesso.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '2d10',
  'Necrótico',
  '1d10'
);

-- Raio da Doença
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Raio da Doença',
  1,
  'Necromancia',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você dispara um raio esverdeado em uma criatura dentro do alcance. Realiza um ataque mágico à distância contra o alvo. Ao acertar, o alvo sofre 2d8 de dano de Veneno e permanece na condição Envenenado até o final do seu próximo turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '2d8',
  'Veneno',
  '1d8'
);

-- ============================================================
-- TRANSMUTAÇÃO (8 magias)
-- ============================================================

-- Criar ou Destruir Água
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Criar ou Destruir Água',
  1,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma mistura de água e areia)',
  'Instantânea',
  'Você faz um dos seguintes procedimentos:

Criar Água. Você cria até 40 litros de água limpa dentro do alcance, em um recipiente aberto. Alternativamente, a água cai como chuva em um Cubo de 9 metros dentro do alcance, extinguindo chamas expostas ali.

Destrua Água. Você destrói até 40 litros de água em um recipiente aberto dentro do alcance. Alternativamente, você destrói neblina em um Cubo de 9 metros dentro do alcance.

Usando um Espaço de Magia de Nível Superior. Você cria ou destrói 40 litros adicionais de água, ou o tamanho do Cubo aumenta em 1,5 metro, para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Clérigo, Druida',
  false,
  false,
  '40 litros'
);

-- Retirada Rápida
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Retirada Rápida',
  1,
  'Transmutação',
  'Ação Bônus',
  'Próprio',
  'V, S',
  'Concentração, até 10 minutos',
  'Você realiza a ação de Disparar e, até que a magia termine, você pode realizar essa ação novamente como uma Ação Bônus.',
  'PHB 2024',
  'Artífice, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Queda de Penas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Queda de Penas',
  1,
  'Transmutação',
  'Reação',
  '60 pés',
  'V, M (uma pequena pena ou pedaço de penugem)',
  '1 minuto',
  'Escolha até cinco criaturas em queda dentro do alcance. A velocidade de queda de uma criatura em queda diminui para 18 metros por rodada até o fim da magia. Se uma criatura pousar antes do fim da magia, ela não sofre dano da queda e a magia termina para ela.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Mago',
  false,
  false
);

-- Pular
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Pular',
  1,
  'Transmutação',
  'Ação Bônus',
  'Toque',
  'V, S, M (pata traseira de um gafanhoto)',
  '1 minuto',
  'Você toca uma criatura disposta. Uma vez em cada um dos seus turnos até o fim da magia, essa criatura pode saltar até 9 metros gastando 3 metros de movimento.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Artífice, Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  false,
  '1 criatura'
);

-- Longstrider
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Longstrider',
  1,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (uma pitada de terra)',
  '1 hora',
  'Você toca uma criatura. A Velocidade do alvo aumenta em 3 metros até o fim da magia.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 1.',
  'PHB 2024',
  'Artífice, Bardo, Druida, Patrulheiro, Mago',
  false,
  false,
  '1 criatura'
);

-- Purificar Alimentos e Bebidas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Purificar Alimentos e Bebidas',
  1,
  'Transmutação',
  'Ação',
  '10 pés',
  'V, S',
  'Instantânea',
  'Você remove veneno e podridão de alimentos e bebidas não mágicos em uma Esfera de 1,5 m de raio centrada em um ponto dentro do alcance.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Paladino',
  true,
  false
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 1º círculo foram inseridas
SELECT 
  'Magias de 1º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 1 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 1 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- ============================================================
-- FIM DO SCRIPT - PARTE 2
-- ============================================================
