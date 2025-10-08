-- ============================================================
-- INSERÇÃO DE EQUIPAMENTOS - PHB 2024 - PARTE 1
-- ============================================================
-- Itens de Aventura, Ferramentas, Instrumentos e Focos
-- ============================================================

-- ============================================================
-- ITENS DE AVENTURA
-- ============================================================

-- Ácido
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ácido',
  'Item de Aventura',
  25.00, '25', 'PO',
  1.00, '1',
  'Ao realizar a ação de Ataque, você pode substituir um dos seus ataques por lançar um frasco de Ácido. Escolha uma criatura ou objeto que você possa ver a até 6 metros de distância. O alvo deve ser bem-sucedido em um teste de resistência de Destreza (CD 8 mais seu modificador de Destreza e Bônus de Proficiência) ou sofrerá 2d6 de dano de Ácido.',
  'PHB 2024'
);

-- Fogo do Alquimista
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Fogo do Alquimista',
  'Item de Aventura',
  50.00, '50', 'PO',
  1.00, '1',
  'Ao realizar a ação de Ataque, você pode substituir um dos seus ataques por lançar um frasco de Fogo do Alquimista. Escolha uma criatura ou objeto que você possa ver a até 6 metros de distância. O alvo deve ser bem-sucedido em um teste de resistência de Destreza (CD 8 mais seu modificador de Destreza e Bônus de Proficiência) ou sofrerá 1d4 de dano de Fogo e começará a queimar.',
  'PHB 2024'
);

-- Antitoxina
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Antitoxina',
  'Item de Aventura',
  50.00, '50', 'PO',
  NULL, '',
  'Como uma Ação Bônus, você pode beber um frasco de Antitoxina para ganhar Vantagem em testes de resistência para evitar ou encerrar a condição Envenenado por 1 hora.',
  'PHB 2024'
);

-- Mochila
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Mochila',
  'Item de Aventura',
  2.00, '2', 'PO',
  5.00, '5',
  'Uma mochila suporta até 13,6 kg em 1 pé cúbico. Ela também pode servir como alforje.',
  'PHB 2024'
);

-- Rolamentos de Esferas
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Rolamentos de Esferas',
  'Item de Aventura',
  1.00, '1', 'PO',
  2.00, '2',
  'Com uma ação Utilizar, você pode derramar Rolamentos de Esferas da bolsa. Eles se espalham, cobrindo uma área plana de 3 metros quadrados a até 3 metros de você. Uma criatura que entrar nessa área pela primeira vez em um turno deve ser bem-sucedida em um teste de resistência de Destreza CD 10 ou ter a condição Caído. Leva 10 minutos para recuperar os Rolamentos de Esferas.',
  'PHB 2024'
);

-- Veneno Básico
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Veneno Básico',
  'Item de Aventura',
  100.00, '100', 'PO',
  NULL, '',
  'Como uma Ação Bônus, você pode usar um frasco de Veneno Básico para revestir uma arma ou até três munições. Uma criatura que sofrer dano Perfurante ou Cortante da arma ou munição envenenada sofre 1d4 de dano de Veneno adicional. Uma vez aplicado, o veneno mantém sua potência por 1 minuto ou até que seu dano seja causado, o que ocorrer primeiro.',
  'PHB 2024'
);

-- Cesta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cesta',
  'Item de Aventura',
  0.40, '4', 'PP',
  2.00, '2',
  'Uma cesta comporta até 40 libras em 2 pés cúbicos.',
  'PHB 2024'
);

-- Saco de Dormir
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Saco de Dormir',
  'Item de Aventura',
  1.00, '1', 'PO',
  7.00, '7',
  'Um Saco de Dormir acomoda uma criatura Pequena ou Média. Enquanto estiver em um Saco de Dormir, você obtém sucesso automático em testes de resistência contra frio extremo (consulte o Guia do Mestre).',
  'PHB 2024'
);

-- Cobertor
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cobertor',
  'Item de Aventura',
  0.50, '5', 'PP',
  3.00, '3',
  'Enquanto estiver envolto em um cobertor, você tem vantagem em testes de resistência contra frio extremo (veja o Guia do Mestre).',
  'PHB 2024'
);

