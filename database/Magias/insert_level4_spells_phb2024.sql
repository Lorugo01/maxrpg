-- ============================================================
-- MAGIAS DE 4º CÍRCULO - PHB 2024 (PARTE 1)
-- ============================================================
-- Total: 40 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (7 magias)
-- ============================================================

-- Aura da Vida
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aura da Vida',
  4,
  'Abjuração',
  'Ação',
  'Próprio',
  'V',
  'Concentração, até 10 minutos',
  'Uma aura irradia de você em uma Emanação de 9 metros durante a duração. Enquanto estiver na aura, você e seus aliados têm Resistência a dano Necrótico, e seus Pontos de Vida máximos não podem ser reduzidos. Se um aliado com 0 Pontos de Vida começar seu turno na aura, ele recupera 1 Ponto de Vida.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Aura de Pureza
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Aura de Pureza',
  4,
  'Abjuração',
  'Ação',
  'Próprio',
  'V',
  'Concentração, até 10 minutos',
  'Uma aura irradia de você em uma Emanação de 9 metros durante a duração. Enquanto estiver na aura, você e seus aliados têm Resistência a dano de Veneno e Vantagem em testes de resistência para evitar ou anular efeitos que incluem as condições Cego, Encantado, Surdo, Amedrontado, Paralisado, Envenenado ou Atordoado.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Banimento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Banimento',
  4,
  'Abjuração',
  'Ação',
  '30 pés',
  'V, S, M (um pentagrama)',
  'Concentração, até 1 minuto',
  'Uma criatura visível dentro do alcance deve ser bem-sucedida em um teste de resistência de Carisma ou será transportada para um semiplano inofensivo durante a duração da magia. Enquanto estiver lá, o alvo permanece na condição Incapacitado. Quando a magia termina, o alvo reaparece no espaço que deixou ou no espaço desocupado mais próximo, se este estiver ocupado.

Se o alvo for uma Aberração, um Celestial, um Elemental, uma Fada ou um Demônio, o alvo não retorna se a magia durar 1 minuto. Em vez disso, o alvo é transportado para um local aleatório em um plano (à escolha do Mestre) associado ao seu tipo de criatura.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Clérigo, Paladino, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Ala da Morte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ala da Morte',
  4,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S',
  '8 horas',
  'Você toca uma criatura e concede a ela uma medida de proteção contra a morte. Na primeira vez que o alvo cairia para 0 Pontos de Vida antes do fim da magia, o alvo cairia para 1 Ponto de Vida e a magia terminaria.

Se a magia ainda estiver em efeito quando o alvo for submetido a um efeito que o mataria instantaneamente sem causar dano, esse efeito será negado contra o alvo e a magia terminará.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  false
);

-- Liberdade de Movimento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Liberdade de Movimento',
  4,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (uma pulseira de couro)',
  '1 hora',
  'Você toca uma criatura disposta. Durante a duração, o movimento do alvo não é afetado por Terreno Difícil, e magias e outros efeitos mágicos não podem reduzir a Velocidade do alvo nem fazer com que ele tenha as condições Paralisado ou Constrangido. O alvo também tem uma Velocidade de Natação igual à sua Velocidade.

Além disso, o alvo pode gastar 1,5 metro de movimento para escapar automaticamente de restrições não mágicas, como algemas ou uma criatura que imponha a condição Agarrado a ele.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Patrulheiro',
  false,
  false,
  '1 criatura'
);

-- Santuário Privado de Mordenkainen
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Santuário Privado de Mordenkainen',
  4,
  'Abjuração',
  '10 minutos',
  '120 pés',
  'V, S, M (uma fina folha de chumbo)',
  '24 horas',
  'Você torna uma área dentro do alcance magicamente segura. A área é um Cubo que pode ter de 1,5 metro a 30 metros de cada lado. O feitiço dura enquanto durar.

Ao lançar o feitiço, você decide que tipo de segurança o feitiço oferece, escolhendo qualquer uma das seguintes propriedades:

- O som não consegue passar pela barreira na borda da área protegida.
- A barreira da área protegida parece escura e nebulosa, impedindo a visão (incluindo Visão no Escuro) através dela.
- Sensores criados por magias de Adivinhação não podem aparecer dentro da área protegida ou passar pela barreira em seu perímetro.
- Criaturas na área não podem ser alvos de feitiços de Adivinhação.
- Nada pode se teletransportar para dentro ou para fora da área protegida.
- A viagem planar é bloqueada dentro da área protegida.

