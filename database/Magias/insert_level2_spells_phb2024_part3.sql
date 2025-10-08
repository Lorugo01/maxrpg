-- ============================================================
-- MAGIAS DE 2º CÍRCULO - PHB 2024 (PARTE 3)
-- ============================================================
-- Continuação final das magias de 2º círculo
-- ============================================================

-- ============================================================
-- NECROMANCIA (3 magias)
-- ============================================================

-- Repouso Suave
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Repouso Suave',
  2,
  'Necromancia',
  'Ação',
  'Toque',
  'V, S, M (2 Peças de Cobre, que o feitiço consome)',
  '10 dias',
  'Você toca um cadáver ou outros restos mortais. Durante a duração, o alvo fica protegido da decomposição e não pode se tornar morto-vivo.

O feitiço também estende efetivamente o limite de tempo para ressuscitar o alvo dos mortos, já que dias passados ​​sob a influência deste feitiço não contam para o limite de tempo de feitiços como Ressuscitar Mortos.',
  'PHB 2024',
  'Clérigo, Paladino, Mago',
  true,
  false
);

-- Raio de Enfraquecimento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Raio de Enfraquecimento',
  2,
  'Necromancia',
  'Ação',
  '60 pés',
  'V, S',
  'Concentração, até 1 minuto',
  'Um raio de energia enfraquecedora é disparado de você em direção a uma criatura dentro do alcance. O alvo deve realizar um teste de resistência de Constituição. Em caso de sucesso, o alvo recebe Desvantagem na próxima jogada de ataque que fizer até o início do seu próximo turno.

Em caso de falha na defesa, o alvo tem Desvantagem em Testes D20 baseados em Força durante o período. Durante esse tempo, ele também subtrai 1d8 de todas as suas jogadas de dano. O alvo repete a defesa ao final de cada um dos seus turnos, encerrando a magia em caso de sucesso.',
  'PHB 2024',
  'Bruxo, Mago',
  false,
  true
);

-- Oração de Cura (já implementado no 1º círculo, mas é 2º círculo)
DELETE FROM "public"."spells" WHERE name = 'Oração de Cura' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice",
  "upcast_dice_per_level"
) VALUES (
  'Oração de Cura',
  2,
  'Abjuração',
  '10 minutos',
  '30 pés',
  'V',
  'Instantânea',
  'Até cinco criaturas à sua escolha que permanecerem dentro do alcance durante toda a conjuração da magia ganham os benefícios de um Descanso Curto e também recuperam 2d8 Pontos de Vida. Uma criatura não pode ser afetada por esta magia novamente até que termine um Descanso Longo.

Usando um Espaço de Magia de Nível Superior. A cura aumenta em 1d8 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  false,
  'healing',
  '2d8',
  '1d8'
);

-- ============================================================
-- TRANSMUTAÇÃO (12 magias)
-- ============================================================

-- Pele de Casca de Árvore (já implementado no 1º círculo, mas é 2º círculo)
DELETE FROM "public"."spells" WHERE name = 'Pele de Casca de Árvore' AND level = 1;

INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Pele de Casca de Árvore',
  2,
  'Transmutação',
  'Ação Bônus',
  'Toque',
  'V, S, M (um punhado de casca de carvalho)',
  '1 hora',
  'Você toca uma criatura disposta. Até o fim da magia, a pele do alvo assume uma aparência de casca de árvore, e o alvo tem uma Classe de Armadura 17 se sua CA for menor que isso.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  false
);

-- Visão no Escuro
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Visão no Escuro',
  2,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (uma cenoura seca)',
  '8 horas',
  'Durante a duração, uma criatura disposta que você tocar terá Visão no Escuro com um alcance de 45 metros.',
  'PHB 2024',
  'Artífice, Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  false
);