-- Bloqueio e Tackle
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bloqueio e Tackle',
  'Item de Aventura',
  1.00, '1', 'PO',
  5.00, '5',
  'Um bloco e equipamento permitem que você levante até quatro vezes o peso que você normalmente consegue levantar.',
  'PHB 2024'
);

-- Livro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Livro',
  'Item de Aventura',
  25.00, '25', 'PO',
  5.00, '5',
  'Um livro contém ficção ou não ficção. Se você consultar um livro de não ficção preciso sobre o assunto, você ganha um bônus de +5 em testes de Inteligência (Arcano, História, Natureza ou Religião) que fizer sobre o assunto.',
  'PHB 2024'
);

-- Balde
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Balde',
  'Item de Aventura',
  0.05, '5', 'PC',
  2.00, '2',
  'Um balde comporta até meio pé cúbico de conteúdo.',
  'PHB 2024'
);

-- Lanterna Bullseye
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Lanterna Bullseye',
  'Item de Aventura',
  10.00, '10', 'PO',
  2.00, '2',
  'Uma Lanterna Alvo queima Óleo como combustível para lançar Luz Brilhante em um Cone de 18 metros e Luz Fraca por mais 18 metros.',
  'PHB 2024'
);

-- Estrepes
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Estrepes',
  'Item de Aventura',
  1.00, '1', 'PO',
  2.00, '2',
  'Com uma ação Utilizar, você pode espalhar Estrepes da bolsa para cobrir uma área de 1,5 metro quadrado a até 1,5 metro de você. Uma criatura que entrar nessa área pela primeira vez em um turno deve ser bem-sucedida em um teste de resistência de Destreza CD 15 ou sofrer 1 de dano Perfurante e ter sua Velocidade reduzida a 0 até o início do próximo turno. Leva 10 minutos para recuperar os Estrepes.',
  'PHB 2024'
);

-- Vela
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Vela',
  'Item de Aventura',
  0.01, '1', 'PC',
  NULL, '',
  'Durante 1 hora, uma vela acesa emite luz brilhante em um raio de 1,5 m e luz fraca por mais 1,5 m.',
  'PHB 2024'
);

-- Corrente
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Corrente',
  'Item de Aventura',
  5.00, '5', 'PO',
  10.00, '10',
  'Com uma ação de Utilizar, você pode enrolar uma Corrente em uma criatura relutante a até 1,5 metro de você que tenha a condição Agarrado, Incapacitado ou Contido, se for bem-sucedido em um teste de Força (Atletismo) CD 13. Se as pernas da criatura estiverem amarradas, ela terá a condição Contido até escapar. Escapar da Corrente requer que a criatura faça um teste bem-sucedido de Destreza (Acrobacia) CD 18 como ação. Romper a Corrente requer um teste bem-sucedido de Força (Atletismo) CD 20 como ação.',
  'PHB 2024'
);

-- Baú
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Baú',
  'Item de Aventura',
  5.00, '5', 'PO',
  25.00, '25',
  'Um baú comporta até 12 pés cúbicos de conteúdo.',
  'PHB 2024'
);

-- Kit de Escalador
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit de Escalador',
  'Item de Aventura',
  25.00, '25', 'PO',
  12.00, '12',
  'Um Kit de Escalador inclui pontas de botas, luvas, pitons e um arnês. Como uma ação de Utilizar, você pode usar o Kit de Escalador para se ancorar; ao fazer isso, você não pode cair a mais de 7,5 metros do ponto de ancoragem e não pode se mover a mais de 7,5 metros de lá sem desfazer a ancoragem como uma Ação Bônus.',
  'PHB 2024'
);

-- Bolsa de Componentes
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Bolsa de Componentes',
  'Item de Aventura',
  25.00, '25', 'PO',
  2.00, '2',
  'Uma Bolsa de Componentes é à prova d''água e cheia de compartimentos que armazenam todos os componentes materiais gratuitos de suas magias.',
  'PHB 2024'
);

-- Fantasia
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Fantasia',
  'Item de Aventura',
  5.00, '5', 'PO',
  4.00, '4',
  'Ao usar uma Fantasia, você tem Vantagem em qualquer teste de habilidade que fizer para personificar a pessoa ou tipo de pessoa que ela representa.',
  'PHB 2024'
);

