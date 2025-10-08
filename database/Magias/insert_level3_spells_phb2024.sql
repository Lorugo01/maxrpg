-- ============================================================
-- MAGIAS DE 3º CÍRCULO - PHB 2024
-- ============================================================
-- Total: 6 magias essenciais (início)
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (2 magias)
-- ============================================================

-- Aura de Vitalidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice"
) VALUES (
  'Aura de Vitalidade',
  3,
  'Abjuração',
  'Ação',
  'Próprio',
  'V',
  'Concentração, até 1 minuto',
  'Uma aura irradia de você em uma Emanação de 9 metros enquanto durar. Ao criar a aura e no início de cada um dos seus turnos enquanto ela persistir, você pode restaurar 2d6 Pontos de Vida para uma criatura nela.',
  'PHB 2024',
  'Clérigo, Druida, Paladino',
  false,
  true,
  'healing',
  '2d6'
);

-- Farol da Esperança
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Farol da Esperança',
  3,
  'Abjuração',
  'Ação',
  '30 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Escolha qualquer número de criaturas dentro do alcance. Durante a duração, cada alvo tem Vantagem em testes de resistência de Sabedoria e Testes de Resistência contra Morte e recupera o máximo de Pontos de Vida possível de qualquer cura.',
  'PHB 2024',
  'Clérigo',
  false,
  true
);

-- Contrafeitiço
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Contrafeitiço',
  3,
  'Abjuração',
  'Reação',
  '60 pés',
  'S',
  'Instantânea',
  'Você tenta interromper uma criatura no processo de conjuração de uma magia. A criatura realiza um teste de resistência de Constituição. Em caso de falha, a magia se dissipa sem efeito, e a ação, Ação Bônus ou Reação usada para conjurá-la é desperdiçada. Se a magia foi conjurada com um espaço de magia, o espaço não é gasto.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (1 magia)
-- ============================================================

-- Clarividência
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Clarividência',
  3,
  'Adivinhação',
  '10 minutos',
  '1 milha',
  'V, S, M (um foco que vale mais de 100 GP, um chifre com joias para ouvir ou um olho de vidro para ver)',
  'Concentração, até 10 minutos',
  'Você cria um sensor invisível dentro do alcance em um local familiar (um lugar que você já visitou ou viu antes) ou em um local óbvio que lhe é desconhecido (como atrás de uma porta, em uma esquina ou em um bosque). O sensor intangível e invulnerável permanece no local enquanto durar o efeito.

Ao conjurar a magia, escolha entre visão ou audição. Você pode usar o sentido escolhido através do sensor como se estivesse no espaço dele. Como uma Ação Bônus, você pode alternar entre visão e audição.

Uma criatura que vê o sensor (como uma criatura que se beneficia de Ver Invisibilidade ou Visão Verdadeira) vê um orbe luminoso do tamanho do seu punho.',
  'PHB 2024',
  'Bardo, Clérigo, Feiticeiro, Mago',
  false,
  true
);

-- ============================================================
-- CONJURAÇÃO (2 magias)
-- ============================================================

-- Conjurar Animais
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Conjurar Animais',
  3,
  'Conjuração',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Você conjura espíritos da natureza que aparecem como uma grande matilha de animais espectrais e intangíveis em um espaço desocupado que você possa ver dentro do alcance. A matilha dura enquanto durar o efeito, e você escolhe a forma animal dos espíritos, como lobos, serpentes ou pássaros.

Você tem Vantagem em testes de resistência de Força enquanto estiver a até 1,5 metro do bando e, quando se move no seu turno, você também pode mover o bando até 9 metros para um espaço desocupado que você possa ver.

Sempre que o bando se mover a menos de 3 metros de uma criatura que você possa ver e sempre que uma criatura que você possa ver entrar em um espaço a menos de 3 metros do bando ou terminar seu turno ali, você pode forçar essa criatura a realizar um teste de resistência de Destreza. Em caso de falha, a criatura sofre 3d10 de dano Cortante. Uma criatura realiza esse teste apenas uma vez por turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true,
  'damage',
  '3d10',
  'Cortante',
  '1d10'
);

-- Chamada Relâmpago
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Chamada Relâmpago',
  3,
  'Conjuração',
  'Ação',
  '120 pés',
  'V, S',
  'Concentração, até 10 minutos',
  'Uma nuvem de tempestade surge em um ponto dentro do alcance que você pode ver acima de si. Ela assume a forma de um cilindro com 3 metros de altura e 18 metros de raio.

Ao conjurar a magia, escolha um ponto visível sob a nuvem. Um raio é disparado da nuvem até esse ponto. Cada criatura a até 1,5 metro desse ponto realiza um teste de resistência de Destreza, sofrendo 3d10 de dano de Raio em caso de falha ou metade desse dano em caso de sucesso.

Até que a magia termine, você pode realizar uma ação de Magia para invocar um raio daquela forma novamente, mirando no mesmo ponto ou em um diferente.

