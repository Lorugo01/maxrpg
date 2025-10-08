-- ============================================================
-- MAGIAS DE 7º CÍRCULO - PHB 2024 (PARTE 1)
-- ============================================================
-- Total: 25 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (1 magia)
-- ============================================================

-- Símbolo
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Símbolo',
  7,
  'Abjuração',
  '1 minuto',
  'Toque',
  'V, S, M (diamante em pó que vale mais de 1.000 GP, que a magia consome)',
  'Até ser dissipado ou acionado',
  'Você inscreve um glifo nocivo em uma superfície (como um pedaço de chão ou parede) ou dentro de um objeto que possa ser fechado (como um livro ou um baú). O glifo pode cobrir uma área de até 3 metros de diâmetro. Se você escolher um objeto, ele deve permanecer no lugar; se for movido a mais de 3 metros de onde você conjurou a magia, o glifo é quebrado e a magia termina sem ser ativada.

O glifo é quase imperceptível e requer um teste bem-sucedido de Sabedoria (Percepção) contra sua CD de resistência à magia para ser notado.

Ao inscrever o glifo, você define seu gatilho e escolhe o efeito que o símbolo terá: Morte, Discórdia, Medo, Dor, Sono ou Atordoamento.

Uma vez ativado, o glifo brilha, preenchendo uma Esfera de 18 metros de raio com Luz Fraca por 10 minutos, após os quais a magia termina. Cada criatura na Esfera quando o glifo é ativado é alvo de seu efeito, assim como uma criatura que entra na Esfera pela primeira vez em um turno ou termina seu turno lá.

Morte. Cada alvo realiza um teste de resistência de Constituição, sofrendo 10d10 de dano Necrótico em caso de falha ou metade desse dano em caso de sucesso.

Discórdia. Cada alvo realiza um teste de resistência de Sabedoria. Em caso de falha, o alvo discute com outras criaturas por 1 minuto.

Medo. Cada alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição Assustado por 1 minuto.

Dor. Cada alvo deve ser bem-sucedido em um teste de resistência de Constituição ou permanecerá na condição Incapacitado por 1 minuto.

Sono. Cada alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou permanecer na condição de Inconsciente por 10 minutos.

Atordoamento. Cada alvo deve ser bem-sucedido em um teste de resistência de Sabedoria ou ficará atordoado por 1 minuto.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Mago',
  false,
  false,
  'damage',
  '10d10',
  'Necrótico'
);

-- ============================================================
-- CONJURAÇÃO (8 magias)
-- ============================================================

-- Conjurar Celestial
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "include_spell_mod", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Celestial',
  7,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura um espírito dos Planos Superiores, que se manifesta como um pilar de luz em um Cilindro de 3 metros de raio e 12 metros de altura, centrado em um ponto dentro do alcance. Para cada criatura que você puder ver no Cilindro, escolha qual destas luzes brilhará sobre ela:

Luz Curativa. O alvo recupera Pontos de Vida iguais a 4d12 mais o seu modificador de habilidade de conjuração.

Luz Calcinante. O alvo realiza um teste de resistência de Destreza, sofrendo 6d12 de dano Radiante em caso de falha ou metade desse dano em caso de sucesso.

Até que a magia termine, Luz Brilhante preenche o Cilindro e, quando você se move no seu turno, você também pode mover o Cilindro até 9 metros.

Sempre que o Cilindro se mover para o espaço de uma criatura que você possa ver e sempre que uma criatura que você possa ver entrar no Cilindro ou terminar seu turno lá, você pode banhá-la com uma das luzes. Uma criatura pode ser afetada por esta magia apenas uma vez por turno.

Usando um Espaço de Magia de Nível Superior. A cura e o dano aumentam em 1d12 para cada nível de espaço de magia acima de 7.',
  'PHB 2024',
  'Clérigo',
  false,
  true,
  'damage',
  '6d12',
  true,
  'Radiante',
  '1d12'
);

-- Eterealidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Eterealidade',
  7,
  'Conjuração',
  'Ação',
  'Próprio',
  'V, S',
  '8 horas',
  'Você entra nas regiões limítrofes do Plano Etéreo, onde ele se sobrepõe ao seu plano atual. Você permanece na Fronteira Etérea durante esse período. Durante esse tempo, você pode se mover em qualquer direção. Se você se mover para cima ou para baixo, cada metro de movimento custa um metro a mais. Você consegue perceber o plano que deixou, que parece cinza, e não consegue ver nada a mais de 18 metros de distância.

Enquanto estiver no Plano Etéreo, você pode afetar e ser afetado apenas por criaturas, objetos e efeitos naquele plano. Criaturas que não estejam no Plano Etéreo não podem perceber ou interagir com você, a menos que uma característica lhes dê a capacidade de fazê-lo.

Quando a magia termina, você retorna ao plano que deixou no local correspondente ao seu espaço na Fronteira Etérea. Se você aparecer em um espaço ocupado, será deslocado para o espaço desocupado mais próximo e sofrerá dano de Força igual ao dobro do número de metros que você se moveu.

