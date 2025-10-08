-- Talentos de Estilo de Luta (Fighting Style Feats) - PHB 2024
-- Pré-requisito: Característica de Estilo de Luta

-- 1. Tiro com arco (Archery)
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
  'Tiro com arco',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Bônus em Ataques à Distância",
      "description": "Você ganha um bônus de +2 em jogadas de ataque feitas com armas de longo alcance."
    }
  ]'::jsonb
);

-- 2. Luta às Cegas (Blind Fighting)
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
  'Luta às Cegas',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Visão às Cegas",
      "description": "Você tem Visão às Cegas com um alcance de 3 metros."
    }
  ]'::jsonb
);

-- 3. Defesa (Defense)
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
  'Defesa',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Bônus de Armadura",
      "description": "Enquanto estiver usando armadura Leve, Média ou Pesada, você ganha um bônus de +1 na Classe de Armadura."
    }
  ]'::jsonb
);

-- 4. Duelo (Dueling)
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
  'Duelo',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Bônus de Dano em Duelo",
      "description": "Quando você segura uma arma corpo a corpo em uma mão e nenhuma outra arma, você ganha um bônus de +2 em jogadas de dano com aquela arma."
    }
  ]'::jsonb
);

-- 5. Grande Luta com Armas (Great Weapon Fighting)
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
  'Grande Luta com Armas',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Rerolagem de Dano",
      "description": "Ao rolar o dano de um ataque feito com uma arma corpo a corpo que você está segurando com as duas mãos, você pode tratar qualquer 1 ou 2 em um dado de dano como um 3. A arma deve ter a propriedade Duas Mãos ou Versátil para obter esse benefício."
    }
  ]'::jsonb
);

-- 6. Guerreiro Abençoado (Blessed Warrior) - Específico para Paladino
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
  'Guerreiro Abençoado',
  'Ao obter o recurso Estilo de Luta do Paladino de Nível 2',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Truques de Clérigo",
      "description": "Você aprende dois truques de Clérigo à sua escolha. Orientação e Chama Sagrada são recomendados. Os truques escolhidos contam como magias de Paladino para você, e Carisma é sua habilidade de conjuração para eles. Sempre que você ganha um nível de Paladino, pode substituir um desses truques por outro truque de Clérigo."
    }
  ]'::jsonb
);

-- 7. Guerreiro Druídico (Druidic Warrior) - Específico para Patrulheiro
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
  'Guerreiro Druídico',
  'Ao obter o recurso Estilo de Luta do Patrulheiro de Nível 2',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Truques de Druida",
      "description": "Você aprende dois truques de Druida à sua escolha. Orientação e Fogo-fátuo Estrelado são recomendados. Os truques escolhidos contam como magias de Patrulheiro para você, e Sabedoria é sua habilidade de conjuração para eles. Sempre que você ganha um nível de Patrulheiro, pode substituir um desses truques por outro truque de Druida."
    }
  ]'::jsonb
);

-- 8. Proteção (Protection)
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
  'Proteção',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Proteção com Escudo",
      "description": "Quando uma criatura visível ataca um alvo que não seja você e que esteja a até 1,5 metro de distância, você pode usar uma Reação para interpor seu Escudo, se estiver segurando um. Você impõe Desvantagem na jogada de ataque desencadeadora e em todas as outras jogadas de ataque contra o alvo até o início do seu próximo turno, se permanecer a até 1,5 metro do alvo."
    }
  ]'::jsonb
);

-- 9. Luta com Armas de Arremesso (Thrown Weapon Fighting)
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
  'Luta com Armas de Arremesso',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Bônus de Dano em Arremesso",
      "description": "Quando você acerta com um ataque à distância usando uma arma que tem a propriedade Arremessar, você ganha um bônus de +2 no teste de dano."
    }
  ]'::jsonb
);

-- 10. Luta com Duas Armas (Two-Weapon Fighting)
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
  'Luta com Duas Armas',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Dano com Modificador",
      "description": "Quando você faz um ataque extra como resultado do uso de uma arma que tem a propriedade Luz, você pode adicionar seu modificador de habilidade ao dano daquele ataque, se ainda não o estiver adicionando ao dano."
    }
  ]'::jsonb
);

-- 11. Luta Desarmada (Unarmed Fighting)
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
  'Luta Desarmada',
  'Característica de Estilo de Luta',
  '',
  '',
  'PHB 2024',
  'Estilo de Luta',
  false,
  '[
    {
      "name": "Dano Desarmado Aprimorado",
      "description": "Ao atingir com seu Ataque Desarmado e causar dano, você pode causar dano Contundente igual a 1d6 mais seu modificador de Força em vez do dano normal de um Ataque Desarmado. Se você não estiver segurando nenhuma arma ou um Escudo ao fazer a jogada de ataque, o d6 se torna um d8."
    },
    {
      "name": "Dano em Agarramento",
      "description": "No início de cada um dos seus turnos, você pode causar 1d4 de dano de Concussão a uma criatura agarrada por você."
    }
  ]'::jsonb
);
