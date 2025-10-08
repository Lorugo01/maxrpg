-- ============================================================
-- MAGIAS DE 6º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final: Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- NECROMANCIA (6 magias)
-- ============================================================

-- Círculo da Morte
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Círculo da Morte',
  6,
  'Necromancia',
  'Ação',
  '150 pés',
  'V, S, M (pó de uma pérola negra triturada que vale mais de 500 GP)',
  'Instantânea',
  'Energia negativa se espalha em uma Esfera de 18 metros de raio a partir de um ponto à sua escolha dentro do alcance. Cada criatura naquela área realiza um teste de resistência de Constituição, sofrendo 8d8 de dano Necrótico em caso de falha ou metade do dano em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 2d8 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Feiticeiro, Bruxo, Mago',
  false,
  false,
  'damage',
  '8d8',
  'Necrótico',
  '2d8'
);

-- Criar Mortos-Vivos
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Criar Mortos-Vivos',
  6,
  'Necromancia',
  '1 minuto',
  '10 pés',
  'V, S, M (uma pedra de ônix preta de 150+ GP para cada cadáver)',
  'Instantânea',
  'Você só pode conjurar esta magia à noite. Escolha até três cadáveres de humanoides médios ou pequenos dentro do alcance. Cada um se torna um carniçal sob seu controle.

Como uma Ação Bônus em cada um dos seus turnos, você pode comandar mentalmente qualquer criatura que você tenha animado com esta magia se ela estiver a até 36 metros de você. Você decide qual ação a criatura realizará e para onde ela se moverá no próximo turno, ou pode emitir um comando geral. Se você não emitir nenhum comando, a criatura realiza a ação de Esquiva e se move apenas para evitar danos.

A criatura fica sob seu controle por 24 horas. Para manter o controle por mais 24 horas, você deve conjurar esta magia sobre ela antes que o período atual termine. Este uso reafirma seu controle sobre até três criaturas, em vez de animar novas.

Usando um Espaço de Magia de Nível Superior. Nível 7: quatro Carniçais. Nível 8: cinco Carniçais ou dois Ghasts/Criaturas. Nível 9: seis Carniçais, três Ghasts/Criaturas ou duas Múmias.',
  'PHB 2024',
  'Clérigo, Bruxo, Mago',
  false,
  false
);

-- Mordida Ocular
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mordida Ocular',
  6,
  'Necromancia',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 1 minuto',
  'Enquanto durar, seus olhos se tornarão um vazio escuro. Uma criatura à sua escolha a até 18 metros de você que você possa ver deve ser bem-sucedida em um teste de resistência de Sabedoria ou será afetada por um dos seguintes efeitos à sua escolha durante a duração.

Em cada um dos seus turnos até que a magia termine, você pode realizar uma ação de Magia para escolher outra criatura como alvo, mas não pode escolher outra criatura novamente se ela tiver sucesso em um teste de resistência contra esta conjuração da magia.

Adormecido. O alvo está na condição Inconsciente. Ele acorda se sofrer dano ou se outra criatura realizar uma ação para acordá-lo.

Em pânico. O alvo tem a condição Assustado. Em cada um dos seus turnos, o alvo Assustado deve realizar a ação de Disparada e se afastar de você pela rota mais curta e segura disponível. Se o alvo se mover para um espaço a pelo menos 18 metros de distância de você, onde não possa vê-lo, este efeito termina.

Enjoado. O alvo está com a condição Envenenado.',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- Ferir
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Ferir',
  6,
  'Necromancia',
  'Ação',
  '60 pés',
  'V, S',
  'Instantânea',
  'Você libera magia virulenta em uma criatura visível dentro do alcance. O alvo realiza um teste de resistência de Constituição. Em caso de falha, ele sofre 14d6 de dano Necrótico e seu máximo de Pontos de Vida é reduzido em uma quantidade igual ao dano Necrótico sofrido. Em caso de sucesso, ele sofre apenas metade do dano. Esta magia não pode reduzir o máximo de Pontos de Vida do alvo para menos de 1.',
  'PHB 2024',
  'Clérigo',
  false,
  false,
  'damage',
  '14d6',
  'Necrótico'
);

-- Pote Mágico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Pote Mágico',
  6,
  'Necromancia',
  '1 minuto',
  'Próprio',
  'V, S, M (uma gema, cristal ou relicário que valha mais de 500 GP)',
  'Até ser dissipado',
  'Seu corpo entra em estado catatônico quando sua alma o deixa e entra no recipiente que você usou para o componente Material da magia. Enquanto sua alma habita o recipiente, você tem consciência do que acontece ao seu redor como se estivesse no espaço do recipiente. A única ação que você pode realizar é projetar sua alma até 30 metros para fora do recipiente, retornando ao seu corpo vivo (e encerrando a magia) ou tentando possuir o corpo de um Humanoide.

Você pode tentar possuir qualquer humanoide a até 30 metros de você que possa ver. O alvo realiza um teste de resistência de Carisma. Em caso de falha, sua alma entra no corpo do alvo, e a alma do alvo fica presa no recipiente. Em caso de sucesso, você não pode tentar possuí-lo novamente por 24 horas.

Ao possuir o corpo de uma criatura, você a controla. Enquanto possuir um corpo, você pode realizar uma ação de Magia para retornar ao recipiente se ele estiver a até 30 metros. Se o corpo hospedeiro morrer enquanto você estiver nele, a criatura morre e você faz um teste de resistência de Carisma contra sua própria CD. Em caso de sucesso, você retorna ao recipiente. Caso contrário, você morre.