-- Pé de Cabra
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pé de Cabra',
  'Item de Aventura',
  2.00, '2', 'PO',
  5.00, '5',
  'Usar um pé-de-cabra lhe dá vantagem em testes de Força onde a alavancagem do pé-de-cabra pode ser aplicada.',
  'PHB 2024'
);

-- ============================================================
-- PACOTES DE EQUIPAMENTO
-- ============================================================

-- Pacote do Ladrão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Ladrão',
  'Item de Aventura',
  16.00, '16', 'PO',
  47.50, '47½',
  'Um Pacote de Ladrão contém os seguintes itens: Mochila, Rolamentos de Esferas, Sino, 10 Velas, Pé de Cabra, Lanterna com Capuz, 7 frascos de Óleo, 5 dias de Rações, Corda, Caixa de Fogo e Odre de Água.',
  'PHB 2024'
);

-- Pacote do Diplomata
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Diplomata',
  'Item de Aventura',
  39.00, '39', 'PO',
  39.00, '39',
  'Um Pacote de Diplomata contém os seguintes itens: Baú, Roupas Finas, Tinta, 5 Canetas de Tinta, Lâmpada, 2 Estojos para Mapas ou Pergaminhos, 4 frascos de Óleo, 5 folhas de Papel, 5 folhas de Pergaminho, Perfume e Caixa de Isca.',
  'PHB 2024'
);

-- Pacote do Dungeoner
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Dungeoner',
  'Item de Aventura',
  12.00, '12', 'PO',
  55.00, '55',
  'Um Pacote de Dungeon contém os seguintes itens: Mochila, Estrepes, Pé de Cabra, 2 frascos de Óleo, 10 dias de Rações, Corda, Caixa de Fogo, 10 Tochas e Odre de Água.',
  'PHB 2024'
);

-- Pacote do Artista
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Artista',
  'Item de Aventura',
  40.00, '40', 'PO',
  58.50, '58½',
  'Um pacote de artista contém os seguintes itens: mochila, saco de dormir, sino, lanterna de alvo, 3 fantasias, espelho, 8 frascos de óleo, 9 dias de rações, caixa de fogo e odre de água.',
  'PHB 2024'
);

-- Pacote do Explorador
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pacote do Explorador',
  'Item de Aventura',
  10.00, '10', 'PO',
  55.00, '55',
  'Um Pacote de Explorador contém os seguintes itens: Mochila, Saco de Dormir, 2 frascos de Óleo, 10 dias de Rações, Corda, Caixa de Fogo, 10 Tochas e Odre de Água.',
  'PHB 2024'
);

-- ============================================================
-- FERRAMENTAS DE ARTESÃO
-- ============================================================

