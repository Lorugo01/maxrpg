-- ============================================================
-- INSERÇÃO DE EQUIPAMENTOS - PHB 2024 - PARTE 3
-- ============================================================
-- Instrumentos Adicionais, Itens Diversos, Armas Adicionais
-- ============================================================

-- ============================================================
-- INSTRUMENTOS MUSICAIS ADICIONAIS
-- ============================================================

-- Alaúde
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Alaúde',
  'Instrumento Musical',
  35.00, '35', 'PO',
  2.00, '2',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Lira
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Lira',
  'Instrumento Musical',
  30.00, '30', 'PO',
  2.00, '2',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Flauta de Pã
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Flauta de Pã',
  'Instrumento Musical',
  12.00, '12', 'PO',
  2.00, '2',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Shawm
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Shawm',
  'Instrumento Musical',
  2.00, '2', 'PO',
  1.00, '1',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Viola
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Viola',
  'Instrumento Musical',
  30.00, '30', 'PO',
  1.00, '1',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- CONJUNTOS DE JOGOS ADICIONAIS
-- ============================================================

-- Cartas de Jogar
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cartas de Jogar',
  'Conjunto de Jogos',
  0.50, '5', 'PP',
  NULL, '',
  'Habilidade: Sabedoria. Utilizar: Discernir se alguém está trapaceando (CD 10) ou vencer o jogo (CD 20). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- ITENS DIVERSOS
-- ============================================================

-- Jarro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Jarro',
  'Item de Aventura',
  0.02, '2', 'PC',
  4.00, '4',
  'Uma jarra comporta até 1 galão.',
  'PHB 2024'
);

-- Escada
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Escada',
  'Item de Aventura',
  0.10, '1', 'PP',
  25.00, '25',
  'Uma escada tem 3 metros de altura. Você precisa subir ou descer para subir.',
  'PHB 2024'
);

-- Lâmpada
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Lâmpada',
  'Item de Aventura',
  0.50, '5', 'PP',
  1.00, '1',
  'Uma lâmpada queima óleo como combustível para lançar luz brilhante em um raio de 4,5 metros e luz fraca por mais 9 metros.',
  'PHB 2024'
);

-- Fechadura
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Fechadura',
  'Item de Aventura',
  10.00, '10', 'PO',
  1.00, '1',
  'Uma fechadura vem com uma chave. Sem a chave, uma criatura pode usar Ferramentas de Ladrão para arrombar esta fechadura com um teste bem-sucedido de Destreza (Prestidigitação) CD 15.',
  'PHB 2024'
);

-- Lupa
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Lupa',
  'Item de Aventura',
  100.00, '100', 'PO',
  NULL, '',
  'Uma Lupa concede Vantagem em qualquer teste de habilidade feito para avaliar ou inspecionar um item altamente detalhado. Acender uma fogueira com uma Lupa requer luz tão brilhante quanto a luz do sol para focar, isca para acender e cerca de 5 minutos para o fogo acender.',
  'PHB 2024'
);

-- Algemas
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Algemas',
  'Item de Aventura',
  2.00, '2', 'PO',
  6.00, '6',
  'Como uma ação Utilizar, você pode usar Algemas para prender uma criatura Pequena ou Média relutante a até 1,5 metro de você que tenha a condição Agarrado, Incapacitado ou Contido se você for bem-sucedido em um teste de Destreza (Prestidigitação) CD 13. Escapar das Algemas requer um teste bem-sucedido de Destreza (Prestidigitação) CD 20. Explodi-las requer um teste bem-sucedido de Força (Atletismo) CD 25.',
  'PHB 2024'
);

-- Mapa
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Mapa',
  'Item de Aventura',
  1.00, '1', 'PO',
  NULL, '',
  'Se você consultar um Mapa preciso, você ganha um bônus de +5 nos testes de Sabedoria (Sobrevivência) que você faz para encontrar seu caminho no lugar representado nele.',
  'PHB 2024'
);

