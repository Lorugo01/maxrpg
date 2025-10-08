-- ============================================================
-- MAGIAS DE 8º CÍRCULO - PHB 2024 (PARTE 2)
-- ============================================================
-- Continuação: Encantamento, Evocação, Necromancia, Transmutação
-- ============================================================

-- ============================================================
-- ENCANTAMENTO (3 magias)
-- ============================================================

-- Antipatia/Simpatia
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Antipatia/Simpatia',
  8,
  'Encantamento',
  '1 hora',
  '60 pés',
  'V, S, M (uma mistura de vinagre e mel)',
  '10 dias',
  'Ao conjurar a magia, escolha se ela cria antipatia ou simpatia e escolha como alvo uma criatura ou objeto Enorme ou menor. Em seguida, especifique um tipo de criatura, como dragões vermelhos, goblins ou vampiros. Uma criatura do tipo escolhido realiza um teste de resistência de Sabedoria ao se aproximar a até 36 metros do alvo. Sua escolha de antipatia ou simpatia determina o que acontece com a criatura quando ela falha nesse teste:

Antipatia. A criatura tem a condição Amedrontada. A criatura Amedrontada deve usar seu movimento em seus turnos para se afastar o máximo possível do alvo, movendo-se pela rota mais segura.

Simpatia. A criatura possui a condição Encantada. A criatura Encantada deve usar seu movimento em seus turnos para chegar o mais perto possível do alvo, movendo-se pela rota mais segura. Se a criatura estiver a menos de 1,5 metro do alvo, ela não pode se afastar voluntariamente. Se o alvo causar dano à criatura Encantada, esta pode realizar um teste de resistência de Sabedoria para encerrar o efeito.

Fim do Efeito. Se a criatura Amedrontada ou Encantada terminar seu turno a mais de 36 metros de distância do alvo, ela realiza um teste de resistência de Sabedoria. Em caso de sucesso, a criatura não é mais afetada pelo alvo. Uma criatura que tenha sucesso no teste de resistência contra este efeito fica imune a ele por 1 minuto, após o qual pode ser afetada novamente.',
  'PHB 2024',
  'Bardo, Druida, Mago',
  false,
  false
);

-- Perplexidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Perplexidade',
  8,
  'Encantamento',
  'Ação',
  '150 pés',
  'V, S, M (um chaveiro sem chaves)',
  'Instantânea',
  'Você destrói a mente de uma criatura que você possa ver dentro do alcance. O alvo realiza um teste de resistência de Inteligência.

Em caso de falha na defesa, o alvo sofre 10d12 de dano Psíquico e não pode conjurar magias ou realizar a ação de Magia. Ao final de cada 30 dias, o alvo repete a defesa, encerrando o efeito em caso de sucesso. O efeito também pode ser encerrado pela magia Restauração Maior, Cura ou Desejo.

Em uma defesa bem-sucedida, o alvo sofre apenas metade do dano.',
  'PHB 2024',
  'Bardo, Druida, Bruxo, Mago',
  false,
  false,
  'damage',
  '10d12',
  'Psíquico'
);

-- Dominar Monstro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dominar Monstro',
  8,
  'Encantamento',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 1 hora',
  'Uma criatura que você possa ver dentro do alcance deve ser bem-sucedida em um teste de resistência de Sabedoria ou permanecer na condição Encantado durante a duração. O alvo tem Vantagem no teste se você ou seus aliados estiverem lutando contra ele. Sempre que o alvo sofrer dano, ele repete o teste, encerrando a magia sobre si mesmo em caso de sucesso.

Você tem um vínculo telepático com o alvo Encantado enquanto ambos estiverem no mesmo plano de existência. No seu turno, você pode usar esse vínculo para emitir comandos ao alvo (nenhuma ação necessária), como "Ataque aquela criatura", "Vá até lá" ou "Pegue aquele objeto". O alvo faz o possível para obedecer no seu turno. Se cumprir uma ordem e não receber mais instruções suas, ele age e se move como quiser, concentrando-se em se proteger.