-- Suprimentos do Alquimista
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Suprimentos do Alquimista',
  'Ferramenta',
  50.00, '50', 'PO',
  8.00, '8',
  'Habilidade: Inteligência. Utilizar: Identificar uma substância (CD 15) ou iniciar um incêndio (CD 15). Artesanato: Ácido, Fogo do Alquimista, Bolsa de Componentes, Óleo, Papel, Perfume. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Suprimentos para Cervejeiros
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Suprimentos para Cervejeiros',
  'Ferramenta',
  20.00, '20', 'PO',
  9.00, '9',
  'Habilidade: Inteligência. Utilizar: Detectar bebida envenenada (CD 15) ou identificar álcool (CD 10). Artesanato: Antitoxina. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Suprimentos para Calígrafo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Suprimentos para Calígrafo',
  'Ferramenta',
  10.00, '10', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Escrever texto com floreios impressionantes que protejam contra falsificação (CD 15). Artesanato: Tinta, Pergaminho de Feitiço. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Carpinteiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Carpinteiro',
  'Ferramenta',
  8.00, '8', 'PO',
  6.00, '6',
  'Habilidade: Força. Utilizar: Selar ou arrombar uma porta ou recipiente (CD 20). Artesanato: Clava, Clava grande, Bastão, Barril, Baú, Escada, Vara, Carneiro portátil, Tocha. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Cartógrafo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Cartógrafo',
  'Ferramenta',
  15.00, '15', 'PO',
  6.00, '6',
  'Habilidade: Sabedoria. Utilizar: Elaborar um mapa de uma pequena área (CD 15). Artesanato: Mapa. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Sapateiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Sapateiro',
  'Ferramenta',
  5.00, '5', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Modificar calçados para dar Vantagem no próximo teste de Destreza (Acrobacia) do usuário (CD 10). Artesanato: Kit de Alpinista. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Utensílios de Cozinha
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Utensílios de Cozinha',
  'Ferramenta',
  1.00, '1', 'PO',
  8.00, '8',
  'Habilidade: Sabedoria. Utilizar: Melhorar o sabor da comida (CD 10) ou detectar comida estragada ou envenenada (CD 15). Artesanato: Rações. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Kit de Disfarce
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit de Disfarce',
  'Ferramenta',
  25.00, '25', 'PO',
  3.00, '3',
  'Habilidade: Carisma. Utilizar: Aplicar maquiagem (CD 10). Artesanato: Traje. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Kit de Falsificação
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit de Falsificação',
  'Ferramenta',
  15.00, '15', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Imitar 10 ou menos palavras da caligrafia de outra pessoa (CD 15) ou duplicar um selo de cera (CD 20). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Soprador de Vidro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Soprador de Vidro',
  'Ferramenta',
  30.00, '30', 'PO',
  5.00, '5',
  'Habilidade: Inteligência. Utilizar: Discernir o que um objeto de vidro segurou nas últimas 24 horas (CD 15). Artesanato: Garrafa de vidro, Lupa, Luneta, Frasco. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Kit de Herbalismo
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit de Herbalismo',
  'Ferramenta',
  5.00, '5', 'PO',
  3.00, '3',
  'Habilidade: Inteligência. Utilizar: Identificar uma planta (CD 10). Artesanato: Antitoxina, Vela, Kit do Curandeiro, Poção de Cura. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Joalheiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Joalheiro',
  'Ferramenta',
  25.00, '25', 'PO',
  2.00, '2',
  'Habilidade: Inteligência. Utilizar: Discernir o valor de uma gema (CD 15). Artesanato: Foco Arcano, Símbolo Sagrado. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Marceneiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Marceneiro',
  'Ferramenta',
  5.00, '5', 'PO',
  5.00, '5',
  'Habilidade: Destreza. Utilizar: Adicionar um design a um item de couro (CD 10). Artesanato: Funda, Chicote, Armadura de Couro, Armadura de Couro Cravejada, Mochila, Estojo para Flecha de Besta, Estojo para Mapa ou Pergaminho, Pergaminho, Bolsa, Aljava, Odre de Água. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Pedreiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Pedreiro',
  'Ferramenta',
  10.00, '10', 'PO',
  8.00, '8',
  'Habilidade: Força. Utilizar: Esculpir um símbolo ou buraco na pedra (CD 10). Artesanato: Bloco e Tackle. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas do Navegador
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas do Navegador',
  'Ferramenta',
  25.00, '25', 'PO',
  2.00, '2',
  'Habilidade: Sabedoria. Utilizar: Traçar um curso (CD 10) ou determinar a posição observando as estrelas (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Suprimentos para Pintores
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Suprimentos para Pintores',
  'Ferramenta',
  10.00, '10', 'PO',
  5.00, '5',
  'Habilidade: Sabedoria. Utilizar: Pintar uma imagem reconhecível de algo que você viu (CD 10). Artesanato: Foco Druídico, Símbolo Sagrado. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Kit de Envenenamento
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit de Envenenamento',
  'Ferramenta',
  50.00, '50', 'PO',
  2.00, '2',
  'Habilidade: Inteligência. Utilizar: Detectar um objeto envenenado (CD 10). Artesanato: Veneno Básico. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Ferramentas de Oleiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Ferramentas de Oleiro',
  'Ferramenta',
  10.00, '10', 'PO',
  3.00, '3',
  'Habilidade: Inteligência. Utilizar: Discernir o que um objeto de cerâmica segurou nas últimas 24 horas (CD 15). Artesanato: Jarro, Lâmpada. Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- INSTRUMENTOS MUSICAIS
-- ============================================================