Esta magia termina instantaneamente se você conjurá-la enquanto estiver no Plano Etéreo ou em um plano que não faça fronteira com ele, como um dos Planos Exteriores.

Usando um Espaço de Magia de Nível Superior. Você pode escolher até três criaturas voluntárias (incluindo você) para cada nível de espaço de magia acima de 7. As criaturas devem estar a até 3 metros de você quando você conjurar a magia.',
  'PHB 2024',
  'Bardo, Clérigo, Feiticeiro, Bruxo, Mago',
  false,
  false,
  '3 criaturas'
);

-- A Magnífica Mansão de Mordenkainen
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'A Magnífica Mansão de Mordenkainen',
  7,
  'Conjuração',
  '1 minuto',
  '300 pés',
  'V, S, M (uma porta em miniatura que vale mais de 15 GP)',
  '24 horas',
  'Você conjura uma porta cintilante ao alcance que dura enquanto durar a magia. A porta leva a uma habitação extradimensional com 1,5 metro de largura e 3 metros de altura. Você e qualquer criatura que designar ao conjurar a magia podem entrar na habitação extradimensional enquanto a porta permanecer aberta. Você pode abri-la ou fechá-la (nenhuma ação necessária) se estiver a até 9 metros dela. Enquanto fechada, a porta é imperceptível.

Do outro lado da porta, há um magnífico saguão com inúmeras câmaras. A atmosfera da residência é limpa, fresca e acolhedora.

Você pode criar qualquer planta baixa que desejar para a residência, mas ela não pode exceder 50 Cubos contíguos de 3 metros. O local é mobiliado e decorado como você escolher. Contém comida suficiente para servir um banquete de nove pratos para até 100 pessoas. Móveis e outros objetos criados por esta magia se dissipam em fumaça se removidos.

Uma equipe de 100 servos quase transparentes atende a todos que entram. Você determina a aparência desses servos e suas vestimentas. Eles são invulneráveis e obedecem aos seus comandos. Cada servo pode realizar tarefas que um humano realizaria, mas não pode atacar ou realizar qualquer ação que possa prejudicar diretamente outra criatura. Os servos não podem sair da habitação.

Quando o feitiço termina, quaisquer criaturas ou objetos deixados dentro do espaço extradimensional são expulsos para os espaços desocupados mais próximos da entrada.',
  'PHB 2024',
  'Bardo, Mago',
  false,
  false
);

-- Mudança de Plano
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mudança de Plano',
  7,
  'Conjuração',
  'Ação',
  'Toque',
  'V, S, M (uma haste de metal bifurcada que vale mais de 250 GP e está sintonizada com um plano de existência)',
  'Instantânea',
  'Você e até oito criaturas dispostas que derem as mãos em círculo são transportados para um plano de existência diferente. Você pode especificar um destino em termos gerais, como a Cidade de Latão no Plano Elemental do Fogo ou o palácio de Dispater no segundo nível dos Nove Infernos, e você aparece nesse destino ou próximo a ele, conforme determinado pelo Mestre.

Alternativamente, se você souber a sequência de sigilos de um círculo de teletransporte em outro plano de existência, esta magia pode levá-lo a esse círculo. Se o círculo de teletransporte for pequeno demais para comportar todas as criaturas que você transportou, elas aparecerão nos espaços desocupados mais próximos ao círculo.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Teletransporte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Teletransporte',
  7,
  'Conjuração',
  'Ação',
  '10 pés',
  'V',
  'Instantânea',
  'Esta magia transporta instantaneamente você e até oito criaturas dispostas que você possa ver dentro do alcance, ou um único objeto que você possa ver dentro do alcance, para um destino selecionado. Se você mirar em um objeto, ele deve ser Grande ou menor, e não pode ser segurado ou carregado por uma criatura involuntária.

O destino escolhido deve ser conhecido por você e estar no mesmo plano de existência que você. Sua familiaridade com o destino determina se você chegará lá com sucesso. O Mestre rola 1d100 e consulta a tabela de Resultados de Teletransporte.

Familiaridade:
- Círculo permanente: 01-00 (sempre no alvo)
- Objeto vinculado: 01-00 (sempre no alvo)
- Muito familiar: 25-00 (no alvo)
- Visto casualmente: 54-00 (no alvo)
- Visto uma vez ou descrito: 74-00 (no alvo)
- Destino falso: 01-50 (acidente)

Acidente. Cada criatura teletransportada sofre 3d10 de dano de Força, e o Mestre rola novamente na tabela.

Área semelhante. Você aparece em uma área diferente, visual ou tematicamente semelhante à área alvo.

Fora do Alvo. Você aparece a 2d12 milhas de distância do destino em uma direção aleatória.

No alvo. Você aparece onde pretendia.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '3d10',
  'Força'
);

-- Continua na parte 2...
