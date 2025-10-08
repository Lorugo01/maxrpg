-- ============================================================
-- MAGIAS DE 5º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final: Evocação, Ilusão, Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- EVOCAÇÃO (7 magias)
-- ============================================================

-- Cone de Frio
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Cone de Frio',
  5,
  'Evocação',
  'Ação',
  'Próprio',
  'V, S, M (um pequeno cone de cristal ou vidro)',
  'Instantânea',
  'Você libera uma rajada de ar frio. Cada criatura em um cone de 18 metros originário de você realiza um teste de resistência de Constituição, sofrendo 8d8 de dano de Gelo em caso de falha ou metade desse dano em caso de sucesso. Uma criatura morta por esta magia se torna uma estátua congelada até descongelar.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '8d8',
  'Frio',
  '1d8'
);

-- Ataque de Chamas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Ataque de Chamas',
  5,
  'Evocação',
  'Ação',
  '60 pés',
  'V, S, M (uma pitada de enxofre)',
  'Instantânea',
  'Uma coluna vertical de fogo brilhante ruge lá de cima. Cada criatura em um Cilindro de 3 metros de raio e 12 metros de altura, centrado em um ponto dentro do alcance, realiza um teste de resistência de Destreza, sofrendo 5d6 de dano de Fogo e 5d6 de dano Radiante em caso de falha ou metade do dano em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. O dano de Fogo e o dano Radiante aumentam em 1d6 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '5d6 + 5d6',
  'Fogo/Radiante',
  '1d6'
);

-- Tempestade de Radiância de Jallarzi
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Tempestade de Radiância de Jallarzi',
  5,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (uma pitada de fósforo)',
  'Concentração, até 1 minuto',
  'Você libera uma tempestade de luz brilhante e trovões furiosos em um Cilindro de 3 metros de raio e 12 metros de altura, centrado em um ponto visível dentro do alcance. Enquanto estiverem nesta área, as criaturas terão as condições Cego e Surdo, e não poderão conjurar magias com componente Verbal.

Quando a tempestade surge, cada criatura nela faz um teste de resistência de Constituição, sofrendo 2d10 de dano Radiante e 2d10 de dano Trovejante em caso de falha ou metade do dano em caso de sucesso. Uma criatura também faz esse teste quando entra na área da magia pela primeira vez em um turno ou termina seu turno lá.

Usando um Espaço de Magia de Nível Superior. O dano de Radiante e Trovejante aumenta em 1d10 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true,
  'damage',
  '2d10 + 2d10',
  'Radiante/Trovão',
  '1d10'
);

-- Mão de Bigby
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Mão de Bigby',
  5,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (uma casca de ovo e uma luva)',
  'Concentração, até 1 minuto',
  'Você cria uma Mão Grande de energia mágica cintilante em um espaço desocupado que você possa ver dentro do alcance. A mão dura enquanto durar o efeito e se move ao seu comando, imitando os movimentos da sua própria mão.

A mão é um objeto que tem CA 20 e Pontos de Vida iguais ao seu máximo de Pontos de Vida. Se cair para 0 Pontos de Vida, a magia termina.

Ao conjurar a magia e como uma Ação Bônus em seus turnos posteriores, você pode mover a mão até 18 metros e então causar um dos seguintes efeitos:

Punho Cerrado. A mão atinge um alvo a até 1,5 metro de distância. Realiza um ataque mágico corpo a corpo. Ao acertar, o alvo sofre 5d8 de dano de Força.

Mão Poderosa. A mão tenta empurrar uma criatura Enorme ou menor a até 1,5 metro de distância dela.

Mão Agarradora. A mão tenta agarrar uma criatura Enorme ou menor. Enquanto agarra, você pode esmagar causando 4d6 de dano de Concussão.

Mão Interposta. A mão concede Meia Cobertura contra ataques.

Usando um Espaço de Magia de Nível Superior. O dano do Punho Cerrado aumenta em 2d8 e o dano da Mão Agarradora aumenta em 2d6 para cada nível acima de 5.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '5d8',
  'Força',
  '2d8'
);

-- Muro de Força
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Muro de Força',
  5,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (um caco de vidro)',
  'Concentração, até 10 minutos',
  'Uma parede invisível de força surge em um ponto dentro do alcance escolhido. A parede aparece em qualquer orientação que você escolher, como uma barreira horizontal ou vertical ou em ângulo. Ela pode flutuar livremente ou repousar sobre uma superfície sólida. Você pode moldá-la em uma cúpula hemisférica ou um globo com um raio de até 3 metros, ou pode moldar uma superfície plana composta por dez painéis de 3 metros por 3 metros. Cada painel deve ser contíguo a outro painel. Em qualquer forma, a parede tem 6 mm de espessura.

