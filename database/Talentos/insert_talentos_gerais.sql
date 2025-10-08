-- Talentos Gerais (General Feats) - PHB 2024
-- Pré-requisito: Nível 4+

-- 1. Adepto Elemental (Elemental Adept)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Adepto Elemental',
  'Nível 4+; Característica de Conjuração ou Pacto Mágico',
  '',
  '',
  'PHB 2024',
  'Geral',
  true,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Maestria em Energia",
      "description": "Escolha um dos seguintes tipos de dano: Ácido, Frio, Fogo, Relâmpago ou Trovão. As magias que você conjurar ignoram a Resistência a dano do tipo escolhido. Além disso, ao rolar o dano de uma magia que você conjurar que cause dano daquele tipo, você pode tratar qualquer 1 em um dado de dano como 2."
    },
    {
      "name": "Repetível",
      "description": "Você pode escolher este talento mais de uma vez, mas deve escolher um tipo de dano diferente a cada vez para Maestria em Energia."
    }
  ]'::jsonb
);

-- 2. Ator (Actor)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Ator',
  'Nível 4+, Carisma 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Personificação",
      "description": "Enquanto estiver disfarçado de uma pessoa real ou fictícia, você tem Vantagem em testes de Carisma (Enganação ou Atuação) para convencer os outros de que você é essa pessoa."
    },
    {
      "name": "Mimetismo",
      "description": "Você pode imitar os sons de outras criaturas, incluindo a fala. Uma criatura que ouve o mimetismo deve ser bem-sucedida em um teste de Sabedoria (Intuição) para determinar se o efeito é falso (CD 8 mais seu modificador de Carisma e Bônus de Proficiência)."
    }
  ]'::jsonb
);

-- 3. Atleta (Athlete)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Atleta',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Velocidade de Escalada",
      "description": "Você ganha uma Velocidade de Escalada igual à sua Velocidade."
    },
    {
      "name": "Pule para cima",
      "description": "Quando você está na posição deitado, consegue se endireitar com apenas 1,5 metro de movimento."
    },
    {
      "name": "Pular",
      "description": "Você pode fazer um salto em distância ou em altura correndo após se mover apenas 1,5 metro."
    }
  ]'::jsonb
);

-- 4. Atento (Observant)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Atento',
  'Nível 4+, Inteligência ou Sabedoria 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência ou Sabedoria em 1, até um máximo de 20."
    },
    {
      "name": "Observador Aguçado",
      "description": "Escolha uma das seguintes perícias: Intuição, Investigação ou Percepção. Se você não for proficiente na perícia escolhida, ganhará proficiência nela e, se já for proficiente, ganhará Perícia nela."
    },
    {
      "name": "Busca rápida",
      "description": "Você pode realizar a ação de Busca como uma Ação Bônus."
    }
  ]'::jsonb
);

-- 5. Carregador (Charger)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Carregador',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Corrida Aprimorada",
      "description": "Quando você realiza a ação de Corrida, sua Velocidade aumenta em 3 metros para essa ação."
    },
    {
      "name": "Ataque de Carga",
      "description": "Se você se mover pelo menos 3 metros em linha reta em direção a um alvo imediatamente antes de atingi-lo com uma jogada de ataque corpo a corpo como parte da ação de Ataque, escolha um dos seguintes efeitos: ganhe um bônus de 1d8 na jogada de dano do ataque ou empurre o alvo até 3 metros de distância se ele não for mais do que um tamanho maior que você. Você pode usar este benefício apenas uma vez em cada um dos seus turnos."
    }
  ]'::jsonb
);

-- 6. Chefe de Cozinha (Chef)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Chefe de Cozinha',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Constituição ou Sabedoria em 1, até um máximo de 20."
    },
    {
      "name": "Utensílios de Cozinha",
      "description": "Você ganha proficiência com Utensílios de Cozinha, caso ainda não os tenha."
    },
    {
      "name": "Refeição Reabastecedora",
      "description": "Como parte de um Descanso Curto, você pode cozinhar uma comida especial se tiver ingredientes e Utensílios de Cozinha à mão. Você pode preparar comida suficiente para um número de criaturas igual a 4 mais o seu Bônus de Proficiência. Ao final do Descanso Curto, qualquer criatura que comer a comida e gastar um ou mais Dados de Vida para recuperar Pontos de Vida recupera 1d8 Pontos de Vida adicionais."
    },
    {
      "name": "Guloseimas Reforçadoras",
      "description": "Com 1 hora de trabalho ou ao terminar um Descanso Longo, você pode cozinhar uma quantidade de guloseimas igual ao seu Bônus de Proficiência se tiver ingredientes e Utensílios de Cozinha em mãos. Essas guloseimas especiais duram 8 horas após serem preparadas. Uma criatura pode usar uma Ação Bônus para comer uma dessas guloseimas e ganhar uma quantidade de Pontos de Vida Temporários igual ao seu Bônus de Proficiência."
    }
  ]'::jsonb
);

