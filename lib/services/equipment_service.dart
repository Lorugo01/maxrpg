import 'package:flutter/material.dart';
import '../models/equipment.dart';
import 'supabase_service.dart';

class EquipmentService {
  static List<Equipment>? _cache;

  /// Carrega todos os equipamentos do Supabase
  static Future<List<Equipment>> loadAll() async {
    if (_cache != null) return _cache!;

    try {
      final response = await SupabaseService.client
          .from('equipment')
          .select()
          .order('name');

      _cache = response.map((json) => Equipment.fromJson(json)).toList();
      debugPrint('Equipamentos carregados do Supabase: ${_cache!.length}');
      return _cache!;
    } catch (e) {
      debugPrint('Erro ao carregar equipamentos do Supabase: $e');
      return [];
    }
  }

  /// Busca equipamentos por tipo
  static Future<List<Equipment>> getByType(String type) async {
    final equipment = await loadAll();
    return equipment
        .where((item) => item.type.toLowerCase() == type.toLowerCase())
        .toList();
  }

  /// Busca equipamentos por categoria
  static Future<List<Equipment>> getByCategory(String category) async {
    final equipment = await loadAll();
    return equipment
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Busca equipamentos por nome
  static Future<List<Equipment>> searchByName(String query) async {
    final equipment = await loadAll();
    if (query.isEmpty) return equipment;

    return equipment
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Busca um equipamento específico pelo nome
  static Future<Equipment?> getByName(String name) async {
    final equipment = await loadAll();
    try {
      return equipment.firstWhere(
        (item) => item.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Limpa o cache local
  static void clearCache() {
    _cache = null;
  }
}