Se o recipiente for destruído ou a magia terminar, sua alma retornará ao seu corpo. Se seu corpo estiver a mais de 30 metros ou morto, você morre.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- ============================================================
-- TRANSMUTAÇÃO (5 magias)
-- ============================================================

-- Desintegrar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Desintegrar',
  6,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S, M (uma magnetita e poeira)',
  'Instantânea',
  'Você lança um raio verde em um alvo visível dentro do alcance. O alvo pode ser uma criatura, um objeto não mágico ou uma criação de poder mágico, como a parede criada por Muralha de Força.

Uma criatura alvo desta magia realiza um teste de resistência de Destreza. Em caso de falha, o alvo sofre 10d6 + 40 de dano de Força. Se este dano o reduzir a 0 Pontos de Vida, ele e tudo o que não for mágico que esteja vestindo e carregando são desintegrados em pó cinzento. O alvo só pode ser revivido por uma Ressurreição Verdadeira ou por uma magia de Desejo.

Esta magia desintegra automaticamente um objeto não mágico Grande ou menor ou uma criação de força mágica. Se o alvo for Enorme ou maior, esta magia desintegra uma porção cúbica de 3 metros dele.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 3d6 para cada nível de espaço de magia acima de 6.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  false,
  'damage',
  '10d6 + 40',
  'Força',
  '3d6'
);

-- Carne para Pedra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Carne para Pedra',
  6,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S, M (uma pena de basilisco)',
  'Concentração, até 1 minuto',
  'Você tenta transformar uma criatura visível dentro do alcance em pedra. O alvo realiza um teste de resistência de Constituição. Em caso de falha, ele fica com a condição de Restringido durante o teste. Em caso de sucesso, sua Velocidade é 0 até o início do seu próximo turno. Construtos são automaticamente bem-sucedidos no teste.

Um alvo Contido realiza outro teste de resistência de Constituição ao final de cada um de seus turnos. Se obtiver sucesso na resistência contra esta magia três vezes, a magia termina. Se falhar três vezes, ele é transformado em pedra e fica petrificado enquanto durar a magia. Os sucessos e fracassos não precisam ser consecutivos.

Se você mantiver sua Concentração nesta magia por toda a duração possível, o alvo ficará Petrificado até que a condição seja encerrada por Restauração Maior ou magia similar.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true
);

-- Mover a Terra
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Mover a Terra',
  6,
  'Transmutação',
  'Ação',
  '120 pés',
  'V, S, M (uma pá em miniatura)',
  'Concentração, até 2 horas',
  'Escolha uma área de terreno com no máximo 12 metros de lado dentro do alcance. Você pode remodelar terra, areia ou argila na área da maneira que desejar durante o período. Você pode aumentar ou diminuir a elevação da área, criar ou preencher uma trincheira, erguer ou achatar uma parede ou formar um pilar. A extensão de tais mudanças não pode exceder metade da maior dimensão da área. Essas mudanças levam 10 minutos para serem concluídas.

No final de cada 10 minutos que você gastar Concentrando-se na magia, você pode escolher uma nova área de terreno para afetar dentro do alcance.

Este feitiço não pode manipular pedras naturais ou construções em pedra. Rochas e estruturas se movem para se adaptar ao novo terreno. Se a forma como você molda o terreno tornar uma estrutura instável, ela poderá desabar.

Da mesma forma, este feitiço não afeta diretamente o crescimento das plantas. A terra movida carrega as plantas consigo.',
  'PHB 2024',
  'Druida, Feiticeiro, Mago',
  false,
  true
);

-- Caminhada do Vento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Caminhada do Vento',
  6,
  'Transmutação',
  '1 minuto',
  '30 pés',
  'V, S, M (uma vela)',
  '8 horas',
  'Você e até dez criaturas voluntárias à sua escolha dentro do alcance assumem formas gasosas durante a duração, aparecendo como fiapos de nuvem. Enquanto estiver nesta forma de nuvem, o alvo tem Velocidade de Voo de 90 metros e pode pairar; possui Imunidade à condição Caído; e possui Resistência a danos Contundentes, Perfurantes e Cortantes. As únicas ações que um alvo pode realizar nesta forma são a ação de Disparada ou uma ação de Magia para começar a reverter à sua forma normal. A reversão leva 1 minuto, durante o qual o alvo permanece na condição Atordoado. Até o fim da magia, o alvo pode reverter à forma de nuvem, o que também requer uma ação de Magia seguida de uma transformação de 1 minuto.

Se um alvo estiver em forma de nuvem e voando quando o efeito terminar, ele desce 18 metros por rodada durante 1 minuto até pousar, o que acontece com segurança. Se não conseguir pousar após 1 minuto, ele cai a distância restante.',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 6º círculo foram inseridas
SELECT 
  'Magias de 6º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 6 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 6 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral (0º a 6º)
SELECT 
  CASE 
    WHEN level = 0 THEN 'Truques (0)'
    WHEN level = 1 THEN '1º Círculo'
    WHEN level = 2 THEN '2º Círculo'
    WHEN level = 3 THEN '3º Círculo'
    WHEN level = 4 THEN '4º Círculo'
    WHEN level = 5 THEN '5º Círculo'
    WHEN level = 6 THEN '6º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 6
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - 6º CÍRCULO COMPLETO
-- ============================================================