-- 7. Combatente Montado (Mounted Combatant)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Combatente Montado',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força, Destreza ou Sabedoria em 1, até um máximo de 20."
    },
    {
      "name": "Ataque Montado",
      "description": "Enquanto estiver montado, você tem Vantagem em jogadas de ataque contra qualquer criatura desmontada a até 1,5 m da sua montaria que seja pelo menos um tamanho menor que a montaria."
    },
    {
      "name": "Salto para o Lado",
      "description": "Se sua montaria for submetida a um efeito que lhe permita fazer um teste de resistência de Destreza para receber apenas metade do dano, ela não sofrerá dano se for bem-sucedida no teste e apenas metade do dano se falhar. Para que sua montaria receba esse benefício, você precisa estar montado nela, e nenhum dos dois pode ter a condição Incapacitado."
    },
    {
      "name": "Desviar",
      "description": "Enquanto estiver montado, você pode forçar um ataque que atinja sua montaria a atingir você, caso não tenha a condição Incapacitado."
    }
  ]'::jsonb
);

-- 8. Duelista Defensivo (Defensive Duelist)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Duelista Defensivo',
  'Nível 4+, Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Aparar",
      "description": "Se você estiver segurando uma arma de Finesse e outra criatura o atingir com um ataque corpo a corpo, você pode usar uma Reação para adicionar seu Bônus de Proficiência à sua Classe de Armadura, potencialmente fazendo com que o ataque erre você. Você ganha esse bônus na sua CA contra ataques corpo a corpo até o início do seu próximo turno."
    }
  ]'::jsonb
);

-- 9. Durável (Durable)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Durável',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Constituição em 1, até um máximo de 20."
    },
    {
      "name": "Desafie a Morte",
      "description": "Você tem vantagem em testes de resistência contra Morte."
    },
    {
      "name": "Recuperação Rápida",
      "description": "Como uma Ação Bônus, você pode gastar um dos seus Dados de Pontos de Vida, rolar o dado e recuperar um número de Pontos de Vida igual ao resultado."
    }
  ]'::jsonb
);

-- 10. Especialista em Besta (Crossbow Expert)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Especialista em Besta',
  'Nível 4+, Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Ignorar Carregamento",
      "description": "Você ignora a propriedade de Carregamento da Besta de Mão, Besta Pesada e Besta Leve (todas chamadas de bestas em outras partes deste talento). Se estiver segurando uma delas, você pode carregar uma munição nela mesmo que não tenha uma mão livre."
    },
    {
      "name": "Atirar em combate corpo a corpo",
      "description": "Estar a menos de 1,5 metro de um inimigo não impõe Desvantagem às suas jogadas de ataque com bestas."
    },
    {
      "name": "Empunhadura Dupla",
      "description": "Ao realizar o ataque extra da propriedade Luz, você pode adicionar seu modificador de habilidade ao dano do ataque extra se esse ataque for com uma besta que tenha a propriedade Luz e você ainda não tiver adicionado esse modificador ao dano."
    }
  ]'::jsonb
);

-- 11. Fortemente Blindado (Heavily Armored)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Fortemente Blindado',
  'Nível 4+, Treinamento em Armadura Média',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Constituição ou Força em 1, até um máximo de 20."
    },
    {
      "name": "Treinamento com Armadura",
      "description": "Você ganha treinamento com armadura pesada."
    }
  ]'::jsonb
);

-- 12. Grande Mestre de Armas (Great Weapon Master)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Grande Mestre de Armas',
  'Nível 4+, Força 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Força em 1, até um máximo de 20."
    },
    {
      "name": "Maestria em Arma Pesada",
      "description": "Ao atingir uma criatura com uma arma que tenha a propriedade Pesada como parte da ação de Ataque no seu turno, você pode fazer com que a arma cause dano extra ao alvo. O dano extra é igual ao seu Bônus de Proficiência."
    },
    {
      "name": "Hew",
      "description": "Imediatamente após você conseguir um Acerto Crítico com uma arma corpo a corpo ou reduzir uma criatura a 0 Pontos de Vida com uma, você pode fazer um ataque com a mesma arma como uma Ação Bônus."
    }
  ]'::jsonb
);

