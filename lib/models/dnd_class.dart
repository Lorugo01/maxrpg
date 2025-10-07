import 'package:flutter/foundation.dart';

enum ClassType {
  barbarian,
  bard,
  cleric,
  druid,
  fighter,
  monk,
  paladin,
  ranger,
  rogue,
  sorcerer,
  warlock,
  wizard,
  artificer,
}

class ClassFeature {
  String name;
  String description;
  int level;
  bool isPassive;

  ClassFeature({
    required this.name,
    required this.description,
    required this.level,
    this.isPassive = true,
  });

  /// Converte JSON para ClassFeature
  factory ClassFeature.fromJson(Map<String, dynamic> json) {
    return ClassFeature(
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as int,
      isPassive: json['isPassive'] as bool? ?? true,
    );
  }

  /// Converte ClassFeature para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'level': level,
      'isPassive': isPassive,
    };
  }
}

class ClassProficiency {
  List<String> armor;

  List<String> weapons;

  List<String> tools;

  List<String> savingThrows;

  List<String> skills;

  int skillChoices;

  ClassProficiency({
    required this.armor,
    required this.weapons,
    required this.tools,
    required this.savingThrows,
    required this.skills,
    required this.skillChoices,
  });

  /// Converte JSON para ClassProficiency
  factory ClassProficiency.fromJson(Map<String, dynamic> json) {
    return ClassProficiency(
      armor: List<String>.from(json['armor'] ?? []),
      weapons: List<String>.from(json['weapons'] ?? []),
      tools: List<String>.from(json['tools'] ?? []),
      savingThrows: List<String>.from(json['savingThrows'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      skillChoices: json['skillChoices'] as int,
    );
  }

  /// Converte ClassProficiency para JSON
  Map<String, dynamic> toJson() {
    return {
      'armor': armor,
      'weapons': weapons,
      'tools': tools,
      'savingThrows': savingThrows,
      'skills': skills,
      'skillChoices': skillChoices,
    };
  }
}

class ClassSpellcasting {
  String ability;

  String spellSaveDC; // Sempre String

  String spellAttackBonus; // Sempre String

  String? spellList;

  bool? preparedSpells;

  bool? ritualCasting;

  int cantripsKnown; // Sempre int

  int spellsKnown; // Sempre int

  bool spellSlots; // Sempre bool

  ClassSpellcasting({
    required this.ability,
    required this.spellSaveDC,
    required this.spellAttackBonus,
    this.spellList,
    this.preparedSpells,
    this.ritualCasting,
    required this.cantripsKnown,
    required this.spellsKnown,
    required this.spellSlots,
  });

  /// Converte JSON para ClassSpellcasting
  factory ClassSpellcasting.fromJson(Map<String, dynamic> json) {
    return ClassSpellcasting(
      ability: json['ability'] as String,
      spellSaveDC: json['spellSaveDC'].toString(), // Converte para String
      spellAttackBonus:
          json['spellAttackBonus'].toString(), // Converte para String
      spellList: json['spellList'] as String?,
      preparedSpells: json['preparedSpells'] as bool?,
      ritualCasting: json['ritualCasting'] as bool?,
      cantripsKnown:
          json['cantripsKnown'] is int
              ? json['cantripsKnown'] as int
              : (json['cantripsKnown'] as List)
                  .length, // Se for List, usa o tamanho
      spellsKnown:
          json['spellsKnown'] is int
              ? json['spellsKnown'] as int
              : (json['spellsKnown'] as List)
                  .length, // Se for List, usa o tamanho
      spellSlots:
          json['spellSlots'] is bool
              ? json['spellSlots'] as bool
              : json['spellSlots'] !=
                  null, // Se não for bool, converte para bool
    );
  }

  /// Converte ClassSpellcasting para JSON
  Map<String, dynamic> toJson() {
    return {
      'ability': ability,
      'spellSaveDC': spellSaveDC,
      'spellAttackBonus': spellAttackBonus,
      'spellList': spellList,
      'preparedSpells': preparedSpells,
      'ritualCasting': ritualCasting,
      'cantripsKnown': cantripsKnown,
      'spellsKnown': spellsKnown,
      'spellSlots': spellSlots,
    };
  }
}

class SubclassFeature {
  String name;

  String description;

  int level;

  bool isPassive;

  SubclassFeature({
    required this.name,
    required this.description,
    required this.level,
    this.isPassive = true,
  });

  /// Converte JSON para SubclassFeature
  factory SubclassFeature.fromJson(Map<String, dynamic> json) {
    return SubclassFeature(
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as int,
      isPassive: json['isPassive'] as bool? ?? true,
    );
  }

  /// Converte SubclassFeature para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'level': level,
      'isPassive': isPassive,
    };
  }
}