-- Estojo para Mapas ou Pergaminhos
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Estojo para Mapas ou Pergaminhos',
  'Item de Aventura',
  1.00, '1', 'PO',
  1.00, '1',
  'Um estojo para mapas ou pergaminhos comporta até 10 folhas de papel ou 5 folhas de pergaminho.',
  'PHB 2024'
);

-- Espelho
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Espelho',
  'Item de Aventura',
  5.00, '5', 'PO',
  0.50, '½',
  'Um espelho de aço portátil é útil para cosméticos pessoais, mas também para espiar pelos cantos e refletir a luz como um sinal.',
  'PHB 2024'
);

-- Rede
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Rede',
  'Item de Aventura',
  1.00, '1', 'PO',
  3.00, '3',
  'Ao realizar a ação de Ataque, você pode substituir um dos seus ataques por lançar uma Rede. Escolha uma criatura que você possa ver a até 4,5 metros de você. O alvo deve ser bem-sucedido em um teste de resistência de Destreza (CD 8 mais seu modificador de Destreza e Bônus de Proficiência) ou permanecer na condição Restringido até escapar. Para escapar, o alvo deve realizar um teste de Força CD 10 (Atletismo). Destruir a Rede (CA 10; 5 PV) também liberta o alvo.',
  'PHB 2024'
);

-- Óleo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Óleo',
  'Item de Aventura',
  0.10, '1', 'PP',
  1.00, '1',
  'Você pode encharcar uma criatura, objeto ou espaço com Óleo ou usá-lo como combustível. Ao realizar a ação de Ataque, você pode substituir um dos seus ataques por lançar um frasco de Óleo. O alvo deve ser bem-sucedido em um teste de resistência de Destreza ou ficará coberto de óleo. Se o alvo sofrer dano de Fogo antes que o óleo seque (após 1 minuto), ele sofre 5 de dano de Fogo adicionais. O óleo serve como combustível para Lâmpadas e Lanternas. Uma vez aceso, um frasco de Óleo queima por 6 horas.',
  'PHB 2024'
);

-- Papel
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Papel',
  'Item de Aventura',
  0.20, '2', 'PP',
  NULL, '',
  'Uma folha de papel pode conter cerca de 250 palavras escritas à mão.',
  'PHB 2024'
);

-- Pergaminho
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pergaminho',
  'Item de Aventura',
  0.10, '1', 'PP',
  NULL, '',
  'Uma folha de pergaminho pode conter cerca de 250 palavras escritas à mão.',
  'PHB 2024'
);

-- Perfume
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Perfume',
  'Item de Aventura',
  5.00, '5', 'PO',
  NULL, '',
  'O perfume vem em um frasco de 113 ml. Por 1 hora após aplicar o Perfume em si mesmo, você tem Vantagem em testes de Carisma (Persuasão) para influenciar um Humanoide Indiferente a até 1,5 metro de você.',
  'PHB 2024'
);

-- Vara
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Vara',
  'Item de Aventura',
  0.05, '5', 'PC',
  7.00, '7',
  'Um bastão tem 3 metros de comprimento. Você pode usá-lo para tocar em algo a até 3 metros de distância. Se precisar fazer um teste de Força (Atletismo) como parte de um Salto em Altura ou em Distância, você pode usar o bastão para saltar, ganhando vantagem no teste.',
  'PHB 2024'
);

-- Aríete Portátil
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Aríete Portátil',
  'Item de Aventura',
  4.00, '4', 'PO',
  35.00, '35',
  'Você pode usar um Aríete Portátil para arrombar portas. Ao fazer isso, você ganha um bônus de +4 no teste de Força. Outro personagem pode ajudá-lo a usar o aríete, concedendo-lhe Vantagem neste teste.',
  'PHB 2024'
);

-- Bolsa
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bolsa',
  'Item de Aventura',
  0.50, '5', 'PP',
  1.00, '1',
  'Uma bolsa comporta até 6 libras em um quinto de um pé cúbico.',
  'PHB 2024'
);

