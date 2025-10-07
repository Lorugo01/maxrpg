// Classe para características de antecedente
class BackgroundFeature {
  final String name;
  final String description;

  BackgroundFeature({required this.name, required this.description});

  /// Converte JSON para BackgroundFeature
  factory BackgroundFeature.fromJson(Map<String, dynamic> json) {
    return BackgroundFeature(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  /// Converte BackgroundFeature para JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description};
  }
}

// Classe para equipamentos de antecedente
class BackgroundEquipment {
  final String name;
  final String description;
  final int? quantity;

  BackgroundEquipment({
    required this.name,
    required this.description,
    this.quantity,
  });

  /// Converte JSON para BackgroundEquipment
  factory BackgroundEquipment.fromJson(Map<String, dynamic> json) {
    return BackgroundEquipment(
      name: json['name'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int?,
    );
  }

  /// Converte BackgroundEquipment para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      if (quantity != null) 'quantity': quantity,
    };
  }
}

// Classe principal para antecedentes
class Background {
  final String name;
  final String description;
  final List<String> abilityScores; // Novos campos PHB 2024
  final String feat; // Novo campo PHB 2024
  final List<String> skillProficiencies;
  final List<String> toolProficiencies;
  final List<String> languages;
  final List<BackgroundEquipment> equipment;
  final BackgroundFeature feature;
  final int startingGold;

  Background({
    required this.name,
    required this.description,
    required this.abilityScores,
    required this.feat,
    required this.skillProficiencies,
    required this.toolProficiencies,
    required this.languages,
    required this.equipment,
    required this.feature,
    required this.startingGold,
  });

  /// Converte JSON para Background
  factory Background.fromJson(Map<String, dynamic> json) {
    List<String> splitToList(dynamic v) {
      if (v == null) return [];
      if (v is List) return v.map((e) => e.toString()).toList();
      if (v is String) {
        if (v.trim().isEmpty) return [];
        return v
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    BackgroundFeature parseFeature(dynamic v) {
      if (v is Map<String, dynamic>) return BackgroundFeature.fromJson(v);
      final desc = (v ?? '').toString();
      return BackgroundFeature(name: 'Característica', description: desc);
    }

    List<BackgroundEquipment> parseEquipment(dynamic v) {
      if (v is List) {
        return v
            .whereType<Map<String, dynamic>>()
            .map((e) => BackgroundEquipment.fromJson(e))
            .toList();
      }
      if (v is String && v.trim().isNotEmpty) {
        return v
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .map(
              (name) => BackgroundEquipment(
                name: name,
                description: '',
                quantity: null,
              ),
            )
            .toList();
      }
      return [];
    }

    return Background(
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      abilityScores: splitToList(
        json['abilityScores'] ?? json['ability_scores'],
      ),
      feat: (json['feat'] ?? '').toString(),
      skillProficiencies: splitToList(
        json['skillProficiencies'] ??
            json['skill_proficiencies_2024'] ??
            json['skill_proficiencies_2014'],
      ),
      toolProficiencies: splitToList(
        json['toolProficiencies'] ?? json['tool_proficiency'],
      ),
      languages: splitToList(json['languages']),
      equipment: parseEquipment(json['equipment'] ?? json['equipment_2014']),
      feature: parseFeature(json['feature'] ?? json['features_2014']),
      startingGold:
          (json['startingGold'] is int)
              ? json['startingGold'] as int
              : int.tryParse((json['startingGold'] ?? '0').toString()) ?? 0,
    );
  }

  /// Converte Background para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'abilityScores': abilityScores,
      'feat': feat,
      'skillProficiencies': skillProficiencies,
      'toolProficiencies': toolProficiencies,
      'languages': languages,
      'equipment': equipment.map((e) => e.toJson()).toList(),
      'feature': feature.toJson(),
      'startingGold': startingGold,
    };
  }
}