Nada pode atravessar fisicamente a parede. Ela é imune a todo dano e não pode ser dissipada por Dissipar Magia. No entanto, um feitiço Desintegrar destrói a parede instantaneamente. A parede também se estende para o Plano Etéreo e bloqueia a viagem etérea através dela.',
  'PHB 2024',
  'Mago',
  false,
  true
);

-- Muro de Pedra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Muro de Pedra',
  5,
  'Evocação',
  'Ação',
  '120 pés',
  'V, S, M (um cubo de granito)',
  'Concentração, até 10 minutos',
  'Uma parede não mágica de pedra sólida surge em um ponto à sua escolha dentro do alcance. A parede tem 15 cm de espessura e é composta por dez painéis de 3 x 3 m. Cada painel deve ser contíguo a outro painel. Como alternativa, você pode criar painéis de 3 x 6 m com apenas 7,5 cm de espessura.

Se a parede atravessar o espaço de uma criatura ao aparecer, a criatura é empurrada para um lado da parede. A parede pode ter qualquer formato que você desejar. Cada painel tem CA 15 e 30 Pontos de Vida por polegada de espessura, além de imunidade a Veneno e dano Psíquico.

Se você mantiver sua Concentração neste feitiço por toda a sua duração, a barreira se tornará permanente e não poderá ser dissipada. Caso contrário, a barreira desaparecerá quando o feitiço terminar.',
  'PHB 2024',
  'Artífice, Druida, Feiticeiro, Mago',
  false,
  true
);

-- ============================================================
-- ILUSÃO (4 magias)
-- ============================================================

-- Criação
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Criação',
  5,
  'Ilusão',
  '1 minuto',
  '30 pés',
  'V, S, M (um pincel)',
  'Especial',
  'Você extrai fragmentos de material sombrio do Pendor das Sombras para criar um objeto dentro do alcance. Pode ser um objeto de matéria vegetal (materiais macios, corda, madeira) ou mineral (pedra, cristal, metal). O objeto não deve ser maior que um Cubo de 1,5 metro e deve ter forma e material que você já tenha visto.

A duração da magia depende do material do objeto:
- Matéria vegetal: 24 horas
- Pedra ou cristal: 12 horas
- Metais preciosos: 1 hora
- Gemas: 10 minutos
- Adamantino ou mitral: 1 minuto

Usando qualquer objeto criado por esta magia como componente Material de outra magia faz com que a outra magia falhe.

Usando um Espaço de Magia de Nível Superior. O Cubo aumenta em 1,5 metro para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  false
);

-- Sonhar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Sonhar',
  5,
  'Ilusão',
  '1 minuto',
  'Próprio',
  'V, S, M (um punhado de areia)',
  '8 horas',
  'Você escolhe uma criatura que conhece no mesmo plano de existência. Você ou uma criatura que você tocar entra em estado de transe para atuar como um mensageiro dos sonhos. Durante o transe, o mensageiro fica Incapacitado e tem Velocidade 0.

Se o alvo estiver dormindo, o mensageiro aparece em seus sonhos e pode conversar com ele. O mensageiro também pode moldar o ambiente do sonho, criando paisagens, objetos e outras imagens. O alvo se lembra perfeitamente do sonho ao acordar.

Você pode tornar o mensageiro aterrorizante para o alvo. Se fizer isso, o mensageiro poderá entregar uma mensagem de no máximo dez palavras, e então o alvo realizará um teste de resistência de Sabedoria. Em caso de falha, o alvo não ganha nenhum benefício do seu descanso e sofre 3d6 de dano Psíquico ao acordar.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  false,
  false,
  'damage',
  '3d6',
  'Psíquico'
);

-- Enganar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Enganar',
  5,
  'Ilusão',
  'Ação',
  'Próprio',
  'S',
  'Concentração, até 1 hora',
  'Você ganha a condição Invisível ao mesmo tempo em que uma cópia ilusória sua aparece onde você está. A cópia permanece enquanto durar o efeito, mas a invisibilidade termina imediatamente após você realizar uma jogada de ataque, causar dano ou conjurar uma magia.

Com uma ação de Magia, você pode mover o duplo ilusório até o dobro da sua Velocidade e fazê-lo gesticular, falar e se comportar da maneira que você escolher. Ele é intangível e invulnerável.

Você pode ver através dos seus olhos e ouvir através dos seus ouvidos como se estivesse localizado onde ele está.',
  'PHB 2024',
  'Bardo, Bruxo, Mago',
  false,
  true
);

