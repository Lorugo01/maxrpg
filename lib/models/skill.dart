class Skill {
  String name;
  String baseAbility;
  bool isProficient;
  bool hasExpertise;

  Skill({
    required this.name,
    required this.baseAbility,
    this.isProficient = false,
    this.hasExpertise = false,
  });

  // Cálculo do modificador da perícia
  int getModifier(Map<String, int> abilityScores, int proficiencyBonus) {
    int abilityScore = abilityScores[baseAbility] ?? 10;
    int abilityModifier = (abilityScore - 10) ~/ 2;

    if (isProficient) {
      int bonus = hasExpertise ? proficiencyBonus * 2 : proficiencyBonus;
      return abilityModifier + bonus;
    }

    return abilityModifier;
  }

  @override
  String toString() {
    return 'Skill{name: $name, baseAbility: $baseAbility, isProficient: $isProficient, hasExpertise: $hasExpertise}';
  }

  /// Converte JSON para Skill
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] as String,
      baseAbility: json['baseAbility'] as String,
      isProficient: json['isProficient'] as bool? ?? false,
      hasExpertise: json['hasExpertise'] as bool? ?? false,
    );
  }

  /// Converte Skill para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'baseAbility': baseAbility,
      'isProficient': isProficient,
      'hasExpertise': hasExpertise,
    };
  }
}

// Perícias padrão do D&D 5e
class DefaultSkills {
  static List<Skill> getDefaultSkills() {
    return [
      Skill(name: 'Acrobacia', baseAbility: 'Destreza'),
      Skill(name: 'Arcanismo', baseAbility: 'Inteligência'),
      Skill(name: 'Atletismo', baseAbility: 'Força'),
      Skill(name: 'Atuação', baseAbility: 'Carisma'),
      Skill(name: 'Blefar', baseAbility: 'Carisma'),
      Skill(name: 'Furtividade', baseAbility: 'Destreza'),
      Skill(name: 'História', baseAbility: 'Inteligência'),
      Skill(name: 'Intuição', baseAbility: 'Sabedoria'),
      Skill(name: 'Intimidação', baseAbility: 'Carisma'),
      Skill(name: 'Investigação', baseAbility: 'Inteligência'),
      Skill(name: 'Lidar com Animais', baseAbility: 'Sabedoria'),
      Skill(name: 'Medicina', baseAbility: 'Sabedoria'),
      Skill(name: 'Natureza', baseAbility: 'Inteligência'),
      Skill(name: 'Percepção', baseAbility: 'Sabedoria'),
      Skill(name: 'Persuasão', baseAbility: 'Carisma'),
      Skill(name: 'Prestidigitação', baseAbility: 'Destreza'),
      Skill(name: 'Religião', baseAbility: 'Inteligência'),
      Skill(name: 'Sobrevivência', baseAbility: 'Sabedoria'),
    ];
  }
}
