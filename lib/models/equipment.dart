class Equipment {
  final String name;
  final String type; // tipo do equipamento (armor, weapon, tool, etc.)
  final String category; // ex.: Armadura, Arma, Aventura, Ferramenta, Montaria
  final String?
  subcategory; // ex.: Leve/Média/Pesada; Simples/Marcial; Corpo-a-corpo/À distância
  final String? cost; // ex.: "10 po"
  final String? weight; // ex.: "2 kg"
  final Map<String, dynamic>?
  stats; // campos específicos (ex.: CA, dano, propriedades)
  final String? description;

  Equipment({
    required this.name,
    required this.type,
    required this.category,
    this.subcategory,
    this.cost,
    this.weight,
    this.stats,
    this.description,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      subcategory: json['subcategory']?.toString(),
      cost: json['cost']?.toString(),
      weight: json['weight']?.toString(),
      stats:
          json['stats'] is Map<String, dynamic>
              ? json['stats'] as Map<String, dynamic>
              : null,
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'category': category,
      'subcategory': subcategory,
      'cost': cost,
      'weight': weight,
      'stats': stats,
      'description': description,
    };
  }

  // Obter CA da armadura
  String? get armorClass {
    return stats?['CA'] as String?;
  }

  // Obter tipo de armadura (Leve, Média, Pesada)
  String? get armorType {
    return subcategory;
  }

  // Obter força necessária para armaduras pesadas
  String? get strengthRequirement {
    return stats?['força'] as String?;
  }

  // Obter penalidade de furtividade
  String? get stealthPenalty {
    return stats?['furtividade'] as String?;
  }

  // Verificar se é uma armadura
  bool get isArmor {
    return category == 'Armadura';
  }

  // Verificar se é um escudo
  bool get isShield {
    return category == 'Escudo';
  }
}
