-- ============================================================
-- MAGIAS DE 7º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final: Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- NECROMANCIA (2 magias)
-- ============================================================

-- Dedo da Morte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Dedo da Morte',
  7,
  'Necromancia',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você libera energia negativa em direção a uma criatura visível dentro do alcance. O alvo realiza um teste de resistência de Constituição, sofrendo 7d8 + 30 de dano Necrótico em caso de falha ou metade do dano em caso de sucesso.

Um Humanoide morto por esta magia se ergue no início do seu próximo turno como um Zumbi que segue suas ordens verbais.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '7d8 + 30',
  'Necrótico'
);

-- Ressurreição
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ressurreição',
  7,
  'Necromancia',
  '1 hora',
  'Toque',
  'V, S, M (um diamante que vale mais de 1.000 GP, que a magia consome)',
  'Instantânea',
  'Com um toque, você revive uma criatura morta que estava morta há não mais de um século, não morreu de velhice e não era morta-viva quando morreu.

A criatura retorna à vida com todos os seus Pontos de Vida. Esta magia também neutraliza quaisquer venenos que a afetaram no momento da morte. Esta magia fecha todos os ferimentos mortais e restaura quaisquer partes do corpo perdidas.

Voltar dos mortos é uma provação. O alvo sofre uma penalidade de -4 nos Testes do D20. Toda vez que o alvo termina um Descanso Longo, a penalidade é reduzida em 1 até chegar a 0.

Conjurar esta magia para reviver uma criatura morta há 365 dias ou mais exige esforço. Até terminar um Descanso Longo, você não pode conjurar magias novamente e tem Desvantagem em Testes D20.',
  'PHB 2024',
  'Bardo, Clérigo',
  false,
  false
);

-- ============================================================
-- TRANSMUTAÇÃO (4 magias)
-- ============================================================

-- Gravidade Reversa
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Gravidade Reversa',
  7,
  'Transmutação',
  'Ação',
  '100 pés',
  'V, S, M (uma magnetita e limalha de ferro)',
  'Concentração, até 1 minuto',
  'Esta magia inverte a gravidade em um Cilindro de 15 metros de raio e 30 metros de altura, centrado em um ponto dentro do alcance. Todas as criaturas e objetos naquela área que não estejam ancorados ao solo caem para cima e alcançam o topo do Cilindro. Uma criatura pode fazer um teste de resistência de Destreza para agarrar um objeto fixo que esteja ao seu alcance, evitando assim a queda para cima.

Se um teto ou um objeto ancorado for encontrado nesta queda para cima, criaturas e objetos o atingirão da mesma forma que em uma queda para baixo. Se uma criatura ou objeto afetado atingir o topo do Cilindro sem atingir nada, ele permanecerá pairando ali enquanto durar a magia. Quando a magia terminar, objetos e criaturas afetados cairão.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true
);

-- Sequestro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Sequestro',
  7,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (pó de gema no valor de 5.000+ GP, que a magia consome)',
  'Até ser dissipado',
  'Com um toque, você sequestra magicamente um objeto ou uma criatura disposta. Enquanto durar o efeito, o alvo permanece invisível e não pode ser alvo de magias de Adivinhação, detectado por magia ou visualizado remotamente com magia.

Se o alvo for uma criatura, ela entra em um estado de animação suspensa; fica inconsciente, não envelhece e não precisa de comida, água ou ar.

Você pode definir uma condição para que a magia termine mais cedo. A condição pode ser qualquer uma de sua escolha, mas deve ocorrer ou ser visível a até 1,6 km do alvo. Exemplos incluem "após 1.000 anos" ou "quando o tarrasque despertar". Esta magia também termina se o alvo sofrer algum dano.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 7º círculo foram inseridas
SELECT 
  'Magias de 7º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 7 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 7 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral (0º a 7º)
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
    WHEN level = 5 THEN '5º Círculo'
    WHEN level = 6 THEN '6º Círculo'
    WHEN level = 7 THEN '7º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 7
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - 7º CÍRCULO COMPLETO
-- ============================================================
