import 'package:flutter/material.dart';
import '../models/feat.dart';
import 'supabase_service.dart';

class FeatService {
  static List<Feat>? _feats;

  /// Carrega todos os talentos do Supabase
  static Future<List<Feat>> loadAll() async {
    if (_feats != null) {
      return _feats!;
    }

    try {
      final response = await SupabaseService.getFeats();
      _feats = response.map<Feat>((json) => Feat.fromJson(json)).toList();
      debugPrint('Talentos carregados do Supabase: ${_feats!.length}');
      return _feats!;
    } catch (e) {
      debugPrint('Erro ao carregar talentos do Supabase: $e');
      return [];
    }
  }

  /// Carrega um talento específico pelo nome
  static Future<Feat?> loadByName(String name) async {
    final feats = await loadAll();
    try {
      return feats.firstWhere(
        (feat) => feat.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Filtra talentos por nome (busca parcial)
  static Future<List<Feat>> searchByName(String query) async {
    final feats = await loadAll();
    if (query.isEmpty) return feats;

    return feats
        .where((feat) => feat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Limpa o cache local (útil para forçar recarregamento)
  static void clearCache() {
    _feats = null;
  }
}