-- Aparente
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aparente',
  5,
  'Ilusão',
  'Ação',
  '30 pés',
  'V, S',
  '8 horas',
  'Você confere uma aparência ilusória a cada criatura à sua escolha que você possa ver dentro do alcance. Um alvo relutante pode realizar um teste de resistência de Carisma e, se for bem-sucedido, não será afetado pela magia.

Você pode dar a mesma aparência ou diferentes aos alvos. A magia pode alterar a aparência dos corpos e equipamentos dos alvos. Você pode fazer com que cada criatura pareça 30 cm mais baixa ou mais alta e mais pesada ou mais leve. A nova aparência de um alvo deve ter o mesmo arranjo básico de membros que o alvo. A magia dura enquanto durar.

As mudanças causadas por esta magia não resistem à inspeção física. Uma criatura que realiza a ação Estudar para examinar um alvo pode realizar um teste de Inteligência (Investigação) contra sua CD de resistência à magia. Se for bem-sucedida, ela percebe que o alvo está disfarçado.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false
);

-- ============================================================
-- NECROMANCIA (3 magias)
-- ============================================================

-- Contágio
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Contágio',
  5,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S',
  '7 dias',
  'Seu toque inflige um contágio mágico. O alvo deve ser bem-sucedido em um teste de resistência de Constituição ou sofrer 11d8 de dano Necrótico e ficar com a condição Envenenado. Além disso, escolha uma habilidade ao conjurar a magia. Enquanto Envenenado, o alvo tem Desvantagem em testes de resistência feitos com a habilidade escolhida.

O alvo deve repetir o teste de resistência ao final de cada um dos seus turnos até obter três sucessos ou falhas. Se o alvo obtiver sucesso em três desses testes, a magia termina para ele. Se o alvo falhar em três dos testes, a magia dura 7 dias.

Sempre que o alvo Envenenado receber um efeito que encerraria a condição Envenenado, o alvo deve ser bem-sucedido em um teste de resistência de Constituição, ou a condição Envenenado não terminará com ele.',
  'PHB 2024',
  'Clérigo, Druida',
  false,
  false,
  'damage',
  '11d8',
  'Necrótico'
);

-- Ressuscitar Mortos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ressuscitar Mortos',
  5,
  'Necromancia',
  '1 hora',
  'Toque',
  'V, S, M (um diamante que vale mais de 500 GP, que a magia consome)',
  'Instantânea',
  'Com um toque, você revive uma criatura morta se ela estiver morta há menos de 10 dias e não for morta-viva quando morreu.

A criatura retorna à vida com 1 Ponto de Vida. Este feitiço também neutraliza quaisquer venenos que afetaram a criatura no momento da morte.

Este feitiço fecha todos os ferimentos mortais, mas não restaura partes do corpo perdidas. Se a criatura não tiver partes do corpo ou órgãos essenciais à sua sobrevivência — a cabeça, por exemplo — o feitiço falha automaticamente.

Voltar dos mortos é uma provação. O alvo sofre uma penalidade de -4 nos Testes do D20. Toda vez que o alvo termina um Descanso Longo, a penalidade é reduzida em 1 até chegar a 0.',
  'PHB 2024',
  'Bardo, Clérigo, Paladino',
  false,
  false
);

-- Reencarnar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Reencarnar',
  5,
  'Necromancia',
  '1 hora',
  'Toque',
  'V, S, M (óleos raros que valem mais de 1.000 GP, que a magia consome)',
  'Instantânea',
  'Você toca um Humanoide morto ou um pedaço dele. Se a criatura estiver morta há menos de 10 dias, a magia forma um novo corpo para ela e invoca a alma para entrar naquele corpo. Role 1d10 para determinar a espécie do corpo:

1 - Aasimar
2 - Dragonborn
3 - Anão
4 - Duende
5 - Gnomo
6 - Golias
7 - Halfling
8 - Humano
9 - Orc
10 - Tiefling

A criatura reencarnada faz todas as escolhas que a descrição de uma espécie oferece, e a criatura relembra sua vida anterior. Ela retém as capacidades que tinha em sua forma original, exceto que perde as características de sua espécie anterior e ganha as características da nova.',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- ============================================================
-- TRANSMUTAÇÃO (6 magias)
-- ============================================================

-- Objetos Animados
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Objetos Animados',
  5,
  'Transmutação',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Objetos são animados ao seu comando. Escolha um número de objetos não mágicos dentro do alcance que não estejam sendo usados ou carregados, não estejam fixos em uma superfície e não sejam Gargantuanos. O número máximo de objetos é igual ao seu modificador de habilidade de conjuração; para esse número, um alvo Médio ou menor conta como um objeto, um alvo Grande conta como dois e um alvo Enorme conta como três.

