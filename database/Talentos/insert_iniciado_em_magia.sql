-- Talento: Iniciado em Magia (Magic Initiate) - PHB 2024
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
  'Iniciado em Magia',
  null,
  '',
  '',
  'PHB 2024',
  'Origem',
  true,  -- Pode ser adquirido múltiplas vezes escolhendo listas diferentes
  '[
    {
      "name": "Dois Truques Mágicos",
      "description": "Você aprende dois truques mágicos à sua escolha da lista de magias de Clérigo, Druida ou Mago. Inteligência, Sabedoria ou Carisma é a sua habilidade de conjuração para as magias deste talento (escolha ao selecionar este talento)."
    },
    {
      "name": "Magia de Nível 1",
      "description": "Escolha uma magia de nível 1 da mesma lista que você selecionou para os truques deste talento. Você sempre tem essa magia preparada. Você pode conjurá-la uma vez sem um espaço de magia e recupera a habilidade de conjurá-la dessa forma ao terminar um Descanso Longo. Você também pode conjurar a magia usando qualquer espaço de magia que tiver."
    },
    {
      "name": "Mudança de Magia",
      "description": "Sempre que você ganha um novo nível, você pode substituir uma das magias que escolheu para este talento por uma magia diferente do mesmo nível da lista de magias escolhida."
    },
    {
      "name": "Repetível",
      "description": "Você pode escolher este talento mais de uma vez, mas deve escolher uma lista de magias diferente a cada vez."
    }
  ]'::jsonb
);