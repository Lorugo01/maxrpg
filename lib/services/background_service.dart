import 'package:flutter/material.dart';
import '../models/background.dart';
import 'supabase_service.dart';

class BackgroundService {
  static List<Background>? _backgrounds;

  /// Carrega todos os antecedentes do Supabase
  static Future<List<Background>> loadAll() async {
    if (_backgrounds != null) {
      return _backgrounds!;
    }

    try {
      final response = await SupabaseService.getBackgrounds();
      _backgrounds =
          response
              .map<Background>((json) => Background.fromJson(json))
              .toList();
      debugPrint(
        'Antecedentes carregados do Supabase: ${_backgrounds!.length}',
      );
      return _backgrounds!;
    } catch (e) {
      debugPrint('Erro ao carregar antecedentes do Supabase: $e');
      return [];
    }
  }

  /// Carrega um antecedente específico pelo nome
  static Future<Background?> loadByName(String name) async {
    final backgrounds = await loadAll();
    try {
      return backgrounds.firstWhere(
        (bg) => bg.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Filtra antecedentes por nome (busca parcial)
  static Future<List<Background>> searchByName(String query) async {
    final backgrounds = await loadAll();
    if (query.isEmpty) return backgrounds;

    return backgrounds
        .where((bg) => bg.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Limpa o cache local (útil para forçar recarregamento)
  static void clearCache() {
    _backgrounds = null;
  }
}