Se você estiver ao ar livre durante uma tempestade ao conjurar esta magia, ela lhe dará controle sobre a tempestade em vez de criar uma nova. Sob tais condições, o dano da magia aumenta em 1d10.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d10 para cada nível de espaço de magia acima de 3.',
  'PHB 2024',
  'Druida',
  false,
  true,
  'damage',
  '3d10',
  'Elétrico',
  '1d10'
);

-- ============================================================
-- NECROMANCIA (1 magia)
-- ============================================================

-- Animar Mortos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Animar Mortos',
  3,
  'Necromancia',
  '1 minuto',
  '10 pés',
  'V, S, M (uma gota de sangue, um pedaço de carne e uma pitada de pó de osso)',
  'Instantânea',
  'Escolha uma pilha de ossos ou um cadáver de um Humanoide Médio ou Pequeno dentro do alcance. O alvo se torna uma criatura Morta-Viva: um Esqueleto se você escolher ossos ou um Zumbi se escolher um cadáver.

Em cada um dos seus turnos, você pode realizar uma Ação Bônus para comandar mentalmente qualquer criatura que você criou com esta magia, se a criatura estiver a até 18 metros de você (se você controlar várias criaturas, poderá comandar qualquer uma delas ao mesmo tempo, emitindo o mesmo comando para cada uma). Você decide qual ação a criatura realizará e para onde ela se moverá no próximo turno, ou pode emitir um comando geral, como para guardar uma câmara ou corredor. Se você não emitir nenhum comando, a criatura realiza a ação de Esquiva e se move apenas para evitar danos. Uma vez dada a ordem, a criatura continua a segui-la até que sua tarefa seja concluída.

A criatura fica sob seu controle por 24 horas, após as quais ela para de obedecer a qualquer comando que você tenha dado. Para manter o controle da criatura por mais 24 horas, você deve conjurar esta magia nela novamente antes que o período atual de 24 horas termine. Este uso da magia reafirma seu controle sobre até quatro criaturas que você animou com esta magia, em vez de animar uma nova criatura.

Usando um Espaço de Magia de Nível Superior. Você anima ou reassume o controle sobre duas criaturas Mortas-Vivas adicionais para cada nível de espaço de magia acima de 3. Cada uma das criaturas deve vir de um cadáver ou pilha de ossos diferente.',
  'PHB 2024',
  'Clérigo, Mago',
  false,
  false,
  '2 criaturas'
);

-- Conceder Maldição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Conceder Maldição',
  3,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S',
  'Concentração, até 1 minuto',
  'Você toca uma criatura, que deve ser bem-sucedida em um teste de resistência de Sabedoria ou ficará amaldiçoada por toda a duração. Até que a maldição termine, o alvo sofre um dos seguintes efeitos à sua escolha:

- Escolha uma habilidade. O alvo tem Desvantagem em testes de habilidade e testes de resistência feitos com essa habilidade.
- O alvo tem Desvantagem em jogadas de ataque contra você.
- Em combate, o alvo deve ser bem-sucedido em um teste de resistência de Sabedoria no início de cada um de seus turnos ou será forçado a realizar a ação de Esquiva naquele turno.
- Se você causar dano ao alvo com uma jogada de ataque ou uma magia, o alvo sofre 1d8 de dano Necrótico extra.

Usando um Espaço de Magia de Nível Superior. Se você conjurar esta magia usando um espaço de magia de nível 4, poderá manter Concentração nela por até 10 minutos. Se usar um espaço de magia de nível 5+, a magia não requer Concentração e a duração passa a ser de 8 horas (espaço de nível 5-6) ou 24 horas (espaço de nível 7-8). Se usar um espaço de magia de nível 9, a magia dura até ser dissipada.',
  'PHB 2024',
  'Bardo, Clérigo, Mago',
  false,
  true,
  'damage',
  '1d8',
  'Necrótico'
);

-- ============================================================
-- TRANSMUTAÇÃO (1 magia)
-- ============================================================

-- Piscar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Piscar',
  3,
  'Transmutação',
  'Ação',
  'Próprio',
  'V, S',
  '1 minuto',
  'Role 1d6 ao final de cada um dos seus turnos durante a duração. Com um resultado de 4-6, você desaparece do seu plano de existência atual e reaparece no Plano Etéreo (a magia termina instantaneamente se você já estiver naquele plano). Enquanto estiver no Plano Etéreo, você pode perceber o plano que deixou, que é conjurado em tons de cinza, mas não consegue ver nada a mais de 18 metros de distância. Você pode afetar e ser afetado apenas por outras criaturas no Plano Etéreo, e criaturas no outro plano não podem percebê-lo, a menos que tenham uma habilidade especial que as permita perceber coisas no Plano Etéreo.

Você retorna ao outro plano no início do seu próximo turno e quando a magia terminar, se estiver no Plano Etéreo. Você retorna a um espaço desocupado à sua escolha que possa ver a até 3 metros do espaço que você deixou. Se não houver espaço desocupado disponível dentro desse alcance, você aparece no espaço desocupado mais próximo.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
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
-- FIM DO SCRIPT - 3º CÍRCULO (PARTE 1)
-- ============================================================
