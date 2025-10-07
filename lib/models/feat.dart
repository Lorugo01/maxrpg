class Feat {
  final String name;
  final String description;
  final String? prerequisite;
  final String? source;

  Feat({
    required this.name,
    required this.description,
    this.prerequisite,
    this.source,
  });

  /// Converte JSON para Feat
  factory Feat.fromJson(Map<String, dynamic> json) {
    return Feat(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      prerequisite: json['prerequisite'] as String?,
      source: json['source'] as String?,
    );
  }

  /// Converte Feat para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'prerequisite': prerequisite,
      'source': source,
    };
  }

  @override
  String toString() {
    return 'Feat{name: $name, description: $description}';
  }
}
