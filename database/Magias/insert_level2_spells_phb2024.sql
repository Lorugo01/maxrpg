-- ============================================================
-- MAGIAS DE 2º CÍRCULO - PHB 2024
-- ============================================================
-- Total: 50 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (4 magias)
-- ============================================================

-- Restauração Menor
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Restauração Menor',
  2,
  'Abjuração',
  'Ação Bônus',
  'Toque',
  'V, S',
  'Instantânea',
  'Você toca uma criatura e encerra uma condição nela: Cego, Surdo, Paralisado ou Envenenado.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Paladino, Patrulheiro',
  false,
  false
);

-- Passe sem deixar rastros
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Passe sem deixar rastros',
  2,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S, M (cinzas de visco queimado)',
  'Concentração, até 1 hora',
  'Você irradia uma aura oculta em uma Emanação de 9 metros enquanto durar o efeito. Enquanto estiver na aura, você e cada criatura que escolher terão um bônus de +10 em testes de Destreza (Furtividade) e não deixarão rastros.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true
);

-- Proteção contra Veneno
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Proteção contra Veneno',
  2,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  '1 hora',
  'Você toca uma criatura e encerra a condição Envenenada nela. Enquanto durar o efeito, o alvo tem Vantagem em testes de resistência para evitar ou encerrar a condição Envenenada e tem Resistência a dano de Veneno.',
  'PHB 2024',
  'Artífice, Clérigo, Druida, Paladino, Patrulheiro',
  false,
  false
);

-- Fiador
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Fiador',
  2,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (um par de anéis de platina que valem mais de 50 GP cada, que você e o alvo devem usar durante todo o período)',
  '1 hora',
  'Você toca outra criatura que esteja disposta e cria uma conexão mística entre você e o alvo até o fim da magia. Enquanto o alvo estiver a até 18 metros de você, ele ganha +1 de bônus na CA e em testes de resistência, além de ter Resistência a todo tipo de dano. Além disso, cada vez que ele sofre dano, você sofre a mesma quantidade de dano.

A magia termina se você ficar com 0 Pontos de Vida ou se você e o alvo ficarem separados por mais de 18 metros. Ela também termina se a magia for lançada novamente em qualquer uma das criaturas conectadas.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (7 magias)
-- ============================================================

-- Detectar Pensamentos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Detectar Pensamentos',
  2,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (1 peça de cobre)',
  'Concentração, até 1 minuto',
  'Você ativa um dos efeitos abaixo. Até o fim da magia, você pode ativar qualquer um dos efeitos como uma ação de Magia nos seus turnos posteriores.

Sentir Pensamentos. Você sente a presença de pensamentos a até 9 metros de você, pertencentes a criaturas que conhecem línguas ou são telepáticas. Você não lê os pensamentos, mas sabe que uma criatura pensante está presente.

O feitiço é bloqueado por 30 cm de pedra, terra ou madeira; 2,5 cm de metal; ou uma fina folha de chumbo.

Ler Pensamentos. Selecione uma criatura que você possa ver a até 9 metros de você ou uma criatura a até 9 metros de você que você detectou com a opção Sentir Pensamentos. Você descobre o que está mais na mente do alvo naquele momento. Se o alvo não souber nenhum idioma e não for telepático, você não descobre nada.

Como uma ação de Magia no seu próximo turno, você pode tentar sondar mais profundamente a mente do alvo. Se você sondar mais profundamente, o alvo realiza um teste de resistência de Sabedoria. Em caso de falha, você discerne o raciocínio, as emoções e algo que paira sobre a mente do alvo (como uma preocupação, amor ou ódio). Em caso de sucesso, a magia termina. De qualquer forma, o alvo sabe que você está sondando a mente dele e, até que você desvie sua atenção da mente do alvo, o alvo pode realizar uma ação em seu turno para fazer um teste de Inteligência (Arcano) contra sua CD de resistência à magia, encerrando a magia em caso de sucesso.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  true
);

-- Encontrar Armadilhas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Encontrar Armadilhas',
  2,
  'Adivinhação',
  'Ação',
  '120 pés',
  'V, S',
  'Instantânea',
  'Você sente qualquer armadilha dentro do alcance que esteja dentro da linha de visão. Uma armadilha, para os propósitos desta magia, inclui qualquer objeto ou mecanismo criado para causar dano ou outro perigo. Assim, a magia sentiria a magia Alarme ou Glifo de Proteção ou uma armadilha mecânica de fosso, mas não revelaria uma fraqueza natural no chão, um teto instável ou um buraco escondido.

Este feitiço revela a presença de uma armadilha, mas não sua localização. Você aprende a natureza geral do perigo representado por uma armadilha que você pressente.',
  'PHB 2024',
  'Clérigo, Druida, Patrulheiro',
  false,
  false
);

