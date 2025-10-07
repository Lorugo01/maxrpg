import 'dart:convert';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../config/supabase_config.dart';

class DataMigrationService {
  static SupabaseClient get client => Supabase.instance.client;

  // Migrar dados de classes
  static Future<void> migrateClasses() async {
    try {
      final file = File('assets/classes/phb_2024_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> classes = json.decode(content);

      for (final classData in classes) {
        await client.from(SupabaseConfig.classesTable).upsert({
          'name': classData['name'],
          'hit_dice': classData['hit_dice'] ?? 8,
          'primary_ability': classData['primary_ability'] ?? 'varies',
          'saving_throw_proficiencies': json.encode(
            classData['saving_throw_proficiencies'] ?? [],
          ),
          'skill_proficiencies': json.encode(
            classData['skill_proficiencies'] ?? [],
          ),
          'equipment': classData['equipment'] ?? '',
          'features': classData['features'] ?? {},
          'spellcasting': classData['spellcasting'] ?? {},
        });
      }
      debugPrint('Classes migradas com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar classes: $e');
    }
  }

  // Migrar dados de raças
  static Future<void> migrateRaces() async {
    try {
      final file = File('assets/races/phb_2024_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> races = json.decode(content);

      for (final raceData in races) {
        await client.from(SupabaseConfig.racesTable).upsert({
          'name': raceData['name'],
          'ability_score_increases': raceData['ability_score_increases'] ?? {},
          'size': raceData['size'] ?? 'Medium',
          'speed': raceData['speed'] ?? 30,
          'traits': raceData['traits'] ?? {},
          'languages': raceData['languages'] ?? '',
        });
      }
      debugPrint('Raças migradas com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar raças: $e');
    }
  }

  // Migrar dados de antecedentes
  static Future<void> migrateBackgrounds() async {
    try {
      final file = File('assets/backgrounds/phb_2024_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> backgrounds = json.decode(content);

      for (final backgroundData in backgrounds) {
        await client.from(SupabaseConfig.backgroundsTable).upsert({
          'name': backgroundData['name'],
          'skill_proficiencies': json.encode(
            backgroundData['skill_proficiencies'] ?? [],
          ),
          'tool_proficiencies': backgroundData['tool_proficiencies'] ?? '',
          'languages': backgroundData['languages'] ?? '',
          'equipment': backgroundData['equipment'] ?? '',
          'features': backgroundData['features'] ?? {},
        });
      }
      debugPrint('Antecedentes migrados com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar antecedentes: $e');
    }
  }

  // Migrar dados de talentos
  static Future<void> migrateFeats() async {
    try {
      final file = File('assets/feats/phb_2024_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> feats = json.decode(content);

      for (final featData in feats) {
        await client.from(SupabaseConfig.featsTable).upsert({
          'name': featData['name'],
          'prerequisite': featData['prerequisite'] ?? '',
          'description': featData['description'] ?? '',
          'benefits': featData['benefits'] ?? {},
        });
      }
      debugPrint('Talentos migrados com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar talentos: $e');
    }
  }

  // Migrar dados de equipamentos
  static Future<void> migrateEquipment() async {
    try {
      final file = File('assets/equipment/phb_2014_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> equipment = json.decode(content);

      for (final equipmentData in equipment) {
        await client.from(SupabaseConfig.equipmentTable).upsert({
          'name': equipmentData['name'],
          'type': equipmentData['type'] ?? 'misc',
          'category': equipmentData['category'] ?? 'misc',
          'cost': equipmentData['cost'] ?? 0,
          'weight': equipmentData['weight'] ?? 0,
          'description': equipmentData['description'] ?? '',
          'properties': equipmentData['properties'] ?? '',
          'damage': equipmentData['damage'] ?? '',
          'armor_class': equipmentData['armor_class'],
          'stealth_disadvantage':
              equipmentData['stealth_disadvantage'] ?? false,
        });
      }
      debugPrint('Equipamentos migrados com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar equipamentos: $e');
    }
  }

  // Migrar dados de magias
  static Future<void> migrateSpells() async {
    try {
      final file = File('assets/spells/phb_2014_ptbr.json');
      final content = await file.readAsString();
      final List<dynamic> spells = json.decode(content);

      for (final spellData in spells) {
        await client.from(SupabaseConfig.spellsTable).upsert({
          'name': spellData['name'],
          'level': spellData['level'] ?? 0,
          'school': spellData['school'] ?? 'abjuration',
          'casting_time': spellData['casting_time'] ?? '1 action',
          'range': spellData['range'] ?? 'self',
          'components': spellData['components'] ?? 'V',
          'duration': spellData['duration'] ?? 'instantaneous',
          'description': spellData['description'] ?? '',
        });
      }
      debugPrint('Magias migradas com sucesso!');
    } catch (e) {
      debugPrint('Erro ao migrar magias: $e');
    }
  }

  // Executar todas as migrações
  static Future<void> migrateAllData() async {
    debugPrint('Iniciando migração de dados...');

    await migrateClasses();
    await migrateRaces();
    await migrateBackgrounds();
    await migrateFeats();
    await migrateEquipment();
    await migrateSpells();

    debugPrint('Migração concluída!');
  }
}
