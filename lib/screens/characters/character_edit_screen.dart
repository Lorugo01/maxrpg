import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'dart:convert';
import '/models/character.dart';
import '/models/skill.dart';
import '/models/item.dart';
import '/models/spell.dart';
import '/services/supabase_service.dart';
import '/services/character_service_supabase.dart';
import '/providers/character_provider.dart';

class CharacterEditScreen extends ConsumerStatefulWidget {
  final Character character;

  const CharacterEditScreen({super.key, required this.character});

  @override
  ConsumerState<CharacterEditScreen> createState() =>
      _CharacterEditScreenState();
}

class _CharacterEditScreenState extends ConsumerState<CharacterEditScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Character _character;

  // Controladores de texto
  final _nameController = TextEditingController();
  final _backgroundController = TextEditingController();
  final _alignmentController = TextEditingController();

  // Estado da edição
  bool _hasChanges = false;
  bool _isSaving = false;

  // Controle de conjuração
  bool? _isSpellcaster;
  String? _customSpellcastingAbility;

  // Dados editáveis
  Map<String, int> _abilityScores = {};
  List<Skill> _skills = [];
  List<Item> _inventory = [];
  List<Spell> _knownSpells = [];
  List<Map<String, dynamic>> _customAbilities = [];
  int _currentHitPoints = 0;
  int _maxHitPoints = 0;
  int _temporaryHitPoints = 0;
  int _armorClass = 10;
  int _speed = 30;
  int _level = 1;
  int _experiencePoints = 0;
  List<String> _languages = [];
  List<String> _proficiencies = [];

  // Cache de dados do banco
  Map<String, dynamic>? _classDataCache;
  Map<String, dynamic>? _raceDataCache;
  Map<String, dynamic>? _backgroundDataCache;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _initializeCharacter();
    _loadCharacterData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _backgroundController.dispose();
    _alignmentController.dispose();
    super.dispose();
  }

  void _initializeCharacter() {
    _character = widget.character;

    // Inicializar controladores
    _nameController.text = _character.name;
    _backgroundController.text = _character.background;
    _alignmentController.text = _character.alignment;

    // Inicializar dados editáveis
    _abilityScores = Map<String, int>.from(_character.abilityScores);
    _skills =
        _character.skills
            .map(
              (skill) => Skill(
                name: skill.name,
                baseAbility: skill.baseAbility,
                isProficient: skill.isProficient,
                hasExpertise: skill.hasExpertise,
              ),
            )
            .toList();
    _inventory =
        _character.inventory
            .map(
              (item) => Item(
                id: item.id,
                name: item.name,
                description: item.description,
                quantity: item.quantity,
                weight: item.weight,
                value: item.value,
                type: item.type,
                isEquipped: item.isEquipped,
              ),
            )
            .toList();
    _knownSpells = List<Spell>.from(_character.knownSpells);

    // Carregar habilidades personalizadas se existirem
    _customAbilities = _character.customAbilities ?? [];

    _currentHitPoints = _character.currentHitPoints;
    _maxHitPoints = _character.maxHitPoints;
    _temporaryHitPoints = _character.temporaryHitPoints;
    _armorClass = _character.armorClass;
    _speed = _character.speed;
    _level = _character.level;
    _experiencePoints = _character.experiencePoints;
    _languages = List<String>.from(_character.languages);
    _proficiencies = List<String>.from(_character.proficiencies);

    // Carregar configurações de conjuração
    _isSpellcaster = _character.isSpellcaster;
    _customSpellcastingAbility = _character.customSpellcastingAbility;

    // Recalcular CA inicial baseada nos atributos atuais
    _recalculateArmorClass();
  }

  Future<void> _loadCharacterData() async {
    try {
      // Carregar dados da classe
      final classResponse =
          await SupabaseService.client
              .from('classes')
              .select()
              .eq('name', _character.className)
              .single();
      _classDataCache = classResponse;

      // Carregar dados da raça
      final raceResponse =
          await SupabaseService.client
              .from('races')
              .select()
              .eq('name', _character.race)
              .single();
      _raceDataCache = raceResponse;

      // Carregar dados do antecedente
      final backgroundResponse =
          await SupabaseService.client
              .from('backgrounds')
              .select()
              .eq('name', _character.background)
              .single();
      _backgroundDataCache = backgroundResponse;

      setState(() {});
    } catch (e) {
      debugPrint('Erro ao carregar dados do personagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar ${_character.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          if (_hasChanges)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isSaving ? null : _saveCharacter,
            ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Básico'),
            Tab(icon: Icon(Icons.fitness_center), text: 'Atributos'),
            Tab(icon: Icon(Icons.star), text: 'Perícias'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Magias'),
            Tab(icon: Icon(Icons.psychology), text: 'Habilidades'),
            Tab(icon: Icon(Icons.inventory), text: 'Inventário'),
            Tab(icon: Icon(Icons.favorite), text: 'Vida'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBasicInfoTab(),
          _buildAttributesTab(),
          _buildSkillsTab(),
          _buildSpellsTab(),
          _buildAbilitiesTab(),
          _buildInventoryTab(),
          _buildHitPointsTab(),
        ],
      ),
      floatingActionButton:
          _hasChanges
              ? FloatingActionButton(
                onPressed: _isSaving ? null : _saveCharacter,
                backgroundColor: Colors.green,
                child:
                    _isSaving
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                        : const Icon(Icons.save, color: Colors.white),
              )
              : null,
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Informações Básicas'),

          const SizedBox(height: 16),

          // Nome
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome do Personagem',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            onChanged: (_) => _markAsChanged(),
          ),

          const SizedBox(height: 16),

          // Nível e Experiência
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nível',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed:
                                _level > 1
                                    ? () {
                                      setState(() {
                                        _level--;
                                        _markAsChanged();
                                      });
                                    }
                                    : null,
                            icon: const Icon(Icons.remove),
                          ),
                          Expanded(
                            child: Text(
                              '$_level',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed:
                                _level < 20
                                    ? () {
                                      setState(() {
                                        _level++;
                                        _markAsChanged();
                                      });
                                    }
                                    : null,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  initialValue: _experiencePoints.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Pontos de Experiência',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.star),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _experiencePoints = int.tryParse(value) ?? 0;
                    _markAsChanged();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Background e Alignment
          TextFormField(
            controller: _backgroundController,
            decoration: const InputDecoration(
              labelText: 'Antecedente',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.history),
            ),
            onChanged: (_) => _markAsChanged(),
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: _alignmentController,
            decoration: const InputDecoration(
              labelText: 'Tendência',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.balance),
            ),
            onChanged: (_) => _markAsChanged(),
          ),

          const SizedBox(height: 24),

          // Velocidade e CA
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: _speed.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Velocidade (pés)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.directions_run),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _speed = int.tryParse(value) ?? 30;
                    _markAsChanged();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  initialValue: _armorClass.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Classe de Armadura (Calculada)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.shield),
                    suffixIcon: Icon(Icons.auto_fix_high, color: Colors.blue),
                  ),
                  readOnly: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Idiomas
          _buildLanguagesSection(),

          const SizedBox(height: 16),

          // Proficiências
          _buildProficienciesSection(),

          const SizedBox(height: 16),

          // Configurações de Conjuração
          _buildSpellcastingSection(),
        ],
      ),
    );
  }

  Widget _buildAttributesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Atributos'),

          const SizedBox(height: 16),

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
                    _abilityScores.entries.map((entry) {
                      final abilityName = entry.key;
                      final abilityScore = entry.value;
                      final modifier = (abilityScore - 10) ~/ 2;
                      final sign = modifier >= 0 ? "+" : "";

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
                                abilityName,
                              ).withAlpha(100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _getAbilityColor(
                                    abilityName,
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
                                        abilityName,
                                      ).withAlpha(20),
                                      _getAbilityColor(
                                        abilityName,
                                      ).withAlpha(5),
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap:
                                      () => _showAbilityRollDialog(
                                        abilityName,
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
                                            _getAbilityIcon(abilityName),
                                            color: _getAbilityColor(
                                              abilityName,
                                            ),
                                            size: width < 600 ? 16 : 20,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          abilityName,
                                          style: TextStyle(
                                            fontSize: width < 600 ? 12 : 14,
                                            fontWeight: FontWeight.bold,
                                            color: _getAbilityColor(
                                              abilityName,
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
                                        const SizedBox(height: 8),
                                        // Botões de edição
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed:
                                                  abilityScore > 3
                                                      ? () {
                                                        setState(() {
                                                          _abilityScores[abilityName] =
                                                              abilityScore - 1;
                                                          // Atualizar atributo no personagem para cálculo correto
                                                          _character
                                                                  .abilityScores[abilityName] =
                                                              abilityScore - 1;
                                                          // Recalcular CA se for Destreza
                                                          if (abilityName ==
                                                              'Destreza') {
                                                            _recalculateArmorClass();
                                                          }
                                                          _markAsChanged();
                                                        });
                                                      }
                                                      : null,
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                              iconSize: width < 600 ? 18 : 20,
                                              color: _getAbilityColor(
                                                abilityName,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed:
                                                  abilityScore < 20
                                                      ? () {
                                                        setState(() {
                                                          _abilityScores[abilityName] =
                                                              abilityScore + 1;
                                                          // Atualizar atributo no personagem para cálculo correto
                                                          _character
                                                                  .abilityScores[abilityName] =
                                                              abilityScore + 1;
                                                          // Recalcular CA se for Destreza
                                                          if (abilityName ==
                                                              'Destreza') {
                                                            _recalculateArmorClass();
                                                          }
                                                          _markAsChanged();
                                                        });
                                                      }
                                                      : null,
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                              ),
                                              iconSize: width < 600 ? 18 : 20,
                                              color: _getAbilityColor(
                                                abilityName,
                                              ),
                                            ),
                                          ],
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

          // Botões de ação rápida
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ações Rápidas',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _resetAttributes,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Resetar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _randomizeAttributes,
                          icon: const Icon(Icons.casino),
                          label: const Text('Aleatório'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Perícias'),

          const SizedBox(height: 16),

          Text(
            'Toque em uma perícia para alternar a proficiência',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 16),

          // Salvaguardas
          _buildSavingThrowsCard(),

          const SizedBox(height: 16),

          // Perícias
          ..._skills.map((skill) {
            final modifier = skill.getModifier(
              _abilityScores,
              _getProficiencyBonus(),
            );
            final sign = modifier >= 0 ? "+" : "";

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      skill.isProficient
                          ? (skill.hasExpertise ? Colors.purple : Colors.green)
                          : Colors.grey,
                  child: Icon(
                    skill.isProficient
                        ? (skill.hasExpertise ? Icons.star : Icons.check)
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$sign$modifier',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (skill.hasExpertise) {
                            skill.hasExpertise = false;
                            skill.isProficient = false;
                          } else if (skill.isProficient) {
                            skill.hasExpertise = true;
                          } else {
                            skill.isProficient = true;
                          }
                          _markAsChanged();
                        });
                      },
                      icon: Icon(
                        skill.hasExpertise
                            ? Icons.star
                            : skill.isProficient
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            skill.hasExpertise
                                ? Colors.purple
                                : skill.isProficient
                                ? Colors.green
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSavingThrowsCard() {
    final savingThrows = [
      'Força',
      'Destreza',
      'Constituição',
      'Inteligência',
      'Sabedoria',
      'Carisma',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Salvaguardas',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...savingThrows.map((ability) {
              final isProficient = _character.isSavingThrowProficient(ability);
              final modifier = _character.getAbilityModifier(ability);
              final proficiencyBonus = _getProficiencyBonus();
              final totalModifier =
                  modifier + (isProficient ? proficiencyBonus : 0);
              final sign = totalModifier >= 0 ? "+" : "";

              return ListTile(
                dense: true,
                leading: CircleAvatar(
                  backgroundColor: isProficient ? Colors.green : Colors.grey,
                  radius: 12,
                  child: Icon(
                    isProficient ? Icons.check : Icons.circle_outlined,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                title: Text(ability),
                trailing: Text(
                  '$sign$totalModifier',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSpellsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Magias'),

          const SizedBox(height: 16),

          // Informações de conjuração
          if (_classDataCache != null) _buildSpellcastingInfo(),

          const SizedBox(height: 16),

          // Magias conhecidas
          _buildKnownSpellsSection(),

          const SizedBox(height: 16),

          // Botão para adicionar magia
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _showAddSpellDialog,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Magia'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellcastingInfo() {
    final hasSpellcasting = _classDataCache!['has_spells'] == true;

    if (!hasSpellcasting) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              'Esta classe não possui conjuração',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ),
      );
    }

    final spellcastingAbility = _getSpellcastingAbility();
    final spellSaveDC = _getSpellSaveDC();
    final spellAttackBonus = _getSpellAttackBonus();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações de Conjuração',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Habilidade', spellcastingAbility),
                _buildChip('CD de Magia', spellSaveDC.toString()),
                _buildChip('Bônus de Ataque', '+$spellAttackBonus'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).primaryColor.withAlpha(50)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildKnownSpellsSection() {
    if (_knownSpells.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.auto_awesome_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma magia conhecida',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Adicione magias usando o botão abaixo',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return _buildKnownSpellsByLevel();
  }

  Widget _buildKnownSpellsByLevel() {
    // Agrupar magias por nível
    final spellsByLevel = <int, List<Spell>>{};
    for (final spell in _knownSpells) {
      spellsByLevel.putIfAbsent(spell.level, () => []).add(spell);
    }

    // Ordenar níveis
    final sortedLevels = spellsByLevel.keys.toList()..sort();

    return Column(
      children:
          sortedLevels.map((level) {
            final spells = spellsByLevel[level]!;
            final levelName = level == 0 ? 'Truques' : 'Nível $level';

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          levelName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        if (level > 0) _buildSpellSlotsCounter(level),
                      ],
                    ),
                  ),
                  ...spells.map((spell) => _buildSpellCard(spell)),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSpellSlotsCounter(int level) {
    final totalSlots = _getSpellSlotsFromDatabase(level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.purple.shade600],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withAlpha(30),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Espaços',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$totalSlots',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellCard(Spell spell) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(child: Text(spell.name)),
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
                _buildSpellInfoRow('Tempo de Conjuração', spell.castingTime),
                _buildSpellInfoRow('Alcance', spell.range),
                _buildSpellInfoRow('Componentes', spell.components),
                _buildSpellInfoRow('Duração', spell.duration),
                if (spell.material != null)
                  _buildSpellInfoRow('Material', spell.material!),
                const SizedBox(height: 12),
                Text(
                  'Descrição:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(spell.description),
                if (spell.higherLevels != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Em Níveis Superiores:',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(spell.higherLevels!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellFlag(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withAlpha(50)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
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
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showAddSpellDialog() {
    showDialog(
      context: context,
      builder:
          (context) => _AddSpellDialog(
            knownSpells: _knownSpells,
            onSpellAdded: (spell) {
              setState(() {
                _knownSpells.add(spell);
                _markAsChanged();
              });
            },
          ),
    );
  }

  void _removeSpell(Spell spell) {
    setState(() {
      _knownSpells.remove(spell);
      _markAsChanged();
    });
  }

  String _getSpellcastingAbility() {
    if (_classDataCache == null) return 'N/A';

    try {
      final spellcasting = _classDataCache!['spellcasting'];
      if (spellcasting is Map) {
        return spellcasting['ability'] ?? 'N/A';
      } else if (spellcasting is String) {
        final decoded = jsonDecode(spellcasting);
        return decoded['ability'] ?? 'N/A';
      }
    } catch (e) {
      debugPrint('Erro ao obter habilidade de conjuração: $e');
    }

    // Fallback baseado no nome da classe
    switch (_character.className) {
      case 'Bardo':
      case 'Paladino':
      case 'Patrulheiro':
        return 'Carisma';
      case 'Clérigo':
      case 'Druida':
        return 'Sabedoria';
      case 'Mago':
      case 'Bruxo':
      case 'Arcanista':
        return 'Inteligência';
      default:
        return 'N/A';
    }
  }

  int _getSpellSaveDC() {
    final abilityName = _getSpellcastingAbility();
    final abilityModifier = _character.getAbilityModifier(abilityName);
    final proficiencyBonus = _getProficiencyBonus();
    return 8 + proficiencyBonus + abilityModifier;
  }

  int _getSpellAttackBonus() {
    final abilityName = _getSpellcastingAbility();
    final abilityModifier = _character.getAbilityModifier(abilityName);
    final proficiencyBonus = _getProficiencyBonus();
    return proficiencyBonus + abilityModifier;
  }

  // Resolve o atributo usado por habilidades com uso baseado em atributo
  String? _resolveUsageAttribute(Map<String, dynamic> abilityData) {
    final explicit = abilityData['usage_attribute'];
    if (explicit is String && explicit.trim().isNotEmpty) {
      return _normalizeAbilityName(explicit);
    }

    // Heurística: se o nome for "Inspiração Bárdica", usar Carisma
    final name = (abilityData['name'] as String?)?.toLowerCase() ?? '';
    if (name.contains('inspiração')) {
      return 'Carisma';
    }

    // Fallback: usar a habilidade primária da classe do BD (primary_ability)
    final primary = _classDataCache?['primary_ability'];
    if (primary is String && primary.trim().isNotEmpty) {
      return _normalizeAbilityName(primary);
    }

    return null;
  }

  String _normalizeAbilityName(String ability) {
    final a = ability.toLowerCase().trim();
    if (a.startsWith('for')) return 'Força';
    if (a.startsWith('des')) return 'Destreza';
    if (a.startsWith('con')) return 'Constituição';
    if (a.startsWith('int')) return 'Inteligência';
    if (a.startsWith('sab')) return 'Sabedoria';
    if (a.startsWith('car')) return 'Carisma';
    return ability;
  }

  String? _getCurrentDie(Map<String, dynamic> abilityData) {
    // Espera 'initial_dice' como string tipo "1d6" ou int (não comum). Exibe apenas a parte do dado (d6)
    String? baseDie;
    final initial = abilityData['initial_dice'];
    if (initial is String && initial.isNotEmpty) {
      final match = RegExp(r"\d*d\d+").firstMatch(initial);
      baseDie = match?.group(0);
    } else if (initial is int) {
      baseDie = 'd$initial';
    }

    // Verificar aumentos por nível para trocar o dado conforme o nível atual
    final increases = abilityData['dice_increases'];
    if (increases is List && increases.isNotEmpty) {
      for (final inc in increases) {
        final level = inc['level'];
        final dice = inc['dice'];
        if (level != null && dice is String) {
          int? lvl;
          if (level is int) {
            lvl = level;
          } else if (level is String) {
            lvl = int.tryParse(level);
          }
          if (lvl != null && _character.level >= lvl) {
            final m = RegExp(r"\d*d\d+").firstMatch(dice);
            baseDie = m?.group(0) ?? baseDie;
          }
        }
      }
    }

    // Retornar apenas a parte do dado sem quantidade (ex.: d6)
    if (baseDie != null) {
      final onlyDie = baseDie.replaceAll(RegExp(r"^\d+"), '');
      if (onlyDie.isNotEmpty) return onlyDie;
      return baseDie;
    }
    return null;
  }

  int _getSpellSlotsFromDatabase(int spellLevel) {
    if (_classDataCache == null) return 0;

    try {
      final spellSlotsLevels = _classDataCache!['spell_slots_levels'] as List?;
      if (spellSlotsLevels == null) return 0;

      // Encontrar o nível do personagem
      final characterLevel = _character.level;

      // Procurar pelos slots do nível do personagem
      for (final levelData in spellSlotsLevels) {
        if (levelData['level'] == characterLevel) {
          final slotKey = 'level_$spellLevel';
          return levelData[slotKey] ?? 0;
        }
      }
    } catch (e) {
      debugPrint('Erro ao obter slots de magia: $e');
    }

    return 0;
  }

  Widget _buildAbilitiesTab() {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: const [
              Tab(text: 'Raça'),
              Tab(text: 'Classe'),
              Tab(text: 'Origem'),
              Tab(text: 'Talentos'),
              Tab(text: 'Personalizadas'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRaceAbilitiesTab(),
                _buildClassAbilitiesTab(),
                _buildBackgroundAbilitiesTab(),
                _buildFeatsAbilitiesTab(),
                _buildCustomAbilitiesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRaceAbilitiesTab() {
    if (_raceDataCache == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final traits = _raceDataCache!['traits'];
    List<Map<String, dynamic>> abilities = [];

    if (traits != null) {
      if (traits is String) {
        try {
          abilities = List<Map<String, dynamic>>.from(jsonDecode(traits));
        } catch (e) {
          debugPrint('Erro ao decodificar traits: $e');
        }
      } else if (traits is List) {
        abilities = List<Map<String, dynamic>>.from(traits);
      }
    } else {
      // Fallback para traits_text
      final traitsText = _raceDataCache!['traits_text'] as String?;
      if (traitsText != null && traitsText.isNotEmpty) {
        final lines = traitsText.split('\n');
        for (final line in lines) {
          if (line.contains(':')) {
            final parts = line.split(':');
            if (parts.length >= 2) {
              abilities.add({
                'name': parts[0].trim(),
                'description': parts.sublist(1).join(':').trim(),
              });
            }
          }
        }
      }
    }

    if (abilities.isEmpty) {
      return const Center(child: Text('Nenhuma habilidade de raça encontrada'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            abilities.map((ability) => _buildAbilityCard(ability)).toList(),
      ),
    );
  }

  Widget _buildClassAbilitiesTab() {
    if (_classDataCache == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final levelFeatures = _classDataCache!['level_features'];
    List<Map<String, dynamic>> abilities = [];

    if (levelFeatures != null) {
      if (levelFeatures is String) {
        try {
          abilities = List<Map<String, dynamic>>.from(
            jsonDecode(levelFeatures),
          );
        } catch (e) {
          debugPrint('Erro ao decodificar level_features: $e');
        }
      } else if (levelFeatures is List) {
        abilities = List<Map<String, dynamic>>.from(levelFeatures);
      }
    }

    // Filtrar habilidades do nível atual ou menor
    final currentLevel = _character.level;
    abilities =
        abilities.where((ability) {
          final levelValue = ability['level'];
          int? level;
          if (levelValue is int) {
            level = levelValue;
          } else if (levelValue is String) {
            level = int.tryParse(levelValue);
          }
          return level != null && level <= currentLevel;
        }).toList();

    if (abilities.isEmpty) {
      return const Center(
        child: Text('Nenhuma habilidade de classe encontrada'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            abilities.map((ability) => _buildAbilityCard(ability)).toList(),
      ),
    );
  }

  Widget _buildBackgroundAbilitiesTab() {
    if (_backgroundDataCache == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final feature = _backgroundDataCache!['feature'];
    final feat = _backgroundDataCache!['feat'];

    List<Map<String, dynamic>> abilities = [];

    if (feature != null && feature.isNotEmpty) {
      abilities.add({'name': 'Característica', 'description': feature});
    } else if (feat != null && feat.isNotEmpty) {
      abilities.add({'name': 'Talento', 'description': feat});
    }

    if (abilities.isEmpty) {
      return const Center(
        child: Text('Nenhuma habilidade de origem encontrada'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children:
            abilities.map((ability) => _buildAbilityCard(ability)).toList(),
      ),
    );
  }

  Widget _buildFeatsAbilitiesTab() {
    if (_backgroundDataCache == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final feat = _backgroundDataCache!['feat'];

    if (feat == null || feat.isEmpty) {
      return const Center(child: Text('Nenhum talento de origem encontrado'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildAbilityCard({
            'name': feat,
            'description':
                'Talento obtido pela origem ${_character.background}',
          }),
        ],
      ),
    );
  }

  Widget _buildAbilityCard(Map<String, dynamic> abilityData) {
    final name = abilityData['name'] as String? ?? 'Habilidade';
    final description = abilityData['description'] as String? ?? '';
    final hasUsageLimit = abilityData['has_usage_limit'] == true;
    final currentDie = _getCurrentDie(abilityData);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: _buildAbilityTitle(name, hasUsageLimit, abilityData, currentDie),
        subtitle: Text(
          description.length > 100
              ? '${description.substring(0, 100)}...'
              : description,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descrição:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(description),
                if (hasUsageLimit) ...[
                  const SizedBox(height: 16),
                  _buildUsageInfo(abilityData),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilityTitle(
    String name,
    bool hasUsageLimit,
    Map<String, dynamic> abilityData,
    String? currentDie,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        final titleText = Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );

        if (!hasUsageLimit) {
          return titleText;
        }

        final counter = _buildUsageCounter(abilityData, dieLabel: currentDie);

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText,
              const SizedBox(height: 6),
              Align(alignment: Alignment.centerRight, child: counter),
            ],
          );
        }

        return Row(children: [Expanded(child: titleText), counter]);
      },
    );
  }

  // Removido: o dado é exibido dentro do contador de usos

  Widget _buildUsageCounter(
    Map<String, dynamic> abilityData, {
    String? dieLabel,
  }) {
    final rawUsageType = abilityData['usage_type'] as String?;
    final usageType = rawUsageType?.toLowerCase().trim();
    final usageAttribute = _resolveUsageAttribute(abilityData);

    int? initialDice;
    final initialDiceValue = abilityData['initial_dice'];
    if (initialDiceValue is int) {
      initialDice = initialDiceValue;
    } else if (initialDiceValue is String) {
      initialDice = int.tryParse(initialDiceValue);
    }

    final diceIncreases = abilityData['dice_increases'] as List?;

    int totalUses = 1;
    if (usageType != null &&
        usageType.contains('modificador de atributo') &&
        usageAttribute != null) {
      final modifier = _character.getAbilityModifier(usageAttribute);
      totalUses = modifier > 0 ? modifier : 1;
    } else if (initialDice != null) {
      totalUses = initialDice;
      if (diceIncreases != null) {
        for (final increase in diceIncreases) {
          final levelValue = increase['level'];
          int? level;
          if (levelValue is int) {
            level = levelValue;
          } else if (levelValue is String) {
            level = int.tryParse(levelValue);
          }

          if (level != null && level <= _character.level) {
            final diceValue = increase['dice'];
            int? dice;
            if (diceValue is int) {
              dice = diceValue;
            } else if (diceValue is String) {
              dice = int.tryParse(diceValue);
            }
            totalUses += dice ?? 0;
          }
        }
      }
    }

    return _AbilityUsageCounter(
      totalUses: totalUses,
      dieLabel: dieLabel,
      onChanged: (used) {
        // Implementar lógica de uso se necessário
      },
    );
  }

  Widget _buildUsageInfo(Map<String, dynamic> abilityData) {
    final usageType =
        (abilityData['usage_type'] as String?)?.toLowerCase().trim();
    final usageAttribute = _resolveUsageAttribute(abilityData);
    final recovery = abilityData['recovery'] as String?;

    int? initialDice;
    final initialDiceValue = abilityData['initial_dice'];
    if (initialDiceValue is int) {
      initialDice = initialDiceValue;
    } else if (initialDiceValue is String) {
      initialDice = int.tryParse(initialDiceValue);
    }

    final diceIncreases = abilityData['dice_increases'] as List?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações de Uso:',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (usageType != null) Text('Tipo: $usageType'),
        if (usageAttribute != null) Text('Atributo: $usageAttribute'),
        if (recovery != null) Text('Recuperação: $recovery'),
        if (initialDice != null) Text('Dados iniciais: $initialDice'),
        if (diceIncreases != null && diceIncreases.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Aumentos por nível:'),
          ...diceIncreases.map((increase) {
            final levelValue = increase['level'];
            int? level;
            if (levelValue is int) {
              level = levelValue;
            } else if (levelValue is String) {
              level = int.tryParse(levelValue);
            }

            final diceValue = increase['dice'];
            int? dice;
            if (diceValue is int) {
              dice = diceValue;
            } else if (diceValue is String) {
              dice = int.tryParse(diceValue);
            }

            return Text('  Nível ${level ?? '?'}: +${dice ?? 0} dados');
          }),
        ],
      ],
    );
  }

  Widget _buildCustomAbilitiesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Habilidades Personalizadas',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _showAddCustomAbilityDialog,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_customAbilities.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.psychology_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma habilidade personalizada',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Adicione habilidades personalizadas usando o botão acima',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            ..._customAbilities.asMap().entries.map((entry) {
              final index = entry.key;
              final ability = entry.value;
              return _buildCustomAbilityCard(ability, index);
            }),
        ],
      ),
    );
  }

  Widget _buildCustomAbilityCard(Map<String, dynamic> ability, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(child: Text(ability['name'] ?? 'Habilidade')),
            IconButton(
              onPressed: () => _editCustomAbility(index),
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () => _deleteCustomAbility(index),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        subtitle: Text(
          ability['description']?.length > 100
              ? '${ability['description'].substring(0, 100)}...'
              : ability['description'] ?? '',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descrição:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(ability['description'] ?? ''),
                if (ability['has_usage_limit'] == true) ...[
                  const SizedBox(height: 16),
                  _buildUsageInfo(ability),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCustomAbilityDialog() {
    _showCustomAbilityDialog();
  }

  void _editCustomAbility(int index) {
    _showCustomAbilityDialog(ability: _customAbilities[index], index: index);
  }

  void _deleteCustomAbility(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Habilidade'),
            content: Text(
              'Tem certeza que deseja excluir "${_customAbilities[index]['name']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _customAbilities.removeAt(index);
                    _markAsChanged();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showCustomAbilityDialog({Map<String, dynamic>? ability, int? index}) {
    final nameController = TextEditingController(text: ability?['name'] ?? '');
    final descriptionController = TextEditingController(
      text: ability?['description'] ?? '',
    );
    bool hasUsageLimit = ability?['has_usage_limit'] == true;
    final usageTypeController = TextEditingController(
      text: ability?['usage_type'] ?? '',
    );
    final usageAttributeController = TextEditingController(
      text: ability?['usage_attribute'] ?? '',
    );
    final recoveryController = TextEditingController(
      text: ability?['recovery'] ?? '',
    );
    final initialDiceController = TextEditingController(
      text: ability?['initial_dice']?.toString() ?? '',
    );
    final diceIncreasesController = TextEditingController(
      text: ability?['dice_increases']?.toString() ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: Text(
                    index != null
                        ? 'Editar Habilidade'
                        : 'Adicionar Habilidade',
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome da habilidade',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 12),
                        CheckboxListTile(
                          title: const Text('Tem limite de uso'),
                          value: hasUsageLimit,
                          onChanged: (value) {
                            setDialogState(() {
                              hasUsageLimit = value ?? false;
                            });
                          },
                        ),
                        if (hasUsageLimit) ...[
                          const SizedBox(height: 12),
                          TextField(
                            controller: usageTypeController,
                            decoration: const InputDecoration(
                              labelText:
                                  'Tipo de uso (ex: Por Modificador de Atributo)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: usageAttributeController,
                            decoration: const InputDecoration(
                              labelText: 'Atributo (ex: Carisma)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: recoveryController,
                            decoration: const InputDecoration(
                              labelText:
                                  'Recuperação (ex: Após descanso longo)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: initialDiceController,
                            decoration: const InputDecoration(
                              labelText: 'Dados iniciais',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: diceIncreasesController,
                            decoration: const InputDecoration(
                              labelText: 'Aumentos por nível (JSON)',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          final newAbility = {
                            'name': nameController.text,
                            'description': descriptionController.text,
                            'has_usage_limit': hasUsageLimit,
                            if (hasUsageLimit) ...{
                              'usage_type': usageTypeController.text,
                              'usage_attribute': usageAttributeController.text,
                              'recovery': recoveryController.text,
                              'initial_dice': int.tryParse(
                                initialDiceController.text,
                              ),
                              'dice_increases':
                                  diceIncreasesController.text.isNotEmpty
                                      ? jsonDecode(diceIncreasesController.text)
                                      : null,
                            },
                          };

                          setState(() {
                            if (index != null) {
                              _customAbilities[index] = newAbility;
                            } else {
                              _customAbilities.add(newAbility);
                            }
                            _markAsChanged();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(index != null ? 'Salvar' : 'Adicionar'),
                    ),
                  ],
                ),
          ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Inventário'),

          const SizedBox(height: 16),

          // Resumo do inventário
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Itens: ${_inventory.length}'),
                      Text(
                        'Peso: ${_calculateTotalWeight().toStringAsFixed(1)} lbs',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Capacidade: ${_getCarryingCapacity()} lbs'),
                      Text(
                        _calculateTotalWeight() > _getCarryingCapacity()
                            ? 'SOBRECARREGADO'
                            : 'Normal',
                        style: TextStyle(
                          color:
                              _calculateTotalWeight() > _getCarryingCapacity()
                                  ? Colors.red
                                  : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Botão para adicionar item
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addNewItem,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Item'),
            ),
          ),

          const SizedBox(height: 16),

          // Lista de itens
          if (_inventory.isEmpty)
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
                        'Adicione itens usando o botão acima',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            ..._inventory.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
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
                      Expanded(child: Text(item.name)),
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
                    'Qtd: ${item.quantity} • Peso: ${item.weight} lbs • Valor: ${item.value} po',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _editItem(item);
                          break;
                        case 'equip':
                          _toggleItemEquipped(item);
                          break;
                        case 'delete':
                          _deleteItem(item);
                          break;
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Editar'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'equip',
                            child: Row(
                              children: [
                                Icon(
                                  item.isEquipped
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color:
                                      item.isEquipped
                                          ? Colors.green
                                          : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.isEquipped ? 'Desequipar' : 'Equipar',
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Excluir'),
                              ],
                            ),
                          ),
                        ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildHitPointsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Pontos de Vida'),

          const SizedBox(height: 16),

          // Pontos de vida atuais
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pontos de Vida Atuais',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _currentHitPoints.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Atuais',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.favorite),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _currentHitPoints = int.tryParse(value) ?? 0;
                            _markAsChanged();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _maxHitPoints.toString(),
                          decoration: const InputDecoration(
                            labelText: 'Máximos',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.favorite_border),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _maxHitPoints = int.tryParse(value) ?? 0;
                            _markAsChanged();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _currentHitPoints = _maxHitPoints;
                              _markAsChanged();
                            });
                          },
                          icon: const Icon(Icons.healing),
                          label: const Text('Curar Total'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _currentHitPoints = 0;
                              _markAsChanged();
                            });
                          },
                          icon: const Icon(Icons.warning),
                          label: const Text('Inconsciente'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Pontos de vida temporários
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pontos de Vida Temporários',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: _temporaryHitPoints.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Pontos Temporários',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _temporaryHitPoints = int.tryParse(value) ?? 0;
                      _markAsChanged();
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Resumo de vida
          Card(
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo de Vida',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vida Total: ${_currentHitPoints + _temporaryHitPoints}',
                      ),
                      Text('Status: ${_getHealthStatus()}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value:
                        _currentHitPoints /
                        (_maxHitPoints > 0 ? _maxHitPoints : 1),
                    backgroundColor: Colors.red.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _currentHitPoints <= 0
                          ? Colors.red
                          : _currentHitPoints < _maxHitPoints * 0.5
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildLanguagesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Idiomas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addLanguage,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_languages.isEmpty)
              Text(
                'Nenhum idioma adicionado',
                style: TextStyle(color: Colors.grey.shade600),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children:
                    _languages.map((language) {
                      return Chip(
                        label: Text(language),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _languages.remove(language);
                            _markAsChanged();
                          });
                        },
                      );
                    }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProficienciesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Proficiências',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addProficiency,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_proficiencies.isEmpty)
              Text(
                'Nenhuma proficiência adicionada',
                style: TextStyle(color: Colors.grey.shade600),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children:
                    _proficiencies.map((proficiency) {
                      return Chip(
                        label: Text(proficiency),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _proficiencies.remove(proficiency);
                            _markAsChanged();
                          });
                        },
                      );
                    }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares
  void _markAsChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  void _recalculateArmorClass() {
    // Recalcular CA baseada nos atributos atuais
    final dexModifier = _character.getAbilityModifier('Destreza');
    final equippedArmor = _character.getEquippedArmor();

    if (equippedArmor == null || equippedArmor.id.isEmpty) {
      // Sem armadura: CA padrão = 10 + modificador de Destreza
      _armorClass = 10 + dexModifier;
    } else {
      // Com armadura: usar cálculo do modelo Character
      _armorClass = _character.getCalculatedArmorClass();
    }

    debugPrint(
      'CA recalculada: $_armorClass (Destreza: ${_abilityScores['Destreza']}, Mod: $dexModifier)',
    );

    // Atualizar a interface para mostrar a nova CA
    setState(() {
      // A CA será atualizada na próxima reconstrução da interface
    });
  }

  int _getProficiencyBonus() {
    return ((_level - 1) ~/ 4) + 2;
  }

  double _calculateTotalWeight() {
    return _inventory.fold(
      0.0,
      (sum, item) => sum + (item.weight * item.quantity),
    );
  }

  int _getCarryingCapacity() {
    final strengthScore = _abilityScores['Força'] ?? 10;
    return strengthScore * 15;
  }

  String _getHealthStatus() {
    if (_currentHitPoints <= 0) return 'Inconsciente';
    if (_currentHitPoints < _maxHitPoints * 0.25) return 'Crítico';
    if (_currentHitPoints < _maxHitPoints * 0.5) return 'Ferido';
    if (_currentHitPoints < _maxHitPoints) return 'Levemente Ferido';
    return 'Saudável';
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

  // Métodos de ação
  void _resetAttributes() {
    setState(() {
      _abilityScores = CharacterDefaults.defaultAbilityScores;
      _markAsChanged();
    });
  }

  void _randomizeAttributes() {
    final random = Random();
    setState(() {
      for (final ability in _abilityScores.keys) {
        // Rolar 4d6, descartar menor
        final rolls = List.generate(4, (_) => 1 + random.nextInt(6));
        rolls.sort();
        rolls.removeAt(0);
        _abilityScores[ability] = rolls.reduce((a, b) => a + b);
      }
      _markAsChanged();
    });
  }

  void _addLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Adicionar Idioma'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nome do idioma',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    _languages.add(controller.text);
                    _markAsChanged();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _addProficiency() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Adicionar Proficiência'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nome da proficiência',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    _proficiencies.add(controller.text);
                    _markAsChanged();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _addNewItem() {
    // Implementar diálogo de criação de item
    _showItemDialog();
  }

  void _editItem(Item item) {
    _showItemDialog(item: item);
  }

  void _toggleItemEquipped(Item item) {
    setState(() {
      item.isEquipped = !item.isEquipped;
      _markAsChanged();
    });
  }

  void _deleteItem(Item item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Item'),
            content: Text('Tem certeza que deseja excluir "${item.name}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _inventory.remove(item);
                    _markAsChanged();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showItemDialog({Item? item}) {
    final nameController = TextEditingController(text: item?.name ?? '');
    final descriptionController = TextEditingController(
      text: item?.description ?? '',
    );
    final quantityController = TextEditingController(
      text: item?.quantity.toString() ?? '1',
    );
    final weightController = TextEditingController(
      text: item?.weight.toString() ?? '0',
    );
    final valueController = TextEditingController(
      text: item?.value.toString() ?? '0',
    );
    ItemType selectedType = item?.type ?? ItemType.misc;
    bool isEquipped = item?.isEquipped ?? false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: Text(item == null ? 'Adicionar Item' : 'Editar Item'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: quantityController,
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
                                controller: weightController,
                                decoration: const InputDecoration(
                                  labelText: 'Peso',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: valueController,
                          decoration: const InputDecoration(
                            labelText: 'Valor (po)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<ItemType>(
                          value: selectedType,
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
                            setDialogState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        CheckboxListTile(
                          title: const Text('Equipado'),
                          value: isEquipped,
                          onChanged: (value) {
                            setDialogState(() {
                              isEquipped = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          final newItem = Item(
                            id:
                                item?.id ??
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                            name: nameController.text,
                            description: descriptionController.text,
                            quantity:
                                int.tryParse(quantityController.text) ?? 1,
                            weight:
                                double.tryParse(weightController.text) ?? 0.0,
                            value: int.tryParse(valueController.text) ?? 0,
                            type: selectedType,
                            isEquipped: isEquipped,
                          );

                          setState(() {
                            if (item == null) {
                              _inventory.add(newItem);
                            } else {
                              final index = _inventory.indexWhere(
                                (i) => i.id == item.id,
                              );
                              if (index != -1) {
                                _inventory[index] = newItem;
                              }
                            }
                            _markAsChanged();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(item == null ? 'Adicionar' : 'Salvar'),
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

  void _saveCharacter() async {
    setState(() {
      _isSaving = true;
    });

    try {
      // Recalcular CA antes de salvar para garantir que esteja atualizada
      _recalculateArmorClass();

      // Criar personagem atualizado
      final updatedCharacter = Character(
        id: _character.id,
        name: _nameController.text,
        race: _character.race,
        className: _character.className,
        level: _level,
        background: _backgroundController.text,
        alignment: _alignmentController.text,
        abilityScores: Map<String, int>.from(_abilityScores),
        skills:
            _skills
                .map(
                  (skill) => Skill(
                    name: skill.name,
                    baseAbility: skill.baseAbility,
                    isProficient: skill.isProficient,
                    hasExpertise: skill.hasExpertise,
                  ),
                )
                .toList(),
        inventory:
            _inventory
                .map(
                  (item) => Item(
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    quantity: item.quantity,
                    weight: item.weight,
                    value: item.value,
                    type: item.type,
                    isEquipped: item.isEquipped,
                  ),
                )
                .toList(),
        knownSpells: List<Spell>.from(_knownSpells),
        customAbilities: _customAbilities,
        currentHitPoints: _currentHitPoints,
        maxHitPoints: _maxHitPoints,
        temporaryHitPoints: _temporaryHitPoints,
        armorClass: _armorClass,
        speed: _speed,
        experiencePoints: _experiencePoints,
        languages: List<String>.from(_languages),
        proficiencies: List<String>.from(_proficiencies),
        isSpellcaster: _isSpellcaster,
        customSpellcastingAbility: _customSpellcastingAbility,
      );

      // Salvar no banco de dados
      await CharacterService.saveCharacter(updatedCharacter);

      // Atualizar o provider para refletir as mudanças na lista
      ref.read(charactersProvider.notifier).updateCharacter(updatedCharacter);

      setState(() {
        _hasChanges = false;
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Personagem salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Retornar o personagem atualizado para a tela anterior
        Navigator.pop(context, updatedCharacter);
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
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

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Ajuda - Edição de Personagem'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Abas de Edição:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• Básico: Nome, nível, antecedente, tendência'),
                  Text('• Atributos: Força, Destreza, Constituição, etc.'),
                  Text('• Perícias: Proficiências e especializações'),
                  Text(
                    '• Magias: Magias conhecidas e informações de conjuração',
                  ),
                  Text(
                    '• Habilidades: Habilidades de raça, classe, origem, talentos e personalizadas',
                  ),
                  Text('• Inventário: Itens e equipamentos'),
                  Text('• Vida: Pontos de vida e status'),
                  SizedBox(height: 16),
                  Text('Dicas:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• Toque nos atributos para alterar valores'),
                  Text('• Toque nas perícias para alternar proficiência'),
                  Text('• Adicione e remova magias na aba Magias'),
                  Text('• Visualize e edite habilidades na aba Habilidades'),
                  Text('• Use o botão flutuante para salvar alterações'),
                  Text('• As alterações são salvas automaticamente'),
                ],
              ),
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

  Widget _buildSpellcastingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configurações de Conjuração',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Esta classe é conjuradora'),
              subtitle: const Text('Permite usar magias e espaços de magia'),
              value: _isSpellcaster ?? _character.hasSpellcasting,
              onChanged: (value) {
                setState(() {
                  _isSpellcaster = value;
                  _markAsChanged();
                });
              },
            ),
            if (_isSpellcaster ?? _character.hasSpellcasting) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value:
                    _customSpellcastingAbility ??
                    _character.getSpellcastingAbility(),
                decoration: const InputDecoration(
                  labelText: 'Atributo de Conjuração',
                  border: OutlineInputBorder(),
                  helperText:
                      'Atributo usado para CD de magia e bônus de ataque',
                ),
                items: const [
                  DropdownMenuItem(value: 'Força', child: Text('Força')),
                  DropdownMenuItem(value: 'Destreza', child: Text('Destreza')),
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
                  DropdownMenuItem(value: 'Carisma', child: Text('Carisma')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _customSpellcastingAbility = value;
                      _markAsChanged();
                    });
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Widget para contador de uso de habilidades
class _AbilityUsageCounter extends StatefulWidget {
  final int totalUses;
  final Function(int) onChanged;
  final String? dieLabel;

  const _AbilityUsageCounter({
    required this.totalUses,
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
    _usedUses = widget.totalUses; // Inicializar com o máximo
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
    if (_usedUses > 0) {
      setState(() {
        _usedUses--;
      });
      widget.onChanged(_usedUses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withAlpha(30),
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
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _decrement,
              icon: const Icon(Icons.remove, color: Colors.white, size: 16),
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Uso',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_usedUses/${widget.totalUses}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          if (widget.dieLabel != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(24),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withAlpha(40)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Dado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.dieLabel!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _increment,
              icon: const Icon(Icons.add, color: Colors.white, size: 16),
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para adicionar magias
class _AddSpellDialog extends StatefulWidget {
  final List<Spell> knownSpells;
  final Function(Spell) onSpellAdded;

  const _AddSpellDialog({
    required this.knownSpells,
    required this.onSpellAdded,
  });

  @override
  State<_AddSpellDialog> createState() => _AddSpellDialogState();
}

class _AddSpellDialogState extends State<_AddSpellDialog> {
  List<Spell> _availableSpells = [];
  List<Spell> _filteredSpells = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvailableSpells();
  }

  Future<void> _loadAvailableSpells() async {
    try {
      final spellsData = await SupabaseService.getSpells();
      _availableSpells =
          spellsData.map((spellMap) => Spell.fromMap(spellMap)).toList();
      _filteredSpells = _availableSpells;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar magias: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterSpells(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSpells = _availableSpells;
      } else {
        _filteredSpells =
            _availableSpells.where((spell) {
              return spell.name.toLowerCase().contains(query.toLowerCase()) ||
                  spell.school.toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Magia'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar magia',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterSpells,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredSpells.isEmpty
                      ? const Center(child: Text('Nenhuma magia encontrada'))
                      : ListView.builder(
                        itemCount: _filteredSpells.length,
                        itemBuilder: (context, index) {
                          final spell = _filteredSpells[index];
                          final isAlreadyKnown = widget.knownSpells.any(
                            (known) => known.name == spell.name,
                          );

                          return ListTile(
                            title: Text(spell.name),
                            subtitle: Text(
                              'Nível ${spell.level} • ${spell.school}',
                            ),
                            trailing:
                                isAlreadyKnown
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                    : IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        widget.onSpellAdded(spell);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${spell.name} adicionada!',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