Lançar este feitiço no mesmo local todos os dias durante 365 dias faz com que o feitiço dure até ser dissipado.

Usando um Espaço de Magia de Nível Superior. Você pode aumentar o tamanho do Cubo em 30 metros para cada nível de espaço de magia acima de 4.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  false
);

-- Esfera Resiliente de Otiluke
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Esfera Resiliente de Otiluke',
  4,
  'Abjuração',
  'Ação',
  '30 pés',
  'V, S, M (uma esfera de vidro)',
  'Concentração, até 1 minuto',
  'Uma esfera brilhante envolve uma criatura ou objeto grande ou menor dentro do alcance. Uma criatura relutante deve ser bem-sucedida em um teste de resistência de Destreza ou ficará cercada pelo tempo restante.

Nada — nem objetos físicos, energia ou outros efeitos mágicos — pode atravessar a barreira, para dentro ou para fora, embora uma criatura na esfera possa respirar ali. A esfera é imune a todo dano, e uma criatura ou objeto dentro dela não pode ser danificado por ataques ou efeitos originados de fora, nem uma criatura dentro da esfera pode causar dano a qualquer coisa fora dela.

A esfera não tem peso e é grande o suficiente para conter a criatura ou objeto dentro dela. Uma criatura presa pode realizar uma ação para empurrar as paredes da esfera e, assim, rolar a esfera com até metade da Velocidade da criatura. Da mesma forma, o globo pode ser pego e movido por outras criaturas.

Um feitiço Desintegrar direcionado ao globo o destrói sem danificar nada dentro dele.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  true
);

-- ============================================================
-- ADIVINHAÇÃO (3 magias)
-- ============================================================

-- Olho Arcano
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Olho Arcano',
  4,
  'Adivinhação',
  'Ação',
  '30 pés',
  'V, S, M (um pouco de pelo de morcego)',
  'Concentração, até 1 hora',
  'Você cria um olho invisível e invulnerável dentro do alcance que paira enquanto durar o efeito. Você recebe informações visuais mentalmente do olho, que pode ver em todas as direções. Ele também possui Visão no Escuro com um alcance de 9 metros.

Como Ação Bônus, você pode mover o olho até 9 metros em qualquer direção. Uma barreira sólida bloqueia o movimento do olho, mas ele pode passar por uma abertura de até 2,5 cm de diâmetro.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  true
);

-- Adivinhação
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Adivinhação',
  4,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (incenso que vale 25+ GP, que a magia consome)',
  'Instantânea',
  'Esta magia coloca você em contato com um deus ou com os servos de um deus. Você faz uma pergunta sobre um objetivo, evento ou atividade específica que ocorrerá dentro de 7 dias. O Mestre oferece uma resposta verdadeira, que pode ser uma frase curta ou uma rima enigmática. A magia não leva em conta circunstâncias que possam alterar a resposta, como a conjuração de outras magias.

Se você conjurar o feitiço mais de uma vez antes de terminar um Descanso Longo, há uma chance cumulativa de 25% para cada conjuração após a primeira de você não obter resposta.',
  'PHB 2024',
  'Clérigo, Druida, Mago',
  true,
  false
);

-- Localizar Criatura
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Localizar Criatura',
  4,
  'Adivinhação',
  'Ação',
  'Próprio',
  'V, S, M (pele de cão de caça)',
  'Concentração, até 1 hora',
  'Descreva ou nomeie uma criatura que lhe seja familiar. Você sente a direção da localização da criatura se ela estiver a até 300 metros de você. Se a criatura estiver se movendo, você sabe a direção do seu movimento.

A magia pode localizar uma criatura específica conhecida por você ou a criatura mais próxima de um tipo específico (como um humano ou um unicórnio) se você já tiver visto tal criatura de perto — a até 9 metros — pelo menos uma vez. Se a criatura que você descreveu ou nomeou estiver em uma forma diferente, como sob os efeitos de uma magia de Transformação em Carne ou Pedra ou Polimorfia, esta magia não a localiza.

Esta magia não consegue localizar uma criatura se qualquer pedaço de chumbo bloquear um caminho direto entre você e a criatura.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Paladino, Patrulheiro, Mago',
  false,
  true
);

-- Continua na parte 2...
