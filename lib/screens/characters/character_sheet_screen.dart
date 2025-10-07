import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/equipment_service.dart';
import '/services/character_service_supabase.dart';
import '/services/supabase_service.dart';
import '/services/ability_calculator.dart';
import '/services/class_service.dart';
import '/models/spell.dart';
import '/models/character.dart';
import '/models/item.dart';
import '/models/equipment.dart';
import 'character_edit_screen.dart';
import 'level_up_screen.dart';

class CharacterSheetScreen extends ConsumerStatefulWidget {
  final Character character;

  const CharacterSheetScreen({super.key, required this.character});

  @override
  ConsumerState<CharacterSheetScreen> createState() =>
      _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends ConsumerState<CharacterSheetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Character _character;
  List<Item> _items = [];
  bool _loadingItems = false;

  // Debug mode
  bool _debugMode = false;
  DateTime? _debugStartTime;

  // Controle local de espaços de magia usados por nível (spellLevel -> usados)
  final Map<int, int> _usedSlotsByLevel = <int, int>{};

  @override
  void initState() {
    super.initState();
    _character = widget.character;
    _tabController = TabController(length: 6, vsync: this);

    debugPrint('=== INICIALIZAÇÃO DA FICHA ===');
    debugPrint('Personagem: ${_character.name}');
    debugPrint('Classe: ${_character.className}');
    debugPrint('dndClass: ${_character.dndClass?.name}');
    debugPrint(
      'levelFeatures: ${_character.dndClass?.levelFeatures?.length ?? 0}',
    );
    debugPrint('CA inicial: ${_character.armorClass}');
    debugPrint('Ability scores: ${_character.abilityScores}');

    _loadItems();
    _loadKnownSpells();
    _loadSpellsIndex();
    // Carregar classe se não estiver carregada
    _loadCharacterClass();
    // removido UD

    // Verificar se o debug mode ainda está ativo
    _checkDebugMode();
  }

  // --- Chips de efeito de magia (dano/cura) ---
  Widget? _buildSpellEffectChip(Spell spell) {
    String? effectType =
        spell.effectType; // 'Dano' | 'Cura' | 'damage' | 'healing'
    String? baseDice = spell.baseDice; // ex: 1d8
    bool includeMod = spell.includeSpellMod;
    List<Map<String, dynamic>>? increases = spell.cantripDiceIncreases;

    // Fallback: enriquecer a partir do índice global de magias (tabela spells)
    if ((effectType == null || effectType.isEmpty) &&
        _spellIndexByName.isNotEmpty) {
      final data = _spellIndexByName[spell.name];
      if (data != null) {
        effectType = data['effect_type'] as String?;
        baseDice = data['base_dice'] as String?;
        includeMod = (data['include_spell_mod'] as bool?) ?? includeMod;
        final cdi = data['cantrip_dice_increases'];
        if (cdi is List) {
          increases =
              cdi
                  .map(
                    (e) => (e as Map).map((k, v) => MapEntry(k.toString(), v)),
                  )
                  .cast<Map<String, dynamic>>()
                  .toList();
        }
      }
    }

    if (effectType == null || effectType.isEmpty) return null;

    String diceLabel = baseDice ?? '';

    // Truques escalam com nível do personagem
    if (spell.level == 0) {
      final scaled = _getCurrentCantripDice(
        spell,
        increasesOverride: increases,
      );
      if (scaled != null && scaled.isNotEmpty) {
        diceLabel = scaled;
      }
    }

    final String modSuffix = includeMod ? ' + mod' : '';
    final String label =
        '${(effectType.toLowerCase() == 'cura' || effectType.toLowerCase() == 'healing') ? 'Cura' : 'Dano'}: ${diceLabel.isEmpty ? '?' : diceLabel}$modSuffix';

    final bool isHealing =
        (effectType.toLowerCase() == 'cura' ||
            effectType.toLowerCase() == 'healing');
    final Color color = isHealing ? Colors.green : Colors.red;
    return Container(
      margin: const EdgeInsets.only(left: 4),
      child: Chip(
        backgroundColor: color.withAlpha(24),
        side: BorderSide(color: color.withAlpha(80)),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      ),
    );
  }

  String? _getCurrentCantripDice(
    Spell spell, {
    List<Map<String, dynamic>>? increasesOverride,
  }) {
    final List<Map<String, dynamic>>? increases =
        increasesOverride ?? spell.cantripDiceIncreases;
    if (increases == null || increases.isEmpty) {
      return spell.baseDice;
    }

    String? current = spell.baseDice;
    for (final inc in increases) {
      final int lvl = (inc['level'] as num?)?.toInt() ?? 0;
      final String dice = inc['dice']?.toString() ?? '';
      if (lvl <= _character.level && dice.isNotEmpty) {
        current = dice;
      }
    }
    return current;
  }

  // Índice global de magias (tabela spells) por nome para enriquecer truques salvos sem campos mecânicos
  final Map<String, Map<String, dynamic>> _spellIndexByName = {};

  // Normalizar nome do atributo para português
  String _normalizeAbilityName(String abilityName) {
    switch (abilityName.toLowerCase()) {
      case 'strength':
        return 'Força';
      case 'dexterity':
        return 'Destreza';
      case 'constitution':
        return 'Constituição';
      case 'intelligence':
        return 'Inteligência';
      case 'wisdom':
        return 'Sabedoria';
      case 'charisma':
        return 'Carisma';
      default:
        return abilityName; // Já está em português
    }
  }

  Future<void> _loadSpellsIndex() async {
    try {
      final spellsData = await SupabaseService.getSpells();
      for (final m in spellsData) {
        final name = m['name'] as String?;
        if (name != null && name.isNotEmpty) {
          _spellIndexByName[name] = m;
        }
      }
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Erro ao carregar índice de magias: $e');
    }
  }

  Future<void> _loadCharacterClass() async {
    if (_character.dndClass != null) {
      debugPrint(
        'CharacterSheet: Classe já carregada: ${_character.dndClass!.name}',
      );
      return;
    }

    if (_character.className.isEmpty) {
      debugPrint('CharacterSheet: Nome da classe vazio');
      return;
    }

    try {
      debugPrint('CharacterSheet: Carregando classe: ${_character.className}');
      final dndClass = await ClassService.loadByName(_character.className);
      if (dndClass != null) {
        setState(() {
          _character.dndClass = dndClass;
        });
        debugPrint('CharacterSheet: Classe carregada: ${dndClass.name}');
        debugPrint(
          'CharacterSheet: levelFeatures: ${dndClass.levelFeatures?.length ?? 0}',
        );

        // Verificar se tem UD
        if (dndClass.levelFeatures != null) {
          for (final feature in dndClass.levelFeatures!) {
            if (feature.containsKey('unarmored_defense')) {
              debugPrint(
                'CharacterSheet: UD encontrada: ${feature['unarmored_defense']}',
              );
            }
          }
        }
      } else {
        debugPrint(
          'CharacterSheet: Classe não encontrada: ${_character.className}',
        );
      }
    } catch (e) {
      debugPrint('CharacterSheet: Erro ao carregar classe: $e');
    }
  }

  // Resolve o dado de vida a partir do nome da classe caso o objeto da classe não esteja populado
  int _getHitDieForClassName(String className) {
    switch (className.toLowerCase()) {
      case 'bárbaro':
      case 'barbaro':
        return 12;
      case 'guerreiro':
      case 'paladino':
      case 'patrulheiro':
      case 'ranger':
        return 10;
      case 'bardo':
      case 'clérigo':
      case 'clerigo':
      case 'druida':
      case 'ladino':
      case 'monge':
      case 'bruxo':
        return 8;
      case 'mago':
      case 'feiticeiro':
        return 6;
      default:
        // Fallback seguro
        return 8;
    }
  }

  // diálogo antigo removido (agora controlado por botões no card)