Você pode comandar o alvo para realizar uma Reação, mas deve realizar sua própria Reação para fazer isso.

Usando um Espaço de Magia de Nível Superior. Sua Concentração pode durar mais com um espaço de magia de nível 9 (até 8 horas).',
  'PHB 2024',
  'Bardo, Feiticeiro, Bruxo, Mago',
  false,
  true
);

-- ============================================================
-- EVOCAÇÃO (2 magias)
-- ============================================================

-- Explosão de Sol
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Explosão de Sol',
  8,
  'Evocação',
  'Ação',
  '150 pés',
  'V, S, M (um pedaço de pedra do sol)',
  'Instantânea',
  'A luz solar brilhante brilha em uma Esfera de 18 metros de raio, centrada em um ponto à sua escolha dentro do alcance. Cada criatura na Esfera realiza um teste de resistência de Constituição. Em caso de falha, a criatura sofre 12d6 de dano Radiante e permanece na condição Cegueira por 1 minuto. Em caso de sucesso, sofre apenas metade do dano.

Uma criatura cega por esta magia faz outro teste de resistência de Constituição no final de cada um dos seus turnos, encerrando o efeito sobre si mesma em caso de sucesso.

Esta magia dissipa a Escuridão na área criada por qualquer magia.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro, Mago',
  false,
  false,
  'damage',
  '12d6',
  'Radiante'
);

-- ============================================================
-- NECROMANCIA (1 magia)
-- ============================================================

-- Clone
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Clone',
  8,
  'Necromancia',
  '1 hora',
  'Toque',
  'V, S, M (um diamante que vale mais de 1.000 GP, que a magia consome, e um recipiente selável que vale mais de 2.000 GP, que seja grande o suficiente para conter a criatura que está sendo clonada)',
  'Instantânea',
  'Você toca uma criatura ou pelo menos 2,5 cm³ de sua carne. Uma duplicata inerte dessa criatura se forma dentro do recipiente usado na conjuração da magia e termina de crescer após 120 dias; você escolhe se o clone finalizado tem a mesma idade da criatura ou é mais jovem. O clone permanece inerte e dura indefinidamente enquanto seu recipiente permanecer intacto.

Se a criatura original morrer após a formação do clone, a alma da criatura será transferida para o clone, desde que a alma esteja livre e disposta a retornar. O clone é fisicamente idêntico ao original e possui a mesma personalidade, memórias e habilidades, mas nenhum dos equipamentos do original. Os restos mortais originais da criatura, se houver, tornam-se inertes e não podem ser revividos, pois a alma da criatura está em outro lugar.',
  'PHB 2024',
  'Mago',
  false,
  false
);

-- ============================================================
-- TRANSMUTAÇÃO (6 magias)
-- ============================================================

-- Formas de Animais
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Formas de Animais',
  8,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S',
  '24 horas',
  'Escolha qualquer número de criaturas dispostas que você possa ver dentro do alcance. Cada alvo se transforma em uma Besta Grande ou menor à sua escolha, com Nível de Desafio 4 ou inferior. Você pode escolher uma forma diferente para cada alvo. Em turnos posteriores, você pode realizar uma ação de Magia para transformar os alvos novamente.

As estatísticas de jogo do alvo são substituídas pelas estatísticas da Besta escolhida, mas o alvo mantém seu tipo de criatura; Pontos de Vida; Dados de Pontos de Vida; alinhamento; capacidade de comunicação; e valores de Inteligência, Sabedoria e Carisma. As ações do alvo são limitadas pela anatomia da forma Besta, e ele não pode conjurar magias. O equipamento do alvo se funde à nova forma, e o alvo não pode usar nenhum desses equipamentos enquanto estiver nessa forma.

O alvo ganha uma quantidade de Pontos de Vida Temporários igual aos Pontos de Vida da primeira forma em que se transforma. Esses Pontos de Vida Temporários desaparecem, se ainda houver algum, quando a magia termina. A transformação dura enquanto durar ou até que o alvo a termine como uma Ação Bônus.',
  'PHB 2024',
  'Druida',
  false,
  false
);