-- Sopro do Dragão
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Sopro do Dragão',
  2,
  'Transmutação',
  'Ação Bônus',
  'Toque',
  'V, S, M (uma pimenta)',
  'Concentração, até 1 minuto',
  'Você toca uma criatura disposta e escolhe Ácido, Frio, Fogo, Relâmpago ou Veneno. Até o fim da magia, o alvo pode realizar uma ação de Magia para exalar um Cone de 4,5 metros. Cada criatura naquela área realiza um teste de resistência de Destreza, sofrendo 3d6 de dano do tipo escolhido em caso de falha ou metade desse dano em caso de sucesso.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d6 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Feiticeiro, Mago',
  false,
  true,
  'damage',
  '3d6',
  'Variável',
  '1d6'
);

-- Aumentar a Capacidade
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Aumentar a Capacidade',
  2,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (pelo ou pena)',
  'Concentração, até 1 hora',
  'Você toca uma criatura e escolhe Força, Destreza, Inteligência, Sabedoria ou Carisma. Enquanto durar o efeito, o alvo tem Vantagem em testes de habilidade usando a habilidade escolhida.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 2. Você pode escolher uma habilidade diferente para cada alvo.',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Patrulheiro, Feiticeiro, Mago',
  false,
  true,
  '1 criatura'
);

-- Ampliar/Reduzir
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ampliar/Reduzir',
  2,
  'Transmutação',
  'Ação',
  '30 pés',
  'V, S, M (uma pitada de ferro em pó)',
  'Concentração, até 1 minuto',
  'Enquanto durar, a magia aumenta ou diminui o tamanho de uma criatura ou objeto visível dentro do alcance (veja o efeito escolhido abaixo). O objeto alvo não deve ser usado nem carregado. Se o alvo for uma criatura relutante, ela pode realizar um teste de resistência de Constituição. Em caso de sucesso, a magia não tem efeito.

Tudo o que uma criatura alvo estiver vestindo e carregando muda de tamanho junto com ela. Qualquer item que ela derrubar retorna ao tamanho normal imediatamente. Uma arma ou munição arremessada retorna ao tamanho normal imediatamente após atingir ou errar um alvo.

Ampliar. O tamanho do alvo aumenta em uma categoria — de Médio para Grande, por exemplo. O alvo também tem Vantagem em testes de Força e testes de resistência de Força. Os ataques do alvo com suas armas ampliadas ou Ataques Desarmados causam 1d4 de dano extra em cada acerto.

Reduzir. O tamanho do alvo diminui em uma categoria — de Médio para Pequeno, por exemplo. O alvo também tem Desvantagem em testes de Força e testes de resistência de Força. Os ataques do alvo com suas armas reduzidas ou Ataques Desarmados causam 1d4 a menos de dano em um acerto (isso não pode reduzir o dano para menos de 1).',
  'PHB 2024',
  'Artífice, Bardo, Druida, Feiticeiro, Mago',
  false,
  true
);

-- Metal Térmico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type",
  "upcast_dice_per_level"
) VALUES (
  'Metal Térmico',
  2,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S, M (um pedaço de ferro e uma chama)',
  'Concentração, até 1 minuto',
  'Escolha um objeto de metal manufaturado, como uma arma de metal ou uma armadura de metal Pesada ou Média, que você possa ver dentro do alcance. Você faz o objeto brilhar em brasa. Qualquer criatura em contato físico com o objeto sofre 2d8 de dano de Fogo quando você conjura a magia. Até o fim da magia, você pode realizar uma Ação Bônus em cada um dos seus turnos subsequentes para causar esse dano novamente se o objeto estiver dentro do alcance.

Se uma criatura estiver segurando ou vestindo o objeto e sofrer dano, ela deve ser bem-sucedida em um teste de resistência de Constituição ou largar o objeto, se possível. Se não largar o objeto, ela terá Desvantagem em jogadas de ataque e testes de habilidade até o início do seu próximo turno.

Usando um Espaço de Magia de Nível Superior. O dano aumenta em 1d8 para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Artífice, Bardo, Druida',
  false,
  true,
  'damage',
  '2d8',
  'Fogo',
  '1d8'
);

