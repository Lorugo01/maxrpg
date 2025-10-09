import 'package:flutter/material.dart';
import '../models/spell.dart';
import 'supabase_service.dart';

class SpellService {
  static List<Spell>? _cached;

  /// Carrega todas as magias do Supabase
  static Future<List<Spell>> loadPhbSpellsPtBr() async {
    if (_cached != null) return _cached!;

    try {
      final response = await SupabaseService.client
          .from('spells')
          .select()
          .order('name', ascending: true);

      _cached = response.map((json) => Spell.fromJson(json)).toList();
      return _cached!;
    } catch (e) {
      debugPrint('Erro ao carregar magias do Supabase: $e');
      return [];
    }
  }

  /// Busca magias por nível
  static Future<List<Spell>> getByLevel(int level) async {
    final spells = await loadPhbSpellsPtBr();
    return spells.where((spell) => spell.level == level).toList();
  }

  /// Busca magias por escola
  static Future<List<Spell>> getBySchool(String school) async {
    final spells = await loadPhbSpellsPtBr();
    return spells
        .where((spell) => spell.school.toLowerCase() == school.toLowerCase())
        .toList();
  }

  /// Busca magias por nome
  static Future<List<Spell>> searchByName(String query) async {
    final spells = await loadPhbSpellsPtBr();
    if (query.isEmpty) return spells;

    return spells
        .where(
          (spell) => spell.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// Busca uma magia específica pelo nome
  static Future<Spell?> getByName(String name) async {
    final spells = await loadPhbSpellsPtBr();
    try {
      return spells.firstWhere(
        (spell) => spell.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Filtra magias por classe e nível
  static Future<List<Spell>> filterByClassAndLevel(
    String classNamePtBr,
    int level,
  ) async {
    final all = await loadPhbSpellsPtBr();
    return all
        .where((s) => s.level == level && s.classes.contains(classNamePtBr))
        .toList();
  }

  /// Limpa o cache local
  static void clearCache() {
    _cached = null;
  }
}