-- 13. Levemente Blindado (Lightly Armored)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Levemente Blindado',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Treinamento com Armadura",
      "description": "Você ganha treinamento com armadura leve e escudos."
    }
  ]'::jsonb
);

-- 14. Lutador (Grappler)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Lutador',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Soco e Agarramento",
      "description": "Ao atingir uma criatura com um Ataque Desarmado como parte da ação de Ataque no seu turno, você pode usar tanto a opção de Dano quanto a de Agarrar. Você pode usar este benefício apenas uma vez por turno."
    },
    {
      "name": "Vantagem de Ataque",
      "description": "Você tem Vantagem em jogadas de ataque contra uma criatura agarrada por você."
    },
    {
      "name": "Lutador Rápido",
      "description": "Você não precisa gastar movimento extra para mover uma criatura agarrada por você, seja ela do seu tamanho ou menor."
    }
  ]'::jsonb
);

-- 15. Matador de Magos (Mage Slayer)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Matador de Magos',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Quebrador de Concentração",
      "description": "Quando você causa dano a uma criatura que está se Concentrando, ela tem Desvantagem no teste de resistência que realiza para manter a Concentração."
    },
    {
      "name": "Mente Protegida",
      "description": "Se você falhar em um teste de resistência de Inteligência, Sabedoria ou Carisma, você pode obter sucesso. Depois de usar este benefício, você não poderá usá-lo novamente até terminar um Descanso Curto ou Longo."
    }
  ]'::jsonb
);

-- 16. Mestre de Armadura Pesada (Heavy Armor Master)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Mestre de Armadura Pesada',
  'Nível 4+, Treinamento em Armadura Pesada',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Constituição ou Força em 1, até um máximo de 20."
    },
    {
      "name": "Redução de Dano",
      "description": "Ao ser atingido por um ataque enquanto estiver usando armadura Pesada, qualquer dano de Concussão, Perfuração e Corte causado a você por esse ataque é reduzido em uma quantidade igual ao seu Bônus de Proficiência."
    }
  ]'::jsonb
);

-- 17. Mestre de Armadura Média (Medium Armor Master)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Mestre de Armadura Média',
  'Nível 4+, Treinamento em Armadura Média',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Usuário Destro",
      "description": "Enquanto estiver usando armadura Média, você pode adicionar 3, em vez de 2, à sua CA se tiver um valor de Destreza de 16 ou superior."
    }
  ]'::jsonb
);

-- 18. Mestre em Arma de Haste (Polearm Master)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Mestre em Arma de Haste',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Destreza ou Força em 1, até um máximo de 20."
    },
    {
      "name": "Golpe de Vara",
      "description": "Imediatamente após realizar a ação de Ataque e atacar com um Cajado, uma Lança ou uma arma com as propriedades Pesado e Alcance, você pode usar uma Ação Bônus para realizar um ataque corpo a corpo com a extremidade oposta da arma. A arma causa dano de Concussão, e o dado de dano da arma para este ataque é um d4."
    },
    {
      "name": "Ataque Reativo",
      "description": "Enquanto estiver segurando um Cajado, uma Lança ou uma arma com as propriedades Pesado e Alcance, você pode usar uma Reação para realizar um ataque corpo a corpo contra uma criatura que entre no alcance que você tem com aquela arma."
    }
  ]'::jsonb
);

-- 19. Moderadamente Blindado (Moderately Armored)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Moderadamente Blindado',
  'Nível 4+, Treinamento em Armadura Leve',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Treinamento com Armadura",
      "description": "Você ganha treinamento com armadura Média."
    }
  ]'::jsonb
);

-- 20. Perfurador (Piercer)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Perfurador',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Perfuração",
      "description": "Uma vez por turno, ao atingir uma criatura com um ataque que causa dano Perfurante, você pode rolar novamente um dos dados de dano do ataque e deve usar a nova rolagem."
    },
    {
      "name": "Crítico Aprimorado",
      "description": "Ao obter um Acerto Crítico que cause dano Perfurante a uma criatura, você pode rolar um dado de dano adicional para determinar o dano Perfurante adicional que o alvo recebe."
    }
  ]'::jsonb
);

