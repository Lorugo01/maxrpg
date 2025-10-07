import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  // Lê do .env com fallback opcional (strings vazias) para evitar chave exposta no código
  static String get url => dotenv.env['SUPABASE_URL'] ?? '';
  static String get anonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  // Configurações do projeto
  static const String projectId = 'maxrpg';

  // Nomes das tabelas
  static const String charactersTable = 'characters';
  static const String skillsTable = 'skills';
  static const String itemsTable = 'items';
  static const String spellsTable = 'spells';
  static const String classesTable = 'classes';
  static const String racesTable = 'races';
  static const String backgroundsTable = 'backgrounds';
  static const String featsTable = 'feats';
  static const String equipmentTable = 'equipment';
}