-- Pacote do Sacerdote
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Sacerdote',
  'Item de Aventura',
  33.00, '33', 'PO',
  29.00, '29',
  'O Pacote de um Sacerdote contém os seguintes itens: Mochila, Cobertor, Água Benta, Lâmpada, 7 dias de Rações, Manto e Caixa de Fogo.',
  'PHB 2024'
);

-- Pacote do Acadêmico
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Acadêmico',
  'Item de Aventura',
  40.00, '40', 'PO',
  22.00, '22',
  'Um pacote de estudioso contém os seguintes itens: mochila, livro, tinta, caneta de tinta, lâmpada, 10 frascos de óleo, 10 folhas de pergaminho e caixa de isca.',
  'PHB 2024'
);

-- Rações
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Rações',
  'Item de Aventura',
  0.50, '5', 'PP',
  2.00, '2',
  'As rações consistem em alimentos prontos para viagem, incluindo carne seca, frutas secas, biscoitos e nozes. Consulte "Desnutrição" para saber os riscos de não comer.',
  'PHB 2024'
);

-- Manto
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Manto',
  'Item de Aventura',
  1.00, '1', 'PO',
  4.00, '4',
  'Um robe tem significado vocacional ou cerimonial. Alguns eventos e locais só permitem a entrada de pessoas usando robes com determinadas cores ou símbolos.',
  'PHB 2024'
);

-- Corda
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Corda',
  'Item de Aventura',
  1.00, '1', 'PO',
  5.00, '5',
  'Como uma ação de Utilizar, você pode dar um nó com Corda se for bem-sucedido em um teste de Destreza (Prestidigitação) CD 10. A Corda pode ser arrebentada com um teste bem-sucedido de Força (Atletismo) CD 20. Você pode prender uma criatura relutante com a Corda somente se ela tiver a condição Agarrada, Incapacitada ou Contida. Escapar da Corda requer um teste de Destreza (Acrobacia) CD 15.',
  'PHB 2024'
);

-- Saco
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Saco',
  'Item de Aventura',
  0.01, '1', 'PC',
  0.50, '½',
  'Um saco comporta até 30 libras em 1 pé cúbico.',
  'PHB 2024'
);

-- Pá
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pá',
  'Item de Aventura',
  2.00, '2', 'PO',
  5.00, '5',
  'Trabalhando por 1 hora, você pode usar uma pá para cavar um buraco de 1,5 m de cada lado no solo ou material similar.',
  'PHB 2024'
);

-- Apito de Sinal
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Apito de Sinal',
  'Item de Aventura',
  0.05, '5', 'PC',
  NULL, '',
  'Quando soprado como uma ação Utilizar, um Apito de Sinal produz um som que pode ser ouvido a até 180 metros de distância.',
  'PHB 2024'
);

-- Corda (curta)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Corda (3 metros)',
  'Item de Aventura',
  0.10, '1', 'PP',
  NULL, '',
  'A corda tem 3 metros de comprimento. Você pode dar um nó nela com uma ação de Utilização.',
  'PHB 2024'
);

-- Barraca
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Barraca',
  'Item de Aventura',
  2.00, '2', 'PO',
  20.00, '20',
  'Uma barraca acomoda até duas criaturas pequenas ou médias.',
  'PHB 2024'
);

-- Luneta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Luneta',
  'Item de Aventura',
  1000.00, '1.000', 'PO',
  1.00, '1',
  'Objetos vistos através de uma luneta são ampliados para o dobro de seu tamanho.',
  'PHB 2024'
);

-- Aljava
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Aljava',
  'Item de Aventura',
  1.00, '1', 'PO',
  1.00, '1',
  'Uma aljava comporta até 20 flechas.',
  'PHB 2024'
);

-- ============================================================
-- FOCOS DE CONJURAÇÃO ADICIONAIS
-- ============================================================

