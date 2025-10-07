import 'package:uuid/uuid.dart';
import '../models/character.dart';
import '../models/skill.dart';
import '../models/item.dart';
import 'supabase_service.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class CharacterService {
  static const _uuid = Uuid();

  // Carregar todos os personagens do usuário atual
  static Future<List<Character>> loadCharacters() async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        debugPrint('CharacterService: Usuário não autenticado');
        return [];
      }

      debugPrint(
        'CharacterService: Carregando personagens para usuário: $userId',
      );
      final response = await SupabaseService.client
          .from('characters')
          .select()
          .eq('user_id', userId);

      debugPrint(
        'CharacterService: ${response.length} personagens encontrados no banco',
      );

      return response.map((json) {
        // Converter colunas individuais para mapa em PT-BR
        final abilityScores = {
          'Força': json['strength'] ?? 10,
          'Destreza': json['dexterity'] ?? 10,
          'Constituição': json['constitution'] ?? 10,
          'Inteligência': json['intelligence'] ?? 10,
          'Sabedoria': json['wisdom'] ?? 10,
          'Carisma': json['charisma'] ?? 10,
        };

        // Adicionar abilityScores ao JSON no formato esperado pelo modelo
        json['abilityScores'] = abilityScores;

        // Mapear nomes de colunas do banco para o modelo
        json['className'] = json['class_name'];
        json['armorClass'] = json['armor_class'] ?? 10;
        json['currentHitPoints'] = json['current_hit_points'] ?? 0;
        json['maxHitPoints'] = json['max_hit_points'] ?? 0;
        json['temporaryHitPoints'] = json['temporary_hit_points'] ?? 0;
        json['experiencePoints'] = json['experience_points'] ?? 0;

        // Converter listas JSON de volta
        json['languages'] = json['languages'] ?? [];
        json['proficiencies'] = json['proficiencies'] ?? [];
        json['selectedCantrips'] = json['selected_cantrips'] ?? [];
        json['selectedSpells'] = json['selected_spells'] ?? [];

        // Debug: verificar proficiências carregadas
        debugPrint('Proficiências carregadas: ${json['proficiencies']}');

        final character = Character.fromJson(json);

        // Sincronizar proficiências com skills após carregar
        _syncProficienciesWithSkills(character, character.proficiencies);

        debugPrint(
          'CharacterService: Personagem carregado: ${character.name} (ID: ${character.id})',
        );
        return character;
      }).toList();
    } catch (e) {
      debugPrint('Erro ao carregar personagens: $e');
      return [];
    }
  }

  // Salvar personagem
  static Future<String> saveCharacter(Character character) async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        throw Exception('Usuário não autenticado');
      }

      debugPrint(
        'CharacterService: Salvando personagem ${character.name} (ID: ${character.id})',
      );
      debugPrint('Character className: ${character.className}');

      final characterJson = character.toJson();
      characterJson['user_id'] = userId;

      debugPrint('CharacterJson className: ${characterJson['className']}');
      debugPrint('CharacterJson class_name: ${characterJson['class_name']}');

      // Converter abilityScores Map para colunas individuais
      final abilityScores = Map<String, int>.from(
        characterJson['abilityScores'] ?? {},
      );
      int get(Map<String, int> m, String pt, String en) => m[pt] ?? m[en] ?? 10;
      characterJson['strength'] = get(abilityScores, 'Força', 'strength');
      characterJson['dexterity'] = get(abilityScores, 'Destreza', 'dexterity');
      characterJson['constitution'] = get(
        abilityScores,
        'Constituição',
        'constitution',
      );
      characterJson['intelligence'] = get(
        abilityScores,
        'Inteligência',
        'intelligence',
      );
      characterJson['wisdom'] = get(abilityScores, 'Sabedoria', 'wisdom');
      characterJson['charisma'] = get(abilityScores, 'Carisma', 'charisma');
      // Também persistir o JSON consolidado em ability_scores (coluna jsonb)
      characterJson['ability_scores'] = {
        'Força': characterJson['strength'],
        'Destreza': characterJson['dexterity'],
        'Constituição': characterJson['constitution'],
        'Inteligência': characterJson['intelligence'],
        'Sabedoria': characterJson['wisdom'],
        'Carisma': characterJson['charisma'],
      };

      // Mapear nomes de colunas do modelo para o banco (se necessário)
      if (characterJson['className'] != null) {
        characterJson['class_name'] = characterJson['className'];
      }
      if (characterJson['armorClass'] != null) {
        characterJson['armor_class'] = characterJson['armorClass'];
      }
      if (characterJson['currentHitPoints'] != null) {
        characterJson['current_hit_points'] = characterJson['currentHitPoints'];
      }
      if (characterJson['maxHitPoints'] != null) {
        characterJson['max_hit_points'] = characterJson['maxHitPoints'];
      }
      if (characterJson['temporaryHitPoints'] != null) {
        characterJson['temporary_hit_points'] =
            characterJson['temporaryHitPoints'];
      }
      if (characterJson['experiencePoints'] != null) {
        characterJson['experience_points'] = characterJson['experiencePoints'];
      }

      // Converter outras listas para JSON
      characterJson['languages'] = characterJson['languages'] ?? [];
      characterJson['proficiencies'] = characterJson['proficiencies'] ?? [];
      characterJson['selected_cantrips'] =
          characterJson['selectedCantrips'] ?? [];
      characterJson['selected_spells'] = characterJson['selectedSpells'] ?? [];

      // Debug: verificar proficiências antes de salvar
      debugPrint(
        'Proficiências sendo salvas: ${characterJson['proficiencies']}',
      );

      // Remover campos que não existem na tabela
      characterJson.remove('abilityScores');
      characterJson.remove('className');
      characterJson.remove('armorClass');
      characterJson.remove('currentHitPoints');
      characterJson.remove('maxHitPoints');
      characterJson.remove('temporaryHitPoints');
      characterJson.remove('experiencePoints');
      characterJson.remove('selectedCantrips');
      characterJson.remove('selectedSpells');
      characterJson.remove('skills');
      characterJson.remove('inventory');
      characterJson.remove('dndClass');

      // Inserir se não existir, senão atualizar
      bool exists = false;
      if (character.id.isNotEmpty) {
        final existing =
            await SupabaseService.client
                .from('characters')
                .select('id')
                .eq('id', character.id)
                .eq('user_id', userId)
                .maybeSingle();
        exists = existing != null;
      }

      if (!exists) {
        // Criar novo personagem (usar id existente se fornecido)
        characterJson['id'] =
            character.id.isNotEmpty ? character.id : _uuid.v4();
        debugPrint(
          'CharacterService: Criando novo personagem com ID: ${characterJson['id']}',
        );
        final response =
            await SupabaseService.client
                .from('characters')
                .insert(characterJson)
                .select()
                .single();
        debugPrint(
          'CharacterService: Personagem criado com sucesso: ${response['id']}',
        );
        return response['id'];
      }

      // Atualizar personagem existente
      debugPrint(
        'CharacterService: Atualizando personagem existente: ${character.id}',
      );
      await SupabaseService.client
          .from('characters')
          .update(characterJson)
          .eq('id', character.id)
          .eq('user_id', userId);
      debugPrint('CharacterService: Personagem atualizado com sucesso');
      return character.id;
    } catch (e) {
      debugPrint('Erro ao salvar personagem: $e');
      rethrow;
    }
  }

  // Carregar personagem por ID
  static Future<Character?> loadCharacter(String id) async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        debugPrint('Usuário não autenticado');
        return null;
      }

      final response =
          await SupabaseService.client
              .from('characters')
              .select()
              .eq('id', id)
              .eq('user_id', userId)
              .single();

      // Converter colunas individuais de volta para abilityScores Map
      final abilityScores = {
        'strength': response['strength'] ?? 10,
        'dexterity': response['dexterity'] ?? 10,
        'constitution': response['constitution'] ?? 10,
        'intelligence': response['intelligence'] ?? 10,
        'wisdom': response['wisdom'] ?? 10,
        'charisma': response['charisma'] ?? 10,
      };

      // Adicionar abilityScores ao JSON
      response['abilityScores'] = abilityScores;

      // Mapear nomes de colunas do banco para o modelo
      response['className'] = response['class_name'];
      response['armorClass'] = response['armor_class'] ?? 10;
      response['currentHitPoints'] = response['current_hit_points'] ?? 0;
      response['maxHitPoints'] = response['max_hit_points'] ?? 0;
      response['temporaryHitPoints'] = response['temporary_hit_points'] ?? 0;
      response['experiencePoints'] = response['experience_points'] ?? 0;

      // Converter listas JSON de volta
      response['languages'] = response['languages'] ?? [];
      response['proficiencies'] = response['proficiencies'] ?? [];
      response['selectedCantrips'] = response['selected_cantrips'] ?? [];
      response['selectedSpells'] = response['selected_spells'] ?? [];

      final character = Character.fromJson(response);

      // Sincronizar proficiências com skills após carregar
      _syncProficienciesWithSkills(character, character.proficiencies);

      debugPrint(
        'CharacterService: Personagem individual carregado: ${character.name} (ID: ${character.id})',
      );
      return character;
    } catch (e) {
      debugPrint('Erro ao carregar personagem: $e');
      return null;
    }
  }

  // Remover personagem
  static Future<void> removeCharacter(String id) async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        throw Exception('Usuário não autenticado');
      }

      debugPrint(
        'CharacterService: Removendo personagem com ID: $id para usuário: $userId',
      );
      await SupabaseService.client
          .from('characters')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
      debugPrint('CharacterService: Personagem removido com sucesso');
    } catch (e) {
      debugPrint('Erro ao remover personagem: $e');
      rethrow;
    }
  }

  // Salvar perícias do personagem
  static Future<void> saveSkills(String characterId, List<Skill> skills) async {
    try {
      debugPrint(
        'CharacterService: Salvando ${skills.length} perícias para personagem: $characterId',
      );

      // Primeiro, remover todas as perícias existentes
      await SupabaseService.client
          .from('skills')
          .delete()
          .eq('character_id', characterId);

      // Depois, inserir as novas perícias
      if (skills.isNotEmpty) {
        final skillsData =
            skills
                .map(
                  (skill) => {
                    'id': _uuid.v4(),
                    'character_id': characterId,
                    'name': skill.name,
                    'base_ability': skill.baseAbility,
                    'proficiency': skill.isProficient,
                    'expertise': skill.hasExpertise,
                    'modifier': skill.getModifier({}, 0), // Usar método correto
                  },
                )
                .toList();

        await SupabaseService.client.from('skills').insert(skillsData);
        debugPrint(
          'CharacterService: ${skills.length} perícias salvas com sucesso',
        );
      } else {
        debugPrint('CharacterService: Nenhuma perícia para salvar');
      }
    } catch (e) {
      debugPrint('CharacterService: Erro ao salvar perícias: $e');
      rethrow;
    }
  }

  /// Sincroniza a lista de proficiências com os objetos Skill
  static void _syncProficienciesWithSkills(
    Character character,
    List<String> proficiencies,
  ) {
    debugPrint(
      'CharacterService: Sincronizando ${proficiencies.length} proficiências com skills',
    );
    debugPrint('CharacterService: Proficiências recebidas: $proficiencies');
    debugPrint('CharacterService: Total de skills: ${character.skills.length}');

    // Mapear nomes de perícias do banco para nomes das perícias do modelo
    final Map<String, String> skillNameMapping = {
      'Adestrar Animais': 'Lidar com Animais',
      'Enganação': 'Blefar',
      'Apresentação': 'Atuação',
    };

    // Filtrar apenas perícias (remover atributos)
    final skillProficiencies =
        proficiencies
            .where((prof) {
              return ![
                'Força',
                'Destreza',
                'Constituição',
                'Inteligência',
                'Sabedoria',
                'Carisma',
              ].contains(prof);
            })
            .toSet()
            .toList(); // Remove duplicatas

    debugPrint(
      'CharacterService: Perícias filtradas (sem atributos): $skillProficiencies',
    );

    // Atualizar perícias proficientes
    for (final skill in character.skills) {
      final wasProficient = skill.isProficient;
      bool isProficient = false;

      // Verificar nome direto
      if (skillProficiencies.contains(skill.name)) {
        isProficient = true;
      } else {
        // Verificar mapeamento
        for (final entry in skillNameMapping.entries) {
          if (skillProficiencies.contains(entry.key) &&
              skill.name == entry.value) {
            isProficient = true;
            break;
          }
        }
      }

      skill.isProficient = isProficient;

      if (isProficient && !wasProficient) {
        debugPrint(
          'CharacterService: Marcando perícia como proficiente: ${skill.name}',
        );
      } else if (!isProficient && wasProficient) {
        debugPrint(
          'CharacterService: Removendo proficiência de: ${skill.name}',
        );
      }
    }

    // Debug: verificar resultado final
    final proficientSkills =
        character.skills
            .where((s) => s.isProficient)
            .map((s) => s.name)
            .toList();
    debugPrint(
      'CharacterService: Perícias proficientes após sincronização: $proficientSkills',
    );

    // As salvaguardas proficientes serão calculadas automaticamente
    // pelo método isSavingThrowProficient() usando a lista proficiencies
    debugPrint('CharacterService: Sincronização de proficiências concluída');
  }

  // Carregar perícias do personagem
  static Future<List<Skill>> loadSkills(String characterId) async {
    try {
      debugPrint(
        'CharacterService: Carregando perícias para personagem: $characterId',
      );
      final response = await SupabaseService.client
          .from('skills')
          .select()
          .eq('character_id', characterId);

      debugPrint(
        'CharacterService: ${response.length} perícias encontradas no banco',
      );

      final skills =
          response
              .map<Skill>(
                (data) => Skill(
                  name: data['name'] as String,
                  baseAbility: data['base_ability'] as String,
                  isProficient: data['proficiency'] as bool? ?? false,
                  hasExpertise: data['expertise'] as bool? ?? false,
                ),
              )
              .toList();

      debugPrint(
        'CharacterService: ${skills.length} perícias convertidas para objetos Skill',
      );
      return skills;
    } catch (e) {
      debugPrint('CharacterService: Erro ao carregar perícias: $e');
      return [];
    }
  }

  // Salvar itens do inventário
  static Future<void> saveItems(String characterId, List<Item> items) async {
    try {
      debugPrint(
        'CharacterService: Salvando ${items.length} itens para personagem: $characterId',
      );

      // Verificar se o usuário está autenticado
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        throw Exception('Usuário não autenticado');
      }

      // Verificar se o personagem pertence ao usuário
      final character = await loadCharacter(characterId);
      if (character == null) {
        throw Exception('Personagem não encontrado ou não pertence ao usuário');
      }

      // Primeiro, remover todos os itens existentes
      await SupabaseService.client
          .from('items')
          .delete()
          .eq('character_id', characterId);

      // Depois, inserir os novos itens
      if (items.isNotEmpty) {
        final itemsData =
            items
                .map(
                  (item) => {
                    'id': _uuid.v4(),
                    'character_id': characterId,
                    'name': item.name,
                    'description': item.description,
                    'quantity': item.quantity,
                    'weight': item.weight,
                    'value': item.value,
                    'type': item.type.toString().split('.').last,
                    'equipped': item.isEquipped,
                  },
                )
                .toList();

        await SupabaseService.client.from('items').insert(itemsData);
        debugPrint(
          'CharacterService: ${items.length} itens salvos com sucesso',
        );
      } else {
        debugPrint('CharacterService: Nenhum item para salvar');
      }
    } catch (e) {
      debugPrint('Erro ao salvar itens: $e');
      rethrow;
    }
  }

  // Carregar itens do inventário
  static Future<List<Item>> loadItems(String characterId) async {
    try {
      debugPrint('=== CHARACTER SERVICE: INÍCIO LOAD ITEMS ===');
      debugPrint(
        'CharacterService: Carregando itens para character_id: $characterId',
      );

      // Verificar se o usuário está autenticado
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        debugPrint(
          'CharacterService: Usuário não autenticado para carregar itens',
        );
        return [];
      }

      // Verificar se o personagem pertence ao usuário
      final character = await loadCharacter(characterId);
      if (character == null) {
        debugPrint(
          'CharacterService: Personagem não encontrado ou não pertence ao usuário',
        );
        return [];
      }

      final response = await SupabaseService.client
          .from('items')
          .select()
          .eq('character_id', characterId);

      debugPrint('=== CHARACTER SERVICE: RESPOSTA DO BANCO ===');
      debugPrint(
        'CharacterService: Resposta do banco: ${response.length} itens encontrados',
      );
      debugPrint('Dados brutos: $response');

      final items =
          response.map<Item>((data) {
            debugPrint('Processando item: $data');
            return Item(
              id: data['id'] as String,
              name: data['name'] as String,
              description: data['description'] as String? ?? '',
              quantity: data['quantity'] as int? ?? 1,
              weight: (data['weight'] as num?)?.toDouble() ?? 0.0,
              value: (data['value'] as num?)?.toInt() ?? 0,
              type: ItemType.values.firstWhere(
                (type) => type.toString().split('.').last == data['type'],
                orElse: () => ItemType.misc,
              ),
              isEquipped: data['equipped'] as bool? ?? false,
            );
          }).toList();

      debugPrint('=== CHARACTER SERVICE: CONVERSÃO CONCLUÍDA ===');
      debugPrint(
        'CharacterService: ${items.length} itens convertidos para objetos Item',
      );
      for (int i = 0; i < items.length; i++) {
        debugPrint('Item convertido $i: ${items[i].name} (${items[i].type})');
      }
      debugPrint('=== CHARACTER SERVICE: FIM LOAD ITEMS ===');
      return items;
    } catch (e, stackTrace) {
      debugPrint('=== CHARACTER SERVICE: ERRO LOAD ITEMS ===');
      debugPrint('CharacterService: Erro ao carregar itens: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('=== CHARACTER SERVICE: FIM ERRO ===');
      return [];
    }
  }

  // Carregar dados de referência (classes, raças, etc.)
  static Future<List<Map<String, dynamic>>> loadReferenceData(
    String table,
  ) async {
    try {
      debugPrint(
        'CharacterService: Carregando dados de referência da tabela: $table',
      );
      switch (table) {
        case 'classes':
          return await SupabaseService.getClasses();
        case 'races':
          return await SupabaseService.getRaces();
        case 'backgrounds':
          return await SupabaseService.getBackgrounds();
        case 'feats':
          return await SupabaseService.getFeats();
        case 'equipment':
          return await SupabaseService.getEquipment();
        case 'spells':
          return await SupabaseService.getSpells();
        default:
          debugPrint('CharacterService: Tabela não reconhecida: $table');
          return [];
      }
    } catch (e) {
      debugPrint(
        'CharacterService: Erro ao carregar dados de referência ($table): $e',
      );
      return [];
    }
  }
}
