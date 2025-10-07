import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import 'skill.dart';
import 'item.dart';
import 'dnd_class.dart';
import 'spell.dart';

class Character {
  String id;
  String? userId; // user_id do banco
  String name;
  String race;
  String className;
  String background;
  int level;
  Map<String, int> abilityScores;
  List<Skill> skills;
  List<Item> inventory;
  int currentHitPoints;
  int maxHitPoints;
  int temporaryHitPoints;
  int armorClass;

  int speed;
  String alignment;
  int experiencePoints;
  List<String> languages;
  List<String> proficiencies;
  DndClass? dndClass;

  // Magias selecionadas na criação (por nome)
  List<String> selectedCantrips;
  List<String> selectedSpells;

  // Magias conhecidas (objetos Spell completos)
  List<Spell> knownSpells;

  // Habilidades personalizadas
  List<Map<String, dynamic>>? customAbilities;

  // Controle de conjuração personalizado
  bool? isSpellcaster; // null = usar dados da classe, true/false = override
  String?
  customSpellcastingAbility; // null = usar dados da classe, string = override

  // Campos de personalidade do BD
  String? personalityTraits;
  String? ideals;
  String? bonds;
  String? flaws;

  // Campos de timestamp do BD
  DateTime? createdAt;
  DateTime? updatedAt;

  // Campos de moedas
  int platinumPieces;
  int goldPieces;
  int electrumPieces;
  int silverPieces;
  int copperPieces;

  // Testes de morte
  int deathSaveSuccesses;
  int deathSaveFailures;
  // Dados de Vida usados (0..level)
  int? hitDiceUsed;

  Character({
    String? id,
    this.userId,
    required this.name,
    required this.race,
    required this.className,
    required this.background,
    this.level = 1,
    required this.abilityScores,
    List<Skill>? skills,
    List<Item>? inventory,
    this.currentHitPoints = 0,
    this.maxHitPoints = 0,
    this.temporaryHitPoints = 0,
    this.armorClass = 10,
    List<Map<String, dynamic>>? customAbilities,
    this.isSpellcaster,
    this.customSpellcastingAbility,
    this.speed = 30,
    this.alignment = '',
    this.experiencePoints = 0,
    List<String>? languages,
    List<String>? proficiencies,
    List<Spell>? knownSpells,
    this.dndClass,
    List<String>? selectedCantrips,
    List<String>? selectedSpells,
    this.personalityTraits,
    this.ideals,
    this.bonds,
    this.flaws,
    this.createdAt,
    this.updatedAt,
    this.platinumPieces = 0,
    this.goldPieces = 0,
    this.electrumPieces = 0,
    this.silverPieces = 0,
    this.copperPieces = 0,
    this.deathSaveSuccesses = 0,
    this.deathSaveFailures = 0,
    this.hitDiceUsed = 0,
  }) : id = id ?? const Uuid().v4(),
       skills = skills ?? DefaultSkills.getDefaultSkills(),
       inventory = inventory ?? [],
       languages = languages ?? [],
       proficiencies = proficiencies ?? [],
       selectedCantrips = selectedCantrips ?? [],
       selectedSpells = selectedSpells ?? [],
       knownSpells = knownSpells ?? [],
       customAbilities = customAbilities ?? [];

  // Cálculo do modificador de habilidade
  int getAbilityModifier(String ability) {
    // Suporta chaves em PT-BR e EN (ex.: 'Força' e 'strength')
    int? score = abilityScores[ability];
    if (score == null) {
      final alias = _resolveAbilityAlias(ability);
      score = abilityScores[alias];
    }
    score ??= 10;
    return (score - 10) ~/ 2;
  }

  // Mapeamento bidirecional para nomes de atributos
  String _resolveAbilityAlias(String ability) {
    switch (ability.toLowerCase()) {
      case 'força':
      case 'forca':
      case 'strength':
        return 'Força';
      case 'destreza':
      case 'dexterity':
        return 'Destreza';
      case 'constituição':
      case 'constituicao':
      case 'constitution':
        return 'Constituição';
      case 'inteligência':
      case 'inteligencia':
      case 'intelligence':
        return 'Inteligência';
      case 'sabedoria':
      case 'wisdom':
        return 'Sabedoria';
      case 'carisma':
      case 'charisma':
        return 'Carisma';
      default:
        return ability;
    }
  }

