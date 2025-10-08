-- ============================================================
-- MAGIAS DE 5º CÍRCULO - PHB 2024 (PARTE 1)
-- ============================================================
-- Total: 50 magias essenciais
-- Fonte: Player's Handbook 2024
-- ============================================================

-- ============================================================
-- ABJURAÇÃO (6 magias)
-- ============================================================

-- Concha Antivida
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Concha Antivida',
  5,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S',
  'Concentração, até 1 hora',
  'Uma aura se estende de você em uma Emanação de 3 metros enquanto durar a barreira. A aura impede que criaturas que não sejam Constructos e Mortos-vivos passem ou alcancem através dela. Uma criatura afetada pode conjurar magias ou realizar ataques com armas de Alcance ou de Alcance através da barreira.

Se você se mover de forma que uma criatura afetada seja forçada a passar pela barreira, a magia termina.',
  'PHB 2024',
  'Druida',
  false,
  true
);

-- Círculo de Poder
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Círculo de Poder',
  5,
  'Abjuração',
  'Ação',
  'Próprio',
  'V',
  'Concentração, até 10 minutos',
  'Uma aura irradia de você em uma Emanação de 9 metros durante a duração. Enquanto estiver na aura, você e seus aliados têm Vantagem em testes de resistência contra magias e outros efeitos mágicos. Quando uma criatura afetada realiza um teste de resistência contra uma magia ou efeito mágico que permite que um teste sofra apenas metade do dano, ela não sofre dano se for bem-sucedida no teste.',
  'PHB 2024',
  'Clérigo, Paladino, Mago',
  false,
  true
);

-- Dissipar o Mal e o Bem
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Dissipar o Mal e o Bem',
  5,
  'Abjuração',
  'Ação',
  'Próprio',
  'V, S, M (prata em pó e ferro)',
  'Concentração, até 1 minuto',
  'Enquanto durar, Celestiais, Elementais, Fadas, Demônios e Mortos-vivos terão Desvantagem em jogadas de ataque contra você. Você pode encerrar a magia mais cedo usando qualquer uma das seguintes funções especiais.

Quebrar Encantamento. Como uma ação de Magia, você toca uma criatura que está possuída por ou possui a condição Encantado ou Amedrontado de uma ou mais criaturas dos tipos acima. O alvo não está mais possuído, Encantado ou Amedrontado por tais criaturas.

Dispensa. Como uma ação de Magia, você escolhe uma criatura visível a até 1,5 metro de você que tenha um dos tipos de criatura acima. O alvo deve ser bem-sucedido em um teste de resistência de Carisma ou será enviado de volta ao seu plano de origem, caso ainda não esteja lá. Se não estiver em seu plano de origem, os Mortos-Vivos são enviados para o Pendor das Sombras, e as Fadas são enviadas para a Agrestia das Fadas.',
  'PHB 2024',
  'Clérigo, Paladino',
  false,
  true
);

-- Grande Restauração
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Grande Restauração',
  5,
  'Abjuração',
  'Ação',
  'Toque',
  'V, S, M (pó de diamante que vale mais de 100 GP, que a magia consome)',
  'Instantânea',
  'Você toca em uma criatura e magicamente remove um dos seguintes efeitos dela:

- 1 Nível de exaustão
- A condição Encantada ou Petrificada
- Uma maldição, incluindo a sintonização do alvo com um item mágico amaldiçoado
- Qualquer redução em uma das pontuações de habilidade do alvo
- Qualquer redução no máximo de Pontos de Vida do alvo',
  'PHB 2024',
  'Artífice, Bardo, Clérigo, Druida, Paladino, Patrulheiro',
  false,
  false
);

-- Consagração
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Consagração',
  5,
  'Abjuração',
  '24 horas',
  'Toque',
  'V, S, M (incenso que vale mais de 1.000 GP, que a magia consome)',
  'Até ser dissipado',
  'Você toca um ponto e imbui uma área ao redor com poder sagrado ou profano. A área pode ter um raio de até 18 metros, e a magia falha se o raio incluir uma área já sob o efeito de Consagração. A área afetada tem os seguintes efeitos:

Proteção Sagrada. Escolha qualquer um destes tipos de criatura: Aberração, Celestial, Elemental, Feérico, Demônio ou Morto-vivo. Criaturas dos tipos escolhidos não podem entrar na área voluntariamente.

Efeito Extra. Você vincula um efeito extra à área: Coragem, Escuridão, Luz do dia, Descanso tranquilo, Interferência Extradimensional, Medo, Resistência, Silêncio, Línguas ou Vulnerabilidade.',
  'PHB 2024',
  'Clérigo',
  false,
  false
);

-- Ligação Planar
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Ligação Planar',
  5,
  'Abjuração',
  '1 hora',
  '60 pés',
  'V, S, M (uma joia que vale mais de 1.000 GP, que a magia consome)',
  '24 horas',
  'Você tenta vincular um Celestial, um Elemental, uma Fada ou um Demônio ao seu serviço. A criatura deve estar dentro do alcance durante toda a conjuração da magia. Ao concluir a conjuração, o alvo deve ser bem-sucedido em um teste de resistência de Carisma ou será vinculado a servi-lo durante toda a duração.

Uma criatura aprisionada deve seguir seus comandos da melhor maneira possível. Você pode ordenar que a criatura o acompanhe em uma aventura, proteja um local ou entregue uma mensagem.

Usando um Espaço de Magia de Nível Superior. A duração aumenta com um espaço de magia de nível 6 (10 dias), 7 (30 dias), 8 (180 dias) e 9 (366 dias).',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Bruxo, Mago',
  false,
  false
);