-- Bater
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Bater',
  2,
  'Transmutação',
  'Ação',
  '60 pés',
  'V',
  'Instantânea',
  'Escolha um objeto que você possa ver dentro do alcance. O objeto pode ser uma porta, uma caixa, um baú, um conjunto de algemas, um cadeado ou outro objeto que contenha um meio mundano ou mágico que impeça o acesso.

Um alvo mantido fechado por uma fechadura comum ou que esteja preso ou bloqueado pode ser destrancado, destrancado ou destrancado. Se o objeto tiver várias fechaduras, apenas uma delas será destrancada.

Se o alvo for mantido fechado por Trava Arcana, a magia será suprimida por 10 minutos, tempo durante o qual o alvo poderá ser aberto e fechado.

Quando você lança o feitiço, uma batida forte, audível a até 90 metros de distância, emana do alvo.',
  'PHB 2024',
  'Bardo, Feiticeiro, Mago',
  false,
  false
);

-- Levitar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Levitar',
  2,
  'Transmutação',
  'Ação',
  '60 pés',
  'V, S, M (uma mola de metal)',
  'Concentração, até 10 minutos',
  'Uma criatura ou objeto solto à sua escolha que você possa ver dentro do alcance sobe verticalmente até 6 metros e permanece suspenso lá enquanto durar a magia. A magia pode levitar um objeto que pesa até 227 kg. Uma criatura relutante que seja bem-sucedida em um teste de resistência de Constituição não é afetada.

O alvo só pode se mover empurrando ou puxando um objeto fixo ou superfície ao seu alcance (como uma parede ou teto), o que lhe permite se mover como se estivesse escalando. Você pode alterar a altitude do alvo em até 6 metros em qualquer direção no seu turno. Se você for o alvo, poderá se mover para cima ou para baixo como parte do seu movimento. Caso contrário, você pode realizar uma ação de Magia para mover o alvo, que deve permanecer dentro do alcance da magia.

Quando o feitiço termina, o alvo flutua suavemente até o chão se ainda estiver no ar.',
  'PHB 2024',
  'Artífice, Feiticeiro, Mago',
  false,
  true
);

-- Boca Mágica
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Boca Mágica',
  2,
  'Ilusão',
  '1 minuto',
  '30 pés',
  'V, S, M (pó de jade que vale 10+ GP, que a magia consome)',
  'Até ser dissipado',
  'Você implanta uma mensagem em um objeto dentro do alcance — uma mensagem que é proferida quando uma condição de ativação é atendida. Escolha um objeto que você possa ver e que não esteja sendo usado ou carregado por outra criatura. Em seguida, fale a mensagem, que deve ter 25 palavras ou menos, embora possa ser entregue em até 10 minutos. Por fim, determine a circunstância que desencadeará a magia para entregar sua mensagem.

Quando esse gatilho ocorre, uma boca mágica aparece no objeto e recita a mensagem com a sua voz e no mesmo volume que você falou. Se o objeto escolhido tiver uma boca ou algo que se pareça com uma boca (por exemplo, a boca de uma estátua), a boca mágica aparece ali, de modo que as palavras parecem sair da boca do objeto. Ao conjurar esta magia, você pode fazer com que ela termine após a transmissão da mensagem, ou ela pode permanecer e repetir a mensagem sempre que o gatilho ocorrer.

O gatilho pode ser tão geral ou detalhado quanto você desejar, embora deva ser baseado em condições visuais ou audíveis que ocorram a até 9 metros do objeto. Por exemplo, você pode instruir a boca a falar quando qualquer criatura se mover a até 9 metros do objeto ou quando um sino prateado tocar a até 9 metros dele.',
  'PHB 2024',
  'Artífice, Bardo, Mago',
  true,
  false
);

