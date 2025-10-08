-- Talentos de Origem (Origin Feats) - PHB 2024
-- Estes talentos são adquiridos no nível 1 durante a criação do personagem

-- 1. Alerta (Alert)
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
  'Alerta',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Proficiência em Iniciativa",
      "description": "Ao rolar Iniciativa, você pode adicionar seu Bônus de Proficiência ao teste."
    },
    {
      "name": "Troca de Iniciativa",
      "description": "Imediatamente após rolar Iniciativa, você pode trocar sua Iniciativa pela Iniciativa de um aliado disposto no mesmo combate. Você não pode fazer essa troca se você ou o aliado estiver na condição Incapacitado."
    }
  ]'::jsonb
);

-- 2. Curador (Healer)
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
  'Curador',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Médico de Batalha",
      "description": "Se você tiver um Kit de Curandeiro, poderá usá-lo uma vez e cuidar de uma criatura a até 1,5 metro de você com uma ação de Utilizar. Essa criatura pode gastar um de seus Dados de Pontos de Vida, e você então rola esse dado. A criatura recupera uma quantidade de Pontos de Vida igual à rolagem mais seu Bônus de Proficiência."
    },
    {
      "name": "Rerolagens de Cura",
      "description": "Sempre que você rolar um dado para determinar o número de Pontos de Vida que você restaura com uma magia ou com o benefício Médico de Batalha deste talento, você pode rolar novamente o dado se ele rolar 1, e você deve usar a nova rolagem."
    }
  ]'::jsonb
);

-- 3. Sortudo (Lucky)
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
  'Sortudo',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Pontos de Sorte",
      "description": "Você tem uma quantidade de Pontos de Sorte igual ao seu Bônus de Proficiência e pode gastá-los nos benefícios abaixo. Você recupera os Pontos de Sorte gastos ao terminar um Descanso Longo."
    },
    {
      "name": "Vantagem",
      "description": "Ao rolar um d20 para um Teste D20, você pode gastar 1 Ponto de Sorte para obter Vantagem na rolagem."
    },
    {
      "name": "Desvantagem",
      "description": "Quando uma criatura rola um d20 em uma jogada de ataque contra você, você pode gastar 1 Ponto de Sorte para impor Desvantagem nessa jogada."
    }
  ]'::jsonb
);

-- 4. Iniciado em Magia (Magic Initiate) - Movido para arquivo separado

-- 5. Músico (Musician)
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
  'Músico',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Treinamento de Instrumentos",
      "description": "Você adquire proficiência em três instrumentos musicais de sua escolha."
    },
    {
      "name": "Canção Encorajadora",
      "description": "Ao terminar um Descanso Curto ou Longo, você pode tocar uma música em um Instrumento Musical com o qual tenha proficiência e conceder Inspiração Heroica aos aliados que ouvirem a música. O número de aliados que você pode afetar dessa forma é igual ao seu Bônus de Proficiência."
    }
  ]'::jsonb
);

-- 6. Resistente (Resilient)
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
  'Resistente',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Aumento de Habilidade",
      "description": "Escolha uma habilidade (Força, Destreza, Constituição, Inteligência, Sabedoria ou Carisma). Aumente a habilidade escolhida em 1, até um máximo de 20."
    },
    {
      "name": "Proficiência em Teste de Resistência",
      "description": "Você ganha proficiência em testes de resistência usando a habilidade escolhida."
    }
  ]'::jsonb
);

-- 7. Duro (Tough)
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
  'Duro',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Pontos de Vida Adicionais",
      "description": "Seus Pontos de Vida máximos aumentam em uma quantidade igual ao dobro do seu nível quando você ganha este talento. Sempre que você ganhar um nível depois disso, seus Pontos de Vida máximos aumentam em 2 adicionais."
    }
  ]'::jsonb
);

-- 8. Observador (Observant)
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
  'Observador',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Aumento de Habilidade",
      "description": "Aumente sua Inteligência ou Sabedoria em 1, até um máximo de 20."
    },
    {
      "name": "Percepção Aguçada",
      "description": "Se você puder ver a boca de uma criatura enquanto ela está falando uma língua que você entende, você pode interpretar o que ela está dizendo lendo seus lábios."
    },
    {
      "name": "Bônus em Percepção e Investigação",
      "description": "Você tem um bônus de +5 em sua Percepção Passiva e Investigação Passiva."
    }
  ]'::jsonb
);