-- Esfera
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Esfera',
  'Foco em conjuração',
  20.00, '20', 'PO',
  3.00, '3',
  'Um Foco Arcano assume uma forma específica e é adornado ou esculpado para canalizar magia arcana. Um Feiticeiro, Bruxo ou Mago pode usar tal item como um Foco de Conjuração.',
  'PHB 2024'
);

-- Relicário
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Relicário',
  'Foco em conjuração',
  5.00, '5', 'PO',
  2.00, '2',
  'Para que um Relicário seja um Símbolo Sagrado eficaz, ele deve ser segurado. Um Símbolo Sagrado assume uma forma específica e é adornado com joias ou pintado para canalizar magia divina. Um Clérigo ou Paladino pode usar um Símbolo Sagrado como Foco de Conjuração.',
  'PHB 2024'
);

-- Haste
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Haste',
  'Foco em conjuração',
  10.00, '10', 'PO',
  2.00, '2',
  'Um Foco Arcano assume uma forma específica e é adornado ou esculpado para canalizar magia arcana. Um Feiticeiro, Bruxo ou Mago pode usar tal item como um Foco de Conjuração.',
  'PHB 2024'
);

-- Raminho de Visco
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Raminho de Visco',
  'Foco em conjuração',
  1.00, '1', 'PO',
  NULL, '',
  'Um Foco Druídico assume uma forma específica e é esculpido, amarrado com fita ou pintado para canalizar magia primordial. Um Druida ou Patrulheiro pode usar tal objeto como um Foco de Conjuração.',
  'PHB 2024'
);

-- Varinha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Varinha',
  'Foco em conjuração',
  10.00, '10', 'PO',
  1.00, '1',
  'Um Foco Arcano assume uma forma específica e é adornado ou esculpado para canalizar magia arcana. Um Feiticeiro, Bruxo ou Mago pode usar tal item como um Foco de Conjuração.',
  'PHB 2024'
);

-- Cajado de Madeira
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "weapon_properties", "weapon_mastery",
  "description", "source"
) VALUES (
  'Cajado de Madeira',
  'Foco em conjuração',
  5.00, '5', 'PO',
  4.00, '4',
  '1d6', 'Concussão',
  'Versátil (1d8)',
  'Derrubar',
  'Um Foco Druídico assume uma forma específica e é esculpido, amarrado com fita ou pintado para canalizar magia primordial. Um Druida ou Patrulheiro pode usar tal objeto como um Foco de Conjuração. Pode ser usado como arma.',
  'PHB 2024'
);

-- Varinha de Teixo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Varinha de Teixo',
  'Foco em conjuração',
  10.00, '10', 'PO',
  1.00, '1',
  'Um Foco Druídico assume uma forma específica e é esculpido, amarrado com fita ou pintado para canalizar magia primordial. Um Druida ou Patrulheiro pode usar tal objeto como um Foco de Conjuração.',
  'PHB 2024'
);

-- ============================================================
-- FERRAMENTAS ADICIONAIS
-- ============================================================