class Subclass {
  String name;

  String description;

  List<SubclassFeature> features;

  Subclass({
    required this.name,
    required this.description,
    required this.features,
  });

  /// Converte JSON para Subclass
  factory Subclass.fromJson(Map<String, dynamic> json) {
    return Subclass(
      name: json['name'] as String,
      description: json['description'] as String,
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => SubclassFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converte Subclass para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'features': features.map((f) => f.toJson()).toList(),
    };
  }
}

class ProgressionLevel {
  int level;

  int proficiencyBonus;

  Map<String, dynamic> additionalFields;

  ProgressionLevel({
    required this.level,
    required this.proficiencyBonus,
    this.additionalFields = const {},
  });

  /// Converte JSON para ProgressionLevel
  factory ProgressionLevel.fromJson(Map<String, dynamic> json) {
    final additionalFields = Map<String, dynamic>.from(json);
    additionalFields.remove('level');
    additionalFields.remove('proficiencyBonus');

    return ProgressionLevel(
      level: json['level'] as int,
      proficiencyBonus: json['proficiencyBonus'] as int,
      additionalFields: additionalFields,
    );
  }

  /// Converte ProgressionLevel para JSON
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'level': level,
      'proficiencyBonus': proficiencyBonus,
    };
    result.addAll(additionalFields);
    return result;
  }
}

class ProgressionTable {
  List<ProgressionLevel> levels;

  ProgressionTable({required this.levels});