-- Localizar Animais ou Plantas
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Localizar Animais ou Plantas',
  2,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (pele de cão de caça)',
  'Instantânea',
  'Descreva ou nomeie um tipo específico de Besta, criatura vegetal ou planta não mágica. Você aprenderá a direção e a distância até a criatura ou planta mais próxima desse tipo em um raio de 8 km, se houver alguma presente.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro',
  true,
  false
);

-- Localizar Objeto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Localizar Objeto',
  2,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (um galho bifurcado)',
  'Concentração, até 10 minutos',
  'Descreva ou nomeie um objeto que lhe seja familiar. Você sente a direção da localização do objeto se ele estiver a até 300 metros de você. Se o objeto estiver em movimento, você sabe a direção do seu movimento.

A magia pode localizar um objeto específico conhecido por você, caso você o tenha visto de perto — a até 9 metros — pelo menos uma vez. Alternativamente, a magia pode localizar o objeto mais próximo de um tipo específico, como um determinado tipo de vestimenta, joia, mobília, ferramenta ou arma.

Este feitiço não consegue localizar um objeto se qualquer pedaço de chumbo bloquear um caminho direto entre você e o objeto.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Paladino, Patrulheiro, Mago',
  false,
  true
);

-- Pico Mental
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Pico Mental',
  2,
  'Adivinhação',
  'Ação',
  '120 pés',
  'S',
  'Concentração, até 1 hora',
  'Você lança um pico de energia psiônica na mente de uma criatura que você possa ver dentro do alcance. O alvo realiza um teste de resistência de Sabedoria, sofrendo 3d8 de dano Psíquico em caso de falha ou metade desse dano em caso de sucesso. Em caso de falha, você também sempre sabe a localização do alvo até o fim da magia, mas apenas enquanto vocês dois estiverem no mesmo plano de existência. Enquanto você tiver esse conhecimento, o alvo não pode se esconder de você e, se ele tiver a condição Invisível, não ganha nenhum benefício dessa condição contra você.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  true,
  'damage',
  '3d8',
  'Psíquico',
  '1d8'
);

-- Ver Invisibilidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ver Invisibilidade',
  2,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (uma pitada de talco)',
  '1 hora',
  'Durante a duração, você vê criaturas e objetos que têm a condição Invisível como se fossem visíveis, e pode ver o Plano Etéreo. Criaturas e objetos ali parecem fantasmagóricos.',
  'PHB 2024',
  'Artífice, Bardo, Feiticeiro, Mago',
  false,
  false
);

-- Augúrio (já implementado no 1º círculo, mas é 2º círculo)
-- Movendo para o lugar correto
DELETE FROM "public"."spells" WHERE name = 'Augúrio' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Augúrio',
  2,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V, S, M (bastões, ossos, cartas ou outros marcadores divinatórios especialmente marcados que valem 25+ GP)',
  'Instantânea',
  'Você recebe um presságio de uma entidade sobrenatural sobre os resultados de uma ação que planeja realizar nos próximos 30 minutos. O Mestre escolhe o presságio na tabela de Presságios.

Presságios:
- Bem-estar: Para resultados que serão bons
- Ai: Para resultados que serão ruins
- Bem-estar e aflição: Para resultados que serão bons e maus
- Indiferença: Para resultados que não serão nem bons nem maus

O feitiço não leva em conta circunstâncias, como outros feitiços, que podem alterar os resultados.

Se você conjurar o feitiço mais de uma vez antes de terminar um Descanso Longo, há uma chance cumulativa de 25% para cada conjuração após a primeira de você não obter resposta.',
  'PHB 2024',
  'Clérigo, Druida, Mago',
  true,
  false
);

-- ============================================================
-- CONJURAÇÃO (5 magias)
-- ============================================================

-- Esfera Flamejante
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Esfera Flamejante',
  2,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (uma bola de cera)',
  'Concentração, até 1 minuto',
  'Você cria uma esfera de fogo de 1,5 metro de diâmetro em um espaço desocupado no chão, dentro do alcance. Ela dura enquanto durar a duração. Qualquer criatura que terminar seu turno a até 1,5 metro da esfera realiza um teste de resistência de Destreza, sofrendo 2d6 de dano de Fogo em caso de falha ou metade desse dano em caso de sucesso.

Como uma Ação Bônus, você pode mover a esfera até 9 metros, rolando-a pelo chão. Se você mover a esfera para o espaço de uma criatura, esta faz o teste de resistência contra a esfera, e a esfera para de se mover naquele turno.

