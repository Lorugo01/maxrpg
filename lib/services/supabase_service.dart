import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import 'package:flutter/material.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    try {
      debugPrint('SupabaseService: Inicializando Supabase...');
      final url = SupabaseConfig.url;
      final anonKey = SupabaseConfig.anonKey;

      if (url.isEmpty || anonKey.isEmpty) {
        debugPrint(
          'SupabaseService: Variáveis de ambiente ausentes. '
          'Defina SUPABASE_URL e SUPABASE_ANON_KEY no arquivo .env',
        );
        throw Exception('SUPABASE_URL/ANON_KEY não definidos');
      }

      await Supabase.initialize(url: url, anonKey: anonKey);
      debugPrint('SupabaseService: Supabase inicializado com sucesso!');
    } catch (e) {
      debugPrint('SupabaseService: Erro ao inicializar Supabase: $e');
      rethrow;
    }
  }

  // Métodos para Characters
  static Future<List<Map<String, dynamic>>> getCharacters() async {
    final response = await client.from(SupabaseConfig.charactersTable).select();
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> getCharacter(String id) async {
    final response =
        await client
            .from(SupabaseConfig.charactersTable)
            .select()
            .eq('id', id)
            .single();
    return response;
  }

  static Future<String> createCharacter(Map<String, dynamic> character) async {
    final response =
        await client
            .from(SupabaseConfig.charactersTable)
            .insert(character)
            .select()
            .single();
    return response['id'];
  }

  static Future<void> updateCharacter(
    String id,
    Map<String, dynamic> character,
  ) async {
    await client
        .from(SupabaseConfig.charactersTable)
        .update(character)
        .eq('id', id);
  }

  static Future<void> deleteCharacter(String id) async {
    await client.from(SupabaseConfig.charactersTable).delete().eq('id', id);
  }

  // Métodos para Skills
  static Future<List<Map<String, dynamic>>> getSkills() async {
    final response = await client.from(SupabaseConfig.skillsTable).select();
    return List<Map<String, dynamic>>.from(response);
  }

  // Métodos para Items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final response = await client.from(SupabaseConfig.itemsTable).select();
    return List<Map<String, dynamic>>.from(response);
  }

  // Métodos para Spells
  static Future<List<Map<String, dynamic>>> getSpells() async {
    try {
      debugPrint('SupabaseService: Carregando magias...');
      final response = await client.from(SupabaseConfig.spellsTable).select();
      debugPrint('SupabaseService: Response type: ${response.runtimeType}');
      debugPrint('SupabaseService: Response value: $response');

      debugPrint('SupabaseService: ${response.length} magias carregadas');
      return response.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('Erro ao carregar magias do Supabase: $e');
      return [];
    }
  }

  // Métodos para Classes
  static Future<List<Map<String, dynamic>>> getClasses() async {
    try {
      debugPrint('SupabaseService: Carregando classes...');
      final response = await client.from(SupabaseConfig.classesTable).select();
      debugPrint('SupabaseService: ${response.length} classes carregadas');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao carregar classes do Supabase: $e');
      return [];
    }
  }

  // Métodos para Races
  static Future<List<Map<String, dynamic>>> getRaces() async {
    try {
      debugPrint('SupabaseService: Carregando raças...');
      final response = await client.from(SupabaseConfig.racesTable).select();
      debugPrint('SupabaseService: ${response.length} raças carregadas');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao carregar raças do Supabase: $e');
      return [];
    }
  }

  // Métodos para Backgrounds
  static Future<List<Map<String, dynamic>>> getBackgrounds() async {
    try {
      debugPrint('SupabaseService: Carregando antecedentes...');
      final response =
          await client.from(SupabaseConfig.backgroundsTable).select();
      debugPrint('SupabaseService: ${response.length} antecedentes carregados');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao carregar antecedentes do Supabase: $e');
      return [];
    }
  }

  // Métodos para Feats
  static Future<List<Map<String, dynamic>>> getFeats() async {
    try {
      debugPrint('SupabaseService: Carregando talentos...');
      final response = await client.from(SupabaseConfig.featsTable).select();
      debugPrint('SupabaseService: ${response.length} talentos carregados');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao carregar talentos do Supabase: $e');
      return [];
    }
  }

  // Métodos para Equipment
  static Future<List<Map<String, dynamic>>> getEquipment() async {
    try {
      debugPrint('SupabaseService: Carregando equipamentos...');
      final response =
          await client.from(SupabaseConfig.equipmentTable).select();
      debugPrint('SupabaseService: ${response.length} equipamentos carregados');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Erro ao carregar equipamentos do Supabase: $e');
      return [];
    }
  }

  // Removido: não utilizamos mais JSON parsing; usamos os tipos do banco diretamente
}