-- 21. Portador Duplo (Dual Wielder)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Portador Duplo',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Empunhadura Dupla Aprimorada",
      "description": "Ao realizar a ação de Ataque no seu turno e atacar com uma arma que tenha a propriedade Luz, você pode realizar um ataque extra como Ação Bônus posteriormente no mesmo turno com uma arma diferente, que deve ser uma arma Corpo a Corpo sem a propriedade Duas Mãos. Você não adiciona seu modificador de habilidade ao dano do ataque extra, a menos que esse modificador seja negativo."
    },
    {
      "name": "Saque Rápido",
      "description": "Você pode sacar ou guardar duas armas que não possuem a propriedade de Duas Mãos, quando normalmente só poderia sacar ou guardar uma."
    }
  ]'::jsonb
);

-- 22. Tocado por Fey (Fey Touched)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Tocado por Fey',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Magia Feérica",
      "description": "Escolha uma magia de nível 1 da escola de magia Adivinhação ou Encantamento. Você sempre tem essa magia e a magia Passo Nebuloso preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar qualquer uma delas dessa forma, você não poderá conjurá-la novamente até terminar um Descanso Longo. Você também pode conjurar essas magias usando espaços de magia do nível apropriado que você tenha. A habilidade de conjuração das magias é a habilidade aumentada por este talento."
    }
  ]'::jsonb
);

-- 23. Treinamento com Armas Marciais (Weapon Training)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Treinamento com Armas Marciais',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Proficiência em Armas",
      "description": "Você ganha proficiência com armas marciais."
    }
  ]'::jsonb
);

-- 24. Triturador (Crusher)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Triturador',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Constituição em 1, até um máximo de 20."
    },
    {
      "name": "Empurrar",
      "description": "Uma vez por turno, ao atingir uma criatura com um ataque que cause dano de Concussão, você pode movê-la 1,5 metro para um espaço desocupado se o alvo não for mais do que um tamanho maior que você."
    },
    {
      "name": "Crítico Aprimorado",
      "description": "Quando você acerta um Acerto Crítico que causa dano Contundente a uma criatura, as jogadas de ataque contra essa criatura têm Vantagem até o início do seu próximo turno."
    }
  ]'::jsonb
);

-- 25. Envenenador (Poisoner)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Envenenador',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Destreza ou Inteligência em 1, até um máximo de 20."
    },
    {
      "name": "Veneno Potente",
      "description": "Quando você faz uma jogada de dano que causa dano de Veneno, ela ignora a Resistência a dano de Veneno."
    },
    {
      "name": "Preparar Veneno",
      "description": "Você ganha proficiência com o Kit do Envenenador. Com 1 hora de trabalho usando tal kit e gastando 50 GP em materiais, você pode criar um número de doses de veneno igual ao seu Bônus de Proficiência. Como uma Ação Bônus, você pode aplicar uma dose de veneno a uma arma ou munição. Uma vez aplicado, o veneno retém sua potência por 1 minuto ou até você causar dano com o item envenenado, o que ocorrer primeiro. Quando uma criatura sofre dano do item envenenado, ela deve ser bem-sucedida em um teste de resistência de Constituição (CD 8 mais o modificador da habilidade aumentado por este talento e seu Bônus de Proficiência) ou sofrer 2d8 de dano de Veneno e permanecer na condição Envenenado até o final do seu próximo turno."
    }
  ]'::jsonb
);

-- 26. Rápido (Speedy)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Rápido',
  'Nível 4+, Destreza ou Constituição 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Destreza ou Constituição em 1, até um máximo de 20."
    },
    {
      "name": "Aumento de Velocidade",
      "description": "Sua Velocidade aumenta em 3 metros."
    },
    {
      "name": "Avance por Terreno Difícil",
      "description": "Quando você realiza a ação Avance no seu turno, Terreno Difícil não lhe custa movimento extra pelo resto do turno."
    },
    {
      "name": "Movimento Ágil",
      "description": "Ataques de Oportunidade têm Desvantagem contra você."
    }
  ]'::jsonb
);

-- 27. Resiliente (Resilient)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Resiliente',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Escolha uma habilidade na qual você não tenha proficiência em testes de resistência. Aumente o valor de habilidade escolhido em 1, até um máximo de 20."
    },
    {
      "name": "Proficiência em Teste de Resistência",
      "description": "Você ganha proficiência em teste de resistência com a habilidade escolhida."
    }
  ]'::jsonb
);