-- Arma Mágica
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Arma Mágica',
  2,
  'Transmutação',
  'Ação Bônus',
  'Toque',
  'V, S',
  '1 hora',
  'Você toca em uma arma não mágica. Até que a magia termine, essa arma se torna uma arma mágica com +1 de bônus em jogadas de ataque e dano. A magia termina mais cedo se você conjurá-la novamente.

Usando um Espaço de Magia de Nível Superior. O bônus aumenta para +2 com um espaço de magia de nível 3-5. O bônus aumenta para +3 com um espaço de magia de nível 6+.',
  'PHB 2024',
  'Artífice, Paladino, Patrulheiro, Feiticeiro, Mago',
  false,
  false
);

-- Truque de Corda
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Truque de Corda',
  2,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (um segmento de corda)',
  '1 hora',
  'Você toca uma corda. Uma ponta dela paira para cima até que a corda fique perpendicular ao chão ou atinja o teto. Na ponta superior da corda, um portal invisível de 90 cm por 1,50 m se abre para um espaço extradimensional que dura até o fim da magia. Esse espaço pode ser alcançado escalando a corda, que pode ser puxada para dentro ou para fora dela.

O espaço pode conter até oito criaturas médias ou menores. Ataques, magias e outros efeitos não podem entrar ou sair do espaço, mas criaturas dentro dele podem ver através do portal. Qualquer coisa dentro do espaço é descartada quando a magia termina.',
  'PHB 2024',
  'Artífice, Mago',
  false,
  false
);

-- Escalada de Aranha
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "upcast_dice_per_level"
) VALUES (
  'Escalada de Aranha',
  2,
  'Transmutação',
  'Ação',
  'Toque',
  'V, S, M (uma gota de betume e uma aranha)',
  'Concentração, até 1 hora',
  'Até o fim da magia, uma criatura voluntária que você tocar ganha a habilidade de se mover para cima, para baixo e através de superfícies verticais e tetos, deixando as mãos livres. O alvo também ganha uma Velocidade de Escalada igual à sua Velocidade.

Usando um Espaço de Magia de Nível Superior. Você pode escolher uma criatura adicional para cada nível de espaço de magia acima de 2.',
  'PHB 2024',
  'Artífice, Feiticeiro, Bruxo, Mago',
  false,
  true,
  '1 criatura'
);

-- Crescimento de Pico
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Crescimento de Pico',
  2,
  'Transmutação',
  'Ação',
  '150 pés',
  'V, S, M (sete espinhos)',
  'Concentração, até 10 minutos',
  'O solo em uma Esfera de 6 metros de raio centrada em um ponto dentro do alcance brota espinhos e espinhos duros. A área se torna Terreno Difícil enquanto durar a ação. Quando uma criatura se move para dentro ou dentro da área, ela sofre 2d4 de dano Perfurante a cada 1,5 metro que percorre.

A transformação do solo é camuflada para parecer natural. Qualquer criatura que não consiga ver a área quando a magia for lançada deve realizar uma ação de Procurar e obter sucesso em um teste de Sabedoria (Percepção ou Sobrevivência) contra sua CD de resistência à magia para reconhecer o terreno como perigoso antes de entrar nele.',
  'PHB 2024',
  'Druida, Patrulheiro',
  false,
  true,
  'damage',
  '2d4',
  'Perfurante'
);

-- ============================================================
-- VERIFICAÇÃO FINAL
-- ============================================================

-- Verificar quantas magias de 2º círculo foram inseridas
SELECT 
  'Magias de 2º círculo inseridas com sucesso!' as status,
  COUNT(*) as total_magias
FROM spells 
WHERE level = 2 
  AND source = 'PHB 2024';

-- Ver por escola
SELECT 
  school,
  COUNT(*) as quantidade
FROM spells 
WHERE level = 2 
  AND source = 'PHB 2024'
GROUP BY school
ORDER BY quantidade DESC;

-- ============================================================
-- FIM DO SCRIPT - PARTE 3
-- ============================================================
