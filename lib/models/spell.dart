import 'dart:convert';

import 'package:flutter/material.dart';

class Spell {
  final String name;
  final int level; // 0 = truque
  final String school;
  final List<String> classes; // Ex.: ['Mago', 'Feiticeiro']
  final String castingTime;
  final String range;
  final String components; // V, S, M
  final String? material;
  final String duration;
  final bool concentration;
  final bool ritual;
  final String description;
  final String? higherLevels;
  final String source; // PHB 2014

  // Campos mecânicos opcionais (dano/cura, upcast, escalonamento de truque)
  final String? effectType; // 'Dano' | 'Cura'
  final String? baseDice; // ex: '2d8' ou '2d4'
  final bool includeSpellMod; // soma o modificador de conjuração
  final String? damageType; // ex: 'Necrótico'
  final String? upcastDicePerLevel; // ex: '1d8' ou '2d4'
  final List<Map<String, dynamic>>?
  cantripDiceIncreases; // [{level:int, dice:String}]

  Spell({
    required this.name,
    required this.level,
    required this.school,
    required this.classes,
    required this.castingTime,
    required this.range,
    required this.components,
    this.material,
    required this.duration,
    required this.concentration,
    required this.ritual,
    required this.description,
    this.higherLevels,
    required this.source,
    this.effectType,
    this.baseDice,
    this.includeSpellMod = false,
    this.damageType,
    this.upcastDicePerLevel,
    this.cantripDiceIncreases,
  });

  factory Spell.fromMap(Map<String, dynamic> map) {
    // Debug: imprimir o mapa para identificar o problema
    debugPrint('Spell.fromMap: Mapa recebido: $map');

    // Mapear campos do banco para o modelo
    List<String> classesList = [];
    final classesData = map['classes'];
    if (classesData is String) {
      classesList =
          classesData.isNotEmpty
              ? classesData.split(',').map((c) => c.trim()).toList()
              : <String>[];
    } else if (classesData is List) {
      classesList = classesData.map((c) => c.toString()).toList();
    }

    // Tratar higherLevels que pode vir como List ou String
    String? higherLevels;
    final higherLevelsData = map['higher_levels'];
    if (higherLevelsData is String) {
      higherLevels = higherLevelsData;
    } else if (higherLevelsData is List) {
      higherLevels = higherLevelsData.join(' ');
    }

    // cantrip_dice_increases pode vir como String (JSON) ou List
    List<Map<String, dynamic>>? cantripDiceIncreases;
    final cdi = map['cantrip_dice_increases'];
    if (cdi is String && cdi.isNotEmpty) {
      try {
        final parsed = json.decode(cdi) as List<dynamic>;
        cantripDiceIncreases =
            parsed
                .map((e) => (e as Map).map((k, v) => MapEntry(k.toString(), v)))
                .cast<Map<String, dynamic>>()
                .toList();
      } catch (_) {}
    } else if (cdi is List) {
      cantripDiceIncreases =
          cdi
              .map((e) => (e as Map).map((k, v) => MapEntry(k.toString(), v)))
              .cast<Map<String, dynamic>>()
              .toList();
    }

    return Spell(
      name: map['name'] as String? ?? '',
      level: map['level'] as int? ?? 0,
      school: map['school'] as String? ?? '',
      classes: classesList,
      castingTime: map['casting_time'] as String? ?? '',
      range: map['range'] as String? ?? '',
      components: map['components'] as String? ?? '',
      material: map['material'] as String?,
      duration: map['duration'] as String? ?? '',
      concentration: map['concentration'] as bool? ?? false,
      ritual: map['ritual'] as bool? ?? false,
      description: map['description'] as String? ?? '',
      higherLevels: higherLevels,
      source: map['source'] as String? ?? 'PHB 2014',
      effectType: map['effect_type'] as String?,
      baseDice: map['base_dice'] as String?,
      includeSpellMod: map['include_spell_mod'] as bool? ?? false,
      damageType: map['damage_type'] as String?,
      upcastDicePerLevel: map['upcast_dice_per_level'] as String?,
      cantripDiceIncreases: cantripDiceIncreases,
    );
  }

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'school': school,
      'classes': classes,
      'casting_time': castingTime,
      'range': range,
      'components': components,
      'material': material,
      'duration': duration,
      'concentration': concentration,
      'ritual': ritual,
      'description': description,
      'higher_levels': higherLevels,
      'source': source,
      'effect_type': effectType,
      'base_dice': baseDice,
      'include_spell_mod': includeSpellMod,
      'damage_type': damageType,
      'upcast_dice_per_level': upcastDicePerLevel,
      'cantrip_dice_increases': cantripDiceIncreases,
    };
  }

  static List<Spell> listFromJson(String jsonStr) {
    final data = json.decode(jsonStr) as List<dynamic>;
    return data.map((e) => Spell.fromMap(e as Map<String, dynamic>)).toList();
  }
}