-- 28. Conjurador de Rituais (Ritual Caster)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Conjurador de Rituais',
  'Nível 4+; Inteligência, Sabedoria ou Carisma 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Magias Rituais",
      "description": "Escolha um número de magias de nível 1 igual ao seu Bônus de Proficiência que tenham a etiqueta Ritual. Você sempre tem essas magias preparadas e pode conjurá-las com qualquer espaço de magia que tiver. A habilidade de conjuração das magias é a habilidade aumentada por este talento. Sempre que seu Bônus de Proficiência aumentar posteriormente, você pode adicionar uma magia de nível 1 adicional com a etiqueta Ritual às magias sempre preparadas com esta característica."
    },
    {
      "name": "Ritual Rápido",
      "description": "Com este benefício, você pode conjurar uma magia de Ritual que preparou usando seu tempo de conjuração normal em vez do tempo estendido de um Ritual. Isso não requer um espaço de magia. Depois de conjurar a magia dessa forma, você não poderá usar este benefício novamente até terminar um Descanso Longo."
    }
  ]'::jsonb
);

-- 29. Sentinela (Sentinel)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Sentinela',
  'Nível 4+, Força ou Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Guardião",
      "description": "Imediatamente após uma criatura a até 1,5 metro de você realizar a ação Desengajar ou atingir um alvo que não seja você com um ataque, você pode realizar um Ataque de Oportunidade contra essa criatura."
    },
    {
      "name": "Parar",
      "description": "Quando você atinge uma criatura com um Ataque de Oportunidade, a Velocidade da criatura se torna 0 pelo resto do turno atual."
    }
  ]'::jsonb
);

-- 30. Tocado pela Sombra (Shadow Touched)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Tocado pela Sombra',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Magia das Sombras",
      "description": "Escolha uma magia de nível 1 da escola de magia Ilusão ou Necromancia. Você sempre tem essa magia e a magia Invisibilidade preparadas. Você pode conjurar cada uma dessas magias sem gastar um espaço de magia. Depois de conjurar qualquer uma delas dessa forma, você não poderá conjurá-la novamente até terminar um Descanso Longo. Você também pode conjurar essas magias usando espaços de magia do nível apropriado que você tenha. A habilidade de conjuração das magias é a habilidade aumentada por este talento."
    }
  ]'::jsonb
);

-- 31. Atirador de Elite (Sharpshooter)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Atirador de Elite',
  'Nível 4+, Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Ignorar Cobertura",
      "description": "Seus ataques à distância com armas ignoram Meia Cobertura e Cobertura de Três Quartos."
    },
    {
      "name": "Atirar em combate corpo a corpo",
      "description": "Estar a menos de 1,5 metro de um inimigo não impõe Desvantagem em suas jogadas de ataque com armas de longo alcance."
    },
    {
      "name": "Tiros de Longo Alcance",
      "description": "Atacar à longa distância não impõe Desvantagem em suas jogadas de ataque com armas de Longo Alcance."
    }
  ]'::jsonb
);

-- 32. Especialista em Habilidades (Skill Expert)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Especialista em Habilidades',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 20."
    },
    {
      "name": "Proficiência em Perícias",
      "description": "Você adquire proficiência em uma perícia de sua escolha."
    },
    {
      "name": "Especialização",
      "description": "Escolha uma perícia na qual você tenha proficiência, mas não tenha Especialização. Você ganha Especialização com essa perícia."
    }
  ]'::jsonb
);

-- 33. Escondido (Skulker)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Escondido',
  'Nível 4+, Destreza 13+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente seu valor de Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Visão às Cegas",
      "description": "Você tem Visão às Cegas com alcance de 3 metros."
    },
    {
      "name": "Névoa de Guerra",
      "description": "Você explora as distrações da batalha, ganhando Vantagem em qualquer teste de Destreza (Furtividade) que fizer como parte da ação Esconder-se durante o combate."
    },
    {
      "name": "Atirador de Elite",
      "description": "Se você fizer uma jogada de ataque enquanto estiver escondido e o resultado for errar, fazer a jogada de ataque não revelará sua localização."
    }
  ]'::jsonb
);

-- 34. Assassino (Slasher)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Assassino',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Isquiotibiais",
      "description": "Uma vez por turno, ao atingir uma criatura com um ataque que cause dano cortante, você pode reduzir a Velocidade daquela criatura em 3 metros até o início do seu próximo turno."
    },
    {
      "name": "Crítico Aprimorado",
      "description": "Quando você acerta um Acerto Crítico que causa dano Cortante a uma criatura, ela tem Desvantagem nas jogadas de ataque até o início do seu próximo turno."
    }
  ]'::jsonb
);