Ao mover a esfera, você pode direcioná-la sobre barreiras de até 1,5 metro de altura e saltá-la sobre fossos de até 3 metros de largura. Objetos inflamáveis ​​que não estejam sendo usados ​​ou carregados começam a queimar se tocados pela esfera, e ela emite Luz Brilhante em um raio de 6 metros e Luz Fraca por mais 6 metros.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '2d6',
  'Fogo',
  '1d6'
);

-- Passo Nebuloso
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Passo Nebuloso',
  2,
  'Conjuração',
  'Ação Bônus',
  'Próprio',
  'V',
  'Instantânea',
  'Brevemente cercado por uma névoa prateada, você se teletransporta até 9 metros para um espaço desocupado que você pode ver.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- Invocar Besta
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Invocar Besta',
  2,
  'Conjuração',
  'Ação',
  '90 pés',
  'V, S, M (uma pena, um tufo de pelo e uma cauda de peixe dentro de uma bolota dourada que vale mais de 200 GP)',
  'Concentração, até 1 hora',
  'Você invoca um espírito bestial. Ele se manifesta em um espaço desocupado que você possa ver dentro do seu alcance e usa o bloco de atributos Espírito Bestial. Ao conjurar a magia, escolha um ambiente: Ar, Terra ou Água. A criatura se assemelha a um animal de sua escolha, nativo do ambiente escolhido, o que determina certos detalhes em seu bloco de atributos. A criatura desaparece quando seus Pontos de Vida chegam a 0 ou quando a magia termina.

A criatura é uma aliada sua e de seus aliados. Em combate, a criatura compartilha sua contagem de Iniciativa, mas joga seu turno imediatamente após o seu. Ela obedece aos seus comandos verbais (nenhuma ação é necessária). Se você não emitir nenhum, ela realiza a ação de Esquiva e usa seu movimento para evitar o perigo.

Usando um Espaço de Magia de Nível Superior. Use o nível do espaço de magia para o nível da magia no bloco de estatísticas.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true
);

-- Rede
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Rede',
  2,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S, M (um pouco de teia de aranha)',
  'Concentração, até 1 hora',
  'Você conjura uma massa de teias pegajosas em um ponto dentro do alcance. As teias preenchem um Cubo de 6 metros durante a duração. As teias são de Terreno Difícil, e a área dentro delas é Levemente Obscura.

Se as teias não estiverem ancoradas entre duas massas sólidas (como paredes ou árvores) ou dispostas sobre um piso, parede ou teto, a teia se desfaz sobre si mesma e a magia termina no início do seu próximo turno. Teias dispostas sobre uma superfície plana têm uma profundidade de 1,5 metro.

Na primeira vez que uma criatura entra nas teias em um turno ou começa seu turno lá, ela deve ser bem-sucedida em um teste de resistência de Destreza ou terá a condição Restrito enquanto estiver nas teias ou até se libertar.

Uma criatura Contida pelas teias pode realizar uma ação para realizar um teste de Força (Atletismo) contra sua CD de resistência à magia. Se for bem-sucedida, ela não estará mais Contida.

As teias são inflamáveis. Qualquer cubo de teias de 1,5 m exposto ao fogo queima em 1 rodada, causando 2d4 de dano de Fogo a qualquer criatura que comece seu turno no fogo.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  true,
  'damage',
  '2d4',
  'Fogo'
);

-- Mensageiro Animal (já implementado no 1º círculo, mas é 2º círculo)
-- Movendo para o lugar correto
DELETE FROM "public"."spells" WHERE name = 'Mensageiro Animal' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Mensageiro Animal',
  2,
  'Encantamento',
  'Ação',
  '30 pés',
  'V, S, M (um pedaço de comida)',
  '24 horas',
  'Uma Pequena Besta à sua escolha, que você possa ver dentro do alcance, deve ser bem-sucedida em um teste de resistência de Carisma, ou ela tentará entregar uma mensagem para você (se o Nível de Desafio do alvo não for 0, ela será automaticamente bem-sucedida). Você especifica um local que visitou e um destinatário que corresponda a uma descrição geral, como "uma pessoa vestida com o uniforme da guarda da cidade" ou "um anão ruivo usando um chapéu pontudo". Você também comunica uma mensagem de até 25 palavras. A Besta viaja em direção ao local especificado durante o tempo de duração, cobrindo cerca de 40 quilômetros a cada 24 horas ou 80 quilômetros se puder voar.

Quando a Fera chega, ela entrega sua mensagem à criatura que você descreveu, imitando sua comunicação. Se a Fera não chegar ao seu destino antes do fim do feitiço, a mensagem se perde e a Fera retorna para onde você lançou o feitiço.

Usando um Espaço de Magia de Nível Superior. A duração da magia aumenta em 48 horas para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Bardo, Druida, Patrulheiro',
  true,
  false,
  '48 horas'
);

-- Continua no próximo arquivo...