  // Cálculo do bônus de proficiência baseado no nível
  int get proficiencyBonus {
    // Tentar usar a tabela de progressão da classe primeiro
    if (dndClass?.progressionTable != null) {
      final progression = dndClass!.progressionTable!.levels.firstWhere(
        (l) => l.level == level,
        orElse: () => ProgressionLevel(level: level, proficiencyBonus: 2),
      );
      return progression.proficiencyBonus;
    }

    // Fallback para cálculo padrão se não houver tabela
    return ((level - 1) ~/ 4) + 2;
  }

  // Cálculo do modificador de uma perícia
  int getSkillModifier(String skillName) {
    Skill? skill = skills.firstWhere(
      (s) => s.name == skillName,
      orElse: () => Skill(name: skillName, baseAbility: 'Força'),
    );

    return skill.getModifier(abilityScores, proficiencyBonus);
  }

  // Cálculo dos testes de resistência
  Map<String, int> get savingThrows {
    int modWithProf(String abilityName) {
      final base = getAbilityModifier(abilityName);
      if (isSavingThrowProficient(abilityName)) {
        return base + proficiencyBonus;
      }
      return base;
    }

    return {
      'Força': modWithProf('Força'),
      'Destreza': modWithProf('Destreza'),
      'Constituição': modWithProf('Constituição'),
      'Inteligência': modWithProf('Inteligência'),
      'Sabedoria': modWithProf('Sabedoria'),
      'Carisma': modWithProf('Carisma'),
    };
  }

  // Verifica se o personagem é proficiente em um teste de resistência específico
  bool isSavingThrowProficient(String abilityName) {
    // Verificar primeiro nas proficiências salvas
    if (proficiencies.contains(abilityName)) {
      return true;
    }

    // Fallback para o sistema antigo
    final proficientSaves = dndClass?.proficiency.savingThrows ?? <String>[];
    return proficientSaves.contains(abilityName);
  }

  // Peso total do inventário
  double get totalWeight {
    return inventory.fold(
      0.0,
      (sum, item) => sum + (item.weight * item.quantity),
    );
  }

  // Capacidade de carga
  int get carryingCapacity {
    // Regra PHB 5e: capacidade de carga = valor de Força x 15
    final strengthScore = abilityScores['Força'] ?? 10;
    return strengthScore * 15;
  }

  // Verificar se o personagem é conjurador
  bool get hasSpellcasting {
    // Se foi definido explicitamente, usar essa escolha
    if (isSpellcaster != null) {
      return isSpellcaster!;
    }

    // Caso contrário, verificar se a classe tem conjuração
    return dndClass?.hasSpellcasting ?? false;
  }

  // Obter atributo de conjuração
  String getSpellcastingAbility() {
    // Se foi definido explicitamente, usar essa escolha
    if (customSpellcastingAbility != null &&
        customSpellcastingAbility!.isNotEmpty) {
      return customSpellcastingAbility!;
    }

    // Caso contrário, usar o padrão da classe
    return dndClass?.spellcasting?.ability ?? 'Inteligência';
  }

  // Verificar se está sobrecarregado
  bool get isEncumbered {
    return totalWeight > carryingCapacity;
  }

  // Pontos de vida totais (incluindo temporários)
  int get totalHitPoints {
    return currentHitPoints + temporaryHitPoints;
  }

  // Obter características da classe por nível
  List<ClassFeature> getClassFeaturesAtLevel() {
    if (dndClass == null) return [];
    return dndClass!.getFeaturesAtLevel(level);
  }

  // Obter pontos de vida baseados na classe
  int getClassHitPoints() {
    if (dndClass == null) return 8; // Padrão
    return dndClass!.calculateHitPoints(
      level,
      getAbilityModifier('Constituição'),
    );
  }

  // Obter proficiências da classe
  ClassProficiency? getClassProficiencies() {
    return dndClass?.proficiency;
  }

  // Obter informações de conjuração
  ClassSpellcasting? getSpellcastingInfo() {
    return dndClass?.spellcasting;
  }

  // Obter slots de magia por nível
  List<int> getSpellSlots() {
    debugPrint(
      'Character.getSpellSlots: dndClass=${dndClass?.name}, spellcasting=${dndClass?.spellcasting}, level=$level',
    );
    if (dndClass?.spellcasting == null) {
      debugPrint(
        'Character.getSpellSlots: Sem conjuração, retornando lista vazia',
      );
      return [];
    }
    final slots = dndClass!.getSpellSlotsAtLevel(level);
    debugPrint('Character.getSpellSlots: slots=$slots');
    return slots;
  }

  // Obter truques conhecidos
  int getCantripsKnown() {
    if (dndClass?.spellcasting == null) return 0;
    return dndClass!.getCantripsKnownAtLevel(level);
  }