-- Gaitas de Fole
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Gaitas de Fole',
  'Instrumento Musical',
  30.00, '30', 'PO',
  6.00, '6',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Tambor
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Tambor',
  'Instrumento Musical',
  6.00, '6', 'PO',
  3.00, '3',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Saltério
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Saltério',
  'Instrumento Musical',
  25.00, '25', 'PO',
  10.00, '10',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Flauta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Flauta',
  'Instrumento Musical',
  2.00, '2', 'PO',
  1.00, '1',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Buzina
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Buzina',
  'Instrumento Musical',
  3.00, '3', 'PO',
  2.00, '2',
  'Habilidade: Carisma. Utilizar: Tocar uma melodia conhecida (CD 10) ou improvisar uma música (CD 15). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- FOCOS DE CONJURAÇÃO
-- ============================================================

-- Amuleto (Símbolo Sagrado)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Amuleto',
  'Foco em conjuração',
  5.00, '5', 'PO',
  1.00, '1',
  'Para que um Amuleto seja um Símbolo Sagrado eficaz, ele deve ser usado ou segurado. Um Símbolo Sagrado assume uma forma específica e é adornado com joias ou pintado para canalizar magia divina. Um Clérigo ou Paladino pode usar um Símbolo Sagrado como Foco de Conjuração.',
  'PHB 2024'
);

-- Emblema (Símbolo Sagrado)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Emblema',
  'Foco em conjuração',
  5.00, '5', 'PO',
  NULL, '',
  'Para que um Emblema seja um Símbolo Sagrado eficaz, ele deve ser usado em tecido (como um tabardo ou estandarte) ou em um Escudo. Um Símbolo Sagrado assume uma forma específica e é adornado com joias ou pintado para canalizar magia divina. Um Clérigo ou Paladino pode usar um Símbolo Sagrado como Foco de Conjuração.',
  'PHB 2024'
);

-- Cristal (Foco Arcano)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Cristal',
  'Foco em conjuração',
  10.00, '10', 'PO',
  1.00, '1',
  'Um Foco Arcano assume uma forma específica e é adornado ou esculpado para canalizar magia arcana. Um Feiticeiro, Bruxo ou Mago pode usar tal item como um Foco de Conjuração.',
  'PHB 2024'
);

-- ============================================================
-- CONJUNTOS DE JOGOS
-- ============================================================

-- Conjunto de Dados
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Conjunto de Dados',
  'Conjunto de Jogos',
  0.10, '1', 'PP',
  NULL, '',
  'Habilidade: Sabedoria. Utilizar: Discernir se alguém está trapaceando (CD 10) ou vencer o jogo (CD 20). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- Conjunto de Xadrez Dragão
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Conjunto de Xadrez Dragão',
  'Conjunto de Jogos',
  1.00, '1', 'PO',
  NULL, '',
  'Habilidade: Sabedoria. Utilizar: Discernir se alguém está trapaceando (CD 10) ou vencer o jogo (CD 20). Se você tiver proficiência com uma ferramenta, adicione seu Bônus de Proficiência a qualquer teste de habilidade que utilize a ferramenta.',
  'PHB 2024'
);

-- ============================================================
-- ITENS DIVERSOS
-- ============================================================

-- Roupas Finas
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Roupas Finas',
  'Item de Aventura',
  15.00, '15', 'PO',
  6.00, '6',
  'Roupas finas são feitas de tecidos caros e adornadas com detalhes habilmente trabalhados. Alguns eventos e locais só permitem a entrada de pessoas usando essas roupas.',
  'PHB 2024'
);

-- Frasco
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Frasco',
  'Item de Aventura',
  0.02, '2', 'PC',
  1.00, '1',
  'Um frasco contém até 1 litro.',
  'PHB 2024'
);

-- Garrafa de Vidro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Garrafa de Vidro',
  'Item de Aventura',
  2.00, '2', 'PO',
  2.00, '2',
  'Uma garrafa de vidro comporta até 1½ pintas.',
  'PHB 2024'
);

-- Gancho de Escalada
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Gancho de Escalada',
  'Item de Aventura',
  2.00, '2', 'PO',
  4.00, '4',
  'Com uma ação de Utilização, você pode lançar o Gancho de Escalada em um corrimão, uma saliência ou outro objeto a até 15 metros de você, e o gancho se prenderá se você for bem-sucedido em um teste de Destreza (Acrobacia) CD 13. Se você amarrou uma Corda ao gancho, poderá escalá-lo.',
  'PHB 2024'
);

