import 'dnd_class.dart';

class LevelUp {
  int newLevel;

  int hitPointsGained;

  int proficiencyBonus;

  List<String> newFeatures;

  List<String> availableSubclasses;

  String? selectedSubclass;

  Map<String, dynamic> spellProgression;

  List<String> abilityScoreImprovements;

  bool isCompleted;

  LevelUp({
    required this.newLevel,
    required this.hitPointsGained,
    required this.proficiencyBonus,
    required this.newFeatures,
    required this.availableSubclasses,
    this.selectedSubclass,
    required this.spellProgression,
    required this.abilityScoreImprovements,
    this.isCompleted = false,
  });

  factory LevelUp.fromClass(DndClass dndClass, int currentLevel) {
    final newLevel = currentLevel + 1;

    // Calcular bônus de proficiência baseado no nível
    final proficiencyBonus = ((newLevel - 1) ~/ 4) + 2;

    return LevelUp(
      newLevel: newLevel,
      hitPointsGained: dndClass.hitDie ~/ 2 + 1, // Média do dado
      proficiencyBonus: proficiencyBonus,
      newFeatures: _getNewFeatures(dndClass, currentLevel, newLevel),
      availableSubclasses: _getAvailableSubclasses(dndClass, newLevel),
      spellProgression: _getSpellProgressionFromClass(dndClass, newLevel),
      abilityScoreImprovements: _getAbilityScoreImprovements(newLevel),
    );
  }

  static List<String> _getNewFeatures(
    DndClass dndClass,
    int currentLevel,
    int newLevel,
  ) {
    final features = <String>[];

    // Buscar características que são ganhas no novo nível (exceto subclasse)
    for (final feature in dndClass.features) {
      if (feature.level == newLevel &&
          !feature.name.toLowerCase().contains('subclasse')) {
        features.add(feature.name);
      }
    }

    return features;
  }

  static List<String> _getAvailableSubclasses(DndClass dndClass, int newLevel) {
    final subclasses = <String>[];

    // Verificar se é nível de subclasse (geralmente nível 3)
    if (newLevel == 3) {
      for (final subclass in dndClass.subclasses) {
        subclasses.add(subclass.name);
      }
    }

    return subclasses;
  }

  static Map<String, dynamic> _getSpellProgressionFromClass(
    DndClass dndClass,
    int level,
  ) {
    final spellProgression = <String, dynamic>{};

    // Se a classe tem conjuração, adicionar informações básicas
    if (dndClass.spellcasting != null) {
      spellProgression['hasSpellcasting'] = true;
      spellProgression['spellcastingAbility'] =
          dndClass.spellcasting?.ability ?? 'Carisma';
    }

    return spellProgression;
  }

  static List<String> _getAbilityScoreImprovements(int level) {
    // Níveis onde se ganha melhoria de atributo: 4, 8, 12, 16, 19
    if ([4, 8, 12, 16, 19].contains(level)) {
      return ['Melhoria de Atributo (+2 pontos ou +1 talento)'];
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'newLevel': newLevel,
      'hitPointsGained': hitPointsGained,
      'proficiencyBonus': proficiencyBonus,
      'newFeatures': newFeatures,
      'availableSubclasses': availableSubclasses,
      'selectedSubclass': selectedSubclass,
      'spellProgression': spellProgression,
      'abilityScoreImprovements': abilityScoreImprovements,
      'isCompleted': isCompleted,
    };
  }

  factory LevelUp.fromJson(Map<String, dynamic> json) {
    return LevelUp(
      newLevel: json['newLevel'] as int,
      hitPointsGained: json['hitPointsGained'] as int,
      proficiencyBonus: json['proficiencyBonus'] as int,
      newFeatures: List<String>.from(json['newFeatures'] ?? []),
      availableSubclasses: List<String>.from(json['availableSubclasses'] ?? []),
      selectedSubclass: json['selectedSubclass'] as String?,
      spellProgression: Map<String, dynamic>.from(
        json['spellProgression'] ?? {},
      ),
      abilityScoreImprovements: List<String>.from(
        json['abilityScoreImprovements'] ?? [],
      ),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

class LevelUpChoice {
  String type; // 'hitPoints', 'abilityScore', 'feature', 'spell'

  String description;

  dynamic value;

  bool isSelected;

  LevelUpChoice({
    required this.type,
    required this.description,
    required this.value,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory LevelUpChoice.fromJson(Map<String, dynamic> json) {
    return LevelUpChoice(
      type: json['type'] as String,
      description: json['description'] as String,
      value: json['value'],
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }
}
