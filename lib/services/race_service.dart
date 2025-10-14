import 'package:flutter/material.dart';
import '../models/race.dart';
import 'supabase_service.dart';

class RaceService {
  static List<Race>? _races;

  /// Carrega todas as raças do Supabase
  static Future<List<Race>> loadAll() async {
    if (_races != null) {
      return _races!;
    }

    try {
      final response = await SupabaseService.getRaces();
      debugPrint(
        'RaceService: Dados brutos do Supabase: ${response.length} raças',
      );
      for (int i = 0; i < response.length; i++) {
        final race = response[i];
        debugPrint('RaceService: Raça $i - Nome: ${race['name']}');
        debugPrint('RaceService: Raça $i - traits: ${race['traits']}');
        debugPrint(
          'RaceService: Raça $i - traits_text: ${race['traits_text']}',
        );
      }

      _races = response.map<Race>((json) => Race.fromJson(json)).toList();
      debugPrint('Raças carregadas do Supabase: ${_races!.length}');
      return _races!;
    } catch (e) {
      debugPrint('Erro ao carregar raças do Supabase: $e');
      return [];
    }
  }

  /// Carrega apenas raças habilitadas para criação de personagens
  static Future<List<Race>> loadEnabled() async {
    final allRaces = await loadAll();
    return allRaces.where((race) => race.enabled).toList();
  }

  /// Carrega uma raça específica pelo nome
  static Future<Race?> loadByName(String name) async {
    final races = await loadAll();
    try {
      return races.firstWhere(
        (race) => race.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Filtra raças por nome
  static Future<List<Race>> searchByName(String query) async {
    final races = await loadAll();
    if (query.isEmpty) return races;

    return races
        .where((race) => race.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Busca raças por tipo (se ainda necessário)
  static Future<Race?> getByType(RaceType type) async {
    final races = await loadAll();
    try {
      return races.firstWhere(
        (race) => race.name.toLowerCase() == _getTypeName(type).toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Converte RaceType para nome da raça
  static String _getTypeName(RaceType type) {
    switch (type) {
      case RaceType.dwarf:
        return 'Anão';
      case RaceType.elf:
        return 'Elfo';
      case RaceType.halfling:
        return 'Halfling';
      case RaceType.human:
        return 'Humano';
      case RaceType.dragonborn:
        return 'Draconato';
      case RaceType.gnome:
        return 'Gnomo';
      case RaceType.halfElf:
        return 'Meio-Elfo';
      case RaceType.halfOrc:
        return 'Meio-Orc';
      case RaceType.tiefling:
        return 'Tiefling';
    }
  }

  /// Limpa o cache local (útil para forçar recarregamento)
  static void clearCache() {
    _races = null;
  }
}