-- Kit do Curandeiro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Kit do Curandeiro',
  'Item de Aventura',
  5.00, '5', 'PO',
  3.00, '3',
  'Um Kit de Curandeiro tem dez usos. Com uma ação de Utilizar, você pode gastar um de seus usos para estabilizar uma criatura Inconsciente com 0 Pontos de Vida sem precisar fazer um teste de Sabedoria (Medicina).',
  'PHB 2024'
);

-- Água Benta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Água Benta',
  'Item de Aventura',
  25.00, '25', 'PO',
  1.00, '1',
  'Ao realizar a ação de Ataque, você pode substituir um dos seus ataques por arremessar um frasco de Água Benta. Escolha uma criatura que você possa ver a até 6 metros de você. O alvo deve ser bem-sucedido em um teste de resistência de Destreza (CD 8 mais seu modificador de Destreza e Bônus de Proficiência) ou sofrer 2d8 de dano Radiante se for um Demônio ou um Morto-vivo.',
  'PHB 2024'
);

-- Lanterna com Capuz
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Lanterna com Capuz',
  'Item de Aventura',
  5.00, '5', 'PO',
  2.00, '2',
  'Uma Lanterna com Capuz queima Óleo como combustível para conjurar Luz Brilhante em um raio de 9 metros e Luz Fraca por mais 9 metros. Como uma Ação Bônus, você pode abaixar o capuz, reduzindo a luz para Luz Fraca em um raio de 1,5 metro, ou levantá-lo novamente.',
  'PHB 2024'
);

-- Armadilha de Caça
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Armadilha de Caça',
  'Item de Aventura',
  5.00, '5', 'PO',
  25.00, '25',
  'Como uma ação Utilizar, você pode armar uma Armadilha de Caça, que é um anel de aço em forma de dente de serra que se fecha quando uma criatura pisa em uma placa de pressão no centro. A armadilha é fixada por uma corrente pesada a um objeto imóvel. Uma criatura que pisa na placa deve ser bem-sucedida em um teste de resistência de Destreza CD 13 ou sofrer 1d4 de dano Perfurante e ter sua Velocidade reduzida a 0.',
  'PHB 2024'
);

-- Tinta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Tinta',
  'Item de Aventura',
  10.00, '10', 'PO',
  NULL, '',
  'A tinta vem em um frasco de 1 onça, que fornece tinta suficiente para escrever cerca de 500 páginas.',
  'PHB 2024'
);

-- Caneta de Tinta
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Caneta de Tinta',
  'Item de Aventura',
  0.02, '2', 'PC',
  NULL, '',
  'Usando tinta, uma caneta de tinta é usada para escrever ou desenhar.',
  'PHB 2024'
);

-- Panela de Ferro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Panela de Ferro',
  'Item de Aventura',
  2.00, '2', 'PO',
  10.00, '10',
  'Uma panela de ferro tem capacidade para até 1 galão.',
  'PHB 2024'
);

-- Pico de Ferro
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Pico de Ferro',
  'Item de Aventura',
  0.01, '1', 'PC',
  0.50, '½',
  'Espinhos de Ferro vêm em pacotes de dez. Como uma ação de Utilização, você pode usar um objeto rombudo, como um Martelo Leve, para martelar um espinho em madeira, terra ou material similar. Você pode fazer isso para trancar uma porta ou amarrar uma Corda ou Corrente ao Espinho.',
  'PHB 2024'
);

-- Picos de Ferro (10)
INSERT INTO "public"."equipment" (
  "name", "type", "cost", "cost_text", "cost_currency", "weight", "weight_text",
  "description", "source"
) VALUES (
  'Picos de Ferro (10)',
  'Item de Aventura',
  1.00, '1', 'PO',
  5.00, '5',
  'Espinhos de Ferro vêm em pacotes de dez. Como uma ação de Utilização, você pode usar um objeto rombudo, como um Martelo Leve, para martelar um espinho em madeira, terra ou material similar.',
  'PHB 2024'
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
SELECT COUNT(*) as total_itens FROM equipment WHERE source = 'PHB 2024';