Cada alvo se anima e se torna um Construto que usa o bloco de atributos Objeto Animado; esta criatura fica sob seu controle até que a magia termine ou até que seus Pontos de Vida sejam reduzidos a 0.

Até o fim da magia, você pode realizar uma Ação Bônus para comandar mentalmente qualquer criatura que você criou com esta magia, desde que ela esteja a até 150 metros de você.

Usando um Espaço de Magia de Nível Superior. O dano de Impacto da criatura aumenta em 1d4 (Médio ou menor), 1d6 (Grande) ou 1d12 (Enorme) para cada nível acima de 5.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Mago',
  false,
  true,
  '1d4/1d6/1d12'
);

-- Despertar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Despertar',
  5,
  'Transmutação',
  '8 horas',
  'Toque',
  'V, S, M (uma ágata que vale mais de 1.000 GP, que a magia consome)',
  'Instantânea',
  'Você gasta o tempo de conjuração traçando caminhos mágicos dentro de uma pedra preciosa e, em seguida, toca o alvo. O alvo deve ser uma criatura do tipo Fera ou Planta com Inteligência 3 ou menos, ou uma planta natural que não seja uma criatura. O alvo ganha Inteligência 10 e a habilidade de falar um idioma que você conhece. Se o alvo for uma planta natural, ele se torna uma criatura do tipo Planta e ganha a habilidade de mover seus membros, raízes, trepadeiras, etc.

O alvo desperto permanece na condição Encantado por 30 dias ou até que você ou seus aliados causem dano a ele. Quando essa condição termina, a criatura desperta escolhe sua atitude em relação a você.',
  'PHB 2024',
  'Bardo, Druida',
  false,
  false
);

-- Parede de Passagem
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Parede de Passagem',
  5,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma pitada de sementes de gergelim)',
  '1 hora',
  'Uma passagem surge em um ponto visível em uma superfície de madeira, gesso ou pedra (como uma parede, teto ou piso) dentro do alcance e permanece ativa durante toda a duração. Você escolhe as dimensões da abertura: até 1,5 metro de largura, 2,4 metros de altura e 6 metros de profundidade. A passagem não cria instabilidade na estrutura ao seu redor.

Quando a abertura desaparece, quaisquer criaturas ou objetos que ainda estejam na passagem criada pelo feitiço são ejetados com segurança para um espaço desocupado mais próximo da superfície na qual você lançou o feitiço.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- Telecinese
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Telecinese',
  5,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você ganha a habilidade de mover ou manipular criaturas ou objetos pelo pensamento. Ao conjurar a magia e como uma ação de Magia em seus turnos posteriores antes do fim da magia, você pode exercer sua vontade sobre uma criatura ou objeto que esteja visível dentro do alcance, causando o efeito apropriado abaixo.

Criatura. Você pode tentar mover uma criatura Enorme ou menor. O alvo deve ser bem-sucedido em um teste de resistência de Força, ou você pode movê-lo até 9 metros em qualquer direção dentro do alcance da magia. Até o final do seu próximo turno, a criatura tem a condição "Restringido" e, se você erguê-la no ar, ela fica suspensa ali.

Objeto. Você pode tentar mover um objeto Enorme ou menor. Se o objeto não estiver sendo usado ou carregado, você o move automaticamente até 9 metros. Se for usado ou carregado, a criatura deve ser bem-sucedida em um teste de resistência de Força, ou você puxa o objeto.

Você pode exercer controle preciso sobre objetos com sua empunhadura telecinética, como manipular uma ferramenta simples, abrir uma porta ou um recipiente.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  true
);

-- Cura em Massa de Feridas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod",
  "upcast_dice_per_level"
) VALUES (
  'Cura em Massa de Feridas',
  5,
  'Abjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Uma onda de energia curativa irrompe de um ponto visível dentro do alcance. Escolha até seis criaturas em uma Esfera de 9 metros de raio centrada nesse ponto. Cada alvo recupera Pontos de Vida equivalentes a 5d8 mais o seu modificador de habilidade de conjuração.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 1d8 para cada nível de espaço de magia acima de 5.',
  'PHB 2024',
  'Bardo, Clérigo, Druida',
  false,
  false,
  'healing',
  '5d8',
  true,
  '1d8'
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 5º círculo foram inseridas
SELECT 
  'Magias de 5º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 5 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 5 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral (0º a 5º)
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
    WHEN level = 5 THEN '5º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 5
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - 5º CÍRCULO COMPLETO
-- ============================================================
