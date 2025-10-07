import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/dnd_class.dart';
import 'supabase_service.dart';

class ClassService {
  static List<DndClass>? _classes;

  static String _normalize(String input) {
    final lower = input.trim().toLowerCase();
    const Map<String, String> map = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
      'ä': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ì': 'i',
      'î': 'i',
      'ï': 'i',
      'ó': 'o',
      'ò': 'o',
      'ô': 'o',
      'õ': 'o',
      'ö': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ü': 'u',
      'ç': 'c',
    };
    final buffer = StringBuffer();
    for (final ch in lower.split('')) {
      buffer.write(map[ch] ?? ch);
    }
    return buffer.toString();
  }

  /// Carrega uma classe específica pelo nome
  static Future<DndClass?> loadByName(String name) async {
    debugPrint('ClassService: Carregando classe: $name');
    final classes = await loadAll();
    debugPrint('ClassService: ${classes.length} classes carregadas');
    try {
      final target = _normalize(name);
      debugPrint('ClassService: Procurando por: $target');
      final found = classes.firstWhere((c) => _normalize(c.name) == target);
      debugPrint('ClassService: Classe encontrada: ${found.name}');
      debugPrint(
        'ClassService: levelFeatures: ${found.levelFeatures?.length ?? 0}',
      );
      return found;
    } catch (e) {
      debugPrint('ClassService: Classe não encontrada: $name');
      debugPrint(
        'ClassService: Classes disponíveis: ${classes.map((c) => c.name).toList()}',
      );
      return null;
    }
  }

  /// Carrega todas as classes do Supabase
  static Future<List<DndClass>> loadAll() async {
    if (_classes != null) {
      return _classes!;
    }

    try {
      debugPrint('Carregando classes do Supabase...');
      final response = await SupabaseService.getClasses();

      debugPrint('Classes carregadas do Supabase: ${response.length}');

      List<String> split(dynamic v) {
        if (v == null) return [];
        if (v is List) return v.map((e) => e.toString()).toList();
        final s = v.toString();
        if (s.trim().isEmpty) return [];
        return s
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }

      List<dynamic> parseJsonList(dynamic v) {
        if (v == null) return [];
        if (v is List) return v;
        final s = v.toString().trim();
        if ((s.startsWith('[') && s.endsWith(']'))) {
          try {
            return (jsonDecode(s) as List);
          } catch (_) {
            return [];
          }
        }
        return [];
      }

      Map<String, dynamic>? parseJsonMap(dynamic v) {
        if (v == null) return null;
        if (v is Map<String, dynamic>) return v;
        final s = v.toString().trim();
        if ((s.startsWith('{') && s.endsWith('}'))) {
          try {
            return (jsonDecode(s) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        }
        return null;
      }

      Map<String, dynamic> toModelJson(Map<String, dynamic> row) {
        // Mapear snake_case → camelCase esperado em DndClass
        final proficiency = {
          'armor': split(row['armor_proficiencies']),
          'weapons': split(row['weapon_proficiencies']),
          'tools': split(row['tool_proficiencies']),
          'savingThrows': split(row['saving_throws']),
          'skills': split(row['skill_proficiencies']),
          'skillChoices': row['skill_count'] ?? 2,
        };

        // Features: aceitar jsonb ou string JSON em 'features' ou 'level_features'
        List<dynamic> rawFeatures = [];
        if (row.containsKey('features')) {
          rawFeatures = parseJsonList(row['features']);
        }
        if (rawFeatures.isEmpty && row.containsKey('level_features')) {
          rawFeatures = parseJsonList(row['level_features']);
        }
        final features =
            rawFeatures
                .whereType<Map<String, dynamic>>()
                .map(
                  (f) => {
                    'name': f['name'] ?? '',
                    'description': f['description'] ?? '',
                    'level':
                        f['level'] is int
                            ? f['level']
                            : int.tryParse((f['level'] ?? '1').toString()) ?? 1,
                  },
                )
                .toList();

        final startingEquipment = <String>[];
        startingEquipment.addAll(split(row['equipment_lado_a']));
        startingEquipment.addAll(split(row['equipment_lado_b']));

        // Subclasses safe parse (aceitar string JSON)
        List<dynamic> subclassesRawList = parseJsonList(
          row['subclasses_details'],
        );
        final subclasses =
            subclassesRawList.whereType<Map<String, dynamic>>().toList();

        // Spellcasting safe parse (aceitar string JSON)
        final spellcasting = parseJsonMap(row['spellcasting']);

        // DEBUG: Verificar dados de conjuração
        if (row['name'] != null) {
          debugPrint('=== DEBUG CLASSE: ${row['name']} ===');
          debugPrint('spellcasting raw: ${row['spellcasting']}');
          debugPrint('spellcasting parsed: $spellcasting');
          debugPrint('has_spells: ${row['has_spells']}');
          debugPrint('=== FIM DEBUG CLASSE ===');
        }

        return {
          'name': row['name'] ?? '',
          'description': row['description'] ?? '',
          'hitDie':
              row['hit_die'] is int
                  ? row['hit_die']
                  : int.tryParse('${row['hit_die'] ?? ''}') ?? 8,
          'primaryAbility': row['primary_ability'] ?? '',
          'secondaryAbility': row['secondary_ability'] ?? '',
          'suggestedBackground': row['suggested_background'] ?? '',
          'proficiency': proficiency,
          'startingEquipment': startingEquipment,
          'features': features,
          'spellcasting': spellcasting,
          'subclasses': subclasses,
          'flavorText': row['flavor_text'] ?? (row['description'] ?? ''),
          'progressionTable':
              row['progression_table'] is Map<String, dynamic>
                  ? row['progression_table']
                  : null,
          'levelFeatures': parseJsonList(row['level_features']),
        };
      }

      _classes =
          response.map((row) {
            try {
              final json = toModelJson(row);
              return DndClass.fromJson(json);
            } catch (e) {
              debugPrint('Erro ao converter classe ${row['name']}: $e');
              rethrow;
            }
          }).toList();

      debugPrint('Classes convertidas com sucesso: ${_classes!.length}');
      return _classes!;
    } catch (e) {
      debugPrint('Erro ao carregar classes do Supabase: $e');
      return [];
    }
  }

  /// Busca uma classe pelo nome
  static Future<DndClass?> getByName(String name) async {
    final classes = await loadAll();
    try {
      final target = _normalize(name);
      return classes.firstWhere((cls) => _normalize(cls.name) == target);
    } catch (e) {
      return null;
    }
  }

  /// Filtra classes por nome
  static Future<List<DndClass>> searchByName(String query) async {
    final classes = await loadAll();
    if (query.isEmpty) return classes;

    return classes
        .where((cls) => cls.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Busca classes por tipo (se ainda necessário)
  static Future<DndClass?> getByType(ClassType type) async {
    final classes = await loadAll();
    try {
      return classes.firstWhere(
        (cls) => cls.name.toLowerCase() == _getTypeName(type).toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Converte ClassType para nome da classe
  static String _getTypeName(ClassType type) {
    switch (type) {
      case ClassType.barbarian:
        return 'Bárbaro';
      case ClassType.bard:
        return 'Bardo';
      case ClassType.cleric:
        return 'Clérigo';
      case ClassType.druid:
        return 'Druida';
      case ClassType.fighter:
        return 'Guerreiro';
      case ClassType.monk:
        return 'Monge';
      case ClassType.paladin:
        return 'Paladino';
      case ClassType.ranger:
        return 'Patrulheiro';
      case ClassType.rogue:
        return 'Ladino';
      case ClassType.sorcerer:
        return 'Feiticeiro';
      case ClassType.warlock:
        return 'Bruxo';
      case ClassType.wizard:
        return 'Mago';
      case ClassType.artificer:
        return 'Artífice';
    }
  }

  /// Limpa o cache local (útil para forçar recarregamento)
  static void clearCache() {
    _classes = null;
  }
}
