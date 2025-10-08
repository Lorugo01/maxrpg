-- Talentos de Dádiva Épica (Epic Boon Feats) - PHB 2024
-- Pré-requisito: Nível 19+

-- 1. Dádiva da Proeza de Combate (Boon of Combat Prowess)
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
  'Dádiva da Proeza de Combate',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Mira Inigualável",
      "description": "Ao errar uma jogada de ataque, você pode acertar. Depois de usar este benefício, você não poderá usá-lo novamente até o início do seu próximo turno."
    }
  ]'::jsonb
);

-- 2. Dádiva da Viagem Dimensional (Boon of Dimensional Travel)
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
  'Dádiva da Viagem Dimensional',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Passos de Teletransporte",
      "description": "Imediatamente após realizar a ação de Ataque ou a ação de Magia, você pode se teletransportar até 9 metros para um espaço desocupado que você possa ver."
    }
  ]'::jsonb
);

-- 3. Dádiva da Resistência à Energia (Boon of Energy Resistance)
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
  'Dádiva da Resistência à Energia',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Resistências de Energia",
      "description": "Você ganha Resistência a dois dos seguintes tipos de dano à sua escolha: Ácido, Frio, Fogo, Relâmpago, Necrótico, Venenoso, Psíquico, Radiante ou Trovão. Sempre que terminar um Descanso Longo, você pode mudar suas escolhas."
    },
    {
      "name": "Redirecionamento de Energia",
      "description": "Ao sofrer dano de um dos tipos escolhidos para o benefício de Resistências à Energia, você pode usar uma Reação para direcionar dano do mesmo tipo para outra criatura que você possa ver a até 18 metros de você e que não esteja atrás de Cobertura Total. Se fizer isso, essa criatura deve ser bem-sucedida em um teste de resistência de Destreza (CD 8 mais seu modificador de Constituição e Bônus de Proficiência) ou sofrerá dano igual a 2d12 mais seu modificador de Constituição."
    }
  ]'::jsonb
);

-- 4. Dádiva do Destino (Boon of Fate)
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
  'Dádiva do Destino',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Melhorar Destino",
      "description": "Quando você ou outra criatura a até 18 metros de você obtiver sucesso ou falhar em um Teste de D20, você pode rolar 2d4 e aplicar o total obtido como bônus ou penalidade à rolagem de d20. Depois de usar este benefício, você não poderá usá-lo novamente até rolar Iniciativa ou terminar um Descanso Curto ou Longo."
    }
  ]'::jsonb
);

-- 5. Dádiva da Fortitude (Boon of Fortitude)
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
  'Dádiva da Fortitude',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Saúde Fortificada",
      "description": "Seu máximo de Pontos de Vida aumenta em 40. Além disso, sempre que recuperar Pontos de Vida, você pode recuperar Pontos de Vida adicionais iguais ao seu modificador de Constituição. Depois de recuperar esses Pontos de Vida adicionais, você não poderá fazê-lo novamente até o início do seu próximo turno."
    }
  ]'::jsonb
);

-- 6. Dádiva da Ofensa Irresistível (Boon of Irresistible Offense)
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
  'Dádiva da Ofensa Irresistível',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Força ou Destreza em 1, até um máximo de 30."
    },
    {
      "name": "Supere Defesas",
      "description": "O dano de Concussão, Perfuração e Corte que você causa sempre ignora a Resistência."
    },
    {
      "name": "Golpe Esmagador",
      "description": "Ao tirar 20 no d20 em uma jogada de ataque, você pode causar dano extra ao alvo igual ao valor de habilidade aumentado por este talento. O tipo de dano extra é o mesmo que o tipo de ataque."
    }
  ]'::jsonb
);

-- 7. Dádiva da Recuperação (Boon of Recovery)
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
  'Dádiva da Recuperação',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Última Resistência",
      "description": "Quando você for reduzido a 0 Pontos de Vida, você pode cair para 1 Ponto de Vida e recuperar uma quantidade de Pontos de Vida igual à metade do seu máximo de Pontos de Vida. Depois de usar este benefício, você não poderá usá-lo novamente até terminar um Descanso Longo."
    },
    {
      "name": "Recuperar Vitalidade",
      "description": "Você tem um conjunto de dez d10s. Como uma Ação Bônus, você pode gastar dados do conjunto, rolar esses dados e recuperar uma quantidade de Pontos de Vida igual ao total da rolagem. Você recupera todos os dados gastos ao terminar um Descanso Longo."
    }
  ]'::jsonb
);

-- 8. Dádiva da Habilidade (Boon of Skill)
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
  'Dádiva da Habilidade',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Adepto Completo",
      "description": "Você ganha proficiência em todas as perícias."
    },
    {
      "name": "Especialização",
      "description": "Escolha uma perícia na qual você não tenha Especialização. Você ganha Especialização nessa perícia."
    }
  ]'::jsonb
);

-- 9. Dádiva da Velocidade (Boon of Speed)
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
  'Dádiva da Velocidade',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Artista da Fuga",
      "description": "Como Ação Bônus, você pode realizar a ação Desengajar, que também encerra a condição Agarrado em você."
    },
    {
      "name": "Rapidez",
      "description": "Sua velocidade aumenta em 9 metros."
    }
  ]'::jsonb
);

-- 10. Dádiva de Recordação de Feitiços (Boon of Spell Recall)
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
  'Dádiva de Recordação de Feitiços',
  'Nível 19+; Característica de Conjuração ou Pacto Mágico',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 30."
    },
    {
      "name": "Conjuração Livre",
      "description": "Sempre que você conjurar uma magia com um espaço de magia de nível 1-4, role 1d4. Se o número que você rolar for igual ao nível do espaço, o espaço não será gasto."
    }
  ]'::jsonb
);

-- 11. Dádiva do Espírito da Noite (Boon of the Night Spirit)
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
  'Dádiva do Espírito da Noite',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Fundir-se com Sombras",
      "description": "Enquanto estiver em Luz Fraca ou Escuridão, você pode se conceder a condição Invisível como uma Ação Bônus. A condição termina imediatamente após você realizar uma ação, uma Ação Bônus ou uma Reação."
    },
    {
      "name": "Forma Sombria",
      "description": "Enquanto estiver em Luz Fraca ou Escuridão, você tem Resistência a todos os tipos de dano, exceto Psíquico e Radiante."
    }
  ]'::jsonb
);

-- 12. Dádiva da Verdadeira Visão (Boon of Truesight)
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
  'Dádiva da Verdadeira Visão',
  'Nível 19+',
  '',
  '',
  'PHB 2024',
  'Dádiva Épica',
  false,
  '[
    {
      "name": "Aumento no Valor de Habilidade",
      "description": "Aumente um valor de habilidade de sua escolha em 1, até um máximo de 30."
    },
    {
      "name": "Truesight",
      "description": "Você tem Truesight com um alcance de 18 metros."
    }
  ]'::jsonb
);
