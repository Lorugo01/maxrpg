import 'package:uuid/uuid.dart';
import '../models/character.dart';
import '../models/skill.dart';
import '../models/item.dart';
import 'supabase_service.dart';
import 'class_service.dart';

import 'auth_service.dart';

class CharacterService {
  static const _uuid = Uuid();

  // Carregar todos os personagens do usuário atual
  static Future<List<Character>> loadCharacters() async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        return [];
      }
      final response = await SupabaseService.client
          .from('characters')
          .select()
          .eq('user_id', userId);

      final characters = <Character>[];

      for (final json in response) {
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

        final character = Character.fromJson(json);

        // Carregar dados completos da classe
        if (character.className.isNotEmpty) {
          final dndClass = await ClassService.loadByName(character.className);
          if (dndClass != null) {
            character.dndClass = dndClass;
          } else {}
        }

        // Sincronizar proficiências com skills após carregar
        _syncProficienciesWithSkills(character, character.proficiencies);

        characters.add(character);
      }

      return characters;
    } catch (e) {
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

      final characterJson = character.toJson();
      characterJson['user_id'] = userId;

      // Converter abilityScores Map para colunas individuais a partir do objeto Character
      final abilityScores = Map<String, int>.from(character.abilityScores);
      int getScore(Map<String, int> m, String pt, String en) =>
          m[pt] ?? m[en] ?? 10;
      characterJson['strength'] = getScore(abilityScores, 'Força', 'strength');
      characterJson['dexterity'] = getScore(
        abilityScores,
        'Destreza',
        'dexterity',
      );
      characterJson['constitution'] = getScore(
        abilityScores,
        'Constituição',
        'constitution',
      );
      characterJson['intelligence'] = getScore(
        abilityScores,
        'Inteligência',
        'intelligence',
      );
      characterJson['wisdom'] = getScore(abilityScores, 'Sabedoria', 'wisdom');
      characterJson['charisma'] = getScore(
        abilityScores,
        'Carisma',
        'charisma',
      );
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

        final response =
            await SupabaseService.client
                .from('characters')
                .insert(characterJson)
                .select()
                .single();

        return response['id'];
      }

      // Atualizar personagem existente
      await SupabaseService.client
          .from('characters')
          .update(characterJson)
          .eq('id', character.id)
          .eq('user_id', userId);
      return character.id;
    } catch (e) {
      rethrow;
    }
  }

  // Carregar personagem por ID
  static Future<Character?> loadCharacter(String id) async {
    try {
      final userId = AuthService.userId;
      if (userId.isEmpty) {
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

      // Carregar dados completos da classe
      if (character.className.isNotEmpty) {
        final dndClass = await ClassService.loadByName(character.className);
        if (dndClass != null) {
          character.dndClass = dndClass;
        } else {}
      }

      // Sincronizar proficiências com skills após carregar
      _syncProficienciesWithSkills(character, character.proficiencies);

      return character;
    } catch (e) {
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

      await SupabaseService.client
          .from('characters')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      rethrow;
    }
  }

  // Salvar perícias do personagem
  static Future<void> saveSkills(String characterId, List<Skill> skills) async {
    try {
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
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  /// Sincroniza a lista de proficiências com os objetos Skill
  static void _syncProficienciesWithSkills(
    Character character,
    List<String> proficiencies,
  ) {
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

    // Atualizar perícias proficientes
    for (final skill in character.skills) {
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
    }

    // Debug: verificar resultado final

    // As salvaguardas proficientes serão calculadas automaticamente
    // pelo método isSavingThrowProficient() usando a lista proficiencies
  }

  // Carregar perícias do personagem
  static Future<List<Skill>> loadSkills(String characterId) async {
    try {
      final response = await SupabaseService.client
          .from('skills')
          .select()
          .eq('character_id', characterId);

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

      return skills;
    } catch (e) {
      return [];
    }
  }

  // Salvar itens do inventário
  static Future<void> saveItems(String characterId, List<Item> items) async {
    try {
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
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  // Carregar itens do inventário
  static Future<List<Item>> loadItems(String characterId) async {
    try {
      // Verificar se o usuário está autenticado
      final userId = AuthService.userId;
      if (userId.isEmpty) {
        return [];
      }

      // Verificar se o personagem pertence ao usuário
      final character = await loadCharacter(characterId);
      if (character == null) {
        return [];
      }

      final response = await SupabaseService.client
          .from('items')
          .select()
          .eq('character_id', characterId);

      final items =
          response.map<Item>((data) {
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

      return items;
    } catch (e) {
      return [];
    }
  }

  // Carregar dados de referência (classes, raças, etc.)
  static Future<List<Map<String, dynamic>>> loadReferenceData(
    String table,
  ) async {
    try {
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
          return [];
      }
    } catch (e) {
      return [];
    }
  }
}