-- 9. Mestre de Habilidade (Skilled)
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
  'Mestre de Habilidade',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Proficiências",
      "description": "Você ganha proficiência em qualquer combinação de três perícias ou ferramentas de sua escolha."
    }
  ]'::jsonb
);

-- 10. Telepata (Telepathic)
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
  'Telepata',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Aumento de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Detectar Pensamentos",
      "description": "Você pode conjurar a magia Detectar Pensamentos sem gastar um espaço de magia ou componentes materiais. Você deve terminar um Descanso Longo antes de poder conjurá-la dessa forma novamente. Sua habilidade de conjuração para essa magia é a habilidade aumentada por este talento. Se você tiver espaços de magia de nível 2 ou superior, você pode conjurar essa magia com eles."
    },
    {
      "name": "Comunicação Telepática",
      "description": "Você pode falar telepaticamente com qualquer criatura que você possa ver a até 18 metros de você. Sua comunicação telepática não dá à criatura a habilidade de responder telepaticamente a você. A criatura deve ser capaz de entender pelo menos uma língua ou ser telepática para entender suas mensagens."
    }
  ]'::jsonb
);

-- 11. Qualificado (Skilled)
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
  'Qualificado',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  true,
  '[
    {
      "name": "Proficiências",
      "description": "Você ganha proficiência em qualquer combinação de três habilidades ou ferramentas de sua escolha."
    },
    {
      "name": "Repetível",
      "description": "Você pode realizar este feito mais de uma vez."
    }
  ]'::jsonb
);

-- 12. Atacante Selvagem (Savage Attacker)
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
  'Atacante Selvagem',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Golpes Danosos",
      "description": "Você treinou para desferir golpes particularmente danosos. Uma vez por turno, ao atingir um alvo com uma arma, você pode rolar os dados de dano da arma duas vezes e usar qualquer uma das jogadas contra o alvo."
    }
  ]'::jsonb
);

-- 13. Tavern Brawler
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
  'Tavern Brawler',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Ataque Desarmado Aprimorado",
      "description": "Ao atingir com seu Ataque Desarmado e causar dano, você pode causar dano Contundente igual a 1d4 mais seu modificador de Força em vez do dano normal de um Ataque Desarmado."
    },
    {
      "name": "Rerolagens de Dano",
      "description": "Sempre que você rolar um dado de dano para seu Ataque Desarmado, você pode rolar novamente o dado se ele tirar 1, e você deve usar a nova rolagem."
    },
    {
      "name": "Armamento Improvisado",
      "description": "Você tem proficiência com armas improvisadas."
    },
    {
      "name": "Empurrar",
      "description": "Ao atingir uma criatura com um Ataque Desarmado como parte da ação de Ataque no seu turno, você pode causar dano ao alvo e também empurrá-lo a 1,5 metro de distância. Você pode usar este benefício apenas uma vez por turno."
    }
  ]'::jsonb
);

-- 14. Telecinético (Telekinetic)
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
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Aumento de Habilidade",
      "description": "Aumente sua Inteligência, Sabedoria ou Carisma em 1, até um máximo de 20."
    },
    {
      "name": "Mão de Mago",
      "description": "Você aprende a magia Mão de Mago. Você pode conjurá-la sem componentes verbais ou somáticos, e você pode tornar a mão invisível. Se você já conhece essa magia, seu alcance aumenta em 9 metros quando você a conjura. Sua habilidade de conjuração para essa magia é a habilidade aumentada por este talento."
    },
    {
      "name": "Empurrão Telecinético",
      "description": "Como uma Ação Bônus, você pode tentar empurrar telecineticamente uma criatura que você possa ver a até 9 metros de você. Quando você faz isso, o alvo deve ser bem-sucedido em um teste de resistência de Força (CD 8 + seu bônus de proficiência + o modificador da habilidade aumentada por este talento) ou ser movido 1,5 metro em direção a você ou para longe de você. Uma criatura pode escolher falhar voluntariamente neste teste de resistência."
    }
  ]'::jsonb
);

-- 15. Difícil (Tough)
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
  'Difícil',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  false,
  '[
    {
      "name": "Pontos de Vida Adicionais",
      "description": "Seus Pontos de Vida máximos aumentam em uma quantidade igual ao dobro do seu nível de personagem quando você ganha este talento. Sempre que você ganha um nível de personagem depois disso, seus Pontos de Vida máximos aumentam em mais 2 Pontos de Vida."
    }
  ]'::jsonb
);