-- 35. Atirador de Feitiços (Spell Sniper)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Atirador de Feitiços',
  'Nível 4+; Característica de Conjuração ou Pacto Mágico',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Ignorar Cobertura",
      "description": "Seus ataques para magias ignoram Meia Cobertura e Cobertura de Três Quartos."
    },
    {
      "name": "Conjuração em Combate Corpo a Corpo",
      "description": "Estar a menos de 1,5 metro de um inimigo não impõe Desvantagem em suas jogadas de ataque com magias."
    },
    {
      "name": "Alcance Aumentado",
      "description": "Ao conjurar uma magia com alcance de pelo menos 3 metros e que exija uma jogada de ataque, você pode aumentar o alcance da magia em 18 metros."
    }
  ]'::jsonb
);

-- 36. Telecinético (Telekinetic) - Versão Geral
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Telecinético',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Telecinese Menor",
      "description": "Você aprende a magia Mão Mágica. Você pode conjurá-la sem componentes Verbais ou Somáticos, pode tornar a mão espectral invisível, e seu alcance e a distância que ela pode atingir de você aumentam em 9 metros quando você a conjura. A habilidade de conjuração da magia é a habilidade aumentada por este talento."
    },
    {
      "name": "Empurrão Telecinético",
      "description": "Como uma Ação Bônus, você pode empurrar telecineticamente uma criatura que você possa ver a até 9 metros de você. Ao fazer isso, o alvo deve ser bem-sucedido em um teste de resistência de Força (CD 8 mais o modificador de habilidade do valor aumentado por este talento e seu Bônus de Proficiência) ou será movido 1,5 metro em sua direção ou para longe de você."
    }
  ]'::jsonb
);

-- 37. Telepático (Telepathic) - Versão Geral
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Telepático',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Elocução Telepática",
      "description": "Você pode falar telepaticamente com qualquer criatura que possa ver a até 18 metros de distância. Suas elocuções telepáticas são feitas em um idioma que você conhece, e a criatura só o entende se conhecer esse idioma. Sua comunicação não dá à criatura a capacidade de responder telepaticamente."
    },
    {
      "name": "Detectar Pensamentos",
      "description": "Você sempre tem a magia Detectar Pensamentos preparada. Você pode conjurá-la sem um espaço de magia ou componentes de magia, e precisa terminar um Descanso Longo antes de poder conjurá-la dessa forma novamente. Você também pode conjurá-la usando espaços de magia que você tenha do nível apropriado. Sua habilidade de conjuração para a magia é a habilidade aumentada por este talento."
    }
  ]'::jsonb
);

-- 38. Conjurador de Guerra (War Caster)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Conjurador de Guerra',
  'Nível 4+; Característica de Conjuração ou Pacto Mágico',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Concentração",
      "description": "Você tem Vantagem em testes de resistência de Constituição que realiza para manter a Concentração."
    },
    {
      "name": "Magia Reativa",
      "description": "Quando uma criatura provoca um Ataque de Oportunidade saindo do seu alcance, você pode usar uma Reação para conjurar uma magia contra a criatura em vez de realizar um Ataque de Oportunidade. A magia deve ter um tempo de conjuração de uma ação e deve ter como alvo apenas aquela criatura."
    },
    {
      "name": "Componentes Somáticos",
      "description": "Você pode executar os componentes somáticos das magias mesmo quando tiver armas ou um escudo em uma ou ambas as mãos."
    }
  ]'::jsonb
);

-- 39. Mestre de Armas (Weapon Master)
INSERT INTO "public"."feats" (
  "name",
  "prerequisite",
  "description",
  "benefit",
  "source",
  "category",
  "is_repeatable",
  "abilities"
) VALUES (
  'Mestre de Armas',
  'Nível 4+',
  '',
  '',
  'PHB 2024',
  'Geral',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 20."
    },
    {
      "name": "Propriedade de Maestria",
      "description": "Seu treinamento com armas permite que você use a propriedade de maestria de um tipo de arma Simples ou Marcial de sua escolha, desde que você tenha proficiência nela. Sempre que terminar um Descanso Longo, você pode trocar o tipo de arma por outro tipo elegível."
    }
  ]'::jsonb
);