  // Obter magias conhecidas
  int getSpellsKnown() {
    if (dndClass?.spellcasting == null) return 0;
    return dndClass!.getSpellsKnownAtLevel(level);
  }

  // Calcular CD de magia
  int getSpellSaveDC() {
    if (dndClass?.spellcasting == null) return 8;
    final abilityModifier = getAbilityModifier(dndClass!.spellcasting!.ability);
    return 8 + proficiencyBonus + abilityModifier;
  }

  // Calcular bônus de ataque de magia
  int getSpellAttackBonus() {
    if (dndClass?.spellcasting == null) return 0;
    final abilityModifier = getAbilityModifier(dndClass!.spellcasting!.ability);
    return proficiencyBonus + abilityModifier;
  }

  // Obter armadura equipada
  Item? getEquippedArmor() {
    return inventory.firstWhere(
      (item) => item.isEquipped && item.type == ItemType.armor,
      orElse: () => Item(id: '', name: ''),
    );
  }

  // Obter escudo equipado
  Item? getEquippedShield() {
    return inventory.firstWhere(
      (item) => item.isEquipped && item.type == ItemType.shield,
      orElse: () => Item(id: '', name: ''),
    );
  }

  // Calcular CA baseado em armaduras equipadas
  int getCalculatedArmorClass() {
    final equippedArmor = getEquippedArmor();
    final equippedShield = getEquippedShield();
    final dexModifier = getAbilityModifier('Destreza');

    int baseAC = 10; // CA base sem armadura

    if (equippedArmor != null && equippedArmor.id.isNotEmpty) {
      // Extrair CA da descrição da armadura
      final armorAC = _extractArmorAC(equippedArmor.description);
      if (armorAC != null) {
        baseAC = armorAC;

        // Verificar se é armadura leve, média ou pesada
        final armorType = _getArmorType(equippedArmor.name);
        switch (armorType) {
          case 'Leve':
            baseAC += dexModifier;
            break;
          case 'Média':
            baseAC += dexModifier > 2 ? 2 : dexModifier;
            break;
          case 'Pesada':
            // Armaduras pesadas não adicionam modificador de Destreza
            break;
        }
      }
    } else {
      // Sem armadura, usar CA padrão: 10 + modificador de Destreza
      baseAC += dexModifier;
    }

    // Adicionar bônus do escudo (+2)
    if (equippedShield != null && equippedShield.id.isNotEmpty) {
      baseAC += 2;
    }

    return baseAC;
  }

  // Extrair CA da descrição da armadura
  int? _extractArmorAC(String description) {
    // Procurar por padrões como "CA: 11 + Des", "CA: 16", etc.
    final regex = RegExp(r'CA[:\s]*(\d+)');
    final match = regex.firstMatch(description);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }

  // Determinar tipo de armadura baseado no nome
  String _getArmorType(String armorName) {
    // Lista completa baseada no PHB 2014
    final lightArmors = ['Acolchoada', 'Couro', 'Couro Batido'];
    final mediumArmors = [
      'Gibão de Peles',
      'Camisão de Malha',
      'Brunea',
      'Peitoral',
      'Meia-Armadura',
    ];
    final heavyArmors = [
      'Cota de Anéis',
      'Cota de Malha',
      'Cota de Talas',
      'Placas',
    ];

    if (lightArmors.contains(armorName)) return 'Leve';
    if (mediumArmors.contains(armorName)) return 'Média';
    if (heavyArmors.contains(armorName)) return 'Pesada';

    return 'Leve'; // Padrão
  }

  @override
  String toString() {
    return 'Character{name: $name, race: $race, class: $className, level: $level}';
  }

