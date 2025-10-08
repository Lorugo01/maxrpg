-- ============================================================
-- INSERÇÃO DE TODAS AS ORIGENS (BACKGROUNDS) - PHB 2024
-- ============================================================
-- Este script insere as 16 origens do Player's Handbook 2024
-- IMPORTANTE: Execute primeiro o script de talentos antes deste!
-- ============================================================

-- Nota: Este script usa subqueries para buscar os UUIDs dos talentos
-- Certifique-se de que os talentos foram inseridos antes de executar este script

-- ============================================================
-- 1. ACÓLITO (já existe, apenas para referência)
-- ============================================================
-- Já inserido anteriormente

-- ============================================================
-- 2. ARTESÃO (Artisan)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Artesão',
  'Você aprendeu uma habilidade artesanal, trabalhando como aprendiz de um mestre artesão até dominar a arte de criar itens específicos. Você é um artesão qualificado, criando objetos práticos ou obras de arte.',
  'PHB 2024',
  'Força, Destreza, Inteligência',
  'Artesão',
  (SELECT id FROM feats WHERE name = 'Artesão' LIMIT 1),
  'Investigação, Persuasão',
  'Ferramentas de Artesão (escolha um tipo)',
  '[
    {"name": "Ferramentas de Artesão", "category": "Ferramentas", "cost": "5.0", "weight": "5.0", "quantity": 1},
    {"name": "Bolsa", "category": "Equipamento Geral", "cost": "0.5", "weight": "0.5", "quantity": 2},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  32,
  50,
  '[
    {
      "description": "1 tipo de Ferramentas de Artesão",
      "options": [
        {"name": "Ferramentas de Alquimista", "category": "Ferramentas de Artesão", "cost": "50.0", "weight": "8.0"},
        {"name": "Ferramentas de Cervejeiro", "category": "Ferramentas de Artesão", "cost": "20.0", "weight": "9.0"},
        {"name": "Suprimentos de Calígrafo", "category": "Ferramentas de Artesão", "cost": "10.0", "weight": "5.0"},
        {"name": "Ferramentas de Carpinteiro", "category": "Ferramentas de Artesão", "cost": "8.0", "weight": "6.0"},
        {"name": "Ferramentas de Cartógrafo", "category": "Ferramentas de Artesão", "cost": "15.0", "weight": "6.0"},
        {"name": "Ferramentas de Sapateiro", "category": "Ferramentas de Artesão", "cost": "5.0", "weight": "5.0"},
        {"name": "Utensílios de Cozinheiro", "category": "Ferramentas de Artesão", "cost": "1.0", "weight": "8.0"},
        {"name": "Ferramentas de Vidreiro", "category": "Ferramentas de Artesão", "cost": "30.0", "weight": "5.0"},
        {"name": "Ferramentas de Joalheiro", "category": "Ferramentas de Artesão", "cost": "25.0", "weight": "2.0"},
        {"name": "Ferramentas de Coureiro", "category": "Ferramentas de Artesão", "cost": "5.0", "weight": "5.0"},
        {"name": "Ferramentas de Pedreiro", "category": "Ferramentas de Artesão", "cost": "10.0", "weight": "8.0"},
        {"name": "Ferramentas de Pintor", "category": "Ferramentas de Artesão", "cost": "10.0", "weight": "5.0"},
        {"name": "Ferramentas de Oleiro", "category": "Ferramentas de Artesão", "cost": "10.0", "weight": "3.0"},
        {"name": "Ferramentas de Ferreiro", "category": "Ferramentas de Artesão", "cost": "20.0", "weight": "8.0"},
        {"name": "Ferramentas de Funileiro", "category": "Ferramentas de Artesão", "cost": "50.0", "weight": "10.0"},
        {"name": "Ferramentas de Tecelão", "category": "Ferramentas de Artesão", "cost": "1.0", "weight": "5.0"},
        {"name": "Ferramentas de Entalhador", "category": "Ferramentas de Artesão", "cost": "1.0", "weight": "5.0"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- 3. CRIMINAL (Criminal)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Criminal',
  'Você é um criminoso experiente com histórico de violação da lei. Você passou muito tempo entre outros criminosos e ainda mantém contatos no submundo do crime.',
  'PHB 2024',
  'Destreza, Constituição, Inteligência',
  'Alerta',
  (SELECT id FROM feats WHERE name = 'Alerta' LIMIT 1),
  'Prestidigitação, Furtividade',
  'Ferramentas de Ladrão',
  '[
    {"name": "Adaga", "category": "Armas", "cost": "2.0", "weight": "1.0", "quantity": 2},
    {"name": "Ferramentas de Ladrão", "category": "Ferramentas", "cost": "25.0", "weight": "1.0", "quantity": 1},
    {"name": "Pé de Cabra", "category": "Equipamento Geral", "cost": "2.0", "weight": "5.0", "quantity": 1},
    {"name": "Bolsa", "category": "Equipamento Geral", "cost": "0.5", "weight": "0.5", "quantity": 2},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  16,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 4. ARTISTA (Entertainer)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Artista',
  'Você prospera na frente de uma audiência. Você sabe como encantá-los, entretê-los e até inspirá-los. Suas poesias podem agitar os corações daqueles que ouvem você recitar, ou suas palavras podem tocar suas almas.',
  'PHB 2024',
  'Força, Destreza, Carisma',
  'Músico',
  (SELECT id FROM feats WHERE name = 'Músico'),
  'Acrobacia, Atuação',
  'Instrumento Musical (escolha um tipo)',
  '[
    {"name": "Instrumento Musical", "category": "Ferramentas", "cost": "30.0", "weight": "3.0", "quantity": 1},
    {"name": "Traje", "category": "Roupas", "cost": "5.0", "weight": "4.0", "quantity": 2},
    {"name": "Espelho", "category": "Equipamento Geral", "cost": "5.0", "weight": "0.5", "quantity": 1},
    {"name": "Perfume", "category": "Equipamento Geral", "cost": "5.0", "weight": null, "quantity": 1},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  11,
  50,
  '[
    {
      "description": "1 Instrumento Musical",
      "options": [
        {"name": "Gaita de Foles", "category": "Instrumento Musical", "cost": "30.0", "weight": "6.0"},
        {"name": "Tambor", "category": "Instrumento Musical", "cost": "6.0", "weight": "3.0"},
        {"name": "Dulcimer", "category": "Instrumento Musical", "cost": "25.0", "weight": "10.0"},
        {"name": "Flauta", "category": "Instrumento Musical", "cost": "2.0", "weight": "1.0"},
        {"name": "Alaúde", "category": "Instrumento Musical", "cost": "35.0", "weight": "2.0"},
        {"name": "Lira", "category": "Instrumento Musical", "cost": "30.0", "weight": "2.0"},
        {"name": "Trompa", "category": "Instrumento Musical", "cost": "3.0", "weight": "2.0"},
        {"name": "Flauta de Pã", "category": "Instrumento Musical", "cost": "12.0", "weight": "2.0"},
        {"name": "Charamela", "category": "Instrumento Musical", "cost": "2.0", "weight": "1.0"},
        {"name": "Viola", "category": "Instrumento Musical", "cost": "30.0", "weight": "1.0"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- 5. AGRICULTOR (Farmer)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Agricultor',
  'Você cresceu trabalhando a terra. Você conhece o ciclo das estações, sabe como cultivar alimentos e cuidar de animais. A vida no campo lhe ensinou a ser resistente e autossuficiente.',
  'PHB 2024',
  'Força, Constituição, Sabedoria',
  'Duro',
  (SELECT id FROM feats WHERE name = 'Duro'),
  'Adestrar Animais, Natureza',
  'Ferramentas de Carpinteiro',
  '[
    {"name": "Foice", "category": "Armas", "cost": "1.0", "weight": "2.0", "quantity": 1},
    {"name": "Ferramentas de Carpinteiro", "category": "Ferramentas", "cost": "8.0", "weight": "6.0", "quantity": 1},
    {"name": "Kit de Curandeiro", "category": "Equipamento Geral", "cost": "5.0", "weight": "3.0", "quantity": 1},
    {"name": "Panela de Ferro", "category": "Equipamento Geral", "cost": "2.0", "weight": "10.0", "quantity": 1},
    {"name": "Pá", "category": "Equipamento Geral", "cost": "2.0", "weight": "5.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  30,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 6. GUARDA (Guard)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Guarda',
  'Você serviu em uma força de segurança, protegendo pessoas e propriedades. Você pode ter sido um guarda da cidade, um soldado de guarnição ou um vigia noturno.',
  'PHB 2024',
  'Força, Inteligência, Sabedoria',
  'Alerta',
  (SELECT id FROM feats WHERE name = 'Alerta' LIMIT 1),
  'Atletismo, Percepção',
  'Conjunto de Jogos (escolha um tipo)',
  '[
    {"name": "Lança", "category": "Armas", "cost": "1.0", "weight": "3.0", "quantity": 1},
    {"name": "Besta Leve", "category": "Armas", "cost": "25.0", "weight": "5.0", "quantity": 1},
    {"name": "Virote", "category": "Munição", "cost": "0.05", "weight": "0.075", "quantity": 20},
    {"name": "Conjunto de Jogos", "category": "Ferramentas", "cost": "1.0", "weight": null, "quantity": 1},
    {"name": "Lanterna com Capuz", "category": "Equipamento Geral", "cost": "5.0", "weight": "2.0", "quantity": 1},
    {"name": "Algemas", "category": "Equipamento Geral", "cost": "2.0", "weight": "6.0", "quantity": 1},
    {"name": "Aljava", "category": "Equipamento Geral", "cost": "1.0", "weight": "1.0", "quantity": 1},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  12,
  50,
  '[
    {
      "description": "1 Conjunto de Jogos",
      "options": [
        {"name": "Dados", "category": "Conjunto de Jogos", "cost": "0.1", "weight": null},
        {"name": "Baralho de Cartas", "category": "Conjunto de Jogos", "cost": "0.5", "weight": null},
        {"name": "Tabuleiro de Xadrez", "category": "Conjunto de Jogos", "cost": "1.0", "weight": "0.5"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- 7. GUIA (Guide)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Guia',
  'Você é um especialista em navegar pela natureza selvagem. Você conhece os caminhos através das montanhas, florestas e desertos, e pode guiar outros com segurança através de terrenos perigosos.',
  'PHB 2024',
  'Destreza, Constituição, Sabedoria',
  'Iniciado em Magia',
  (SELECT id FROM feats WHERE name = 'Iniciado em Magia'),
  'Furtividade, Sobrevivência',
  'Ferramentas de Cartógrafo',
  '[
    {"name": "Arco Curto", "category": "Armas", "cost": "25.0", "weight": "2.0", "quantity": 1},
    {"name": "Flecha", "category": "Munição", "cost": "0.05", "weight": "0.05", "quantity": 20},
    {"name": "Ferramentas de Cartógrafo", "category": "Ferramentas", "cost": "15.0", "weight": "6.0", "quantity": 1},
    {"name": "Saco de Dormir", "category": "Equipamento Geral", "cost": "1.0", "weight": "7.0", "quantity": 1},
    {"name": "Aljava", "category": "Equipamento Geral", "cost": "1.0", "weight": "1.0", "quantity": 1},
    {"name": "Tenda", "category": "Equipamento Geral", "cost": "2.0", "weight": "20.0", "quantity": 1},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  3,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 8. EREMITA (Hermit)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Eremita',
  'Você viveu em reclusão, seja em uma comunidade isolada, como um eremita solitário, ou até mesmo como um recluso em uma grande cidade. Em sua solidão, você encontrou quietude, meditação e talvez respostas que você procurava.',
  'PHB 2024',
  'Constituição, Sabedoria, Carisma',
  'Curador',
  (SELECT id FROM feats WHERE name = 'Curador'),
  'Medicina, Religião',
  'Kit de Herbalismo',
  '[
    {"name": "Cajado", "category": "Armas", "cost": "0.2", "weight": "4.0", "quantity": 1},
    {"name": "Kit de Herbalismo", "category": "Ferramentas", "cost": "5.0", "weight": "3.0", "quantity": 1},
    {"name": "Saco de Dormir", "category": "Equipamento Geral", "cost": "1.0", "weight": "7.0", "quantity": 1},
    {"name": "Livro", "category": "Equipamento Geral", "cost": "25.0", "weight": "5.0", "quantity": 1},
    {"name": "Lâmpada", "category": "Equipamento Geral", "cost": "0.5", "weight": "1.0", "quantity": 1},
    {"name": "Óleo", "category": "Equipamento Geral", "cost": "0.1", "weight": "1.0", "quantity": 3},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  16,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 9. COMERCIANTE (Merchant)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Comerciante',
  'Você entende o valor das coisas e sabe como lucrar com o comércio. Você pode ter sido um mercador viajante, um lojista ou um negociante de mercadorias raras.',
  'PHB 2024',
  'Constituição, Inteligência, Carisma',
  'Sortudo',
  (SELECT id FROM feats WHERE name = 'Sortudo'),
  'Adestrar Animais, Persuasão',
  'Ferramentas do Navegador',
  '[
    {"name": "Ferramentas do Navegador", "category": "Ferramentas", "cost": "25.0", "weight": "2.0", "quantity": 1},
    {"name": "Bolsa", "category": "Equipamento Geral", "cost": "0.5", "weight": "0.5", "quantity": 2},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  22,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 10. NOBRE (Noble)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Nobre',
  'Você nasceu em uma família de alta posição social. Você cresceu em um castelo ou mansão, cercado por riqueza e privilégio, e foi educado nas artes da nobreza.',
  'PHB 2024',
  'Força, Inteligência, Carisma',
  'Qualificado',
  (SELECT id FROM feats WHERE name = 'Qualificado'),
  'História, Persuasão',
  'Conjunto de Jogos (escolha um tipo)',
  '[
    {"name": "Conjunto de Jogos", "category": "Ferramentas", "cost": "1.0", "weight": null, "quantity": 1},
    {"name": "Roupas Finas", "category": "Roupas", "cost": "15.0", "weight": "6.0", "quantity": 1},
    {"name": "Perfume", "category": "Equipamento Geral", "cost": "5.0", "weight": null, "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  29,
  50,
  '[
    {
      "description": "1 Conjunto de Jogos",
      "options": [
        {"name": "Dados", "category": "Conjunto de Jogos", "cost": "0.1", "weight": null},
        {"name": "Baralho de Cartas", "category": "Conjunto de Jogos", "cost": "0.5", "weight": null},
        {"name": "Tabuleiro de Xadrez", "category": "Conjunto de Jogos", "cost": "1.0", "weight": "0.5"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- 11. SÁBIO (Sage)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Sábio',
  'Você passou anos aprendendo os conhecimentos do multiverso. Você estudou manuscritos, debateu com outros estudiosos e dominou tópicos esotéricos.',
  'PHB 2024',
  'Constituição, Inteligência, Sabedoria',
  'Iniciado em Magia',
  (SELECT id FROM feats WHERE name = 'Iniciado em Magia'),
  'Arcanismo, História',
  'Suprimentos de Calígrafo',
  '[
    {"name": "Bastão", "category": "Armas", "cost": "5.0", "weight": "4.0", "quantity": 1},
    {"name": "Suprimentos de Calígrafo", "category": "Ferramentas", "cost": "10.0", "weight": "5.0", "quantity": 1},
    {"name": "Livro", "category": "Equipamento Geral", "cost": "25.0", "weight": "5.0", "quantity": 1},
    {"name": "Pergaminho", "category": "Equipamento Geral", "cost": "0.1", "weight": null, "quantity": 8},
    {"name": "Manto", "category": "Roupas", "cost": "1.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  8,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 12. MARINHEIRO (Sailor)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Marinheiro',
  'Você navegou em um navio por anos. Nesse tempo, você enfrentou tempestades poderosas, monstros das profundezas e aqueles que queriam afundar seu navio até o fundo sem fim.',
  'PHB 2024',
  'Força, Destreza, Sabedoria',
  'Tavern Brawler',
  (SELECT id FROM feats WHERE name = 'Tavern Brawler'),
  'Acrobacia, Percepção',
  'Ferramentas do Navegador',
  '[
    {"name": "Adaga", "category": "Armas", "cost": "2.0", "weight": "1.0", "quantity": 1},
    {"name": "Ferramentas do Navegador", "category": "Ferramentas", "cost": "25.0", "weight": "2.0", "quantity": 1},
    {"name": "Corda", "category": "Equipamento Geral", "cost": "1.0", "weight": "10.0", "quantity": 1},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  20,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 13. ESCRIBA (Scribe)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Escriba',
  'Você trabalhou como escriba, copiando manuscritos, mantendo registros ou redigindo documentos oficiais. Sua habilidade com palavras escritas é inestimável.',
  'PHB 2024',
  'Destreza, Inteligência, Sabedoria',
  'Qualificado',
  (SELECT id FROM feats WHERE name = 'Qualificado'),
  'Investigação, Percepção',
  'Suprimentos de Calígrafo',
  '[
    {"name": "Suprimentos de Calígrafo", "category": "Ferramentas", "cost": "10.0", "weight": "5.0", "quantity": 1},
    {"name": "Roupas Finas", "category": "Roupas", "cost": "15.0", "weight": "6.0", "quantity": 1},
    {"name": "Lâmpada", "category": "Equipamento Geral", "cost": "0.5", "weight": "1.0", "quantity": 1},
    {"name": "Óleo", "category": "Equipamento Geral", "cost": "0.1", "weight": "1.0", "quantity": 3},
    {"name": "Pergaminho", "category": "Equipamento Geral", "cost": "0.1", "weight": null, "quantity": 12}
  ]'::jsonb,
  '[]'::jsonb,
  23,
  50,
  '[]'::jsonb
);

-- ============================================================
-- 14. SOLDADO (Soldier)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Soldado',
  'Você serviu em um exército, milícia ou força mercenária. Você foi treinado em combate e disciplina militar, e conhece a hierarquia e as táticas de guerra.',
  'PHB 2024',
  'Força, Destreza, Constituição',
  'Atacante Selvagem',
  (SELECT id FROM feats WHERE name = 'Atacante Selvagem'),
  'Atletismo, Intimidação',
  'Conjunto de Jogos (escolha um tipo)',
  '[
    {"name": "Lança", "category": "Armas", "cost": "1.0", "weight": "3.0", "quantity": 1},
    {"name": "Arco Curto", "category": "Armas", "cost": "25.0", "weight": "2.0", "quantity": 1},
    {"name": "Flecha", "category": "Munição", "cost": "0.05", "weight": "0.05", "quantity": 20},
    {"name": "Conjunto de Jogos", "category": "Ferramentas", "cost": "1.0", "weight": null, "quantity": 1},
    {"name": "Kit de Curandeiro", "category": "Equipamento Geral", "cost": "5.0", "weight": "3.0", "quantity": 1},
    {"name": "Aljava", "category": "Equipamento Geral", "cost": "1.0", "weight": "1.0", "quantity": 1},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  14,
  50,
  '[
    {
      "description": "1 Conjunto de Jogos",
      "options": [
        {"name": "Dados", "category": "Conjunto de Jogos", "cost": "0.1", "weight": null},
        {"name": "Baralho de Cartas", "category": "Conjunto de Jogos", "cost": "0.5", "weight": null},
        {"name": "Tabuleiro de Xadrez", "category": "Conjunto de Jogos", "cost": "1.0", "weight": "0.5"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- 15. VIAJANTE (Wayfarer)
-- ============================================================
INSERT INTO "public"."backgrounds" (
  "name",
  "description",
  "source",
  "ability_scores",
  "feat",
  "feat_id",
  "skill_proficiencies_2024",
  "tool_proficiency",
  "equipment_choice_a_items",
  "equipment_choice_b_items",
  "equipment_choice_a_po",
  "equipment_choice_b_po",
  "equipment_choices"
) VALUES (
  'Viajante',
  'Você vagou por terras distantes, sempre em movimento, nunca ficando em um lugar por muito tempo. Você aprendeu a sobreviver nas estradas e a se adaptar a novas situações.',
  'PHB 2024',
  'Destreza, Sabedoria, Carisma',
  'Sortudo',
  (SELECT id FROM feats WHERE name = 'Sortudo'),
  'Percepção, Furtividade',
  'Ferramentas de Ladrão',
  '[
    {"name": "Adaga", "category": "Armas", "cost": "2.0", "weight": "1.0", "quantity": 2},
    {"name": "Ferramentas de Ladrão", "category": "Ferramentas", "cost": "25.0", "weight": "1.0", "quantity": 1},
    {"name": "Conjunto de Jogos", "category": "Ferramentas", "cost": "1.0", "weight": null, "quantity": 1},
    {"name": "Saco de Dormir", "category": "Equipamento Geral", "cost": "1.0", "weight": "7.0", "quantity": 1},
    {"name": "Bolsa", "category": "Equipamento Geral", "cost": "0.5", "weight": "0.5", "quantity": 2},
    {"name": "Roupas de Viajante", "category": "Roupas", "cost": "2.0", "weight": "4.0", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  16,
  50,
  '[
    {
      "description": "1 Conjunto de Jogos",
      "options": [
        {"name": "Dados", "category": "Conjunto de Jogos", "cost": "0.1", "weight": null},
        {"name": "Baralho de Cartas", "category": "Conjunto de Jogos", "cost": "0.5", "weight": null},
        {"name": "Tabuleiro de Xadrez", "category": "Conjunto de Jogos", "cost": "1.0", "weight": "0.5"}
      ]
    }
  ]'::jsonb
);

-- ============================================================
-- VERIFICAÇÃO
-- ============================================================
-- Verificar quantas origens foram inseridas
SELECT 
  COUNT(*) as total_origens,
  source
FROM backgrounds
WHERE source = 'PHB 2024'
GROUP BY source;

-- Listar todas as origens PHB 2024
SELECT 
  name,
  feat,
  skill_proficiencies_2024,
  tool_proficiency
FROM backgrounds
WHERE source = 'PHB 2024'
ORDER BY name;