-- Controle o Clima
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Controle o Clima',
  8,
  'Transmutação',
  '10 minutos',
  'Próprio',
  'V, S, M (queima de incenso)',
  'Concentração, até 8 horas',
  'Você assume o controle do clima em um raio de 8 quilômetros durante a duração do feitiço. Você precisa estar ao ar livre para conjurá-lo, e ele termina mais cedo se você entrar em um ambiente fechado.

Ao conjurar a magia, você altera as condições climáticas atuais, que são determinadas pelo Mestre. Você pode alterar a precipitação, a temperatura e o vento. As novas condições levam 1d4 × 10 minutos para entrarem em vigor. Após isso, você pode alterá-las novamente. Quando a magia termina, o clima retorna gradualmente ao normal.

Ao alterar as condições climáticas, encontre uma condição atual nas tabelas a seguir e altere seu estágio em um, para cima ou para baixo. Ao alterar o vento, você pode alterar sua direção.

Precipitação: Claro → Nuvens claras → Nevoeiro nublado → Chuva/granizo/neve → Chuva torrencial/granizo/nevasca

Temperatura: Onda de calor → Quente → Esquentar → Legal → Frio → Congelamento

Vento: Calma → Vento moderado → Vento forte → Vendaval → Tempestade',
  'PHB 2024',
  'Clérigo, Druida, Mago',
  false,
  true
);

-- Terremoto
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Terremoto',
  8,
  'Transmutação',
  'Ação',
  '500 pés',
  'V, S, M (uma rocha fraturada)',
  'Concentração, até 1 minuto',
  'Escolha um ponto no chão que você consiga ver dentro do alcance. Enquanto durar o tremor, um tremor intenso rasgará o chão em um círculo de 30 metros de raio centrado naquele ponto. O terreno ali é considerado Terreno Difícil.

Ao conjurar esta magia e ao final de cada um dos seus turnos durante a duração da magia, cada criatura no chão da área realiza um teste de resistência de Destreza. Em caso de falha, a criatura fica com a condição Caído e sua Concentração é quebrada.

Você também pode causar os efeitos abaixo:

Fissuras. Um total de 1d6 fissuras se abrem na área da magia no final do turno em que você a conjura. Você escolhe a localização das fissuras, que não podem ser sob estruturas. Cada fissura tem 1d10 × 3 metros de profundidade e 3 metros de largura, e se estende de uma borda da área da magia à outra. Uma criatura no mesmo espaço que uma fissura deve ser bem-sucedida em um teste de resistência de Destreza ou cairá nela.

Estruturas. O tremor causa 50 de dano de Concussão a qualquer estrutura em contato com o solo na área quando você conjura a magia e ao final de cada um dos seus turnos até o fim da magia. Se uma estrutura cair para 0 Pontos de Vida, ela desmorona.

Uma criatura a uma distância de uma estrutura em colapso igual à metade da altura da estrutura realiza um teste de resistência de Destreza. Em caso de falha, a criatura sofre 12d6 de dano de Concussão, fica prostrada e é soterrada pelos escombros, exigindo um teste de Força CD 20 (Atletismo) como ação para escapar. Em caso de sucesso, a criatura sofre apenas metade do dano.',
  'PHB 2024',
  'Clérigo, Druida, Feiticeiro',
  false,
  true,
  'damage',
  '12d6',
  'Concussão'
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 8º círculo foram inseridas
SELECT 
  'Magias de 8º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 8 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 8 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- Total geral (0º a 8º)
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
    WHEN level = 8 THEN '8º Círculo'
  END as nivel,
  COUNT(*) as quantidade
FROM spells 
WHERE source = 'PHB 2024'
  AND level BETWEEN 0 AND 8
GROUP BY level
ORDER BY level;

-- ============================================================
-- FIM DO SCRIPT - 8º CÍRCULO COMPLETO
-- ============================================================