  /// Converte JSON para Character
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      race: json['race'] as String,
      className: json['class_name'] as String? ?? json['className'] as String,
      background: json['background'] as String,
      level: json['level'] as int? ?? 1,
      abilityScores: Map<String, int>.from(
        json['ability_scores'] ?? json['abilityScores'] ?? {},
      ),
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          DefaultSkills.getDefaultSkills(),
      inventory:
          (json['inventory'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentHitPoints:
          json['current_hit_points'] as int? ??
          json['currentHitPoints'] as int? ??
          0,
      maxHitPoints:
          json['max_hit_points'] as int? ?? json['maxHitPoints'] as int? ?? 0,
      temporaryHitPoints:
          json['temporary_hit_points'] as int? ??
          json['temporaryHitPoints'] as int? ??
          0,
      armorClass:
          json['armor_class'] as int? ?? json['armorClass'] as int? ?? 10,
      speed: json['speed'] as int? ?? 30,
      alignment: json['alignment'] as String? ?? '',
      experiencePoints:
          json['experience_points'] as int? ??
          json['experiencePoints'] as int? ??
          0,
      languages: List<String>.from(json['languages'] ?? []),
      proficiencies: List<String>.from(json['proficiencies'] ?? []),
      dndClass:
          json['dndClass'] != null
              ? DndClass.fromJson(json['dndClass'] as Map<String, dynamic>)
              : null,
      selectedCantrips: List<String>.from(
        json['selected_cantrips'] ?? json['selectedCantrips'] ?? [],
      ),
      selectedSpells: List<String>.from(
        json['selected_spells'] ?? json['selectedSpells'] ?? [],
      ),
      knownSpells:
          (json['known_spells'] as List<dynamic>?)
              ?.map((e) => Spell.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      personalityTraits: json['personality_traits'] as String?,
      ideals: json['ideals'] as String?,
      bonds: json['bonds'] as String?,
      flaws: json['flaws'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
      platinumPieces: json['platinum_pieces'] as int? ?? 0,
      goldPieces: json['gold_pieces'] as int? ?? 0,
      electrumPieces: json['electrum_pieces'] as int? ?? 0,
      silverPieces: json['silver_pieces'] as int? ?? 0,
      copperPieces: json['copper_pieces'] as int? ?? 0,
      deathSaveSuccesses: json['death_save_successes'] as int? ?? 0,
      deathSaveFailures: json['death_save_failures'] as int? ?? 0,
      hitDiceUsed: json['hit_dice_used'] as int? ?? 0,
      isSpellcaster: json['is_spellcaster'] as bool?,
      customSpellcastingAbility: json['custom_spellcasting_ability'] as String?,
    );
  }

  /// Converte Character para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'race': race,
      'class_name': className,
      'background': background,
      'level': level,
      'ability_scores': abilityScores,
      'skills': skills.map((s) => s.toJson()).toList(),
      'inventory': inventory.map((i) => i.toJson()).toList(),
      'current_hit_points': currentHitPoints,
      'max_hit_points': maxHitPoints,
      'temporary_hit_points': temporaryHitPoints,
      'armor_class': armorClass,
      'speed': speed,
      'alignment': alignment,
      'experience_points': experiencePoints,
      'languages': languages,
      'proficiencies': proficiencies,
      'dndClass': dndClass?.toJson(),
      'selected_cantrips': selectedCantrips,
      'selected_spells': selectedSpells,
      'known_spells': knownSpells.map((s) => s.toJson()).toList(),
      'personality_traits': personalityTraits,
      'ideals': ideals,
      'bonds': bonds,
      'flaws': flaws,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'platinum_pieces': platinumPieces,
      'gold_pieces': goldPieces,
      'electrum_pieces': electrumPieces,
      'silver_pieces': silverPieces,
      'copper_pieces': copperPieces,
      'death_save_successes': deathSaveSuccesses,
      'death_save_failures': deathSaveFailures,
      'hit_dice_used': hitDiceUsed ?? 0,
      'is_spellcaster': isSpellcaster,
      'custom_spellcasting_ability': customSpellcastingAbility,
    };
  }
}

// Valores padrão para criação rápida de personagens
class CharacterDefaults {
  static Map<String, int> get defaultAbilityScores => {
    'Força': 10,
    'Destreza': 10,
    'Constituição': 10,
    'Inteligência': 10,
    'Sabedoria': 10,
    'Carisma': 10,
  };

  static List<String> get races => [
    'Humano',
    'Elfo',
    'Anão',
    'Halfling',
    'Draconato',
    'Gnomo',
    'Meio-elfo',
    'Meio-orc',
    'Tiefling',
  ];

  static List<String> get classes => [
    'Bárbaro',
    'Bardo',
    'Bruxo',
    'Clérigo',
    'Druida',
    'Feiticeiro',
    'Guerreiro',
    'Ladino',
    'Mago',
    'Monge',
    'Paladino',
    'Patrulheiro',
  ];

  static List<String> get backgrounds => [
    'Acólito',
    'Artesão da Guilda',
    'Artista',
    'Charlatão',
    'Criminoso',
    'Eremita',
    'Forasteiro',
    'Herói do Povo',
    'Marinheiro',
    'Nobre',
    'Sábio',
    'Soldado',
  ];

  static List<String> get alignments => [
    'Leal e Bom',
    'Neutro e Bom',
    'Caótico e Bom',
    'Leal e Neutro',
    'Neutro',
    'Caótico e Neutro',
    'Leal e Mau',
    'Neutro e Mau',
    'Caótico e Mau',
  ];
}