  /// Converte JSON para ProgressionTable
  factory ProgressionTable.fromJson(Map<String, dynamic> json) {
    return ProgressionTable(
      levels:
          (json['levels'] as List<dynamic>?)
              ?.map((e) => ProgressionLevel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converte ProgressionTable para JSON
  Map<String, dynamic> toJson() {
    return {'levels': levels.map((l) => l.toJson()).toList()};
  }
}

class DndClass {
  String name;

  String description;

  int hitDie;

  String primaryAbility;

  String secondaryAbility;

  String suggestedBackground;

  ClassProficiency proficiency;

  List<String> startingEquipment;

  List<ClassFeature> features;

  ClassSpellcasting? spellcasting;

  List<Subclass> subclasses;

  String flavorText;

  ProgressionTable? progressionTable;

  DndClass({
    required this.name,
    required this.description,
    required this.hitDie,
    required this.primaryAbility,
    required this.secondaryAbility,
    required this.suggestedBackground,
    required this.proficiency,
    required this.startingEquipment,
    required this.features,
    this.spellcasting,
    required this.subclasses,
    required this.flavorText,
    this.progressionTable,
  });

  // Calcular pontos de vida por nível
  int calculateHitPoints(int level, int constitutionModifier) {
    if (level == 1) {
      return hitDie + constitutionModifier;
    }
    return (hitDie ~/ 2) + 1 + constitutionModifier; // Média do dado
  }

  // Obter características por nível
  List<ClassFeature> getFeaturesAtLevel(int level) {
    return features.where((feature) => feature.level <= level).toList();
  }

  // Obter bônus de proficiência por nível
  int getProficiencyBonus(int level) {
    return ((level - 1) ~/ 4) + 2;
  }

  // Obter slots de magia por nível (se aplicável)
  List<int> getSpellSlotsAtLevel(int level) {
    debugPrint(
      'DndClass.getSpellSlotsAtLevel: name=$name, level=$level, spellcasting=$spellcasting',
    );

    // Se tem conjuração (mesmo que spellcasting seja string vazia), retorna slots baseados no nível
    if (spellcasting != null || hasSpellcasting) {
      // Slots padrão para Bardo nível 1: [2, 0, 0, 0, 0, 0, 0, 0, 0]
      // Slots padrão para Bardo nível 2: [3, 0, 0, 0, 0, 0, 0, 0, 0]
      // Slots padrão para Bardo nível 3: [4, 2, 0, 0, 0, 0, 0, 0, 0]
      final slotsByLevel = {
        1: [2, 0, 0, 0, 0, 0, 0, 0, 0],
        2: [3, 0, 0, 0, 0, 0, 0, 0, 0],
        3: [4, 2, 0, 0, 0, 0, 0, 0, 0],
        4: [4, 3, 0, 0, 0, 0, 0, 0, 0],
        5: [4, 3, 2, 0, 0, 0, 0, 0, 0],
        6: [4, 3, 3, 0, 0, 0, 0, 0, 0],
        7: [4, 3, 3, 1, 0, 0, 0, 0, 0],
        8: [4, 3, 3, 2, 0, 0, 0, 0, 0],
        9: [4, 3, 3, 3, 1, 0, 0, 0, 0],
        10: [4, 3, 3, 3, 2, 0, 0, 0, 0],
        11: [4, 3, 3, 3, 2, 1, 0, 0, 0],
        12: [4, 3, 3, 3, 2, 1, 0, 0, 0],
        13: [4, 3, 3, 3, 2, 1, 1, 0, 0],
        14: [4, 3, 3, 3, 2, 1, 1, 0, 0],
        15: [4, 3, 3, 3, 2, 1, 1, 1, 0],
        16: [4, 3, 3, 3, 2, 1, 1, 1, 0],
        17: [4, 3, 3, 3, 2, 1, 1, 1, 1],
        18: [4, 3, 3, 3, 3, 1, 1, 1, 1],
        19: [4, 3, 3, 3, 3, 2, 1, 1, 1],
        20: [4, 3, 3, 3, 3, 2, 2, 1, 1],
      };

      final slots = slotsByLevel[level] ?? [0, 0, 0, 0, 0, 0, 0, 0, 0];
      debugPrint(
        'DndClass.getSpellSlotsAtLevel: Retornando slots para nível $level: $slots',
      );
      return slots;
    }

    debugPrint(
      'DndClass.getSpellSlotsAtLevel: Sem conjuração, retornando lista vazia',
    );
    return [];
  }

  // Verificar se tem conjuração
  bool get hasSpellcasting {
    return spellcasting != null;
  }

  // Obter truques conhecidos por nível (se aplicável)
  int getCantripsKnownAtLevel(int level) {
    if (spellcasting == null) {
      return 0;
    }
    return spellcasting!.cantripsKnown;
  }

  // Obter magias conhecidas por nível (se aplicável)
  int getSpellsKnownAtLevel(int level) {
    if (spellcasting == null) {
      return 0;
    }
    return spellcasting!.spellsKnown;
  }

  /// Converte JSON para DndClass
  factory DndClass.fromJson(Map<String, dynamic> json) {
    return DndClass(
      name: json['name'] as String,
      description: json['description'] as String,
      hitDie: json['hitDie'] as int,
      primaryAbility: json['primaryAbility'] as String,
      secondaryAbility: json['secondaryAbility'] as String,
      suggestedBackground: json['suggestedBackground'] as String,
      proficiency: ClassProficiency.fromJson(
        json['proficiency'] as Map<String, dynamic>,
      ),
      startingEquipment: List<String>.from(json['startingEquipment'] ?? []),
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => ClassFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      spellcasting:
          json['spellcasting'] != null
              ? ClassSpellcasting.fromJson(
                json['spellcasting'] as Map<String, dynamic>,
              )
              : null,
      subclasses:
          (json['subclasses'] as List<dynamic>?)
              ?.map((e) => Subclass.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      flavorText: json['flavorText'] as String,
      progressionTable:
          json['progressionTable'] != null
              ? ProgressionTable.fromJson(
                json['progressionTable'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  /// Converte DndClass para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'hitDie': hitDie,
      'primaryAbility': primaryAbility,
      'secondaryAbility': secondaryAbility,
      'suggestedBackground': suggestedBackground,
      'proficiency': proficiency.toJson(),
      'startingEquipment': startingEquipment,
      'features': features.map((f) => f.toJson()).toList(),
      'spellcasting': spellcasting?.toJson(),
      'subclasses': subclasses.map((s) => s.toJson()).toList(),
      'flavorText': flavorText,
      'progressionTable': progressionTable?.toJson(),
    };
  }
}