  Future<void> _updateHitDiceUsed(int newUsed) async {
    try {
      final updatedCharacter = Character(
        id: _character.id,
        userId: _character.userId,
        name: _character.name,
        race: _character.race,
        className: _character.className,
        background: _character.background,
        level: _character.level,
        abilityScores: _character.abilityScores,
        skills: _character.skills,
        inventory: _character.inventory,
        currentHitPoints: _character.currentHitPoints,
        maxHitPoints: _character.maxHitPoints,
        temporaryHitPoints: _character.temporaryHitPoints,
        armorClass: _character.armorClass,
        speed: _character.speed,
        alignment: _character.alignment,
        experiencePoints: _character.experiencePoints,
        languages: _character.languages,
        proficiencies: _character.proficiencies,
        dndClass: _character.dndClass,
        selectedCantrips: _character.selectedCantrips,
        selectedSpells: _character.selectedSpells,
        knownSpells: _character.knownSpells,
        customAbilities: _character.customAbilities,
        personalityTraits: _character.personalityTraits,
        ideals: _character.ideals,
        bonds: _character.bonds,
        flaws: _character.flaws,
        createdAt: _character.createdAt,
        updatedAt: DateTime.now(),
        platinumPieces: _character.platinumPieces,
        goldPieces: _character.goldPieces,
        electrumPieces: _character.electrumPieces,
        silverPieces: _character.silverPieces,
        copperPieces: _character.copperPieces,
        deathSaveSuccesses: _character.deathSaveSuccesses,
        deathSaveFailures: _character.deathSaveFailures,
        hitDiceUsed: newUsed,
      );

      await CharacterService.saveCharacter(updatedCharacter);
      if (!mounted) return;
      setState(() => _character = updatedCharacter);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar Dados de Vida: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _performLongRest() async {
    try {
      // Resetar pontos de vida atuais para o máximo
      // Resetar dados de vida usados
      // Resetar usos de habilidades (armazenados dinamicamente por cálculo)
      // Resetar espaços de magia usados (counter por nível)

      // Reset slots de magia usados (estrutura local por nível)
      _usedSlotsByLevel.clear();

      final updatedCharacter = Character(
        id: _character.id,
        userId: _character.userId,
        name: _character.name,
        race: _character.race,
        className: _character.className,
        background: _character.background,
        level: _character.level,
        abilityScores: _character.abilityScores,
        skills: _character.skills,
        inventory: _character.inventory,
        currentHitPoints: _character.maxHitPoints,
        maxHitPoints: _character.maxHitPoints,
        temporaryHitPoints: 0,
        armorClass: _character.armorClass,
        speed: _character.speed,
        alignment: _character.alignment,
        experiencePoints: _character.experiencePoints,
        languages: _character.languages,
        proficiencies: _character.proficiencies,
        dndClass: _character.dndClass,
        selectedCantrips: _character.selectedCantrips,
        selectedSpells: _character.selectedSpells,
        knownSpells: _character.knownSpells,
        customAbilities: _character.customAbilities,
        personalityTraits: _character.personalityTraits,
        ideals: _character.ideals,
        bonds: _character.bonds,
        flaws: _character.flaws,
        createdAt: _character.createdAt,
        updatedAt: DateTime.now(),
        platinumPieces: _character.platinumPieces,
        goldPieces: _character.goldPieces,
        electrumPieces: _character.electrumPieces,
        silverPieces: _character.silverPieces,
        copperPieces: _character.copperPieces,
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        hitDiceUsed: 0,
      );

      await CharacterService.saveCharacter(updatedCharacter);
      if (!mounted) return;
      setState(() {
        _character = updatedCharacter;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Descanso longo concluído! Vida, DV e usos foram resetados.',
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao aplicar descanso longo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _checkDebugMode() {
    if (_debugStartTime != null) {
      final now = DateTime.now();
      final difference = now.difference(_debugStartTime!);
      if (difference.inHours >= 1) {
        setState(() {
          _debugMode = false;
          _debugStartTime = null;
        });
      } else {
        setState(() {
          _debugMode = true;
        });
      }
    }
  }

  void _toggleDebugMode() {
    setState(() {
      if (_debugMode) {
        _debugMode = false;
        _debugStartTime = null;
      } else {
        _debugMode = true;
        _debugStartTime = DateTime.now();
      }
    });
  }

  String _getDebugTimeRemaining() {
    if (_debugStartTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(_debugStartTime!);
    final remaining = Duration(hours: 1) - difference;
    if (remaining.isNegative) return 'Expirado';
    return '${remaining.inMinutes}m restantes';
  }

  void _debugAbility(String abilityName, Map<String, dynamic>? abilityData) {
    if (!_debugMode) return;

    debugPrint('=== DEBUG HABILIDADE: $abilityName ===');
    debugPrint('Timestamp: ${DateTime.now()}');
    debugPrint('Dados da habilidade: $abilityData');

    if (abilityData != null) {
      debugPrint('has_usage_limit: ${abilityData['has_usage_limit']}');
      debugPrint('has_dice_increase: ${abilityData['has_dice_increase']}');
      debugPrint('usage_type: ${abilityData['usage_type']}');
      debugPrint('usage_value: ${abilityData['usage_value']}');
      debugPrint('usage_recovery: ${abilityData['usage_recovery']}');
      debugPrint('usage_attribute: ${abilityData['usage_attribute']}');
      debugPrint('initial_dice: ${abilityData['initial_dice']}');
      debugPrint('dice_increases: ${abilityData['dice_increases']}');
      debugPrint(
        'manual_level_increases: ${abilityData['manual_level_increases']}',
      );
      debugPrint(
        'has_hit_point_increase: ${abilityData['has_hit_point_increase']}',
      );
      debugPrint(
        'hit_point_increase_per_level: ${abilityData['hit_point_increase_per_level']}',
      );
      debugPrint(
        'has_additional_features: ${abilityData['has_additional_features']}',
      );
      debugPrint(
        'additional_feature_name: ${abilityData['additional_feature_name']}',
      );
      debugPrint(
        'additional_feature_description: ${abilityData['additional_feature_description']}',
      );
    }

    debugPrint('=== FIM DEBUG HABILIDADE ===');
  }

  Widget _buildDebugInfo(
    String name,
    Map<String, dynamic>? abilityData,
    AbilityCalculation? calculation,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.yellow.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bug_report, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                'Debug Info - $name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (abilityData != null) ...[
            Text('has_usage_limit: ${abilityData['has_usage_limit']}'),
            Text('has_dice_increase: ${abilityData['has_dice_increase']}'),
            Text('usage_type: ${abilityData['usage_type']}'),
            Text('usage_value: ${abilityData['usage_value']}'),
            Text('usage_recovery: ${abilityData['usage_recovery']}'),
            Text('usage_attribute: ${abilityData['usage_attribute']}'),
            Text('initial_dice: ${abilityData['initial_dice']}'),
            Text('dice_increases: ${abilityData['dice_increases']}'),
            Text(
              'manual_level_increases: ${abilityData['manual_level_increases']}',
            ),
            Text(
              'has_hit_point_increase: ${abilityData['has_hit_point_increase']}',
            ),
            Text(
              'hit_point_increase_per_level: ${abilityData['hit_point_increase_per_level']}',
            ),
            Text(
              'has_additional_features: ${abilityData['has_additional_features']}',
            ),
            Text(
              'additional_feature_name: ${abilityData['additional_feature_name']}',
            ),
            Text(
              'additional_feature_description: ${abilityData['additional_feature_description']}',
            ),
          ],
          if (calculation != null) ...[
            const SizedBox(height: 8),
            Text('Tipo: ${calculation.type}'),
            Text('Usos atuais: ${calculation.currentUses}'),
            Text('Dado atual: ${calculation.currentDie}'),
            Text('Tipo de recuperação: ${calculation.recoveryType}'),
            Text(
              'Tem funcionalidades adicionais: ${calculation.hasAdditionalFeatures}',
            ),
            Text(
              'Nome da funcionalidade: ${calculation.additionalFeatureName}',
            ),
            Text(
              'Descrição da funcionalidade: ${calculation.additionalFeatureDescription}',
            ),
          ],
          const SizedBox(height: 8),
          Text(
            'Timestamp: ${DateTime.now()}',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _loadItems() async {
    if (_loadingItems) {
      return;
    }

    setState(() => _loadingItems = true);
    try {
      _items = await CharacterService.loadItems(_character.id);
    } catch (e, stackTrace) {
      debugPrint('=== ERRO NO CARREGAMENTO DE ITENS ===');
      debugPrint('Erro: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('=== FIM DO ERRO ===');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar itens: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loadingItems = false);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.trending_up),
            tooltip: 'Level Up',
            onPressed:
                _character.level < 20
                    ? () async {
                      final result = await Navigator.push<Character>(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => LevelUpScreen(character: _character),
                        ),
                      );
                      if (result != null && mounted) {
                        setState(() {
                          _character = result;
                        });
                      }
                    }
                    : null,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push<Character>(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CharacterEditScreen(character: _character),
                ),
              );
              if (result != null && mounted) {
                setState(() {
                  _character = result;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(
              _debugMode ? Icons.bug_report : Icons.bug_report_outlined,
              color: _debugMode ? Colors.yellow : Colors.white,
            ),
            tooltip:
                _debugMode
                    ? 'Debug Mode Ativo (${_getDebugTimeRemaining()})'
                    : 'Ativar Debug Mode (1 hora)',
            onPressed: _toggleDebugMode,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Básico'),
            Tab(icon: Icon(Icons.fitness_center), text: 'Atributos'),
            Tab(icon: Icon(Icons.star), text: 'Perícias'),
            Tab(icon: Icon(Icons.inventory), text: 'Inventário'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Magias'),
            Tab(icon: Icon(Icons.psychology), text: 'Habilidades'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBasicInfoTab(),
          _buildAttributesTab(),
          _buildSkillsTab(),
          _buildInventoryTab(),
          _buildSpellsTab(),
          _buildAbilitiesTab(),
        ],
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    final ScrollController scrollController = ScrollController();
    bool showScrollIndicator = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                // Verificar se chegou no final
                final isAtBottom =
                    scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 10; // 10px de margem

                // Só mostrar indicador se não estiver no final E se houver conteúdo para rolar
                final hasScrollableContent =
                    scrollInfo.metrics.maxScrollExtent > 0;
                final shouldShowIndicator = hasScrollableContent && !isAtBottom;

                if (shouldShowIndicator != showScrollIndicator) {
                  setState(() {
                    showScrollIndicator = shouldShowIndicator;
                  });
                }
                return false;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header do personagem
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: _getClassColor(
                                    _character.className,
                                  ),
                                  child: Text(
                                    _character.name
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _character.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${_character.race} ${_character.className}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      Text(
                                        'Nível ${_character.level} • ${_character.background}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        '${_character.experiencePoints} XP',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tendência: ${_character.alignment}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Estatísticas vitais
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Pontos de Vida',
                            '${_character.currentHitPoints}/${_character.maxHitPoints}',
                            Icons.favorite,
                            Colors.red,
                            onTap: () => _showHitPointsDialog(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: _buildArmorClassCard()),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Iniciativa (modificador de Destreza) + Dados de Vida
                    Row(
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final int dexMod = _character.getAbilityModifier(
                                'Destreza',
                              );
                              final String sign = dexMod >= 0 ? '+' : '';
                              return _buildStatCard(
                                'Iniciativa',
                                '$sign$dexMod',
                                Icons.flash_on,
                                Colors.orange,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 350),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: 0.85 + (0.15 * value),
                                child: Opacity(
                                  opacity: value,
                                  child: Builder(
                                    builder: (context) {
                                      final int hitDie =
                                          _character.dndClass?.hitDie ??
                                          _getHitDieForClassName(
                                            _character.className,
                                          );
                                      final int totalDice = _character.level;
                                      final int used =
                                          (_character.hitDiceUsed ?? 0).clamp(
                                            0,
                                            totalDice,
                                          );
                                      final int remaining = (totalDice - used)
                                          .clamp(0, totalDice);
                                      return Card(
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              AnimatedRotation(
                                                duration: const Duration(
                                                  milliseconds: 500,
                                                ),
                                                turns: value,
                                                child: Icon(
                                                  Icons.casino,
                                                  color: Colors.teal,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              const Text(
                                                'Dados de Vida',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 4),
                                              AnimatedDefaultTextStyle(
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal,
                                                ),
                                                child: Text(
                                                  '$remaining/$totalDice d$hitDie',
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    tooltip: 'Gastar 1 dado',
                                                    onPressed:
                                                        remaining > 0
                                                            ? () =>
                                                                _updateHitDiceUsed(
                                                                  used + 1,
                                                                )
                                                            : null,
                                                    icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                    ),
                                                    color: Colors.teal,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  IconButton(
                                                    tooltip: 'Devolver 1 dado',
                                                    onPressed:
                                                        used > 0
                                                            ? () =>
                                                                _updateHitDiceUsed(
                                                                  used - 1,
                                                                )
                                                            : null,
                                                    icon: const Icon(
                                                      Icons.add_circle_outline,
                                                    ),
                                                    color: Colors.teal,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // Controle rápido de vida
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Opacity(
                            opacity: value,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Vida',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              tooltip: '-5 PV',
                                              onPressed:
                                                  () => _adjustHitPoints(-5),
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                              color: Colors.red,
                                            ),
                                            IconButton(
                                              tooltip: '-1 PV',
                                              onPressed:
                                                  () => _adjustHitPoints(-1),
                                              icon: const Icon(Icons.remove),
                                            ),
                                            const SizedBox(width: 4),
                                            AnimatedDefaultTextStyle(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              style:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ) ??
                                                  const TextStyle(),
                                              child: Text(
                                                '${_character.currentHitPoints}/${_character.maxHitPoints}',
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            IconButton(
                                              tooltip: '+1 PV',
                                              onPressed:
                                                  () => _adjustHitPoints(1),
                                              icon: const Icon(Icons.add),
                                            ),
                                            IconButton(
                                              tooltip: '+5 PV',
                                              onPressed:
                                                  () => _adjustHitPoints(5),
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                              ),
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Barra de vida com PV temporários (azul)
                                    _buildHitPointBar(),

                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'PV Temporários',
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleSmall,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              tooltip: '-5 PV Temp',
                                              onPressed:
                                                  () =>
                                                      _adjustTempHitPoints(-5),
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                              color: Colors.blue,
                                            ),
                                            IconButton(
                                              tooltip: '-1 PV Temp',
                                              onPressed:
                                                  () =>
                                                      _adjustTempHitPoints(-1),
                                              icon: const Icon(Icons.remove),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '${_character.temporaryHitPoints}',
                                                style: TextStyle(
                                                  color: Colors.blue.shade700,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: '+1 PV Temp',
                                              onPressed:
                                                  () => _adjustTempHitPoints(1),
                                              icon: const Icon(Icons.add),
                                            ),
                                            IconButton(
                                              tooltip: '+5 PV Temp',
                                              onPressed:
                                                  () => _adjustTempHitPoints(5),
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                              ),
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Velocidade',
                            '${_character.speed} pés',
                            Icons.directions_run,
                            Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            'Bônus de Proficiência',
                            '+${_character.proficiencyBonus}',
                            Icons.add_circle,
                            Colors.purple,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const SizedBox(height: 12),

                    // Testes de Morte
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 400),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.9 + (0.1 * value),
                          child: Opacity(
                            opacity: value,
                            child: _buildDeathSavesCard(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Idiomas
                    if (_character.languages.isNotEmpty) ...[
                      _buildInfoSection(
                        'Idiomas',
                        _character.languages.join(', '),
                      ),
                      const SizedBox(height: 12),
                    ],

                    const SizedBox(height: 0),

                    // Seção de Personalidade
                    if (_character.personalityTraits != null &&
                        _character.personalityTraits!.isNotEmpty) ...[
                      _buildInfoSection(
                        'Traços de Personalidade',
                        _character.personalityTraits!,
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (_character.ideals != null &&
                        _character.ideals!.isNotEmpty) ...[
                      _buildInfoSection('Ideais', _character.ideals!),
                      const SizedBox(height: 12),
                    ],

                    if (_character.bonds != null &&
                        _character.bonds!.isNotEmpty) ...[
                      _buildInfoSection('Vínculos', _character.bonds!),
                      const SizedBox(height: 12),
                    ],

                    if (_character.flaws != null &&
                        _character.flaws!.isNotEmpty) ...[
                      _buildInfoSection('Defeitos', _character.flaws!),
                    ],

                    const SizedBox(height: 16),

                    // Botão: Descanso Longo (Básico)
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.bedtime),
                        label: const Text('Descanso Longo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Confirmar Descanso Longo'),
                                  content: const Text(
                                    'Isso vai restaurar sua vida ao máximo, zerar os Dados de Vida usados, testes de morte e espaços de magia usados. Deseja continuar?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () =>
                                              Navigator.of(context).pop(false),
                                      child: const Text('Cancelar'),
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(true),
                                      child: const Text('Confirmar'),
                                    ),
                                  ],
                                ),
                          );
                          if (confirmed == true) {
                            await _performLongRest();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Indicador de scroll (só aparece se não estiver no final)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: showScrollIndicator ? 20 : -50,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: showScrollIndicator ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Role para ver mais',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- Death Saves ---
  Widget _buildDeathSavesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Testes de Morte',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDeathSaveRow(
              label: 'Sucessos',
              value: _character.deathSaveSuccesses,
              color: Colors.green,
              onChanged:
                  (v) => _updateDeathSaves(v, _character.deathSaveFailures),
            ),
            const SizedBox(height: 8),
            _buildDeathSaveRow(
              label: 'Falhas',
              value: _character.deathSaveFailures,
              color: Colors.red,
              onChanged:
                  (v) => _updateDeathSaves(_character.deathSaveSuccesses, v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeathSaveRow({
    required String label,
    required int value,
    required Color color,
    required ValueChanged<int> onChanged,
  }) {
    final clamped = value.clamp(0, 3);
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          tooltip: '-1',
          onPressed: clamped > 0 ? () => onChanged((clamped - 1)) : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Row(
          children: List.generate(3, (i) {
            final filled = i < clamped;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? color : Colors.transparent,
                  border: Border.all(color: color, width: 2),
                ),
                child:
                    filled
                        ? AnimatedScale(
                          duration: const Duration(milliseconds: 150),
                          scale: 1.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                          ),
                        )
                        : null,
              ),
            );
          }),
        ),
        IconButton(
          tooltip: '+1',
          onPressed: clamped < 3 ? () => onChanged((clamped + 1)) : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }

  Future<void> _updateDeathSaves(int successes, int failures) async {
    try {
      final updated = Character(
        id: _character.id,
        userId: _character.userId,
        name: _character.name,
        race: _character.race,
        className: _character.className,
        background: _character.background,
        level: _character.level,
        abilityScores: _character.abilityScores,
        skills: _character.skills,
        inventory: _character.inventory,
        currentHitPoints: _character.currentHitPoints,
        maxHitPoints: _character.maxHitPoints,
        temporaryHitPoints: _character.temporaryHitPoints,
        armorClass: _character.armorClass,
        speed: _character.speed,
        alignment: _character.alignment,
        experiencePoints: _character.experiencePoints,
        languages: _character.languages,
        proficiencies: _character.proficiencies,
        dndClass: _character.dndClass,
        selectedCantrips: _character.selectedCantrips,
        selectedSpells: _character.selectedSpells,
        knownSpells: _character.knownSpells,
        customAbilities: _character.customAbilities,
        personalityTraits: _character.personalityTraits,
        ideals: _character.ideals,
        bonds: _character.bonds,
        flaws: _character.flaws,
        createdAt: _character.createdAt,
        updatedAt: _character.updatedAt,
        platinumPieces: _character.platinumPieces,
        goldPieces: _character.goldPieces,
        electrumPieces: _character.electrumPieces,
        silverPieces: _character.silverPieces,
        copperPieces: _character.copperPieces,
        deathSaveSuccesses: successes.clamp(0, 3),
        deathSaveFailures: failures.clamp(0, 3),
      );

      await CharacterService.saveCharacter(updated);
      setState(() => _character = updated);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar Testes de Morte: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _adjustHitPoints(int delta) async {
    if (!mounted) return;
    setState(() {
      final max = _character.maxHitPoints;
      final next = (_character.currentHitPoints + delta).clamp(0, max);
      _character.currentHitPoints = next;
    });
    // Persistir
    await CharacterService.saveCharacter(_character);
  }

  void _adjustTempHitPoints(int delta) async {
    if (!mounted) return;
    setState(() {
      final next = (_character.temporaryHitPoints + delta).clamp(0, 9999);
      _character.temporaryHitPoints = next;
    });
    await CharacterService.saveCharacter(_character);
  }

  Widget _buildHitPointBar() {
    final max = _character.maxHitPoints;
    if (max <= 0) {
      return LinearProgressIndicator(
        value: 0,
        backgroundColor: Colors.red.shade100,
      );
    }

    final current = _character.currentHitPoints.clamp(0, max).toDouble();
    final temp = _character.temporaryHitPoints.clamp(0, 9999).toDouble();
    final ratioCurrent = (current / max).clamp(0.0, 1.0);
    final ratioTempInside = (temp / max).clamp(0.0, 1.0);

    return SizedBox(
      height: 14,
      child: Stack(
        children: [
          // fundo
          Container(
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // PV atuais (verde/laranja/vermelho)
          FractionallySizedBox(
            widthFactor: ratioCurrent,
            child: Container(
              decoration: BoxDecoration(
                color:
                    current <= 0
                        ? Colors.red
                        : current < max * 0.5
                        ? Colors.orange
                        : Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          // PV temporários (azul) sobrepostos no final da barra
          if (ratioTempInside > 0)
            Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: ratioTempInside,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(160),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttributesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Atributos principais (responsivo)
          LayoutBuilder(
            builder: (context, constraints) {
              // Mais colunas em telas grandes para evitar cartões gigantes
              final double width = constraints.maxWidth;
              int columns = 2;
              if (width >= 1200) {
                columns = 6; // todos os atributos em uma linha
              } else if (width >= 900) {
                columns = 3; // 2 linhas de 3
              } else if (width >= 600) {
                columns = 2;
              }

              // Ajustar proporção dos cards conforme a largura
              final double aspectRatio =
                  width >= 1200
                      ? 1.1
                      : width >= 900
                      ? 1.0
                      : width >= 600
                      ? 0.9
                      : 0.8; // Para telas pequenas, cards mais altos

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: aspectRatio,
                children:
                    _character.abilityScores.entries.map((entry) {
                      final abilityName = entry.key;
                      final abilityScore = entry.value;
                      final modifier = _character.getAbilityModifier(
                        abilityName,
                      );
                      final sign = modifier >= 0 ? "+" : "";

                      // Normalizar nome do atributo para português
                      final normalizedAbilityName = _normalizeAbilityName(
                        abilityName,
                      );

                      return TweenAnimationBuilder<double>(
                        duration: Duration(
                          milliseconds: 300 + (entry.key.hashCode % 200),
                        ),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Card(
                              elevation: 6,
                              shadowColor: _getAbilityColor(
                                normalizedAbilityName,
                              ).withAlpha(100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _getAbilityColor(
                                    normalizedAbilityName,
                                  ).withAlpha(60),
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _getAbilityColor(
                                        normalizedAbilityName,
                                      ).withAlpha(20),
                                      _getAbilityColor(
                                        normalizedAbilityName,
                                      ).withAlpha(5),
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap:
                                      () => _showAbilityRollDialog(
                                        normalizedAbilityName,
                                        modifier,
                                      ),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      width < 600 ? 12 : 16,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Ícone do atributo
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: _getAbilityColor(
                                              abilityName,
                                            ).withAlpha(30),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            _getAbilityIcon(
                                              normalizedAbilityName,
                                            ),
                                            color: _getAbilityColor(
                                              normalizedAbilityName,
                                            ),
                                            size: width < 600 ? 16 : 20,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          normalizedAbilityName,
                                          style: TextStyle(
                                            fontSize: width < 600 ? 12 : 14,
                                            fontWeight: FontWeight.bold,
                                            color: _getAbilityColor(
                                              normalizedAbilityName,
                                            ).withAlpha(200),
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        // Valor do atributo com efeito
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getAbilityColor(
                                              abilityName,
                                            ).withAlpha(40),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color: _getAbilityColor(
                                                abilityName,
                                              ).withAlpha(80),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            '$abilityScore',
                                            style: TextStyle(
                                              fontSize: width < 600 ? 16 : 18,
                                              fontWeight: FontWeight.bold,
                                              color: _getAbilityColor(
                                                abilityName,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Modificador com cor baseada no valor
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                modifier >= 0
                                                    ? Colors.green.withAlpha(30)
                                                    : Colors.red.withAlpha(30),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            '$sign$modifier',
                                            style: TextStyle(
                                              fontSize: width < 600 ? 10 : 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  modifier >= 0
                                                      ? Colors.green.shade700
                                                      : Colors.red.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    // Separar em duas abas internas: Testes de Resistência e Perícias
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: const [Tab(text: 'Resistências'), Tab(text: 'Perícias')],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Aba 1: Testes de Resistência
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildSavingThrowsCard(),
                ),
                // Aba 2: Perícias
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Toque em uma perícia para fazer um teste',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._character.skills.map((skill) {
                        final modifier = skill.getModifier(
                          _character.abilityScores,
                          _character.proficiencyBonus,
                        );
                        final sign = modifier >= 0 ? "+" : "";

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  skill.isProficient
                                      ? (skill.hasExpertise
                                          ? Colors.purple
                                          : Colors.green)
                                      : Colors.grey,
                              child: Icon(
                                skill.isProficient
                                    ? (skill.hasExpertise
                                        ? Icons.star
                                        : Icons.check)
                                    : Icons.circle_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            title: Text(
                              skill.name,
                              style: TextStyle(
                                fontWeight:
                                    skill.isProficient
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(skill.baseAbility),
                            trailing: Text(
                              '$sign$modifier',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap:
                                () =>
                                    _showSkillRollDialog(skill.name, modifier),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      // Legenda
                      Card(
                        color: Colors.grey.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Legenda:',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.circle_outlined,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Sem proficiência'),
                                  const SizedBox(width: 20),
                                  const CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Proficiente'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.purple,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Especialista (2x bônus)'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção de Moedas
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Moedas',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _showCurrencyDialog,
                        tooltip: 'Editar moedas',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isNarrow = constraints.maxWidth < 420;
                      if (isNarrow) {
                        // Em telas estreitas, usar Wrap para evitar overflow
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildEditableCurrencyCard(
                              'PL',
                              _character.platinumPieces,
                              Colors.grey.shade300,
                              (value) =>
                                  _updateSingleCurrency('platinum', value),
                              compact: true,
                            ),
                            _buildEditableCurrencyCard(
                              'PO',
                              _character.goldPieces,
                              Colors.amber,
                              (value) => _updateSingleCurrency('gold', value),
                              compact: true,
                            ),
                            _buildEditableCurrencyCard(
                              'PE',
                              _character.electrumPieces,
                              Colors.amber.shade300,
                              (value) =>
                                  _updateSingleCurrency('electrum', value),
                              compact: true,
                            ),
                            _buildEditableCurrencyCard(
                              'PP',
                              _character.silverPieces,
                              Colors.blue.shade200,
                              (value) => _updateSingleCurrency('silver', value),
                              compact: true,
                            ),
                            _buildEditableCurrencyCard(
                              'PC',
                              _character.copperPieces,
                              Colors.orange,
                              (value) => _updateSingleCurrency('copper', value),
                              compact: true,
                            ),
                          ],
                        );
                      }
                      // Em telas maiores, manter Row com espaçamento fixo
                      return Row(
                        children: [
                          Expanded(
                            child: _buildEditableCurrencyCard(
                              'PL',
                              _character.platinumPieces,
                              Colors.grey.shade300,
                              (value) =>
                                  _updateSingleCurrency('platinum', value),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildEditableCurrencyCard(
                              'PO',
                              _character.goldPieces,
                              Colors.amber,
                              (value) => _updateSingleCurrency('gold', value),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildEditableCurrencyCard(
                              'PE',
                              _character.electrumPieces,
                              Colors.amber.shade300,
                              (value) =>
                                  _updateSingleCurrency('electrum', value),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildEditableCurrencyCard(
                              'PP',
                              _character.silverPieces,
                              Colors.blue.shade200,
                              (value) => _updateSingleCurrency('silver', value),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildEditableCurrencyCard(
                              'PC',
                              _character.copperPieces,
                              Colors.orange,
                              (value) => _updateSingleCurrency('copper', value),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total: ${_getTotalCurrencyValue()} PO',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Resumo do inventário
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título e botão em layout responsivo
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Resumo do Inventário',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _showAddItemDialog,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Adicionar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Informações do inventário em grid responsivo
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 400) {
                        // Layout vertical para telas muito pequenas
                        return Column(
                          children: [
                            _buildInventoryInfoRow('Itens', '${_items.length}'),
                            const SizedBox(height: 8),
                            _buildInventoryInfoRow(
                              'Peso',
                              '${_totalWeight.toStringAsFixed(1)} lbs',
                            ),
                            const SizedBox(height: 8),
                            _buildInventoryInfoRow(
                              'Capacidade',
                              '$_carryingCapacity lbs',
                            ),
                            const SizedBox(height: 8),
                            _buildInventoryStatusRow(),
                          ],
                        );
                      } else {
                        // Layout horizontal para telas maiores
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Itens: ${_items.length}'),
                                Text(
                                  'Peso: ${_totalWeight.toStringAsFixed(1)} lbs',
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Capacidade: $_carryingCapacity lbs'),
                                Text(
                                  'Peso: ${_totalWeight.toStringAsFixed(1)} lbs',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Lista de itens
          if (_loadingItems)
            const Center(child: CircularProgressIndicator())
          else if (_items.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Inventário vazio',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nenhum item no inventário',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            ..._items.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: _getItemTypeColor(item.type),
                    child: Icon(
                      _getItemTypeIcon(item.type),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (item.isEquipped)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'EQUIPADO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Text(
                    _getItemBriefDescription(item),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botão equipar/desequipar para armaduras e escudos
                      if (item.type == ItemType.armor ||
                          item.type == ItemType.shield)
                        IconButton(
                          icon: Icon(
                            item.isEquipped
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: item.isEquipped ? Colors.green : Colors.grey,
                          ),
                          onPressed: () => _toggleEquipItem(item),
                          tooltip: item.isEquipped ? 'Desequipar' : 'Equipar',
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditItemDialog(item),
                        tooltip: 'Editar item',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDeleteItemDialog(item),
                        tooltip: 'Remover item',
                        color: Colors.red,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.description.isNotEmpty) ...[
                            Text(
                              'Descrição:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Quantidade: ${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Peso: ${item.weight} lbs',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Valor: ${item.value} po',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          if (item.type == ItemType.armor &&
                              item.description.contains('CA:')) ...[
                            const SizedBox(height: 8),
                            Text(
                              'CA: ${_extractArmorACFromDescription(item.description)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildSpellsTab() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _loadClassFromDatabase(_character.className),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error, size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      Text(
                        'Erro ao carregar classe: ${snapshot.error}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        final classData = snapshot.data;
        if (classData == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning, size: 48, color: Colors.orange),
                      const SizedBox(height: 12),
                      Text(
                        'Classe não encontrada: ${_character.className}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // Aba de magias sempre disponível

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Configurações de Conjuração
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configurações de Conjuração',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Esta classe é conjuradora'),
                        subtitle: const Text(
                          'Permite usar magias e espaços de magia',
                        ),
                        value: _character.hasSpellcasting,
                        onChanged: (value) {
                          setState(() {
                            _character.isSpellcaster = value;
                          });
                          _saveCharacterSpellcastingSettings();
                        },
                      ),
                      if (_character.hasSpellcasting) ...[
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _character.getSpellcastingAbility(),
                          decoration: const InputDecoration(
                            labelText: 'Atributo de Conjuração',
                            border: OutlineInputBorder(),
                            helperText:
                                'Atributo usado para CD de magia e bônus de ataque',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Força',
                              child: Text('Força'),
                            ),
                            DropdownMenuItem(
                              value: 'Destreza',
                              child: Text('Destreza'),
                            ),
                            DropdownMenuItem(
                              value: 'Constituição',
                              child: Text('Constituição'),
                            ),
                            DropdownMenuItem(
                              value: 'Inteligência',
                              child: Text('Inteligência'),
                            ),
                            DropdownMenuItem(
                              value: 'Sabedoria',
                              child: Text('Sabedoria'),
                            ),
                            DropdownMenuItem(
                              value: 'Carisma',
                              child: Text('Carisma'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _character.customSpellcastingAbility = value;
                              });
                              _saveCharacterSpellcastingSettings();
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Resumo de Conjuração
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conjuração',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_character.hasSpellcasting) ...[
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildChip(
                              'Habilidade',
                              _getSpellcastingAbility(classData),
                            ),
                            _buildChip(
                              'CD de Magia',
                              '${_getSpellSaveDC(classData)}',
                            ),
                            _buildChip(
                              'Bônus de Ataque',
                              '+${_getSpellAttackBonus(classData)}',
                            ),
                            _buildChip(
                              'Truques',
                              '${_getCantripsKnown(classData)}',
                            ),
                            _buildChip(
                              'Magias Conhecidas',
                              '${_getSpellsKnown(classData)}',
                            ),
                          ],
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(32),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.withAlpha(80),
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isNarrow = constraints.maxWidth < 400;
                              if (isNarrow) {
                                // Layout vertical para telas pequenas
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Conjuração desativada.',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Ative nas configurações para usar magias.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                );
                              } else {
                                // Layout horizontal para telas maiores
                                return const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Conjuração desativada. Ative nas configurações para usar magias.',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      if (_character.hasSpellcasting &&
                          _character.getSpellSlots().isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Espaços de Magia',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                _character.getSpellSlots().length,
                                (i) => Chip(
                                  label: Text(
                                    '${i + 1}º: ${_character.getSpellSlots()[i]}',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Seção de Magias Conhecidas por Nível
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 360;
                      final title = const Text(
                        'Magias Conhecidas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );

                      final addButton = ElevatedButton.icon(
                        onPressed:
                            _character.hasSpellcasting
                                ? () => _showAddSpellDialog()
                                : null,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Adicionar Magia'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _character.hasSpellcasting
                                  ? Colors.indigo
                                  : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      );

                      final menu = PopupMenuButton<String>(
                        tooltip: 'Mais ações',
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'save',
                                child: ListTile(
                                  leading: Icon(Icons.save),
                                  title: Text('Testar Salvar'),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'reload',
                                child: ListTile(
                                  leading: Icon(Icons.refresh),
                                  title: Text('Recarregar'),
                                ),
                              ),
                            ],
                        onSelected: (value) {
                          switch (value) {
                            case 'save':
                              _testSaveAndLoad();
                              break;
                            case 'reload':
                              _loadKnownSpells();
                              break;
                          }
                        },
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [Expanded(child: title), menu]),
                            const SizedBox(height: 8),
                            SizedBox(width: double.infinity, child: addButton),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: title),
                          addButton,
                          const SizedBox(width: 8),
                          menu,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  if (!_character.hasSpellcasting)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(32),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withAlpha(80)),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Conjuração desativada. Ative nas configurações para adicionar magias.',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_character.knownSpells.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(32),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withAlpha(80)),
                      ),
                      child: const Text(
                        'Nenhuma magia conhecida.\nClique em "Adicionar Magia" para começar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    ..._buildKnownSpellsByLevel(),
                ],
              ),

              const SizedBox(height: 16),

              // Botão: Descanso Longo (reseta usos da ficha)
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.bedtime),
                  label: const Text('Descanso Longo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _performLongRest,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSavingThrowsCard() {
    // Debug: verificar testes de resistência

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Testes de Resistência',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._character.savingThrows.entries.map((entry) {
              final saveName = entry.key;
              final saveModifier = entry.value;
              final sign = saveModifier >= 0 ? "+" : "";
              final isProf = _character.isSavingThrowProficient(saveName);

              return Card(
                color:
                    isProf
                        ? Theme.of(context).primaryColor.withAlpha(20)
                        : null,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  leading: Icon(
                    isProf ? Icons.check_circle : Icons.circle_outlined,
                    color:
                        isProf ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                  title: Text(
                    saveName,
                    style: TextStyle(
                      fontWeight: isProf ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    '$sign$saveModifier',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _showSaveRollDialog(saveName, saveModifier),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getSpellcastingAbility(Map<String, dynamic> classData) {
    // Usar o método do personagem que já considera override personalizado
    return _character.getSpellcastingAbility();
  }

  int _getSpellSaveDC(Map<String, dynamic> classData) {
    // CD de Magia = 8 + bônus de proficiência + modificador da habilidade de conjuração
    final abilityName = _getSpellcastingAbility(classData);
    final abilityModifier = _character.getAbilityModifier(abilityName);
    final proficiencyBonus = _character.proficiencyBonus;

    return 8 + proficiencyBonus + abilityModifier;
  }

  int _getSpellAttackBonus(Map<String, dynamic> classData) {
    // Bônus de Ataque = bônus de proficiência + modificador da habilidade de conjuração
    final abilityName = _getSpellcastingAbility(classData);
    final abilityModifier = _character.getAbilityModifier(abilityName);
    final proficiencyBonus = _character.proficiencyBonus;

    return proficiencyBonus + abilityModifier;
  }

  int _getCantripsKnown(Map<String, dynamic> classData) {
    // Buscar truques conhecidos por nível no banco de dados
    final spellLevels = classData['spell_levels'] as List<dynamic>?;
    if (spellLevels == null || spellLevels.isEmpty) return 0;

    // Encontrar o nível mais alto que não excede o nível do personagem
    int cantrips = 0;
    for (final spellLevel in spellLevels) {
      final level = spellLevel['level'] as int? ?? 0;
      if (level <= _character.level) {
        cantrips = spellLevel['cantrips'] as int? ?? 0;
      }
    }

    return cantrips;
  }

  int _getSpellsKnown(Map<String, dynamic> classData) {
    // Buscar magias conhecidas por nível no banco de dados
    final spellLevels = classData['spell_levels'] as List<dynamic>?;
    if (spellLevels == null || spellLevels.isEmpty) return 0;

    // Encontrar o nível mais alto que não excede o nível do personagem
    int spells = 0;
    for (final spellLevel in spellLevels) {
      final level = spellLevel['level'] as int? ?? 0;
      if (level <= _character.level) {
        spells = spellLevel['known_spells'] as int? ?? 0;
      }
    }

    return spells;
  }

  Widget _buildChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.withAlpha(60)),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.indigo,
        ),
      ),
    );
  }

  List<Widget> _buildKnownSpellsByLevel() {
    // Agrupar magias por nível
    final Map<int, List<Spell>> spellsByLevel = {};

    for (final spell in _character.knownSpells) {
      if (!spellsByLevel.containsKey(spell.level)) {
        spellsByLevel[spell.level] = [];
      }
      spellsByLevel[spell.level]!.add(spell);
    }

    // Obter todos os níveis que têm espaços de magia (nível 1+)
    final Set<int> levelsWithSlots = {};
    for (int level = 1; level <= 9; level++) {
      final totalSlots = _getSpellSlotsFromDatabase(level);
      if (totalSlots > 0) {
        levelsWithSlots.add(level);
      }
    }

    // Combinar níveis com magias conhecidas e níveis com espaços
    final allLevels = <int>{};
    allLevels.addAll(spellsByLevel.keys);
    allLevels.addAll(levelsWithSlots);

    // Adicionar nível 0 (truques) se houver truques conhecidos
    if (spellsByLevel.containsKey(0)) {
      allLevels.add(0);
    }

    // Ordenar níveis
    final sortedLevels = allLevels.toList()..sort();

    return sortedLevels.map((level) {
      final spells = spellsByLevel[level] ?? [];
      final levelName = level == 0 ? 'Truques' : 'Nível $level';

      // Obter espaços de magia para o nível (apenas para nível 1+)
      Widget slotsWidget = const SizedBox.shrink();
      if (level > 0) {
        // Usar dados do banco para obter slots
        final totalSlots = _getSpellSlotsFromDatabase(level);
        final usedSlots = _getUsedSpellSlots(level);
        slotsWidget = _buildSpellSlotsCounter(level, totalSlots, usedSlots);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                levelName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 8),
              slotsWidget,
            ],
          ),
          const SizedBox(height: 4),
          ...spells.map((spell) => _buildSpellCard(spell)),
          const SizedBox(height: 8),
        ],
      );
    }).toList();
  }

  Widget _buildSpellCard(Spell spell) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.withAlpha(32),
          child: Text(
            '${spell.level}',
            style: const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                spell.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            if (_buildSpellEffectChip(spell) != null)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _buildSpellEffectChip(spell)!,
              ),
            if (spell.concentration) _buildSpellFlag('Concentração'),
            if (spell.ritual) _buildSpellFlag('Ritual'),
          ],
        ),
        subtitle: Text('Nível ${spell.level} • ${spell.school}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _removeSpell(spell),
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Remover magia',
            ),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações básicas
                _buildSpellInfoRow('Tempo de Conjuração', spell.castingTime),
                _buildSpellInfoRow('Alcance', spell.range),
                _buildSpellInfoRow('Componentes', spell.components),
                if (spell.material != null && spell.material!.isNotEmpty)
                  _buildSpellInfoRow('Material', spell.material!),
                _buildSpellInfoRow('Duração', spell.duration),

                const SizedBox(height: 12),

                // Descrição
                if (spell.description.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Descrição:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spell.description,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),

                // Níveis superiores
                if (spell.higherLevels != null &&
                    spell.higherLevels!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Níveis Superiores:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spell.higherLevels!,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildSpellFlag(String flag) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(32),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withAlpha(64)),
      ),
      child: Text(
        flag,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }

  void _showAddSpellDialog() {
    showDialog(
      context: context,
      builder:
          (context) => _AddSpellDialog(
            character: _character,
            onSpellAdded: (spell) {
              setState(() {
                // Verificar se a magia já existe
                final exists = _character.knownSpells.any(
                  (s) => s.name == spell.name,
                );
                if (!exists) {
                  _character.knownSpells.add(spell);
                  // Salvar no banco de dados
                  _saveCharacter();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${spell.name} já está nas magias conhecidas',
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              });
            },
          ),
    );
  }

  void _removeSpell(Spell spell) {
    setState(() {
      _character.knownSpells.removeWhere((s) => s.name == spell.name);
    });
    // Salvar no banco de dados
    _saveCharacter();
  }

  Future<void> _loadKnownSpells() async {
    try {
      final response =
          await SupabaseService.client
              .from('characters')
              .select('known_spells')
              .eq('id', _character.id)
              .single();

      final knownSpellsData = response['known_spells'] as List<dynamic>?;

      if (knownSpellsData != null && knownSpellsData.isNotEmpty) {
        final spells =
            knownSpellsData
                .map(
                  (spellData) =>
                      Spell.fromJson(spellData as Map<String, dynamic>),
                )
                .toList();

        setState(() {
          _character.knownSpells = spells;
        });
      } else {}
    } catch (e) {
      debugPrint('Erro ao carregar magias: $e');
    }
  }

  Future<void> _testSaveAndLoad() async {
    // Primeiro, salvar
    await _saveCharacter();

    // Aguardar um pouco
    await Future.delayed(const Duration(seconds: 1));

    // Depois, carregar
    await _loadKnownSpells();

    debugPrint('=== FIM DO TESTE ===');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Teste de salvar/carregar executado. Verifique os logs.',
          ),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  Future<void> _saveCharacter() async {
    try {
      final spellsJson = _character.knownSpells.map((s) => s.toJson()).toList();

      await SupabaseService.client
          .from('characters')
          .update({'known_spells': spellsJson})
          .eq('id', _character.id);
    } catch (e) {
      debugPrint('Erro ao salvar magias: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar magias: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveCharacterSpellcastingSettings() async {
    try {
      await SupabaseService.client
          .from('characters')
          .update({
            'is_spellcaster': _character.isSpellcaster,
            'custom_spellcasting_ability': _character.customSpellcastingAbility,
          })
          .eq('id', _character.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Configurações de conjuração salvas!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erro ao salvar configurações de conjuração: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar configurações: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildArmorClassCard() {
    final calculatedAC = _character.getCalculatedArmorClass();
    final unarmoredDefense = _getUnarmoredDefense();
    final hasUnarmoredDefense = unarmoredDefense != null;

    // Debug: verificar se UD está sendo detectada
    debugPrint('=== DEBUG CA ===');
    debugPrint('Personagem: ${_character.name}');
    debugPrint('Classe: ${_character.className}');
    debugPrint('dndClass: ${_character.dndClass?.name}');
    debugPrint(
      'levelFeatures: ${_character.dndClass?.levelFeatures?.length ?? 0}',
    );
    debugPrint('unarmoredDefense: $unarmoredDefense');
    debugPrint('hasUnarmoredDefense: $hasUnarmoredDefense');
    debugPrint('calculatedAC: $calculatedAC');
    debugPrint('=== FIM DEBUG CA ===');

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _showArmorClassDialog(),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.shield, color: Colors.blue, size: 24),
              const SizedBox(height: 8),
              Text(
                'Classe de Armadura',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '$calculatedAC',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Indicador de Defesa sem Armadura
              if (hasUnarmoredDefense) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withAlpha(60)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shield_outlined, color: Colors.blue, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'Defesa sem Armadura',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // (sem uso)

  Widget _buildInfoSection(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }

  Color _getClassColor(String className) {
    switch (className.toLowerCase()) {
      case 'bárbaro':
        return Colors.red.shade600;
      case 'bardo':
        return Colors.purple.shade600;
      case 'bruxo':
        return Colors.deepPurple.shade600;
      case 'clérigo':
        return Colors.yellow.shade700;
      case 'druida':
        return Colors.green.shade600;
      case 'feiticeiro':
        return Colors.pink.shade600;
      case 'guerreiro':
        return Colors.brown.shade600;
      case 'ladino':
        return Colors.grey.shade700;
      case 'mago':
        return Colors.blue.shade600;
      case 'monge':
        return Colors.orange.shade600;
      case 'paladino':
        return Colors.amber.shade700;
      case 'patrulheiro':
        return Colors.teal.shade600;
      default:
        return Colors.indigo.shade600;
    }
  }

  Color _getAbilityColor(String abilityName) {
    switch (abilityName.toLowerCase()) {
      case 'força':
        return Colors.red.shade600;
      case 'destreza':
        return Colors.green.shade600;
      case 'constituição':
        return Colors.orange.shade600;
      case 'inteligência':
        return Colors.blue.shade600;
      case 'sabedoria':
        return Colors.purple.shade600;
      case 'carisma':
        return Colors.pink.shade600;
      default:
        return Colors.indigo.shade600;
    }
  }

  IconData _getAbilityIcon(String abilityName) {
    switch (abilityName.toLowerCase()) {
      case 'força':
        return Icons.fitness_center;
      case 'destreza':
        return Icons.sports_handball;
      case 'constituição':
        return Icons.favorite;
      case 'inteligência':
        return Icons.psychology;
      case 'sabedoria':
        return Icons.visibility;
      case 'carisma':
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  Color _getItemTypeColor(ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return Colors.red.shade600;
      case ItemType.armor:
        return Colors.blue.shade600;
      case ItemType.shield:
        return Colors.indigo.shade600;
      case ItemType.tool:
        return Colors.orange.shade600;
      case ItemType.consumable:
        return Colors.green.shade600;
      case ItemType.treasure:
        return Colors.amber.shade600;
      case ItemType.misc:
        return Colors.grey.shade600;
    }
  }

  IconData _getItemTypeIcon(ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return Icons.sports_martial_arts;
      case ItemType.armor:
        return Icons.shield;
      case ItemType.shield:
        return Icons.security;
      case ItemType.tool:
        return Icons.build;
      case ItemType.consumable:
        return Icons.local_drink;
      case ItemType.treasure:
        return Icons.diamond;
      case ItemType.misc:
        return Icons.inventory_2;
    }
  }

  void _showHitPointsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Gerenciar Pontos de Vida'),
            content: const Text(
              'A funcionalidade de edição de pontos de vida será implementada em breve!\n\n'
              'Permitirá curar, causar dano e gerenciar pontos de vida temporários.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendi'),
              ),
            ],
          ),
    );
  }

  void _showArmorClassDialog() {
    final calculatedAC = _character.getCalculatedArmorClass();
    final unarmoredDefense = _getUnarmoredDefense();
    final equippedArmor = _character.getEquippedArmor();
    final equippedShield = _character.getEquippedShield();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Classe de Armadura'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CA Calculada
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withAlpha(60)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shield, color: Colors.blue, size: 24),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CA Atual: $calculatedAC',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            if (unarmoredDefense != null)
                              Text(
                                'Defesa sem Armadura Ativa',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Detalhes do Cálculo
                  Text(
                    'Detalhes do Cálculo:',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (equippedArmor != null && equippedArmor.id.isNotEmpty) ...[
                    _buildACDetailRow('Armadura Equipada', equippedArmor.name),
                    _buildACDetailRow(
                      'CA da Armadura',
                      _extractArmorACFromDescription(equippedArmor.description),
                    ),
                  ] else if (unarmoredDefense != null) ...[
                    _buildACDetailRow('CA Base', '${unarmoredDefense['base']}'),
                    _buildACDetailRow(
                      'Atributos',
                      (unarmoredDefense['abilities'] as List).join(' + '),
                    ),
                  ] else ...[
                    _buildACDetailRow('CA Base', '10'),
                    _buildACDetailRow(
                      'Modificador de Destreza',
                      '${_character.getAbilityModifier('Destreza')}',
                    ),
                  ],

                  if (equippedShield != null &&
                      equippedShield.id.isNotEmpty) ...[
                    _buildACDetailRow('Escudo Equipado', equippedShield.name),
                    _buildACDetailRow('Bônus do Escudo', '+2'),
                  ],

                  const SizedBox(height: 16),

                  // Fórmula da Defesa sem Armadura
                  if (unarmoredDefense != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.withAlpha(60)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.green,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Defesa sem Armadura',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enquanto você não estiver vestindo armadura, sua CA é calculada como:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'CA = ${unarmoredDefense['base']} + ${(unarmoredDefense['abilities'] as List).join(' + ')}${unarmoredDefense['allows_shield'] == true ? ' + Escudo' : ''}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ],
          ),
    );
  }

  Widget _buildACDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Map<String, dynamic>? _getUnarmoredDefense() {
    if (_character.dndClass?.levelFeatures == null) return null;

    // Procurar em todas as features de nível por uma que tenha unarmored_defense
    for (final feature in _character.dndClass!.levelFeatures!) {
      if (feature.containsKey('unarmored_defense')) {
        return feature['unarmored_defense'] as Map<String, dynamic>;
      }
    }

    return null;
  }

  void _showAbilityRollDialog(String abilityName, int modifier) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Teste de $abilityName'),
            content: Text(
              'Modificador: ${modifier >= 0 ? '+' : ''}$modifier\n\n'
              'A funcionalidade de rolagem será implementada em breve!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Rolar d20'),
              ),
            ],
          ),
    );
  }

  void _showSaveRollDialog(String saveName, int modifier) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Teste de Resistência - $saveName'),
            content: Text(
              'Modificador: ${modifier >= 0 ? '+' : ''}$modifier\n\n'
              'A funcionalidade de rolagem será implementada em breve!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Rolar d20'),
              ),
            ],
          ),
    );
  }

  void _showSkillRollDialog(String skillName, int modifier) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Teste de $skillName'),
            content: Text(
              'Modificador: ${modifier >= 0 ? '+' : ''}$modifier\n\n'
              'A funcionalidade de rolagem será implementada em breve!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Rolar d20'),
              ),
            ],
          ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context, // Este é o context do seu State, que tem o .mounted
      builder:
          (dialogContext) => AddItemDialog(
            character: _character,
            onItemAdded: (item) async {
              try {
                await CharacterService.saveItems(_character.id, [
                  ..._items,
                  item,
                ]);
                await _loadItems();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao salvar item: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
    );
  }

  void _showEditItemDialog(Item item) {
    showDialog(
      context: context, // Use o context do seu State
      builder:
          (dialogContext) => EditItemDialog(
            item: item,
            onItemUpdated: (updatedItem) async {
              try {
                // Atualizar item no banco de dados
                final updatedItems =
                    _items
                        .map((i) => i.id == item.id ? updatedItem : i)
                        .toList();
                await CharacterService.saveItems(_character.id, updatedItems);
                await _loadItems(); // Recarregar itens do banco
              } catch (e) {
                // Verifique se o widget ainda está montado ANTES de usar o context
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    // Use o context do State
                    SnackBar(
                      content: Text('Erro ao atualizar item: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
    );
  }

  void _showDeleteItemDialog(Item item) {
    showDialog(
      context: context, // Este é o context do seu State
      builder:
          (dialogContext) => AlertDialog(
            // O context do AlertDialog
            title: const Text('Remover Item'),
            content: Text(
              'Tem certeza que deseja remover "${item.name}" do inventário?',
            ),
            actions: [
              TextButton(
                onPressed:
                    () =>
                        Navigator.of(
                          dialogContext,
                        ).pop(), // Use o context do dialog
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final updatedItems =
                        _items.where((i) => i.id != item.id).toList();
                    await CharacterService.saveItems(
                      _character.id,
                      updatedItems,
                    );
                    await _loadItems(); // Recarregar itens do banco

                    // Feche o diálogo ANTES de tentar exibir o SnackBar
                    // ignore: use_build_context_synchronously
                    Navigator.of(dialogContext).pop();

                    // Use o context do State e verifique `mounted`
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        // Use o context do State
                        SnackBar(
                          content: Text('${item.name} removido do inventário!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        // Use o context do State
                        SnackBar(
                          content: Text('Erro ao remover item: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Remover'),
              ),
            ],
          ),
    );
  }

  void _toggleEquipItem(Item item) async {
    try {
      // Atualizar estado local primeiro
      if (item.type == ItemType.armor) {
        // Desequipar outras armaduras antes de equipar esta
        for (var inventoryItem in _items) {
          if (inventoryItem.type == ItemType.armor &&
              inventoryItem.id != item.id) {
            inventoryItem.isEquipped = false;
          }
        }
      } else if (item.type == ItemType.shield) {
        // Desequipar outros escudos antes de equipar este
        for (var inventoryItem in _items) {
          if (inventoryItem.type == ItemType.shield &&
              inventoryItem.id != item.id) {
            inventoryItem.isEquipped = false;
          }
        }
      }

      item.isEquipped = !item.isEquipped;

      // Salvar no banco de dados
      await CharacterService.saveItems(_character.id, _items);

      // Atualizar CA do personagem
      _character.armorClass = _character.getCalculatedArmorClass();

      // Adicione a verificação `mounted` aqui
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              item.isEquipped
                  ? '${item.name} equipado! CA: ${_character.armorClass}'
                  : '${item.name} desequipado! CA: ${_character.armorClass}',
            ),
            backgroundColor: item.isEquipped ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao equipar/desequipar item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _extractArmorACFromDescription(String description) {
    final regex = RegExp(r'CA:\s*([^\n]+)');
    final match = regex.firstMatch(description);
    if (match != null) {
      return match.group(1)!.trim();
    }
    return '';
  }

  String _getItemBriefDescription(Item item) {
    // Para armaduras, mostrar CA
    if (item.type == ItemType.armor && item.description.contains('CA:')) {
      final ac = _extractArmorACFromDescription(item.description);
      return 'CA: $ac';
    }

    // Para escudos, mostrar bônus
    if (item.type == ItemType.shield) {
      return '+2 CA';
    }

    // Para outros itens, mostrar tipo e peso
    return '${_getItemTypeName(item.type)} • ${item.weight} lbs';
  }

  String _getItemTypeName(ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return 'Arma';
      case ItemType.armor:
        return 'Armadura';
      case ItemType.shield:
        return 'Escudo';
      case ItemType.tool:
        return 'Ferramenta';
      case ItemType.consumable:
        return 'Consumível';
      case ItemType.treasure:
        return 'Tesouro';
      case ItemType.misc:
        return 'Diversos';
    }
  }

  Widget _buildInventoryInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Calcular peso total dos itens carregados
  double get _totalWeight {
    return _items.fold(0.0, (sum, item) => sum + (item.weight * item.quantity));
  }

  // Calcular capacidade de carga (Força × 15)
  int get _carryingCapacity {
    final strengthScore = _character.abilityScores['Força'] ?? 10;
    return strengthScore * 15;
  }

  Widget _buildInventoryStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Capacidade:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          '${_totalWeight.toStringAsFixed(1)} / $_carryingCapacity lbs',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAbilitiesTab() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            isScrollable: false,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            tabAlignment: TabAlignment.center,
            tabs: const [
              Tab(icon: Icon(Icons.pets), text: 'Raça'),
              Tab(icon: Icon(Icons.class_), text: 'Classe'),
              Tab(icon: Icon(Icons.history), text: 'Origem'),
              Tab(icon: Icon(Icons.star), text: 'Talentos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRaceAbilitiesTab(),
                _buildClassAbilitiesTab(),
                _buildBackgroundAbilitiesTab(),
                _buildFeatsAbilitiesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRaceAbilitiesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _loadRaceFromDatabase(_character.race),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint('Erro ao carregar raça: ${snapshot.error}');
            return _buildErrorCard(
              'Erro ao carregar habilidades da raça',
              snapshot.error.toString(),
            );
          }

          final raceData = snapshot.data;
          if (raceData == null) {
            return _buildWarningCard('Raça não encontrada: ${_character.race}');
          }

          // Carregar traços da raça - usar traits_text se traits for null
          final traitsRaw = raceData['traits'];
          final traitsTextRaw = raceData['traits_text'];
          List<dynamic> traits = [];

          // Se traits é null, usar traits_text
          if (traitsRaw == null && traitsTextRaw != null) {
            // Converter traits_text (String) em lista de objetos
            final traitsText = traitsTextRaw as String;
            final lines =
                traitsText
                    .split('\n')
                    .where((line) => line.trim().isNotEmpty)
                    .toList();

            traits =
                lines.map((line) {
                  final parts = line.split(':');
                  if (parts.length >= 2) {
                    return {
                      'name': parts[0].trim(),
                      'description': parts.sublist(1).join(':').trim(),
                    };
                  } else {
                    return {'name': 'Traço', 'description': line.trim()};
                  }
                }).toList();
          } else if (traitsRaw is String) {
            try {
              traits = jsonDecode(traitsRaw) as List<dynamic>;
            } catch (e) {
              traits = [];
            }
          } else if (traitsRaw is List<dynamic>) {
            traits = traitsRaw;
          }

          if (traits.isEmpty) {
            return _buildInfoCard('Nenhuma habilidade de raça disponível');
          }

          return Column(
            children:
                traits
                    .map(
                      (trait) => _buildAbilityCard(
                        trait['name'] ?? 'Traço',
                        trait['description'] ?? 'Descrição não disponível',
                        Colors.green,
                        Icons.pets,
                        meta: '${raceData['name']} • Raça',
                        abilityData:
                            trait, // Passar dados para cálculo automático
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _buildClassAbilitiesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _loadClassFromDatabase(_character.className),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint('Erro ao carregar classe: ${snapshot.error}');
            return _buildErrorCard(
              'Erro ao carregar habilidades da classe',
              snapshot.error.toString(),
            );
          }

          final classData = snapshot.data;
          if (classData == null) {
            return _buildWarningCard(
              'Classe não encontrada: ${_character.className}',
            );
          }

          // Carregar habilidades do nível atual
          final levelFeaturesRaw = classData['level_features'];
          List<dynamic> levelFeatures = [];

          // Parse das level_features se for String
          if (levelFeaturesRaw is String) {
            try {
              levelFeatures = jsonDecode(levelFeaturesRaw) as List<dynamic>;
            } catch (e) {
              levelFeatures = [];
            }
          } else if (levelFeaturesRaw is List<dynamic>) {
            levelFeatures = levelFeaturesRaw;
          }

          final currentLevelFeatures =
              levelFeatures.where((feature) {
                  final lvl = feature['level'] as int?;
                  return lvl != null && lvl <= _character.level;
                }).toList()
                ..sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );

          // Carregar características das subclasses
          List<dynamic> subclassFeatures = [];
          final subclassesDetails = classData['subclasses_details'];
          if (subclassesDetails != null) {
            List<dynamic> subclasses = [];
            if (subclassesDetails is String) {
              try {
                subclasses = jsonDecode(subclassesDetails) as List<dynamic>;
              } catch (e) {
                subclasses = [];
              }
            } else if (subclassesDetails is List<dynamic>) {
              subclasses = subclassesDetails;
            }

            // Coletar todas as características das subclasses do nível atual
            for (final subclass in subclasses) {
              final features = subclass['features'] as List<dynamic>? ?? [];
              for (final feature in features) {
                final level = feature['level'] as int?;
                if (level != null && level <= _character.level) {
                  subclassFeatures.add(feature);
                }
              }
            }
          }

          // removido UD

          if (currentLevelFeatures.isEmpty) {
            return _buildInfoCard(
              'Nenhuma habilidade disponível no nível ${_character.level}',
            );
          }

          return Column(
            children:
                currentLevelFeatures.map((feature) {
                  final card = _buildAbilityCard(
                    feature['name'] ?? 'Habilidade',
                    feature['description'] ?? 'Descrição não disponível',
                    Colors.purple,
                    Icons.class_,
                    meta: '${classData['name']} • Nível ${feature['level']}',
                    abilityData: feature,
                  );
                  return card;
                }).toList(),
          );
        },
      ),
    );
  }

  int _getSpellSlotsFromDatabase(int spellLevel) {
    // Buscar dados da classe do cache ou carregar
    final classData = _classDataCache;
    if (classData == null) return 0;

    final spellSlotsLevels = classData['spell_slots_levels'] as List<dynamic>?;
    if (spellSlotsLevels == null) return 0;

    // Encontrar o nível correspondente ao personagem
    for (final slotLevel in spellSlotsLevels) {
      final slotLevelNum = slotLevel['level'] as int? ?? 0;
      if (slotLevelNum == _character.level) {
        // Obter slots para o nível específico (level_1, level_2, etc.)
        final slotKey = 'level_$spellLevel';
        final slots = slotLevel[slotKey] as int? ?? 0;
        debugPrint(
          '_getSpellSlotsFromDatabase: characterLevel=${_character.level}, spellLevel=$spellLevel, slots=$slots',
        );
        return slots;
      }
    }

    return 0;
  }

  Map<String, dynamic>? _classDataCache;
  final Map<int, int> _usedSpellSlots = {};
  final Map<String, int> _usedAbilityUses = {}; // level -> used slots
  final Map<String, bool> _additionalFeaturesEnabled =
      {}; // habilidade -> ativada

  int _getUsedSpellSlots(int level) {
    return _usedSpellSlots[level] ?? 0;
  }

  Widget _buildSpellSlotsCounter(int level, int totalSlots, int usedSlots) {
    if (totalSlots == 0) return const SizedBox.shrink();

    return _SpellSlotsCounter(
      level: level,
      totalSlots: totalSlots,
      initialUsedSlots: usedSlots,
      onChanged: (newUsedSlots) {
        _usedSpellSlots[level] = newUsedSlots;
      },
    );
  }

  Future<Map<String, dynamic>?> _loadClassFromDatabase(String className) async {
    try {
      final supabase = SupabaseService.client;
      final response =
          await supabase
              .from('classes')
              .select()
              .eq('name', className)
              .single();

      // Cache dos dados da classe
      _classDataCache = response;
      return response;
    } catch (e) {
      debugPrint('Erro ao carregar classe: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _loadRaceFromDatabase(String raceName) async {
    try {
      final supabase = SupabaseService.client;
      final response =
          await supabase.from('races').select().eq('name', raceName).single();

      return response;
    } catch (e) {
      debugPrint('Erro ao carregar raça: $e');
      rethrow;
    }
  }

  // método de teste removido

  Future<Map<String, dynamic>?> _loadBackgroundFromDatabase(
    String backgroundName,
  ) async {
    try {
      final supabase = SupabaseService.client;
      final response =
          await supabase
              .from('backgrounds')
              .select()
              .eq('name', backgroundName)
              .single();

      return response;
    } catch (e) {
      debugPrint('Erro ao carregar antecedente: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _loadBackgroundFeatFromDatabase() async {
    try {
      final supabase = SupabaseService.client;

      // Primeiro, carregar o antecedente para obter o feat_id
      final backgroundResponse =
          await supabase
              .from('backgrounds')
              .select('feat_id, feat')
              .eq('name', _character.background)
              .single();

      final featId = backgroundResponse['feat_id'] as String?;
      final featName = backgroundResponse['feat'] as String?;

      if (featId != null) {
        // Se tem feat_id, carregar o talento completo da tabela feats
        final featResponse =
            await supabase.from('feats').select().eq('id', featId).single();

        return featResponse;
      } else if (featName != null && featName.isNotEmpty) {
        // Se não tem feat_id mas tem nome do feat, tentar encontrar por nome
        try {
          final featResponse =
              await supabase
                  .from('feats')
                  .select()
                  .eq('name', featName)
                  .single();

          return featResponse;
        } catch (e) {
          // Se não encontrar na tabela feats, criar uma entrada simples
          return {
            'name': featName,
            'description':
                'Talento obtido pela origem ${_character.background}',
          };
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Erro ao carregar talento da origem: $e');
      rethrow;
    }
  }

  Widget _buildBackgroundAbilitiesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Conteúdo das habilidades
          FutureBuilder<Map<String, dynamic>?>(
            future: _loadBackgroundFromDatabase(_character.background),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                debugPrint('Erro ao carregar antecedente: ${snapshot.error}');
                return _buildErrorCard(
                  'Erro ao carregar habilidades do antecedente',
                  snapshot.error.toString(),
                );
              }

              final backgroundData = snapshot.data;
              if (backgroundData == null) {
                return _buildWarningCard(
                  'Antecedente não encontrado: ${_character.background}',
                );
              }

              // Regras de fallback: backgrounds podem ter vários formatos
              final List<Widget> widgets = [];

              // 1) Campo feature (string única)
              final feature = backgroundData['feature'] as String?;
              final featureName =
                  (backgroundData['feature_name'] as String?) ??
                  'Habilidade de Origem';
              final featureDescription =
                  (backgroundData['feature_description'] as String?);

              String? abilityText;
              if (feature != null && feature.isNotEmpty) {
                abilityText = feature;
              } else if (featureDescription != null &&
                  featureDescription.isNotEmpty) {
                abilityText = featureDescription;
              }

              if (abilityText != null && abilityText.isNotEmpty) {
                widgets.add(
                  _buildAbilityCard(
                    featureName,
                    abilityText,
                    Colors.brown,
                    Icons.history,
                    meta: '${backgroundData['name']} • Origem',
                  ),
                );
              }

              // 2) Campo features (lista ou JSON em string)
              final rawFeatures = backgroundData['features'];
              List<dynamic> featuresList = [];
              if (rawFeatures is String && rawFeatures.isNotEmpty) {
                try {
                  featuresList = jsonDecode(rawFeatures) as List<dynamic>;
                } catch (_) {}
              } else if (rawFeatures is List) {
                featuresList = rawFeatures;
              }
              for (final f in featuresList) {
                final name =
                    (f is Map && f['name'] != null)
                        ? f['name'] as String
                        : 'Habilidade de Origem';
                final desc =
                    (f is Map && f['description'] != null)
                        ? f['description'] as String
                        : (f is String ? f : '');
                if (desc.isNotEmpty) {
                  widgets.add(
                    _buildAbilityCard(
                      name,
                      desc,
                      Colors.brown,
                      Icons.history,
                      meta: '${backgroundData['name']} • Origem',
                    ),
                  );
                }
              }

              // 3) Se ainda vazio e houver talento de origem, mostra APENAS o nome do talento
              if (widgets.isEmpty) {
                return FutureBuilder<Map<String, dynamic>?>(
                  future: _loadBackgroundFeatFromDatabase(),
                  builder: (context, featSnap) {
                    if (featSnap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final feat = featSnap.data;
                    if (feat != null) {
                      final String featName =
                          (feat['name'] as String?)?.trim().isNotEmpty == true
                              ? (feat['name'] as String)
                              : 'Talento da Origem';
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.star, color: Colors.orange),
                          title: Text(
                            featName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return _buildInfoCard(
                      'Nenhuma habilidade de origem disponível',
                    );
                  },
                );
              }

              return Column(children: widgets);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatsAbilitiesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _loadBackgroundFeatFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint('Erro ao carregar talento da origem: ${snapshot.error}');
            return _buildErrorCard(
              'Erro ao carregar talento da origem',
              snapshot.error.toString(),
            );
          }

          final featData = snapshot.data;
          if (featData == null) {
            return _buildInfoCard('Nenhum talento de origem disponível');
          }

          // Exibir cartão de Talento com seções ao expandir (abilities)
          return _buildFeatCard(
            featData,
            color: Colors.orange,
            icon: Icons.star,
          );
        },
      ),
    );
  }

  // --- Card especializado para Talentos (nome no título e seções ao expandir) ---
  Widget _buildFeatCard(
    Map<String, dynamic> featData, {
    required Color color,
    required IconData icon,
  }) {
    final String title =
        (featData['name'] as String?)?.trim().isNotEmpty == true
            ? (featData['name'] as String)
            : 'Talento';

    // Tentar obter lista de abilities estruturadas; aceitar String JSON também
    List<dynamic> abilities = [];
    final rawAbilities = featData['abilities'];
    if (rawAbilities is String && rawAbilities.isNotEmpty) {
      try {
        abilities = jsonDecode(rawAbilities) as List<dynamic>;
      } catch (_) {}
    } else if (rawAbilities is List) {
      abilities = rawAbilities;
    }

    final String? description = (featData['description'] as String?)?.trim();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (abilities.isNotEmpty)
                  ...abilities.map((a) {
                    // Cada seção: nome, descrição e extras
                    String secName = '';
                    String secDesc = '';
                    List<dynamic> extras = const [];
                    if (a is Map) {
                      secName = (a['name']?.toString() ?? '').trim();
                      secDesc = (a['description']?.toString() ?? '').trim();
                      final rawExtras = a['extras'];
                      if (rawExtras is String && rawExtras.isNotEmpty) {
                        try {
                          extras = jsonDecode(rawExtras) as List<dynamic>;
                        } catch (_) {}
                      } else if (rawExtras is List) {
                        extras = rawExtras;
                      }
                    } else if (a is String) {
                      secDesc = a;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (secName.isNotEmpty)
                            Text(
                              secName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          if (secDesc.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(secDesc, style: const TextStyle(fontSize: 13)),
                          ],
                          if (extras.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children:
                                  extras
                                      .map((e) {
                                        String label = '';
                                        String value = '';
                                        if (e is Map) {
                                          label =
                                              (e['label']?.toString() ?? '')
                                                  .trim();
                                          value =
                                              (e['value']?.toString() ?? '')
                                                  .trim();
                                        }
                                        final chipText =
                                            label.isNotEmpty && value.isNotEmpty
                                                ? '$label: $value'
                                                : (label.isNotEmpty
                                                    ? label
                                                    : value);
                                        if (chipText.isEmpty) {
                                          return const SizedBox();
                                        }
                                        return Chip(
                                          label: Text(
                                            chipText,
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                          backgroundColor: color.withAlpha(20),
                                          side: BorderSide(
                                            color: color.withAlpha(80),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        );
                                      })
                                      .whereType<Widget>()
                                      .toList(),
                            ),
                          ],
                        ],
                      ),
                    );
                  })
                else if (description != null && description.isNotEmpty) ...[
                  Text(description, style: const TextStyle(fontSize: 14)),
                ] else ...[
                  const Text(
                    'Sem detalhes disponíveis',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilityCard(
    String name,
    String description,
    Color color,
    IconData icon, {
    String? meta,
    Map<String, dynamic>? abilityData,
  }) {
    // Debug da habilidade se o modo debug estiver ativo
    _debugAbility(name, abilityData);

    // Usar o AbilityCalculator para cálculo automático
    AbilityCalculation? calculation;
    if (abilityData != null) {
      calculation = AbilityCalculator.calculateAbility(abilityData, _character);
    }

    final hasUsageLimit =
        calculation?.type == AbilityType.usageLimit ||
        calculation?.type == AbilityType.both;
    final hasDiceIncrease =
        calculation?.type == AbilityType.diceIncrease ||
        calculation?.type == AbilityType.both;
    final totalUses = calculation?.currentUses ?? 0;
    final currentDie = hasDiceIncrease ? calculation?.currentDie : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            if (_debugMode) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.bug_report,
                  size: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ],
        ),
        title: _buildAbilityTitle(
          name: name,
          hasUsageLimit: hasUsageLimit && totalUses > 0,
          buildCounter:
              (hasUsageLimit && totalUses > 0) || hasDiceIncrease
                  ? _buildUsageCounter(
                    name,
                    totalUses,
                    color,
                    dieLabel: currentDie,
                  )
                  : null,
          meta: meta,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description, style: const TextStyle(fontSize: 14)),
                if (hasUsageLimit && totalUses > 0) ...[
                  const SizedBox(height: 12),
                  _buildUsageInfo(calculation!),
                ],

                // Funcionalidades adicionais
                if (calculation?.hasAdditionalFeatures == true) ...[
                  const SizedBox(height: 12),
                  _buildAdditionalFeatures(calculation!),
                ],

                // Debug info (apenas quando debug mode estiver ativo)
                if (_debugMode) ...[
                  const SizedBox(height: 12),
                  _buildDebugInfo(name, abilityData, calculation),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilityTitle({
    required String name,
    required bool hasUsageLimit,
    required Widget? buildCounter,
    String? meta,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 480;
        final titleText = Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );

        final metaText =
            meta == null
                ? null
                : Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                );

        if (!hasUsageLimit) {
          return Row(
            children: [
              Expanded(child: titleText),
              if (metaText != null) metaText,
            ],
          );
        }

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: titleText),
                  if (metaText != null) metaText,
                ],
              ),
              const SizedBox(height: 6),
              Align(alignment: Alignment.centerLeft, child: buildCounter!),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: titleText),
            if (metaText != null) metaText,
            const SizedBox(width: 8),
            buildCounter!,
          ],
        );
      },
    );
  }

  Widget _buildUsageCounter(
    String abilityName,
    int totalUses,
    Color color, {
    String? dieLabel,
  }) {
    final usedUses = _usedAbilityUses[abilityName] ?? 0;

    return _AbilityUsageCounter(
      abilityName: abilityName,
      totalUses: totalUses,
      initialUsedUses: usedUses,
      color: color,
      dieLabel: dieLabel,
      onChanged: (newUsedUses) {
        _usedAbilityUses[abilityName] = newUsedUses;
      },
    );
  }

  Widget _buildUsageInfo(AbilityCalculation calculation) {
    final abilityData = calculation.calculationData;
    final usageType = abilityData['usage_type'] as String?;
    final usageAttribute = abilityData['usage_attribute'] as String?;
    final usageRecovery = calculation.recoveryType;
    final initialDice = abilityData['initial_dice'] as String?;
    final diceIncreases = abilityData['dice_increases'] as List<dynamic>?;
    final hasDiceIncrease =
        calculation.type == AbilityType.diceIncrease ||
        calculation.type == AbilityType.both;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações de Uso',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          if (usageType != null) _buildInfoRow('Tipo de Uso', usageType),
          if (usageAttribute != null) _buildInfoRow('Atributo', usageAttribute),
          if (usageRecovery.isNotEmpty)
            _buildInfoRow('Recuperação', usageRecovery),
          if (hasDiceIncrease && initialDice != null)
            _buildInfoRow('Dado Inicial', initialDice),
          if (calculation.currentDie.isNotEmpty)
            _buildInfoRow('Dado Atual', calculation.currentDie),
          if (hasDiceIncrease &&
              diceIncreases != null &&
              diceIncreases.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Melhorias do Dado:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            ...diceIncreases.map(
              (increase) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Text(
                  'Nível ${increase['level']}: ${increase['dice']}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildAdditionalFeatures(AbilityCalculation calculation) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Funcionalidades Adicionais',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Checkbox para ativar/desativar
          CheckboxListTile(
            title: Text(
              calculation.additionalFeatureName ?? 'Funcionalidade Extra',
              style: const TextStyle(fontSize: 14),
            ),
            subtitle:
                calculation.additionalFeatureDescription != null
                    ? Text(
                      calculation.additionalFeatureDescription!,
                      style: const TextStyle(fontSize: 12),
                    )
                    : null,
            value: _additionalFeaturesEnabled[calculation.name] ?? false,
            onChanged: (value) {
              setState(() {
                _additionalFeaturesEnabled[calculation.name] = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String title, String error) {
    return Card(
      color: Colors.red.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.error, color: Colors.red),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              error,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningCard(String message) {
    return Card(
      color: Colors.orange.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            const SizedBox(height: 8),
            Text(message, style: TextStyle(color: Colors.orange[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String message) {
    return Card(
      color: Colors.blue.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.info, color: Colors.blue),
            const SizedBox(height: 8),
            Text(message, style: TextStyle(color: Colors.blue[700])),
          ],
        ),
      ),
    );
  }

  // Métodos para gerenciar moedas

  Widget _buildEditableCurrencyCard(
    String label,
    int value,
    Color color,
    Function(int) onChanged, {
    bool compact = false,
  }) {
    return InkWell(
      onTap: () => _showSingleCurrencyDialog(label, value, color, onChanged),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 6,
          vertical: compact ? 3 : 4,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(50),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 10 : 12,
              height: compact ? 10 : 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text(
              '$label: $value',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.edit,
              size: compact ? 9 : 10,
              color: color.withAlpha(150),
            ),
          ],
        ),
      ),
    );
  }

  String _getTotalCurrencyValue() {
    // Conversão: 1 PL = 10 PO, 1 PE = 0.5 PO, 1 PP = 0.1 PO, 1 PC = 0.01 PO
    final totalInGold =
        _character.platinumPieces * 10 +
        _character.goldPieces +
        _character.electrumPieces * 0.5 +
        _character.silverPieces * 0.1 +
        _character.copperPieces * 0.01;
    return totalInGold.toStringAsFixed(2);
  }

  void _showCurrencyDialog() {
    final plController = TextEditingController(
      text: _character.platinumPieces.toString(),
    );
    final poController = TextEditingController(
      text: _character.goldPieces.toString(),
    );
    final peController = TextEditingController(
      text: _character.electrumPieces.toString(),
    );
    final ppController = TextEditingController(
      text: _character.silverPieces.toString(),
    );
    final pcController = TextEditingController(
      text: _character.copperPieces.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Editar Dinheiro'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCurrencyInputField(
                    'Platina (PL)',
                    plController,
                    Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  _buildCurrencyInputField(
                    'Ouro (PO)',
                    poController,
                    Colors.amber,
                  ),
                  const SizedBox(height: 12),
                  _buildCurrencyInputField(
                    'Electrum (PE)',
                    peController,
                    Colors.amber.shade300,
                  ),
                  const SizedBox(height: 12),
                  _buildCurrencyInputField(
                    'Prata (PP)',
                    ppController,
                    Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  _buildCurrencyInputField(
                    'Cobre (PC)',
                    pcController,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  _updateCurrency(
                    int.tryParse(plController.text) ?? 0,
                    int.tryParse(poController.text) ?? 0,
                    int.tryParse(peController.text) ?? 0,
                    int.tryParse(ppController.text) ?? 0,
                    int.tryParse(pcController.text) ?? 0,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }

  Widget _buildCurrencyInputField(
    String label,
    TextEditingController controller,
    Color color,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _updateCurrency(int pl, int po, int pe, int pp, int pc) async {
    try {
      final updatedCharacter = Character(
        id: _character.id,
        userId: _character.userId,
        name: _character.name,
        race: _character.race,
        className: _character.className,
        background: _character.background,
        level: _character.level,
        abilityScores: _character.abilityScores,
        skills: _character.skills,
        inventory: _character.inventory,
        currentHitPoints: _character.currentHitPoints,
        maxHitPoints: _character.maxHitPoints,
        temporaryHitPoints: _character.temporaryHitPoints,
        armorClass: _character.armorClass,
        speed: _character.speed,
        alignment: _character.alignment,
        experiencePoints: _character.experiencePoints,
        languages: _character.languages,
        proficiencies: _character.proficiencies,
        dndClass: _character.dndClass,
        selectedCantrips: _character.selectedCantrips,
        selectedSpells: _character.selectedSpells,
        knownSpells: _character.knownSpells,
        customAbilities: _character.customAbilities,
        personalityTraits: _character.personalityTraits,
        ideals: _character.ideals,
        bonds: _character.bonds,
        flaws: _character.flaws,
        createdAt: _character.createdAt,
        updatedAt: _character.updatedAt,
        platinumPieces: pl,
        goldPieces: po,
        electrumPieces: pe,
        silverPieces: pp,
        copperPieces: pc,
      );

      await CharacterService.saveCharacter(updatedCharacter);

      setState(() {
        _character = updatedCharacter;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dinheiro atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar dinheiro: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showSingleCurrencyDialog(
    String label,
    int currentValue,
    Color color,
    Function(int) onChanged,
  ) {
    final controller = TextEditingController(text: currentValue.toString());

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Editar $label'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: color, width: 2),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newValue = int.tryParse(controller.text) ?? 0;
                  onChanged(newValue);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _updateSingleCurrency(String currencyType, int newValue) async {
    try {
      final updatedCharacter = Character(
        id: _character.id,
        userId: _character.userId,
        name: _character.name,
        race: _character.race,
        className: _character.className,
        background: _character.background,
        level: _character.level,
        abilityScores: _character.abilityScores,
        skills: _character.skills,
        inventory: _character.inventory,
        currentHitPoints: _character.currentHitPoints,
        maxHitPoints: _character.maxHitPoints,
        temporaryHitPoints: _character.temporaryHitPoints,
        armorClass: _character.armorClass,
        speed: _character.speed,
        alignment: _character.alignment,
        experiencePoints: _character.experiencePoints,
        languages: _character.languages,
        proficiencies: _character.proficiencies,
        dndClass: _character.dndClass,
        selectedCantrips: _character.selectedCantrips,
        selectedSpells: _character.selectedSpells,
        knownSpells: _character.knownSpells,
        customAbilities: _character.customAbilities,
        personalityTraits: _character.personalityTraits,
        ideals: _character.ideals,
        bonds: _character.bonds,
        flaws: _character.flaws,
        createdAt: _character.createdAt,
        updatedAt: _character.updatedAt,
        platinumPieces:
            currencyType == 'platinum' ? newValue : _character.platinumPieces,
        goldPieces: currencyType == 'gold' ? newValue : _character.goldPieces,
        electrumPieces:
            currencyType == 'electrum' ? newValue : _character.electrumPieces,
        silverPieces:
            currencyType == 'silver' ? newValue : _character.silverPieces,
        copperPieces:
            currencyType == 'copper' ? newValue : _character.copperPieces,
      );

      await CharacterService.saveCharacter(updatedCharacter);

      setState(() {
        _character = updatedCharacter;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_getCurrencyName(currencyType)} atualizado para $newValue',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao atualizar ${_getCurrencyName(currencyType)}: $e',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getCurrencyName(String currencyType) {
    switch (currencyType) {
      case 'platinum':
        return 'Platina (PL)';
      case 'gold':
        return 'Ouro (PO)';
      case 'electrum':
        return 'Electrum (PE)';
      case 'silver':
        return 'Prata (PP)';
      case 'copper':
        return 'Cobre (PC)';
      default:
        return 'Moeda';
    }
  }
}

class EditItemDialog extends StatefulWidget {
  final Item item;
  final Function(Item) onItemUpdated;

  const EditItemDialog({
    super.key,
    required this.item,
    required this.onItemUpdated,
  });

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  late TextEditingController _weightController;
  late TextEditingController _valueController;
  late ItemType _selectedType;
  late bool _isEquipped;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _descriptionController = TextEditingController(
      text: widget.item.description,
    );
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    _weightController = TextEditingController(
      text: widget.item.weight.toString(),
    );
    _valueController = TextEditingController(
      text: widget.item.value.toString(),
    );
    _selectedType = widget.item.type;
    _isEquipped = widget.item.isEquipped;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _weightController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome do item é obrigatório!')),
      );
      return;
    }

    final updatedItem = Item(
      id: widget.item.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      quantity: int.tryParse(_quantityController.text) ?? 1,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      value: int.tryParse(_valueController.text) ?? 0,
      type: _selectedType,
      isEquipped: _isEquipped,
    );

    widget.onItemUpdated(updatedItem);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${updatedItem.name} atualizado!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Editar Item',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Nome
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Descrição
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            // Quantidade e Peso
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Peso (lbs)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Valor e Tipo
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _valueController,
                    decoration: const InputDecoration(
                      labelText: 'Valor (moedas de cobre)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<ItemType>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ItemType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(_getItemTypeName(type)),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Equipado
            CheckboxListTile(
              title: const Text('Equipado'),
              value: _isEquipped,
              onChanged: (value) {
                setState(() {
                  _isEquipped = value ?? false;
                });
              },
            ),

            const SizedBox(height: 16),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _saveItem,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getItemTypeName(ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return 'Arma';
      case ItemType.armor:
        return 'Armadura';
      case ItemType.shield:
        return 'Escudo';
      case ItemType.tool:
        return 'Ferramenta';
      case ItemType.consumable:
        return 'Consumível';
      case ItemType.treasure:
        return 'Tesouro';
      case ItemType.misc:
        return 'Diversos';
    }
  }
}

class AddItemDialog extends StatefulWidget {
  final Character character;
  final Function(Item) onItemAdded;

  const AddItemDialog({
    super.key,
    required this.character,
    required this.onItemAdded,
  });

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  List<Equipment> _equipment = [];
  List<Equipment> _filteredEquipment = [];
  String _searchQuery = '';
  String _selectedCategory = 'Todas';

  @override
  void initState() {
    super.initState();
    _loadEquipment();
  }

  Future<void> _loadEquipment() async {
    try {
      final equipment = await EquipmentService.loadAll();
      setState(() {
        _equipment = equipment;
        _filteredEquipment = equipment;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar equipamentos: $e')),
        );
      }
    }
  }

  void _filterEquipment() {
    setState(() {
      _filteredEquipment =
          _equipment.where((equipment) {
            final matchesSearch = equipment.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
            final matchesCategory =
                _selectedCategory == 'Todas' ||
                equipment.category == _selectedCategory;
            return matchesSearch && matchesCategory;
          }).toList();
    });
  }

  List<String> get _categories {
    final categories = _equipment.map((e) => e.category).toSet().toList();
    categories.sort();
    return ['Todas', ...categories];
  }

  ItemType _getItemTypeFromEquipment(Equipment equipment) {
    if (equipment.isArmor) {
      return ItemType.armor;
    } else if (equipment.isShield) {
      return ItemType.shield;
    } else if (equipment.category == 'Arma') {
      return ItemType.weapon;
    } else {
      return ItemType.tool;
    }
  }

  double _parseWeight(String? weight) {
    if (weight == null || weight == '-') return 0.0;
    final cleanWeight = weight.replaceAll(RegExp(r'[^\d,.]'), '');
    return double.tryParse(cleanWeight.replaceAll(',', '.')) ?? 0.0;
  }

  int _parseCost(String? cost) {
    if (cost == null) return 0;
    // Converter para moedas de cobre
    if (cost.contains('pl')) {
      return (double.tryParse(
                cost.replaceAll(RegExp(r'[^\d,.]'), '').replaceAll(',', '.'),
              ) ??
              0.0 * 1000)
          .round();
    } else if (cost.contains('po')) {
      return (double.tryParse(
                cost.replaceAll(RegExp(r'[^\d,.]'), '').replaceAll(',', '.'),
              ) ??
              0.0 * 100)
          .round();
    } else if (cost.contains('pp')) {
      return (double.tryParse(
                cost.replaceAll(RegExp(r'[^\d,.]'), '').replaceAll(',', '.'),
              ) ??
              0.0 * 10)
          .round();
    } else if (cost.contains('pc')) {
      return (double.tryParse(
                cost.replaceAll(RegExp(r'[^\d,.]'), '').replaceAll(',', '.'),
              ) ??
              0.0)
          .round();
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adicionar Item',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Filtros responsivos
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 400) {
                  // Layout vertical para telas pequenas
                  return Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Pesquisar...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _searchQuery = value;
                          _filterEquipment();
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        items:
                            _categories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                          _filterEquipment();
                        },
                      ),
                    ],
                  );
                } else {
                  // Layout horizontal para telas maiores
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Pesquisar equipamento...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _searchQuery = value;
                            _filterEquipment();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        items:
                            _categories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                          _filterEquipment();
                        },
                      ),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // Lista de equipamentos
            Expanded(
              child:
                  _equipment.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: _filteredEquipment.length,
                        itemBuilder: (context, index) {
                          final equipment = _filteredEquipment[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                equipment.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (equipment.description != null)
                                    Text(
                                      equipment.description!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: [
                                      if (equipment.cost != null)
                                        Chip(
                                          label: Text(
                                            'Custo: ${equipment.cost}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      if (equipment.weight != null)
                                        Chip(
                                          label: Text(
                                            'Peso: ${equipment.weight}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth < 300) {
                                    // Botão compacto para telas muito pequenas
                                    return IconButton(
                                      onPressed:
                                          () => _addEquipmentToInventory(
                                            equipment,
                                          ),
                                      icon: const Icon(Icons.add),
                                      tooltip: 'Adicionar',
                                      style: IconButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    );
                                  } else {
                                    // Botão com texto para telas maiores
                                    return ElevatedButton(
                                      onPressed:
                                          () => _addEquipmentToInventory(
                                            equipment,
                                          ),
                                      child: const Text('Adicionar'),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
            ),

            const SizedBox(height: 16),

            // Botão fechar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addEquipmentToInventory(Equipment equipment) {
    // Construir descrição com informações completas se for armadura
    String description = equipment.description ?? '';
    if (equipment.isArmor && equipment.armorClass != null) {
      description = 'CA: ${equipment.armorClass}';

      // Adicionar força necessária se houver
      if (equipment.strengthRequirement != null) {
        description += '\nForça: ${equipment.strengthRequirement}';
      }

      // Adicionar penalidade de furtividade se houver
      if (equipment.stealthPenalty != null) {
        description += '\nFurtividade: ${equipment.stealthPenalty}';
      }

      // Adicionar descrição original
      if (equipment.description != null && equipment.description!.isNotEmpty) {
        description += '\n${equipment.description}';
      }
    }

    final item = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: equipment.name,
      description: description,
      quantity: 1,
      weight: _parseWeight(equipment.weight),
      value: _parseCost(equipment.cost),
      type: _getItemTypeFromEquipment(equipment),
    );

    widget.onItemAdded(item);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${equipment.name} adicionado ao inventário!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _AddSpellDialog extends StatefulWidget {
  final Character character;
  final Function(Spell) onSpellAdded;

  const _AddSpellDialog({required this.character, required this.onSpellAdded});

  @override
  State<_AddSpellDialog> createState() => _AddSpellDialogState();
}

class _AddSpellDialogState extends State<_AddSpellDialog> {
  List<Spell> _availableSpells = [];
  List<Spell> _filteredSpells = [];
  bool _isLoading = true;
  String _searchQuery = '';
  int? _selectedLevel;

  @override
  void initState() {
    super.initState();
    _loadAvailableSpells();
  }

  Future<void> _loadAvailableSpells() async {
    try {
      final spellsData = await SupabaseService.getSpells();

      if (spellsData.isEmpty) {
        setState(() {
          _availableSpells = [];
          _filteredSpells = [];
          _isLoading = false;
        });
        return;
      }

      final spells =
          spellsData
              .map((data) {
                try {
                  return Spell.fromJson(data);
                } catch (e) {
                  debugPrint(
                    '_AddSpellDialog: Erro ao converter magia ${data['name']}: $e',
                  );
                  return null;
                }
              })
              .where((spell) => spell != null)
              .cast<Spell>()
              .toList();

      debugPrint(
        '_AddSpellDialog: ${spells.length} magias convertidas com sucesso',
      );

      setState(() {
        _availableSpells = spells;
        _filteredSpells = spells;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('_AddSpellDialog: Erro ao carregar magias: $e');
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar magias: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _filterSpells() {
    setState(() {
      _filteredSpells =
          _availableSpells.where((spell) {
            final matchesSearch =
                spell.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                spell.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );
            final matchesLevel =
                _selectedLevel == null || spell.level == _selectedLevel;
            final notAlreadyKnown =
                !widget.character.knownSpells.any(
                  (known) => known.name == spell.name,
                );

            return matchesSearch && matchesLevel && notAlreadyKnown;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            // Cabeçalho
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Adicionar Magia',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),

            // Filtros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Buscar magia',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      _filterSpells();
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: _selectedLevel,
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nível',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Todos os níveis'),
                      ),
                      ...List.generate(9, (i) => i + 1).map(
                        (level) => DropdownMenuItem(
                          value: level,
                          child: Text('Nível $level'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value;
                      });
                      _filterSpells();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Lista de magias
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredSpells.isEmpty
                      ? const Center(
                        child: Text(
                          'Nenhuma magia encontrada',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _filteredSpells.length,
                        itemBuilder: (context, index) {
                          final spell = _filteredSpells[index];
                          return ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            minLeadingWidth: 32,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo.withAlpha(32),
                              child: Text(
                                '${spell.level}',
                                style: const TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              spell.name,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nível ${spell.level} • ${spell.school}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (spell.description.isNotEmpty)
                                  Text(
                                    spell.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Detalhes da magia',
                                  icon: const Icon(Icons.info_outline),
                                  onPressed: () => _showSpellDetails(spell),
                                ),
                                const SizedBox(width: 4),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onSpellAdded(spell);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Adicionar'),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSpellDetails(Spell spell) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(spell.name),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('Nível ${spell.level}')),
                      Chip(label: Text(spell.school)),
                      if (spell.ritual) const Chip(label: Text('Ritual')),
                      if (spell.concentration)
                        const Chip(label: Text('Concentração')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _detailRowResponsive(
                    context,
                    'Tempo de Conjuração',
                    spell.castingTime,
                  ),
                  _detailRowResponsive(context, 'Alcance', spell.range),
                  _detailRowResponsive(
                    context,
                    'Componentes',
                    spell.components,
                  ),
                  _detailRowResponsive(context, 'Duração', spell.duration),
                  if (spell.material != null)
                    _detailRowResponsive(context, 'Material', spell.material!),
                  const SizedBox(height: 8),
                  const Text(
                    'Descrição:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(spell.description),
                  if (spell.higherLevels != null &&
                      spell.higherLevels!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Em Níveis Superiores:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(spell.higherLevels!),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _detailRowResponsive(
    BuildContext context,
    String label,
    String value,
  ) {
    final isNarrow = MediaQuery.of(context).size.width < 380;
    if (!isNarrow) return _detailRow(label, value);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }
}

class _SpellSlotsCounter extends StatefulWidget {
  final int level;
  final int totalSlots;
  final int initialUsedSlots;
  final ValueChanged<int> onChanged;

  const _SpellSlotsCounter({
    required this.level,
    required this.totalSlots,
    required this.initialUsedSlots,
    required this.onChanged,
  });

  @override
  State<_SpellSlotsCounter> createState() => _SpellSlotsCounterState();
}

class _SpellSlotsCounterState extends State<_SpellSlotsCounter> {
  late int _usedSlots;

  @override
  void initState() {
    super.initState();
    _usedSlots = widget.totalSlots; // Iniciar com todos os slots usados
  }

  void _increment() {
    if (_usedSlots < widget.totalSlots) {
      setState(() {
        _usedSlots++;
      });
      widget.onChanged(_usedSlots);
    }
  }

  void _decrement() {
    if (_usedSlots > 0) {
      setState(() {
        _usedSlots--;
      });
      widget.onChanged(_usedSlots);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.withAlpha(40), Colors.indigo.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.withAlpha(80), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withAlpha(20),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo.withAlpha(60),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.remove, size: 16, color: Colors.white),
              onPressed: _decrement,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Espaços',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo.withAlpha(180),
                ),
              ),
              Text(
                '$_usedSlots/${widget.totalSlots}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo.withAlpha(60),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              onPressed: _increment,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _AbilityUsageCounter extends StatefulWidget {
  final String abilityName;
  final int totalUses;
  final int initialUsedUses;
  final Color color;
  final ValueChanged<int> onChanged;
  final String? dieLabel;

  const _AbilityUsageCounter({
    required this.abilityName,
    required this.totalUses,
    required this.initialUsedUses,
    required this.color,
    required this.onChanged,
    this.dieLabel,
  });

  @override
  State<_AbilityUsageCounter> createState() => _AbilityUsageCounterState();
}

class _AbilityUsageCounterState extends State<_AbilityUsageCounter> {
  late int _usedUses;

  @override
  void initState() {
    super.initState();
    _usedUses = widget.totalUses; // Inicializado com o máximo
  }

  void _increment() {
    if (_usedUses < widget.totalUses) {
      setState(() {
        _usedUses++;
      });
      widget.onChanged(_usedUses);
    }
  }

  void _decrement() {
    // Clique em qualquer parte do miolo também reduz 1
    if (_usedUses <= 0) return;
    setState(() {
      _usedUses--;
    });
    widget.onChanged(_usedUses);
  }

  @override
  Widget build(BuildContext context) {
    // Se não há limite de uso, mostrar apenas o dado
    if (widget.totalUses == 0 && widget.dieLabel != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color.withAlpha(40), widget.color.withAlpha(20)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.color.withAlpha(80), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: widget.color.withAlpha(20),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: widget.color.withAlpha(24),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.color.withAlpha(60)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dado',
                style: TextStyle(
                  color: widget.color,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.dieLabel!,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Comportamento normal para habilidades com limite de uso
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.color.withAlpha(40), widget.color.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withAlpha(80), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: widget.color.withAlpha(20),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.color.withAlpha(60),
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.remove, size: 14, color: Colors.white),
              onPressed: _decrement,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: _decrement,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Usos',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: widget.color.withAlpha(180),
                  ),
                ),
                Text(
                  '$_usedUses/${widget.totalUses}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (widget.dieLabel != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: widget.color.withAlpha(24),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: widget.color.withAlpha(60)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Dado',
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.dieLabel!,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 6),
          Container(
            decoration: BoxDecoration(
              color: widget.color.withAlpha(60),
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 14, color: Colors.white),
              onPressed: _increment,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
        ],
      ),
    );
  }
}
