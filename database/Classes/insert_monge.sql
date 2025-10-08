-- Inserir classe Monge (PHB 2024)
INSERT INTO "public"."classes" (
  "id",
  "name",
  "hit_die",
  "primary_ability",
  "saving_throws",
  "skill_proficiencies",
  "equipment",
  "features",
  "spellcasting",
  "created_at",
  "updated_at",
  "source",
  "armor_proficiencies",
  "weapon_proficiencies",
  "tool_proficiencies",
  "subclasses",
  "description",
  "equipment_lado_a",
  "equipment_lado_b",
  "level_features",
  "has_spells",
  "spell_levels",
  "spell_slots_levels",
  "subclasses_details",
  "skill_count",
  "has_usage_limit",
  "usage_type",
  "usage_value",
  "usage_recovery",
  "usage_attribute",
  "manual_level_increases",
  "has_dice_increase",
  "initial_dice",
  "dice_increases",
  "has_proficiency_doubling",
  "proficiency_skill_count",
  "equipment_lado_a_items",
  "equipment_lado_b_items",
  "po_lado_a",
  "po_lado_b",
  "equipment_choices"
) VALUES (
  gen_random_uuid(),
  'Monge',
  8,
  'Destreza e Sabedoria',
  'Força, Destreza',
  'Acrobacia, Atletismo, História, Intuição, Religião, Furtividade',
  null,
  null,
  '""',
  now(),
  now(),
  'PHB 2024',
  '',
  'Armas Simples, Armas Marciais com propriedade Luz',
  'Escolha um tipo de ferramenta de artesão ou instrumento musical',
  '',
  'Mestres das artes marciais, os Monges canalizam energia mística chamada Foco através de seus corpos. Usando ataques desarmados e armas simples, eles combinam disciplina física e espiritual para alcançar a perfeição marcial. Seu treinamento rigoroso lhes concede velocidade sobre-humana, reflexos aguçados e a capacidade de realizar feitos extraordinários.',
  '',
  '',
  '[
    {
      "name": "Artes Marciais",
      "level": 1,
      "description": "Sua prática de artes marciais lhe dá maestria em estilos de combate que usam Ataque Desarmado e armas de Monge (armas corpo a corpo simples e armas marciais corpo a corpo com propriedade Luz).\n\nAtaque Desarmado Bônus: Você pode realizar um Ataque Desarmado como Ação Bônus.\n\nDado de Artes Marciais: Você pode rolar 1d6 no lugar do dano normal (aumenta com nível: d8 no 5º, d10 no 11º, d12 no 17º).\n\nAtaques Destros: Use Destreza em vez de Força para ataques e dano.",
      "has_usage_limit": false,
      "has_dice_increase": true,
      "initial_dice": "1d6",
      "dice_increases": [
        {"level": 5, "dice": "1d8"},
        {"level": 11, "dice": "1d10"},
        {"level": 17, "dice": "1d12"}
      ],
      "has_proficiency_doubling": false
    },
    {
      "name": "Defesa sem armadura",
      "level": 1,
      "description": "Enquanto você não estiver usando armadura ou empunhando um Escudo, sua Classe de Armadura base será igual a 10 mais seus modificadores de Destreza e Sabedoria.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false,
      "unarmored_defense": {
        "base": 10,
        "abilities": ["Destreza", "Sabedoria"],
        "allows_shield": false
      }
    },
    {
      "name": "Foco do Monge",
      "level": 2,
      "usage_type": "Por Nível",
      "usage_value": 2,
      "usage_recovery": "Descanso Curto ou Longo",
      "description": "Seu foco e treinamento marcial permitem que você explore uma fonte de energia extraordinária. Seu nível de Monge determina o número de Pontos de Foco.\n\nRajada de Golpes: Gaste 1 Ponto para realizar dois Ataques Desarmados como Ação Bônus.\n\nDefesa Paciente: Desengajar como Ação Bônus. Ou gaste 1 Ponto para Desengajar e Esquivar.\n\nPasso do Vento: Disparar como Ação Bônus. Ou gaste 1 Ponto para Desengajar e Disparar com salto dobrado.\n\nCD = 8 + Sabedoria + Bônus de Proficiência.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Movimento sem armadura",
      "level": 2,
      "description": "Sua velocidade aumenta em 3 metros enquanto você não estiver usando armadura ou empunhando um Escudo. Esse bônus aumenta: +6m no 6º nível, +9m no 10º, +12m no 14º, +15m no 18º.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Metabolismo Estranho",
      "level": 2,
      "usage_type": "Descanso Longo",
      "usage_value": 1,
      "usage_recovery": "Descanso Longo",
      "description": "Ao rolar Iniciativa, você pode recuperar todos os Pontos de Foco gastos. Ao fazer isso, role seu dado de Artes Marciais e recupere PV igual ao seu nível de Monge mais o número obtido.\n\nDepois de usar esse recurso, você não poderá usá-lo novamente até terminar um Descanso Longo.",
      "has_usage_limit": true,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Desviar Ataques",
      "level": 3,
      "description": "Quando uma jogada de ataque atinge você e o dano inclui Concussão, Perfuração ou Corte, você pode realizar uma Reação para reduzir o dano total. A redução é igual a 1d10 + Destreza + nível de Monge.\n\nSe reduzir o dano a 0, pode gastar 1 Ponto de Foco para redirecionar o ataque (criatura a 1,5m se corpo a corpo, ou 18m se à distância). Teste de resistência de Destreza ou sofre dano igual a duas jogadas do dado de Artes Marciais + Destreza.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Subclasse Monge",
      "level": 3,
      "description": "Você ganha uma subclasse de Monge à sua escolha.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Melhoria da Pontuação de Habilidade",
      "level": 4,
      "description": "Você ganha o talento Aprimoramento de Valor de Habilidade ou outro talento à sua escolha. Você ganha essa característica novamente nos níveis 8, 12 e 16 de Monge.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Queda Lenta",
      "level": 4,
      "description": "Você pode realizar uma Reação ao cair para reduzir qualquer dano sofrido na queda em uma quantidade igual a cinco vezes seu nível de Monge.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataque Extra",
      "level": 5,
      "description": "Você pode atacar duas vezes em vez de uma sempre que realizar a ação Atacar no seu turno.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Golpe Atordoante",
      "level": 5,
      "description": "Uma vez por turno, ao atingir uma criatura com arma de Monge ou Ataque Desarmado, você pode gastar 1 Ponto de Foco para tentar atordoar. Teste de resistência de Constituição. Falha: Atordoado até o início do seu próximo turno. Sucesso: Velocidade reduzida pela metade e próximo ataque contra ele tem Vantagem.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Ataques Fortalecidos",
      "level": 6,
      "description": "Sempre que você causa dano com seu Ataque Desarmado, ele pode causar dano de Força de sua escolha ou seu tipo de dano normal.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de subclasse",
      "level": 6,
      "description": "Você ganha uma característica da sua subclasse Monge.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Evasão",
      "level": 7,
      "description": "Quando você é submetido a um efeito que lhe permite fazer um teste de resistência de Destreza para sofrer apenas metade do dano, você não sofre dano se for bem-sucedido e sofre apenas metade se falhar.\n\nVocê não se beneficia desse recurso se tiver a condição Incapacitado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Movimento Acrobático",
      "level": 9,
      "description": "Enquanto você não estiver usando armadura ou empunhando um Escudo, você ganha a habilidade de se mover em superfícies verticais e sobre líquidos no seu turno sem cair durante o movimento.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Foco Aprimorado",
      "level": 10,
      "description": "Rajada de Golpes: Gaste 1 Ponto para realizar três Ataques Desarmados em vez de dois.\n\nDefesa Paciente: Ao gastar 1 Ponto, ganha PV Temporários = duas jogadas do dado de Artes Marciais.\n\nPasso do Vento: Ao gastar 1 Ponto, pode mover uma criatura disposta Grande ou menor a 1,5m com você.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Auto-Restauração",
      "level": 10,
      "description": "Com pura força de vontade, você pode remover Encantado, Assustado ou Envenenado de si mesmo no final de cada um dos seus turnos.\n\nAlém disso, abrir mão de comida e bebida não lhe dá níveis de Exaustão.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 11,
      "description": "Você ganha uma característica da sua subclasse Monge.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Desviar Energia",
      "level": 13,
      "description": "Agora você pode usar seu recurso Defletir Ataques contra ataques que causam qualquer tipo de dano, não apenas Concussão, Perfuração ou Corte.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Sobrevivente Disciplinado",
      "level": 14,
      "description": "Sua disciplina física e mental lhe garantem proficiência em todos os testes de resistência.\n\nAlém disso, sempre que você fizer um teste de resistência e falhar, você pode gastar 1 Ponto de Foco para rolá-lo novamente e deve usar o novo teste.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": true
    },
    {
      "name": "Foco Perfeito",
      "level": 15,
      "description": "Quando você rola Iniciativa e não usa Metabolismo Sobrenatural, você recupera Pontos de Foco gastos até ter 4, se tiver 3 ou menos.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Característica de Subclasse",
      "level": 17,
      "description": "Você ganha uma característica da sua subclasse Monge.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Defesa Superior",
      "level": 18,
      "description": "No início do seu turno, você pode gastar 3 Pontos de Foco para se fortalecer contra dano por 1 minuto ou até atingir a condição Incapacitado. Durante esse tempo, você tem Resistência a todo tipo de dano, exceto dano de Força.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Bênção Épica",
      "level": 19,
      "description": "Você ganha um talento Dádiva Épica ou outro talento à sua escolha. Dádiva de Ataque Irresistível é recomendado.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    },
    {
      "name": "Corpo e Mente",
      "level": 20,
      "description": "Você desenvolveu seu corpo e mente a novos patamares. Seus valores de Destreza e Sabedoria aumentam em 4, chegando a um máximo de 25.",
      "has_usage_limit": false,
      "has_dice_increase": false,
      "has_proficiency_doubling": false
    }
  ]'::jsonb,
  false,
  '[]'::jsonb,
  '[]'::jsonb,
  '[
    {
      "name": "Guerreiro da Misericórdia",
      "description": "Manipular as Forças da Vida e da Morte. Guerreiros da Misericórdia manipulam a força vital dos outros. Esses monges são médicos errantes, mas conseguem dar um fim rápido aos seus inimigos.",
      "features": [
        {
          "name": "Mão do Mal",
          "level": 3,
          "description": "Uma vez por turno, ao atingir uma criatura com Ataque Desarmado e causar dano, você pode gastar 1 Ponto de Foco para causar dano Necrótico extra igual a uma jogada do dado de Artes Marciais + modificador de Sabedoria.",
          "isPassive": false
        },
        {
          "name": "Mão da Cura",
          "level": 3,
          "description": "Como ação de Magia, gaste 1 Ponto de Foco para tocar uma criatura e restaurar PV = dado de Artes Marciais + Sabedoria. Ao usar Rajada de Golpes, pode substituir um Ataque Desarmado por este uso sem gastar Ponto de Foco.",
          "isPassive": false
        },
        {
          "name": "Implementos de Misericórdia",
          "level": 3,
          "description": "Você ganha proficiência em Intuição, Medicina e Kit de Herbalismo.",
          "isPassive": true
        },
        {
          "name": "Toque do Médico",
          "level": 6,
          "description": "Mão do Mal: Também pode conceder condição Envenenado até o fim do seu próximo turno.\\n\\nMão da Cura: Também pode anular uma condição: Cego, Surdo, Paralisado, Envenenado ou Atordoado.",
          "isPassive": false
        },
        {
          "name": "Rajada de Cura e Dano",
          "level": 11,
          "description": "Ao usar Rajada de Golpes, pode substituir cada Ataque Desarmado por Mão de Cura sem gastar Pontos de Foco. Além disso, ao causar dano com Rajada de Golpes, pode usar Mão do Mal sem gastar Ponto de Foco (ainda uma vez por turno).\\n\\nUsos totais = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.",
          "isPassive": false
        },
        {
          "name": "Mão da Misericórdia Suprema",
          "level": 17,
          "description": "Como ação de Magia, toque o cadáver de uma criatura morta nas últimas 24 horas e gaste 5 Pontos de Foco. A criatura retorna à vida com 4d10 + Sabedoria PV. Remove condições: Cego, Surdo, Paralisado, Envenenado, Atordoado.\\n\\nDepois de usar, não pode usar novamente até Descanso Longo.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Guerreiro das Sombras",
      "description": "Aproveite o poder das sombras para furtividade e subterfúgios. Guerreiros das Sombras praticam furtividade e subterfúgios, utilizando o poder do Pendor das Sombras.",
      "features": [
        {
          "name": "Artes das Sombras",
          "level": 3,
          "description": "Escuridão: Gaste 1 Ponto de Foco para conjurar Escuridão sem componentes. Você vê dentro da área. Pode mover a área 18m no início de cada turno.\\n\\nVisão no Escuro: Ganha Visão no Escuro 18m (ou +18m se já tiver).\\n\\nFigmentos Sombrios: Conhece o feitiço Ilusão Menor (Sabedoria como habilidade).",
          "isPassive": false
        },
        {
          "name": "Passo das Sombras",
          "level": 6,
          "description": "Enquanto totalmente em Penumbra ou Escuridão, use Ação Bônus para se teletransportar até 18m para espaço desocupado que também esteja em Penumbra ou Escuridão. Você tem Vantagem no próximo ataque corpo a corpo antes do fim do turno.",
          "isPassive": false
        },
        {
          "name": "Passo de Sombra Aprimorado",
          "level": 11,
          "description": "Ao usar Passo das Sombras, pode gastar 1 Ponto de Foco para remover a exigência de começar/terminar em Penumbra/Escuridão. Como parte desta Ação Bônus, pode realizar um Ataque Desarmado imediatamente após se teletransportar.",
          "isPassive": false
        },
        {
          "name": "Manto das Sombras",
          "level": 17,
          "description": "Como ação de Magia, enquanto em Luz Fraca ou Escuridão, gaste 3 Pontos de Foco para se envolver em sombras por 1 minuto (termina se Incapacitado ou em Luz Brilhante):\\n\\nInvisibilidade: Condição Invisível.\\n\\nParcialmente Incorpóreo: Pode se mover por espaços ocupados (Terreno Difícil).\\n\\nRajada de Sombras: Use Rajada de Golpes sem gastar Pontos de Foco.",
          "isPassive": false
        }
      ]
    },
    {
      "name": "Guerreiro dos Elementos",
      "description": "Use golpes e explosões de poder elemental. Guerreiros dos Elementos se valem do poder dos Planos Elementais, domando energia do Caos Elemental.",
      "features": [
        {
          "name": "Sintonização Elemental",
          "level": 3,
          "description": "No início do turno, gaste 1 Ponto de Foco para se imbuir de energia elemental por 10 minutos (ou até Incapacitado):\\n\\nAlcance: Ataque Desarmado tem alcance +3m.\\n\\nAtaques Elementais: Ataque Desarmado causa Ácido, Frio, Fogo, Raio ou Trovão. Pode forçar teste de For; falha: move alvo 3m.",
          "isPassive": false
        },
        {
          "name": "Manipular Elementos",
          "level": 3,
          "description": "Você conhece o feitiço Elementalismo (Sabedoria como habilidade).",
          "isPassive": true
        },
        {
          "name": "Explosão Elemental",
          "level": 6,
          "description": "Como ação de Magia, gaste 2 Pontos de Foco para criar explosão em Esfera de 6m de raio a até 36m. Escolha tipo: Ácido, Frio, Fogo, Relâmpago ou Trovão.\\n\\nTeste de resistência de Destreza. Falha: três jogadas do dado de Artes Marciais. Sucesso: metade.",
          "isPassive": false
        },
        {
          "name": "Passo dos Elementos",
          "level": 11,
          "description": "Enquanto Sintonização Elemental estiver ativa, você também tem Velocidade de Voo e Velocidade de Natação = sua Velocidade.",
          "isPassive": true
        },
        {
          "name": "Epítome Elemental",
          "level": 17,
          "description": "Enquanto Sintonização Elemental ativa:\\n\\nResistência: Escolha Ácido, Frio, Fogo, Raio ou Trovão. Pode mudar no início de cada turno.\\n\\nPasso Destrutivo: Ao usar Passo do Vento, Velocidade +6m. Criaturas a 1,5m sofrem dano = dado de Artes Marciais (tipo à escolha). Uma vez por turno por criatura.\\n\\nAtaques Potencializados: Uma vez por turno, dano extra = dado de Artes Marciais (mesmo tipo do ataque).",
          "isPassive": true
        }
      ]
    },
    {
      "name": "Guerreiro da Mão Aberta",
      "description": "Domine técnicas de combate desarmado. Guerreiros da Mão Aberta são mestres do combate desarmado, aprendendo técnicas para empurrar e derrubar oponentes.",
      "features": [
        {
          "name": "Técnica de Mão Aberta",
          "level": 3,
          "description": "Sempre que atingir uma criatura com ataque da Rajada de Golpes, pode impor um efeito:\\n\\nAddle: Alvo não pode realizar Ataques de Oportunidade até o início do seu próximo turno.\\n\\nEmpurrar: Teste de For ou empurrado 4,5m.\\n\\nTombado: Teste de Des ou condição Caído.",
          "isPassive": false
        },
        {
          "name": "Totalidade do Corpo",
          "level": 6,
          "description": "Como Ação Bônus, role dado de Artes Marciais. Recupera PV = número rolado + Sabedoria (mínimo 1 PV).\\n\\nUsos = modificador de Sabedoria (mínimo 1). Recupera todos em Descanso Longo.",
          "isPassive": false
        },
        {
          "name": "Passo Rápido",
          "level": 11,
          "description": "Quando você realiza uma Ação Bônus diferente de Passo do Vento, você também pode usar Passo do Vento imediatamente após essa Ação Bônus.",
          "isPassive": true
        },
        {
          "name": "Palma Trêmula",
          "level": 17,
          "description": "Ao atingir criatura com Ataque Desarmado, gaste 4 Pontos de Foco para iniciar vibrações letais por número de dias = nível de Monge. Inofensivas até você encerrá-las (ação ou abrir mão de ataque). Ambos devem estar no mesmo plano.\\n\\nAo encerrar: teste de resistência de Con. Falha: 10d12 dano de Força. Sucesso: metade.\\n\\nApenas uma criatura por vez sob efeito.",
          "isPassive": false
        }
      ]
    }
  ]'::jsonb,
  2,
  false,
  null,
  null,
  null,
  null,
  null,
  false,
  null,
  null,
  false,
  0,
  '[
    {"name": "Lança", "cost": "1.0", "weight": "3.0", "category": "Arma", "quantity": 1},
    {"name": "Adaga", "cost": "2.0", "weight": "1.0", "category": "Arma", "quantity": 5},
    {"name": "Ferramentas de Artesão ou Instrumento Musical", "cost": "varies", "weight": "varies", "category": "Ferramenta", "quantity": 1},
    {"name": "Pacote do Explorador", "cost": "10.0", "weight": null, "category": "Pacote", "quantity": 1}
  ]'::jsonb,
  '[]'::jsonb,
  11,
  50,
  '[]'::jsonb
);