-- Ferramentas de Ladrão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Ladrão',
  'Ferramenta',
  25.00, '25', 'PO',
  1.00, '1',
  'Habilidade: Destreza. Utilizar: Arrombar uma fechadura (CD 15) ou desarmar uma armadilha (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Smith
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Smith',
  'Ferramenta',
  20.00, '20', 'PO',
  8.00, '8',
  'Habilidade: Força. Utilizar: Abrir uma porta ou recipiente (CD 20). Artesanato: Qualquer arma corpo a corpo (exceto clava, clava grande, cajado e chicote), armadura média (exceto couro), armadura pesada, rolamentos de esferas, balde, estrepes, corrente, pé-de-cabra, balas de arma de fogo, gancho de escalada, panela de ferro, pontas de ferro, balas de funda. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Consertador
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Consertador',
  'Ferramenta',
  50.00, '50', 'PO',
  10.00, '10',
  'Habilidade: Destreza. Utilizar: Montar um pequeno item feito de sucata, que se desfaz em 1 minuto (CD 20). Artesanato: Mosquete, Pistola, Sino, Lanterna Alvo, Frasco, Lanterna com Capuz, Armadilha de Caça, Trava, Algemas, Espelho, Pá, Apito de Sinal, Caixa de Fogo. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Tecelão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Tecelão',
  'Ferramenta',
  1.00, '1', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Remendar um rasgo em uma roupa (CD 10) ou costurar um desenho pequeno (CD 10). Artesanato: Armadura acolchoada, Cesta, Saco de dormir, Cobertor, Roupas finas, Rede, Manto, Corda, Saco, Barbante, Tenda, Roupas de viajante. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Entalhador
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Entalhador',
  'Ferramenta',
  1.00, '1', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Esculpir um padrão em madeira (CD 10). Artesanato: Clava, Clava grande, Bastão, Armas de longo alcance (exceto Pistola, Mosquete e Funda), Foco Arcano, Flechas, Virotes, Foco Druídico, Caneta de tinta, Agulhas. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- CONJUNTOS DE JOGOS ADICIONAIS
-- ============================================================

-- Conjunto de Ante de Três Dragões
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Conjunto de Ante de Três Dragões',
  'Conjunto de Jogos',
  1.00, '1', 'PO',
  NULL, '',
  'Habilidade: Sabedoria. Utilizar: Discernir se alguém está trapaceando (CD 10) ou vencer o jogo (CD 20). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- ITENS DIVERSOS ADICIONAIS
-- ============================================================

-- Caixa de Pólvora (Caixa de Fogo)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Caixa de Fogo',
  'Item de Aventura',
  0.50, '5', 'PP',
  1.00, '1',
  'Uma Caixa de Fogo é um pequeno recipiente que contém sílex, aço de fogo e isca (geralmente um pano seco embebido em óleo leve) usado para acender uma fogueira. Usá-la para acender uma Vela, Lâmpada, Lanterna ou Tocha requer uma Ação Bônus. Acender qualquer outra fogueira leva 1 minuto.',
  'PHB 2024'
);

-- Tocha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "damage", "damage_type", "description", "source"
) VALUES (
  'Tocha',
  'Item de Aventura',
  0.01, '1', 'PC',
  1.00, '1',
  '1', 'Fogo',
  'Uma Tocha queima por 1 hora, lançando Luz Brilhante em um raio de 6 metros e Luz Fraca por mais 6 metros. Ao realizar a ação de Ataque, você pode atacar com a Tocha, usando-a como uma arma corpo a corpo simples. Ao acertar, o alvo sofre 1 de dano de Fogo.',
  'PHB 2024'
);

-- Roupas de Viajante
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Roupas de Viajante',
  'Item de Aventura',
  2.00, '2', 'PO',
  4.00, '4',
  'Roupas de viagem são peças resistentes, projetadas para viagens em diversos ambientes.',
  'PHB 2024'
);

-- Frasco
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Frasco',
  'Item de Aventura',
  1.00, '1', 'PO',
  NULL, '',
  'Um frasco contém até 4 onças.',
  'PHB 2024'
);

-- Odre de Água
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Odre de Água',
  'Item de Aventura',
  0.20, '2', 'PP',
  5.00, '5 (cheio)',
  'Um odre de água comporta até 4 pints. Se você não beber água suficiente, corre o risco de desidratação.',
  'PHB 2024'
);

-- Bugiganga
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bugiganga',
  'Item de Aventura',
  NULL, '', '',
  NULL, '',
  'Ao criar seu personagem, você pode rolar uma vez na tabela de Bugigangas para ganhar uma Bugiganga Minúscula, um item simples com um leve toque de mistério. O Mestre também pode usar esta tabela. Ela pode ajudar a abastecer uma sala em uma masmorra ou encher os bolsos de uma criatura.',
  'PHB 2024'
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
SELECT COUNT(*) as total_itens FROM equipment WHERE source = 'PHB 2024';