-- ============================================================
-- ADIVINHAÇÃO (6 magias)
-- ============================================================

-- Comuna
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Comuna',
  5,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V, S, M (incenso)',
  '1 minuto',
  'Você contata uma divindade ou um representante divino e faz até três perguntas que podem ser respondidas com sim ou não. Você deve fazer suas perguntas antes do fim do feitiço. Você recebe uma resposta correta para cada pergunta.

Seres divinos não são necessariamente oniscientes, então você pode receber "incerto" como resposta se a pergunta se referir a informações que estão além do conhecimento da divindade.

Se você conjurar o feitiço mais de uma vez antes de terminar um Descanso Longo, há uma chance cumulativa de 25% para cada conjuração após a primeira de você não obter resposta.',
  'PHB 2024',
  'Clérigo',
  true,
  false
);

-- Comungue com a Natureza
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Comungue com a Natureza',
  5,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V, S',
  '1 minuto',
  'Você se comunica com espíritos da natureza e adquire conhecimento da área ao redor. Ao ar livre, a magia concede conhecimento da área em um raio de 5 quilômetros. Em cavernas e outros ambientes naturais subterrâneos, o raio é limitado a 90 metros.

Escolha três dos fatos a seguir; você os aprende conforme eles se relacionam à área da magia:
- Localização dos assentamentos
- Localizações de portais para outros planos de existência
- Localização de uma criatura com Nível de Desafio 10+
- O tipo mais prevalente de planta, mineral ou Besta
- Localização de corpos d''água',
  'PHB 2024',
  'Druida, Patrulheiro',
  true,
  false
);

-- Contato Outro Plano
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration",
  "effect_type", "base_dice", "damage_type"
) VALUES (
  'Contato Outro Plano',
  5,
  'Adivinhação',
  '1 minuto',
  'Próprio',
  'V',
  '1 minuto',
  'Você contata mentalmente um semideus, o espírito de um sábio morto há muito tempo ou alguma outra entidade com conhecimento de outro plano. Contatar essa inteligência sobrenatural pode destruir sua mente. Ao conjurar esta magia, faça um teste de resistência de Inteligência com CD 15. Em caso de sucesso, você pode fazer até cinco perguntas à entidade.

Em caso de falha, você sofre 6d6 de dano Psíquico e permanece na condição Incapacitado até terminar um Descanso Longo. Uma magia de Restauração Maior conjurada em você encerra este efeito.',
  'PHB 2024',
  'Bruxo, Mago',
  true,
  false,
  'damage',
  '6d6',
  'Psíquico'
);

-- Lenda e Conhecimento
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Lenda e Conhecimento',
  5,
  'Adivinhação',
  '10 minutos',
  'Próprio',
  'V, S, M (incenso que vale mais de 250 GP, que a magia consome, e quatro tiras de marfim que valem mais de 50 GP cada)',
  'Instantânea',
  'Nomeie ou descreva uma pessoa, lugar ou objeto famoso. O feitiço traz à sua mente um breve resumo da história significativa sobre aquele objeto famoso, conforme descrito pelo Mestre.

A história pode consistir em detalhes importantes, revelações divertidas ou até mesmo segredos nunca antes conhecidos. Quanto mais informações você já tiver sobre o objeto, mais precisas e detalhadas serão as informações que você receberá.

Se a coisa famosa que você escolheu não for realmente famosa, você ouve notas musicais tristes tocadas em um trombone, e o feitiço falha.',
  'PHB 2024',
  'Bardo, Clérigo, Mago',
  false,
  false
);

-- Vínculo Telepático de Rary
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Vínculo Telepático de Rary',
  5,
  'Adivinhação',
  'Ação',
  '30 pés',
  'V, S, M (dois ovos)',
  '1 hora',
  'Você cria um vínculo telepático entre até oito criaturas voluntárias à sua escolha dentro do alcance, conectando psiquicamente cada criatura a todas as outras durante a duração. Criaturas que não conseguem se comunicar em nenhum idioma não são afetadas por esta magia.

Até o fim do feitiço, os alvos podem se comunicar telepaticamente através do vínculo, independentemente de compartilharem ou não um idioma. A comunicação é possível a qualquer distância, embora não possa se estender a outros planos de existência.',
  'PHB 2024',
  'Bardo, Mago',
  true,
  false
);

-- Vidência
INSERT INTO "public"."spells" (
  "name", "level", "school",
  "casting_time", "range", "components", "duration",
  "description",
  "source", "classes",
  "ritual", "concentration"
) VALUES (
  'Vidência',
  5,
  'Adivinhação',
  '10 minutos',
  'Próprio',
  'V, S, M (um foco que vale mais de 1.000 GP, como uma bola de cristal, espelho ou fonte cheia de água)',
  'Concentração, até 10 minutos',
  'Você pode ver e ouvir uma criatura de sua escolha que esteja no mesmo plano de existência que você. O alvo faz um teste de resistência de Sabedoria, modificado pelo seu conhecimento do alvo e pelo tipo de conexão física que você tem com ele.

Em uma defesa bem-sucedida, o alvo não é afetado e você não pode usar esta magia nele novamente por 24 horas.

Em caso de falha na defesa, a magia cria um sensor invisível e intangível a até 3 metros do alvo. Você pode ver e ouvir através do sensor como se estivesse lá. O sensor se move com o alvo, permanecendo a até 3 metros dele durante a duração.

Em vez de mirar em uma criatura, você pode mirar em um local que viu. Ao fazer isso, o sensor aparece naquele local e não se move.',
  'PHB 2024',
  'Bardo, Clérigo, Druida, Bruxo, Mago',
  false,
  true
);

-- Continua na parte 2...
