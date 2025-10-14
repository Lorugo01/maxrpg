enum RaceType {
  dwarf,

  elf,

  halfling,

  human,

  dragonborn,

  gnome,

  halfElf,

  halfOrc,

  tiefling,
}

class RaceTrait {
  final String name;

  final String description;

  final int?
  level; // Nível em que a característica é adquirida (null se for inata)

  RaceTrait({required this.name, required this.description, this.level});

  /// Converte JSON para RaceTrait
  factory RaceTrait.fromJson(Map<String, dynamic> json) {
    return RaceTrait(
      name: json['name'] as String,
      description: json['description'] as String,
      level: json['level'] as int?,
    );
  }

  /// Converte RaceTrait para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      if (level != null) 'level': level,
    };
  }
}

class Subrace {
  final String name;

  final String description;

  final Map<String, int> abilityScoreIncrease;

  final List<RaceTrait> traits;

  Subrace({
    required this.name,
    required this.description,
    required this.abilityScoreIncrease,
    required this.traits,
  });

  /// Converte JSON para Subrace
  factory Subrace.fromJson(Map<String, dynamic> json) {
    return Subrace(
      name: json['name'] as String,
      description: json['description'] as String,
      abilityScoreIncrease: Map<String, int>.from(
        json['abilityScoreIncrease'] ?? {},
      ),
      traits:
          (json['traits'] as List<dynamic>?)
              ?.map((e) => RaceTrait.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converte Subrace para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'abilityScoreIncrease': abilityScoreIncrease,
      'traits': traits.map((t) => t.toJson()).toList(),
    };
  }
}

class Race {
  final String name;

  final String description;

  final String creatureType; // Novo campo PHB 2024

  final List<String>
  sizeOptions; // Novo campo PHB 2024 (ex: ["Medium", "Small"])

  final double speed;

  final Map<String, int> abilityScoreIncrease;

  final List<RaceTrait> traits;

  final List<String> languages;

  final List<Subrace> subraces;
  // Campos opcionais para compatibilidade com versão antiga

  final String? flavorText;

  final int? ageOfMaturity;

  final int? averageLifespan;

  final String? alignment;

  final String? size; // Mantido para compatibilidade

  final List<String>? maleNames;

  final List<String>? femaleNames;

  final List<String>? surnames;

  final bool enabled;

  Race({
    required this.name,
    required this.description,
    required this.creatureType,
    required this.sizeOptions,
    required this.speed,
    required this.abilityScoreIncrease,
    required this.traits,
    required this.languages,
    required this.subraces,
    this.flavorText,
    this.ageOfMaturity,
    this.averageLifespan,
    this.alignment,
    this.size,
    this.maleNames,
    this.femaleNames,
    this.surnames,
    this.enabled = true,
  });

  /// Converte JSON para Race
  factory Race.fromJson(Map<String, dynamic> json) {
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

    double toDoubleValue(dynamic v, [double def = 30]) {
      if (v is num) return v.toDouble();
      return double.tryParse(v?.toString() ?? '') ?? def;
    }

    Map<String, int> mapScoreInc(dynamic v) {
      if (v is Map) {
        return v.map(
          (k, val) => MapEntry(k.toString(), int.tryParse(val.toString()) ?? 0),
        );
      }
      if (v is String) {
        final m = <String, int>{};
        for (final part in v.split(',')) {
          final p = part.trim();
          if (p.isEmpty) continue;
          final seg = p.split(':');
          if (seg.length == 2) {
            m[seg[0].trim()] = int.tryParse(seg[1].trim()) ?? 0;
          }
        }
        return m;
      }
      return {};
    }

    List<RaceTrait> parseTraitsFromText(String text) {
      final traits = <RaceTrait>[];
      final lines =
          text.split('\n').where((line) => line.trim().isNotEmpty).toList();

      String currentName = '';
      String currentDescription = '';

      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.isEmpty) continue;

        // Se a linha termina com ':' é um nome de trait
        if (trimmed.endsWith(':')) {
          // Salva o trait anterior se existir
          if (currentName.isNotEmpty) {
            traits.add(
              RaceTrait(
                name: currentName,
                description: currentDescription.trim(),
              ),
            );
          }

          // Inicia novo trait
          currentName = trimmed.substring(0, trimmed.length - 1).trim();
          currentDescription = '';
        } else {
          // É parte da descrição
          if (currentDescription.isNotEmpty) {
            currentDescription += ' ';
          }
          currentDescription += trimmed;
        }
      }

      // Adiciona o último trait
      if (currentName.isNotEmpty) {
        traits.add(
          RaceTrait(name: currentName, description: currentDescription.trim()),
        );
      }

      return traits;
    }

    List<RaceTrait> parseTraits(Map<String, dynamic> json) {
      // Primeiro tenta traits como lista JSON
      if (json['traits'] is List) {
        return (json['traits'] as List)
            .whereType<Map<String, dynamic>>()
            .map((e) => RaceTrait.fromJson(e))
            .toList();
      }

      // Se não, tenta traits_text como texto
      final traitsText = json['traits_text'] as String?;
      if (traitsText != null && traitsText.trim().isNotEmpty) {
        final parsed = parseTraitsFromText(traitsText);
        return parsed;
      }

      return [];
    }

    return Race(
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      creatureType: (json['creatureType'] ?? 'Humanoid').toString(),
      sizeOptions:
          splitToList(json['sizeOptions'] ?? json['size_options']).isEmpty
              ? ['Medium']
              : splitToList(json['sizeOptions'] ?? json['size_options']),
      speed: toDoubleValue(json['speed']),
      abilityScoreIncrease: mapScoreInc(
        json['abilityScoreIncrease'] ?? json['ability_score_increase'],
      ),
      traits: parseTraits(json),
      languages: splitToList(json['languages']),
      subraces:
          (json['subraces'] is List)
              ? (json['subraces'] as List)
                  .whereType<Map<String, dynamic>>()
                  .map((e) => Subrace.fromJson(e))
                  .toList()
              : [],
      // Campos opcionais
      flavorText: json['flavorText'] as String?,
      ageOfMaturity: json['ageOfMaturity'] as int?,
      averageLifespan: json['averageLifespan'] as int?,
      alignment: json['alignment'] as String?,
      size: json['size'] as String?,
      maleNames:
          json['maleNames'] != null ? splitToList(json['maleNames']) : null,
      femaleNames:
          json['femaleNames'] != null ? splitToList(json['femaleNames']) : null,
      surnames: json['surnames'] != null ? splitToList(json['surnames']) : null,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  /// Converte Race para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creatureType': creatureType,
      'sizeOptions': sizeOptions,
      'speed': speed,
      'abilityScoreIncrease': abilityScoreIncrease,
      'traits': traits.map((t) => t.toJson()).toList(),
      'languages': languages,
      'subraces': subraces.map((s) => s.toJson()).toList(),
      // Campos opcionais para compatibilidade
      if (flavorText != null) 'flavorText': flavorText,
      if (ageOfMaturity != null) 'ageOfMaturity': ageOfMaturity,
      if (averageLifespan != null) 'averageLifespan': averageLifespan,
      if (alignment != null) 'alignment': alignment,
      if (size != null) 'size': size,
      if (maleNames != null) 'maleNames': maleNames,
      if (femaleNames != null) 'femaleNames': femaleNames,
      if (surnames != null) 'surnames': surnames,
      'enabled': enabled,
    };
  }
}
