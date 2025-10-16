import 'package:flutter/material.dart';
import 'package:maxrpg/widgets/text_helpers.dart';
import 'package:maxrpg/widgets/rich_text_helpers.dart';
import 'package:maxrpg/widgets/form_sections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../services/supabase_service.dart';
import '../../../services/equipment_service.dart';
import '../../../models/equipment.dart';

class EditClassScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> classData;

  const EditClassScreen({super.key, required this.classData});

  @override
  ConsumerState<EditClassScreen> createState() => _EditClassScreenState();
}

class _EditClassScreenState extends ConsumerState<EditClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _hitDieController = TextEditingController(text: '8');
  List<String> _selectedPrimaryAbilities = [];
  List<String> _selectedSavingThrows = [];

  // Opções de atributos para seleção
  final List<String> _abilityOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];
  List<String> _selectedArmorProficiencies = [];
  List<String> _selectedWeaponProficiencies = [];
  List<String> _selectedToolProficiencies = [];
  List<String> _selectedSkillProficiencies = [];
  final _skillCountController = TextEditingController();
  final _equipmentController = TextEditingController();
  final _equipmentLadoAController = TextEditingController();
  final _equipmentLadoBController = TextEditingController();
  final _featuresController = TextEditingController();
  final _spellcastingController = TextEditingController();
  final _subclassesController = TextEditingController();
  String? _selectedSource;

  // Estado da edição
  bool _hasChanges = false;
  Map<String, dynamic>? _initialData;

  // Estrutura para ganhos por nível
  final List<Map<String, dynamic>> _levelFeatures = [];

  // Controle de magias
  bool _hasSpells = false;
  final List<Map<String, dynamic>> _spellLevels = [];

  // Controle de espaços de magia por nível
  final List<Map<String, dynamic>> _spellSlotsLevels = [];

  // Subclasses dinâmicas (nome + habilidades por nível)
  final List<Map<String, dynamic>> _subclasses = [];

  final List<Map<String, dynamic>> _equipmentLadoAItems = [];
  final List<Map<String, dynamic>> _equipmentLadoBItems = [];

  // PO (Peças de Ouro) para cada lado
  final _poLadoAController = TextEditingController();
  final _poLadoBController = TextEditingController();
  // Escolhas de equipamento (ex.: instrumento musical à escolha)
  final List<Map<String, dynamic>> _equipmentChoices = [];
  final List<String> _savingThrowOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];

  final List<String> _armorProficiencyOptions = [
    'Armaduras Leves',
    'Armaduras Médias',
    'Armaduras Pesadas',
    'Escudos',
  ];

  final List<String> _weaponProficiencyOptions = [
    'Armas Simples',
    'Armas Marciais',
    'Armas Simples de Corpo a Corpo',
    'Armas Simples à Distância',
    'Armas Marciais de Corpo a Corpo',
    'Armas Marciais à Distância',
  ];

  final List<String> _toolProficiencyOptions = [
    'Ferramentas de Artesão',
    'Ferramentas de Ladrão',
    'Ferramentas de Música',
    'Ferramentas de Veículos',
    'Ferramentas de Jogos',
    'Ferramentas de Herbalismo',
    'Ferramentas de Navegação',
    'Ferramentas de Caligrafia',
  ];

  final List<String> _skillProficiencyOptions = [
    'Acrobacia',
    'Adestrar Animais',
    'Arcanismo',
    'Atletismo',
    'Atuação',
    'Enganação',
    'Furtividade',
    'História',
    'Intimidação',
    'Intuição',
    'Investigação',
    'Medicina',
    'Natureza',
    'Percepção',
    'Persuasão',
    'Prestidigitação',
    'Religião',
    'Sobrevivência',
  ];

  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFromClass();
    _initializeChangeTracking();
  }

  void _initializeChangeTracking() {
    // Aguardar um frame para garantir que os dados foram inicializados
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialData = _getCurrentFormData();
    });
  }

  Map<String, dynamic> _getCurrentFormData() {
    return {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'hit_die': _hitDieController.text,
      'primary_abilities': List.from(_selectedPrimaryAbilities),
      'saving_throws': List.from(_selectedSavingThrows),
      'armor_proficiencies': List.from(_selectedArmorProficiencies),
      'weapon_proficiencies': List.from(_selectedWeaponProficiencies),
      'tool_proficiencies': List.from(_selectedToolProficiencies),
      'skill_proficiencies': List.from(_selectedSkillProficiencies),
      'skill_count': _skillCountController.text,
      'equipment': _equipmentController.text,
      'equipment_lado_a': _equipmentLadoAController.text,
      'equipment_lado_b': _equipmentLadoBController.text,
      'features': _featuresController.text,
      'spellcasting': _spellcastingController.text,
      'subclasses': _subclassesController.text,
      'source': _selectedSource,
      'level_features': List.from(_levelFeatures),
      'has_spells': _hasSpells,
      'spell_levels': List.from(_spellLevels),
    };
  }

  bool _hasUnsavedChanges() {
    if (_initialData == null) return false;
    final currentData = _getCurrentFormData();

    // Comparar dados principais
    for (final key in _initialData!.keys) {
      if (_initialData![key] != currentData[key]) {
        return true;
      }
    }
    return false;
  }

  Future<bool?> _showExitConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Alterações não salvas'),
            content: const Text(
              'Você tem alterações não salvas. Deseja realmente sair sem salvar?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Sair sem salvar'),
              ),
            ],
          ),
    );
  }

  void _onPopInvokedWithResult(bool didPop, Object? result) async {
    if (didPop) {
      return; // O pop já aconteceu (ex: via gesto), não faça nada
    }

    // Se tem mudanças, pergunte ao usuário
    if (_hasUnsavedChanges()) {
      final bool? shouldPop = await _showExitConfirmationDialog();

      if (shouldPop == true) {
        // Se o usuário confirmou, fazemos o pop manualmente
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } else {
      // Se não tem mudanças, permita o pop
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _markAsChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  void _initializeFromClass() {
    final classData = widget.classData;

    _nameController.text = classData['name'] ?? '';
    _descriptionController.text = classData['description'] ?? '';
    _hitDieController.text = classData['hit_die']?.toString() ?? '8';
    // Converter habilidade primária para lista (máximo 2)
    final primaryAbility = classData['primary_ability'];
    if (primaryAbility != null && primaryAbility.isNotEmpty) {
      if (primaryAbility.contains(' e ')) {
        _selectedPrimaryAbilities = primaryAbility.split(' e ');
      } else {
        _selectedPrimaryAbilities = [primaryAbility];
      }
    } else {
      _selectedPrimaryAbilities = [];
    }

    // Validar fonte
    final source = classData['source'];
    _selectedSource = _sourceOptions.contains(source) ? source : null;

    // Carregar testes de resistência
    if (classData['saving_throws'] != null) {
      final savingThrows = classData['saving_throws'];
      if (savingThrows is String) {
        _selectedSavingThrows =
            savingThrows.split(', ').where((e) => e.isNotEmpty).toList();
      } else if (savingThrows is List) {
        _selectedSavingThrows = List<String>.from(savingThrows);
      }
    }

    // Carregar proficiências
    if (classData['armor_proficiencies'] != null) {
      final armorProfs = classData['armor_proficiencies'];
      if (armorProfs is String) {
        _selectedArmorProficiencies =
            armorProfs.split(', ').where((e) => e.isNotEmpty).toList();
      } else if (armorProfs is List) {
        _selectedArmorProficiencies = List<String>.from(armorProfs);
      }
    }
    if (classData['weapon_proficiencies'] != null) {
      final weaponProfs = classData['weapon_proficiencies'];
      if (weaponProfs is String) {
        _selectedWeaponProficiencies =
            weaponProfs.split(', ').where((e) => e.isNotEmpty).toList();
      } else if (weaponProfs is List) {
        _selectedWeaponProficiencies = List<String>.from(weaponProfs);
      }
    }
    if (classData['tool_proficiencies'] != null) {
      final toolProfs = classData['tool_proficiencies'];
      if (toolProfs is String) {
        _selectedToolProficiencies =
            toolProfs.split(', ').where((e) => e.isNotEmpty).toList();
      } else if (toolProfs is List) {
        _selectedToolProficiencies = List<String>.from(toolProfs);
      }
    }
    if (classData['skill_proficiencies'] != null) {
      final skillProfs = classData['skill_proficiencies'];
      if (skillProfs is String) {
        _selectedSkillProficiencies =
            skillProfs.split(', ').where((e) => e.isNotEmpty).toList();
      } else if (skillProfs is List) {
        _selectedSkillProficiencies = List<String>.from(skillProfs);
      }
    }

    _skillCountController.text = classData['skill_count']?.toString() ?? '';
    _equipmentController.text = classData['equipment'] ?? '';
    _equipmentLadoAController.text = classData['equipment_lado_a'] ?? '';
    _equipmentLadoBController.text = classData['equipment_lado_b'] ?? '';
    _featuresController.text = classData['features'] ?? '';

    // Tratar spellcasting que pode ser String ou Map
    if (classData['spellcasting'] != null) {
      if (classData['spellcasting'] is String) {
        _spellcastingController.text = classData['spellcasting'];
      } else if (classData['spellcasting'] is Map) {
        // Converter Map para string legível
        final spellcasting = classData['spellcasting'] as Map<String, dynamic>;
        final ability = spellcasting['ability'] ?? '';
        final type = spellcasting['type'] ?? '';
        _spellcastingController.text = 'Habilidade: $ability, Tipo: $type';
      }
    } else {
      _spellcastingController.text = '';
    }

    // Tratar subclasses que pode ser String ou JSON
    if (classData['subclasses'] != null) {
      if (classData['subclasses'] is String) {
        _subclassesController.text = classData['subclasses'];
      } else if (classData['subclasses'] is List) {
        // Converter List para string legível
        final subclasses = classData['subclasses'] as List;
        final names = subclasses.map((s) => s['name'] ?? 'Sem nome').join(', ');
        _subclassesController.text = 'Subclasses: $names';
      }
    } else {
      _subclassesController.text = '';
    }

    // Carregar características por nível
    if (classData['level_features'] != null) {
      _levelFeatures.clear();
      _levelFeatures.addAll(
        List<Map<String, dynamic>>.from(classData['level_features']),
      );
    }

    // Carregar magias
    _hasSpells = classData['has_spells'] ?? false;
    if (classData['spell_levels'] != null) {
      _spellLevels.clear();
      _spellLevels.addAll(
        List<Map<String, dynamic>>.from(classData['spell_levels']),
      );
    }
    if (classData['spell_slots_levels'] != null) {
      _spellSlotsLevels.clear();
      _spellSlotsLevels.addAll(
        List<Map<String, dynamic>>.from(classData['spell_slots_levels']),
      );
    }

    // Carregar equipamentos lado A e B
    if (classData['equipment_lado_a_items'] != null) {
      _equipmentLadoAItems
        ..clear()
        ..addAll(
          List<Map<String, dynamic>>.from(classData['equipment_lado_a_items']),
        );
    }
    if (classData['equipment_lado_b_items'] != null) {
      _equipmentLadoBItems
        ..clear()
        ..addAll(
          List<Map<String, dynamic>>.from(classData['equipment_lado_b_items']),
        );
    }

    // Carregar PO (Peças de Ouro)
    _poLadoAController.text = classData['po_lado_a']?.toString() ?? '0';
    _poLadoBController.text = classData['po_lado_b']?.toString() ?? '0';

    // Carregar escolhas de equipamento
    if (classData['equipment_choices'] != null) {
      _equipmentChoices
        ..clear()
        ..addAll(
          List<Map<String, dynamic>>.from(classData['equipment_choices']),
        );
    }

    // Carregar subclasses
    if (classData['subclasses_details'] != null) {
      _subclasses.clear();
      _subclasses.addAll(
        List<Map<String, dynamic>>.from(classData['subclasses_details']),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _hitDieController.dispose();
    _equipmentController.dispose();
    _equipmentLadoAController.dispose();
    _equipmentLadoBController.dispose();
    _featuresController.dispose();
    _spellcastingController.dispose();
    _subclassesController.dispose();
    _poLadoAController.dispose();
    _poLadoBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);

    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acesso Negado'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Apenas administradores podem editar classes.'),
        ),
      );
    }

    return PopScope(
      canPop: !_hasUnsavedChanges(),
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Classe'),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _isLoading ? null : _updateClass,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Informações Básicas
                SectionCard(
                  title: 'Informações Básicas',
                  icon: Icons.info,
                  color: Colors.purple,
                  children: [
                    LabeledTextField(
                      controller: _nameController,
                      label: 'Nome da Classe *',
                      hint: 'Ex: Guerreiro',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                      onChanged: (_) => _markAsChanged(),
                    ),
                    const SizedBox(height: 16),
                    AutoGrowTextFormField(
                      controller: _descriptionController,
                      label: 'Descrição',
                      hint: 'Descrição da classe...',
                      onChanged: (_) => _markAsChanged(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            controller: _hitDieController,
                            label: 'Dado de Vida',
                            hint: '8',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Dado de vida é obrigatório';
                              }
                              final die = int.tryParse(value);
                              if (die == null || die < 4 || die > 20) {
                                return 'Dado deve ser entre 4 e 20';
                              }
                              return null;
                            },
                            onChanged: (_) => _markAsChanged(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _buildPrimaryAbilitySelector()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedSource,
                      decoration: const InputDecoration(
                        labelText: 'Fonte *',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items:
                          _sourceOptions
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _selectedSource = v),
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Fonte é obrigatória'
                                  : null,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Proficiências
                _buildSectionCard(
                  context,
                  'Proficiências',
                  Icons.shield,
                  Colors.blue,
                  [
                    _buildMultiSelectField(
                      label: 'Testes de Resistência',
                      selectedItems: _selectedSavingThrows,
                      options: _savingThrowOptions,
                      onChanged: (items) {
                        setState(() => _selectedSavingThrows = items);
                        _markAsChanged();
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMultiSelectField(
                      label: 'Proficiência em Armaduras',
                      selectedItems: _selectedArmorProficiencies,
                      options: _armorProficiencyOptions,
                      onChanged: (items) {
                        setState(() => _selectedArmorProficiencies = items);
                        _markAsChanged();
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildMultiSelectField(
                      label: 'Proficiência em Armas',
                      selectedItems: _selectedWeaponProficiencies,
                      options: _weaponProficiencyOptions,
                      onChanged:
                          (items) => setState(
                            () => _selectedWeaponProficiencies = items,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _buildMultiSelectField(
                      label: 'Proficiência em Ferramentas',
                      selectedItems: _selectedToolProficiencies,
                      options: _toolProficiencyOptions,
                      onChanged:
                          (items) => setState(
                            () => _selectedToolProficiencies = items,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Proficiência em Perícias',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedSkillProficiencies = List.from(
                                        _skillProficiencyOptions,
                                      );
                                    });
                                  },
                                  child: const Text('Todas'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedSkillProficiencies.clear();
                                    });
                                  },
                                  child: const Text('Nenhuma'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap:
                              () => _showMultiSelectDialog(
                                'Proficiência em Perícias',
                                _selectedSkillProficiencies,
                                _skillProficiencyOptions,
                                (items) => setState(
                                  () => _selectedSkillProficiencies = items,
                                ),
                              ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedSkillProficiencies.isEmpty
                                        ? 'Selecione as perícias...'
                                        : '${_selectedSkillProficiencies.length} perícias selecionadas',
                                    style: TextStyle(
                                      color:
                                          _selectedSkillProficiencies.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _skillCountController,
                      label: 'Número de Perícias Escolhíveis',
                      hint: 'Ex: 2',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Equipamentos e Recursos
                _buildSectionCard(
                  context,
                  'Equipamentos e Recursos',
                  Icons.inventory,
                  Colors.green,
                  [
                    _buildEquipmentPicker(
                      title: 'Selecionar Itens (Lado A) a partir do BD',
                      selected: _equipmentLadoAItems,
                      onChanged:
                          (items) => setState(() {
                            _equipmentLadoAItems
                              ..clear()
                              ..addAll(items);
                          }),
                    ),
                    if (_equipmentLadoAItems.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildSelectedEquipmentChips(_equipmentLadoAItems, (e) {
                        setState(() => _equipmentLadoAItems.remove(e));
                      }),
                    ],
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _poLadoAController,
                      label: 'PO (Peças de Ouro) - Lado A',
                      hint: 'Ex: 100',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _buildEquipmentPicker(
                      title: 'Selecionar Itens (Lado B) a partir do BD',
                      selected: _equipmentLadoBItems,
                      onChanged:
                          (items) => setState(() {
                            _equipmentLadoBItems
                              ..clear()
                              ..addAll(items);
                          }),
                    ),
                    if (_equipmentLadoBItems.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildSelectedEquipmentChips(_equipmentLadoBItems, (e) {
                        setState(() => _equipmentLadoBItems.remove(e));
                      }),
                    ],
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _poLadoBController,
                      label: 'PO (Peças de Ouro) - Lado B',
                      hint: 'Ex: 100',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildEquipmentChoicesSection(),
                  ],
                ),

                const SizedBox(height: 24),

                // Ganhos por Nível
                _buildSectionCard(
                  context,
                  'Ganhos por Nível',
                  Icons.trending_up,
                  Colors.orange,
                  [_buildLevelFeaturesSection()],
                ),

                const SizedBox(height: 24),

                // Bônus de Proficiência
                _buildSectionCard(
                  context,
                  'Bônus de Proficiência',
                  Icons.trending_up,
                  Colors.purple,
                  [_buildProficiencyBonusTable()],
                ),

                const SizedBox(height: 24),

                // Magias
                _buildSectionCard(
                  context,
                  'Magias',
                  Icons.auto_awesome,
                  Colors.indigo,
                  [_buildSpellsSection()],
                ),

                const SizedBox(height: 24),

                // Subclasses
                _buildSectionCard(
                  context,
                  'Subclasses',
                  Icons.account_tree,
                  Colors.teal,
                  [_buildSubclassesSection()],
                ),

                const SizedBox(height: 32),

                // Botão Salvar
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _updateClass,
                  icon:
                      _isLoading
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.save),
                  label: Text(
                    _isLoading ? 'Atualizando...' : 'Atualizar Classe',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

                const SizedBox(height: 16),

                // Informações
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text(
                              'Dicas',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '• Campos marcados com * são obrigatórios\n'
                          '• Use vírgulas para separar múltiplos itens\n'
                          '• As informações serão validadas antes de salvar\n'
                          '• A classe ficará disponível para todos os usuários',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildLevelFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool isNarrow = constraints.maxWidth < 420;
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Características por Nível',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addLevelFeature,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Características por Nível',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton.icon(
                  onPressed: _addLevelFeature,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Adicionar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        if (_levelFeatures.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(32),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withAlpha(80)),
            ),
            child: const Text(
              'Nenhuma característica por nível adicionada.\nClique em "Adicionar" para começar.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ..._levelFeatures.asMap().entries.map((entry) {
            final index = entry.key;
            final feature = entry.value;
            return _buildLevelFeatureCard(index, feature);
          }),
      ],
    );
  }

  Widget _buildLevelFeatureCard(int index, Map<String, dynamic> feature) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Nível ${feature['level']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editLevelFeature(index, feature),
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context,
                      title: 'Excluir Característica',
                      itemName: feature['name'] ?? 'Característica',
                      customMessage:
                          'Deseja excluir a característica "${feature['name'] ?? 'Sem nome'}"?',
                    );
                    if (confirmed) _removeLevelFeature(index);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              feature['name'] ?? '',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            if ((feature['description'] ?? '').toString().isNotEmpty)
              CollapsibleRichText(
                feature['description'] ?? '',
                initialMaxLines: 6,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            // Indicador de Defesa sem Armadura
            if (feature['unarmored_defense'] != null) ...[
              const SizedBox(height: 8),
              _buildUnarmoredDefenseIndicator(feature['unarmored_defense']),
            ],
            if (feature['has_usage_limit'] == true) ...[
              const SizedBox(height: 8),
              _buildUsageInfo(feature),
            ],
            if (feature['has_dice_increase'] == true) ...[
              const SizedBox(height: 8),
              _buildDiceInfo(feature),
            ],
            if (feature['has_proficiency_doubling'] == true) ...[
              const SizedBox(height: 8),
              _buildProficiencyInfo(feature),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUnarmoredDefenseIndicator(Map<String, dynamic> udData) {
    final base = udData['base'] as int? ?? 10;
    final abilities = List<String>.from(udData['abilities'] ?? []);
    final allowsShield = udData['allows_shield'] as bool? ?? true;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: Colors.blue, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Defesa sem Armadura',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'CA: $base + ${abilities.join(' + ')}${allowsShield ? ' + Escudo' : ''}',
                  style: TextStyle(fontSize: 11, color: Colors.blue.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageInfo(Map<String, dynamic> feature) {
    final usageType = feature['usage_type'] ?? '';
    final usageValue = feature['usage_value'];
    final usageRecovery = feature['usage_recovery'] ?? '';
    final usageAttribute = feature['usage_attribute'] ?? '';

    String usageText = '';

    switch (usageType) {
      case 'Por Nível':
        usageText = 'Usos: ${usageValue ?? 1} por nível da classe';
        break;
      case 'Por Modificador de Atributo':
        final multiplier = usageValue != null ? ' x $usageValue' : '';
        usageText = 'Usos: Modificador de $usageAttribute$multiplier';
        break;
      case 'Por Proficiência':
        final multiplier = usageValue != null ? ' x $usageValue' : '';
        usageText = 'Usos: Bônus de Proficiência$multiplier';
        break;
      case 'Fixo':
        usageText = 'Usos: ${usageValue ?? 1} por dia';
        break;
      case 'Por Longo Descanso':
        usageText = 'Usos: ${usageValue ?? 1} por longo descanso';
        break;
      case 'Por Curto Descanso':
        usageText = 'Usos: ${usageValue ?? 1} por curto descanso';
        break;
      case 'Manual por Nível':
        final increases =
            (feature['manual_level_increases'] as List<dynamic>?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [];
        if (increases.isNotEmpty) {
          final levels = increases.map((e) => 'Nível ${e['level']}').join(', ');
          usageText = 'Usos: ${usageValue ?? 1} inicial, aumenta em $levels';
        } else {
          usageText = 'Usos: ${usageValue ?? 1} inicial';
        }
        break;
      default:
        usageText = 'Usos limitados';
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(32),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.withAlpha(80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.repeat, size: 16, color: Colors.blue[700]),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  usageText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
          if (usageRecovery.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Recuperação: $usageRecovery',
              style: TextStyle(
                fontSize: 11,
                color: Colors.blue[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDiceInfo(Map<String, dynamic> feature) {
    final initialDice = feature['initial_dice'] ?? '';
    final diceIncreases =
        (feature['dice_increases'] as List<dynamic>?)
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];

    String diceText = 'Dado: $initialDice';
    if (diceIncreases.isNotEmpty) {
      final increases = diceIncreases
          .map((e) => 'Nível ${e['level']}: ${e['dice']}')
          .join(', ');
      diceText = 'Dado: $initialDice, aumenta em $increases';
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(32),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.green.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.casino, size: 16, color: Colors.green[700]),
          const SizedBox(width: 6),
          Text(
            diceText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProficiencyInfo(Map<String, dynamic> feature) {
    final skillCount = feature['proficiency_skill_count'] ?? 0;

    String proficiencyText =
        'Proficiência dobrada em $skillCount perícia${skillCount != 1 ? 's' : ''}';

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(32),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.orange.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.star, size: 16, color: Colors.orange[700]),
          const SizedBox(width: 6),
          Text(
            proficiencyText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }

  void _addLevelFeature() {
    showDialog(
      context: context,
      builder:
          (context) => _LevelFeatureDialog(
            onSave: (feature) {
              setState(() {
                _levelFeatures.add(feature);
                // Ordenar por nível
                _levelFeatures.sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );
              });
            },
          ),
    );
  }

  void _removeLevelFeature(int index) {
    setState(() {
      _levelFeatures.removeAt(index);
    });
  }

  void _editLevelFeature(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _LevelFeatureDialog(
            initialFeature: current,
            onSave: (updated) {
              setState(() {
                _levelFeatures[index] = updated;
                _levelFeatures.sort(
                  (a, b) => (a["level"] as int).compareTo(b["level"] as int),
                );
              });
            },
          ),
    );
  }

  Widget _buildSpellsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox para indicar se a classe tem magias
        CheckboxListTile(
          title: const Text(
            'Esta classe possui magias',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text('Marque se a classe pode conjurar magias'),
          value: _hasSpells,
          onChanged: (value) {
            setState(() {
              _hasSpells = value ?? false;
              if (!_hasSpells) {
                _spellLevels.clear();
                _spellSlotsLevels.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (_hasSpells) ...[
          const SizedBox(height: 16),

          // Ganhos de magias por nível
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 420;
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ganhos de Magias por Nível',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _addSpellLevel,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ganhos de Magias por Nível',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addSpellLevel,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          if (_spellLevels.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.withAlpha(32),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo.withAlpha(80)),
              ),
              child: const Text(
                'Nenhum ganho de magia por nível adicionado.\nClique em "Adicionar" para começar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigo),
              ),
            )
          else
            ..._spellLevels.asMap().entries.map((entry) {
              final index = entry.key;
              final spellLevel = entry.value;
              return _buildSpellLevelCard(index, spellLevel);
            }),

          const SizedBox(height: 24),

          // Espaços de magia por nível
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 420;
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Espaços de Magia por Nível',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _addSpellSlotsLevel,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Espaços de Magia por Nível',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addSpellSlotsLevel,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          if (_spellSlotsLevels.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withAlpha(32),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple.withAlpha(80)),
              ),
              child: const Text(
                'Nenhum espaço de magia por nível adicionado.\nClique em "Adicionar" para começar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple),
              ),
            )
          else
            ..._spellSlotsLevels.asMap().entries.map((entry) {
              final index = entry.key;
              final slotsLevel = entry.value;
              return _buildSpellSlotsLevelCard(index, slotsLevel);
            }),
        ],
      ],
    );
  }

  Widget _buildSpellLevelCard(int index, Map<String, dynamic> spellLevel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Nível ${spellLevel['level']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editSpellLevel(index, spellLevel),
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context,
                      title: 'Excluir Nível de Magia',
                      itemName: 'Nível ${spellLevel['level']}',
                      customMessage:
                          'Deseja excluir o nível ${spellLevel['level']} de magias?',
                    );
                    if (confirmed) _removeSpellLevel(index);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Conhece ${spellLevel['known_spells']} magias e ${spellLevel['cantrips']} truques',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpellSlotsLevelCard(int index, Map<String, dynamic> slotsLevel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Nível ${slotsLevel['level']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editSpellSlotsLevel(index, slotsLevel),
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context,
                      title: 'Excluir Nível de Slots',
                      itemName: 'Nível ${slotsLevel['level']}',
                      customMessage:
                          'Deseja excluir os slots de magia do nível ${slotsLevel['level']}?',
                    );
                    if (confirmed) _removeSpellSlotsLevel(index);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (int i = 1; i <= 9; i++)
                  if (slotsLevel['level_$i'] != null &&
                      slotsLevel['level_$i'] > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withAlpha(32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Nível $i: ${slotsLevel['level_$i']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addSpellLevel() {
    showDialog(
      context: context,
      builder:
          (context) => _SpellLevelDialog(
            onSave: (spellLevel) {
              setState(() {
                _spellLevels.add(spellLevel);
                _spellLevels.sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );
              });
            },
          ),
    );
  }

  void _removeSpellLevel(int index) {
    setState(() {
      _spellLevels.removeAt(index);
    });
  }

  void _editSpellLevel(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _SpellLevelDialog(
            initialSpellLevel: current,
            onSave: (updated) {
              setState(() {
                _spellLevels[index] = updated;
                _spellLevels.sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );
              });
            },
          ),
    );
  }

  void _addSpellSlotsLevel() {
    showDialog(
      context: context,
      builder:
          (context) => _SpellSlotsLevelDialog(
            onSave: (slotsLevel) {
              setState(() {
                _spellSlotsLevels.add(slotsLevel);
                _spellSlotsLevels.sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );
              });
            },
          ),
    );
  }

  void _removeSpellSlotsLevel(int index) {
    setState(() {
      _spellSlotsLevels.removeAt(index);
    });
  }

  void _editSpellSlotsLevel(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _SpellSlotsLevelDialog(
            initialSlotsLevel: current,
            onSave: (updated) {
              setState(() {
                _spellSlotsLevels[index] = updated;
                _spellSlotsLevels.sort(
                  (a, b) => (a['level'] as int).compareTo(b['level'] as int),
                );
              });
            },
          ),
    );
  }

  Widget _buildSubclassesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subclasses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ElevatedButton.icon(
              onPressed: _addSubclass,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Adicionar Subclasse'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
        if (_subclasses.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.withAlpha(32),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.teal.withAlpha(80)),
            ),
            child: const Text(
              'Nenhuma subclasse adicionada.\nClique em "Adicionar Subclasse" para começar.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal),
            ),
          )
        else
          ..._subclasses.asMap().entries.map((entry) {
            final index = entry.key;
            final subclass = entry.value;
            return _buildSubclassCard(index, subclass);
          }),
      ],
    );
  }

  // --- Escolhas de Equipamento ---
  Widget _buildEquipmentChoicesSection() {
    return _buildSectionCard(
      context,
      'Escolhas de Equipamento',
      Icons.checklist,
      Colors.amber,
      [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool isNarrow = constraints.maxWidth < 420;
            final helper = const Text(
              'Defina escolhas como: "1 instrumento musical à sua escolha"',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            );
            final addBtn = ElevatedButton.icon(
              onPressed: _addEquipmentChoice,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Adicionar Escolha'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
            );
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [helper, const SizedBox(height: 8), addBtn],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: helper),
                const SizedBox(width: 8),
                addBtn,
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        if (_equipmentChoices.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.withAlpha(80)),
            ),
            child: const Text(
              'Nenhuma escolha cadastrada',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.amber),
            ),
          )
        else
          ..._equipmentChoices.asMap().entries.map((entry) {
            final index = entry.key;
            final choice = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: CollapsibleRichText(
                  choice['description'] ?? 'Escolha',
                  initialMaxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle:
                    (choice['options'] is List &&
                            (choice['options'] as List).isNotEmpty)
                        ? Text(
                          (choice['options'] as List)
                              .map((e) => e['name'])
                              .whereType<String>()
                              .join(', '),
                        )
                        : const Text('Sem opções cadastradas'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _editEquipmentChoice(index, choice),
                      icon: const Icon(Icons.edit, color: Colors.blueGrey),
                    ),
                    IconButton(
                      onPressed: () async {
                        final confirmed = await showDeleteConfirmationDialog(
                          context,
                          title: 'Excluir Escolha de Equipamento',
                          itemName: 'Escolha de equipamento',
                          customMessage:
                              'Deseja excluir esta escolha de equipamento?',
                        );
                        if (confirmed) {
                          setState(() {
                            _equipmentChoices.removeAt(index);
                          });
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  void _addEquipmentChoice() {
    showDialog(
      context: context,
      builder:
          (context) => _EditEquipmentChoiceDialog(
            onSave: (choice) => setState(() => _equipmentChoices.add(choice)),
          ),
    );
  }

  void _editEquipmentChoice(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _EditEquipmentChoiceDialog(
            initialChoice: current,
            onSave:
                (choice) => setState(() => _equipmentChoices[index] = choice),
          ),
    );
  }

  // Dialogs usados na edição das escolhas de equipamento

  Widget _buildSubclassCard(int index, Map<String, dynamic> subclass) {
    final String name = subclass['name'] ?? '';
    final String description = subclass['description'] ?? '';
    final List<Map<String, dynamic>> features = List<Map<String, dynamic>>.from(
      subclass['features'] ?? [],
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name.isEmpty ? 'Sem nome' : name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _editSubclass(index, subclass),
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context,
                      title: 'Excluir Subclasse',
                      itemName: subclass['name'] ?? 'Subclasse',
                      customMessage:
                          'Deseja excluir a subclasse "${subclass['name'] ?? 'Sem nome'}"?',
                    );
                    if (confirmed) _removeSubclass(index);
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              CollapsibleRichText(
                description,
                initialMaxLines: 8,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 8),
            if (features.isEmpty)
              const Text(
                'Sem habilidades cadastradas',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nível ${f['level']}: ${f['name']}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      if ((f['description'] ?? '').toString().isNotEmpty)
                        CollapsibleRichText(
                          f['description'] ?? '',
                          initialMaxLines: 6,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      if (f['has_usage_limit'] == true) ...[
                        const SizedBox(height: 4),
                        _buildSubclassUsageInfo(f),
                      ],
                      if (f['has_dice_increase'] == true) ...[
                        const SizedBox(height: 4),
                        _buildSubclassDiceInfo(f),
                      ],
                      if (f['has_additional_features'] == true) ...[
                        const SizedBox(height: 4),
                        _buildSubclassAdditionalFeaturesInfo(f),
                      ],
                      if (f['has_hit_point_increase'] == true) ...[
                        const SizedBox(height: 4),
                        _buildSubclassHitPointInfo(f),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _addSubclass() {
    showDialog(
      context: context,
      builder:
          (context) => _SubclassDialog(
            onSave: (subclass) {
              setState(() {
                _subclasses.add(subclass);
              });
            },
          ),
    );
  }

  void _removeSubclass(int index) {
    setState(() {
      _subclasses.removeAt(index);
    });
  }

  void _editSubclass(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _SubclassDialog(
            initialSubclass: current,
            onSave: (updated) {
              setState(() {
                _subclasses[index] = updated;
              });
            },
          ),
    );
  }

  Widget _buildSubclassUsageInfo(Map<String, dynamic> feature) {
    final usageType = feature['usage_type'] ?? '';
    final usageValue = feature['usage_value'];
    final usageRecovery = feature['usage_recovery'] ?? '';
    final usageAttribute = feature['usage_attribute'] ?? '';

    String usageText = '';

    switch (usageType) {
      case 'Por Nível':
        usageText = 'Usos: ${usageValue ?? 1} por nível da classe';
        break;
      case 'Por Modificador de Atributo':
        final multiplier = usageValue != null ? ' x $usageValue' : '';
        usageText = 'Usos: Modificador de $usageAttribute$multiplier';
        break;
      case 'Por Proficiência':
        final multiplier = usageValue != null ? ' x $usageValue' : '';
        usageText = 'Usos: Bônus de Proficiência$multiplier';
        break;
      case 'Fixo':
        usageText = 'Usos: ${usageValue ?? 1} por dia';
        break;
      case 'Por Longo Descanso':
        usageText = 'Usos: ${usageValue ?? 1} por longo descanso';
        break;
      case 'Por Curto Descanso':
        usageText = 'Usos: ${usageValue ?? 1} por curto descanso';
        break;
      case 'Manual por Nível':
        final increases =
            (feature['manual_level_increases'] as List<dynamic>?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [];
        if (increases.isNotEmpty) {
          final levels = increases.map((e) => 'Nível ${e['level']}').join(', ');
          usageText = 'Usos: ${usageValue ?? 1} inicial, aumenta em $levels';
        } else {
          usageText = 'Usos: ${usageValue ?? 1} inicial';
        }
        break;
      default:
        usageText = 'Usos limitados';
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(32),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.repeat, size: 12, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            '$usageText - Recupera: $usageRecovery',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubclassDiceInfo(Map<String, dynamic> feature) {
    final initialDice = feature['initial_dice'] ?? '';
    final diceIncreases =
        (feature['dice_increases'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>() ??
        [];

    String diceText = 'Dado: $initialDice';
    if (diceIncreases.isNotEmpty) {
      final increases = diceIncreases
          .map((inc) => 'N${inc['level']}: ${inc['dice']}')
          .join(', ');
      diceText += ' ($increases)';
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(32),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.casino, size: 12, color: Colors.green[700]),
          const SizedBox(width: 4),
          Text(
            diceText,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubclassAdditionalFeaturesInfo(Map<String, dynamic> feature) {
    final featureName = feature['additional_feature_name'] ?? '';
    final featureDescription = feature['additional_feature_description'] ?? '';

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(32),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.orange.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.star, size: 12, color: Colors.orange[700]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              '$featureName: $featureDescription',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.orange[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubclassHitPointInfo(Map<String, dynamic> feature) {
    final hitPointIncrease = feature['hit_point_increase_per_level'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(32),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.withAlpha(80)),
      ),
      child: Row(
        children: [
          Icon(Icons.favorite, size: 12, color: Colors.red[700]),
          const SizedBox(width: 4),
          Text(
            'Aumento de Vida: +$hitPointIncrease por nível',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryAbilitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidade Primária',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showPrimaryAbilityDialog(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedPrimaryAbilities.isEmpty
                        ? 'Selecione até 2 atributos'
                        : _selectedPrimaryAbilities.join(' e '),
                    style: TextStyle(
                      color:
                          _selectedPrimaryAbilities.isEmpty
                              ? Colors.grey[600]
                              : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (_selectedPrimaryAbilities.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children:
                _selectedPrimaryAbilities.map((ability) {
                  return Chip(
                    label: Text(ability),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedPrimaryAbilities.remove(ability);
                      });
                    },
                  );
                }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildMultiSelectField({
    required String label,
    required List<String> selectedItems,
    required List<String> options,
    required Function(List<String>) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap:
              () => _showMultiSelectDialog(
                label,
                selectedItems,
                options,
                onChanged,
              ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedItems.isEmpty
                        ? 'Selecione as opções...'
                        : selectedItems.join(', '),
                    style: TextStyle(
                      color: selectedItems.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPrimaryAbilityDialog() {
    List<String> tempSelectedAbilities = List.from(_selectedPrimaryAbilities);

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Selecionar Habilidades Primárias'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          _abilityOptions.map((ability) {
                            final isSelected = tempSelectedAbilities.contains(
                              ability,
                            );
                            final canSelect =
                                tempSelectedAbilities.length < 2 || isSelected;

                            return CheckboxListTile(
                              title: Text(ability),
                              value: isSelected,
                              enabled: canSelect,
                              onChanged: (value) {
                                setDialogState(() {
                                  if (value == true) {
                                    if (tempSelectedAbilities.length < 2) {
                                      tempSelectedAbilities.add(ability);
                                    }
                                  } else {
                                    tempSelectedAbilities.remove(ability);
                                  }
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedPrimaryAbilities = tempSelectedAbilities;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showMultiSelectDialog(
    String title,
    List<String> selectedItems,
    List<String> options,
    Function(List<String>) onChanged,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(title),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = selectedItems.contains(option);
                        return CheckboxListTile(
                          title: Text(option),
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedItems.add(option);
                              } else {
                                selectedItems.remove(option);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        onChanged(List.from(selectedItems));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
          ),
    );
  }

  Future<void> _updateClass() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Validar tamanhos antes de salvar
      final skillProficienciesText = _selectedSkillProficiencies.join(', ');
      if (skillProficienciesText.length > 1000) {
        throw Exception(
          'Lista de perícias muito longa. Máximo: 1000 caracteres',
        );
      }

      final savingThrowsText = _selectedSavingThrows.join(', ');
      if (savingThrowsText.length > 500) {
        throw Exception(
          'Lista de testes de resistência muito longa. Máximo: 500 caracteres',
        );
      }

      final classData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'hit_die': int.parse(_hitDieController.text),
        'primary_ability': _selectedPrimaryAbilities.join(' e '),
        'source': _selectedSource,
        'saving_throws': savingThrowsText,
        'armor_proficiencies': _selectedArmorProficiencies.join(', '),
        'weapon_proficiencies': _selectedWeaponProficiencies.join(', '),
        'tool_proficiencies': _selectedToolProficiencies.join(', '),
        'skill_proficiencies': skillProficienciesText,
        'skill_count': int.tryParse(_skillCountController.text) ?? 2,
        // 'equipment' removido: usamos apenas lados A/B
        'equipment_lado_a_items': _equipmentLadoAItems,
        'equipment_lado_b_items': _equipmentLadoBItems,
        'po_lado_a': int.tryParse(_poLadoAController.text) ?? 0,
        'po_lado_b': int.tryParse(_poLadoBController.text) ?? 0,
        'equipment_choices': _equipmentChoices,
        'level_features':
            _levelFeatures.map((feature) {
              return {
                'level': feature['level'],
                'name': feature['name'],
                'description': feature['description'],
                'has_usage_limit': feature['has_usage_limit'],
                if (feature['subabilities'] != null)
                  'subabilities': feature['subabilities'],
                if (feature['has_usage_limit'] == true) ...{
                  'usage_type': feature['usage_type'],
                  'usage_value': feature['usage_value'],
                  'usage_recovery': feature['usage_recovery'],
                  'usage_attribute': feature['usage_attribute'],
                  if (feature['usage_type'] == 'Manual por Nível') ...{
                    'manual_level_increases': feature['manual_level_increases'],
                  },
                },
                'has_dice_increase': feature['has_dice_increase'],
                if (feature['has_dice_increase'] == true) ...{
                  'initial_dice': feature['initial_dice'],
                  'dice_increases': feature['dice_increases'],
                },
                'has_proficiency_doubling': feature['has_proficiency_doubling'],
                if (feature['has_proficiency_doubling'] == true) ...{
                  'proficiency_skill_count': feature['proficiency_skill_count'],
                },
                if (feature['unarmored_defense'] != null)
                  'unarmored_defense': feature['unarmored_defense'],
              };
            }).toList(),
        'has_spells': _hasSpells,
        'spell_levels': _spellLevels,
        'spell_slots_levels': _spellSlotsLevels,
        // 'features' removido desta versão
        'spellcasting': _spellcastingController.text.trim(),
        'subclasses': _subclassesController.text.trim(),
        'subclasses_details': _subclasses,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await SupabaseService.client
          .from('classes')
          .update(classData)
          .eq('id', widget.classData['id']);

      if (mounted) {
        // Atualizar os dados locais após salvar
        widget.classData.updateAll((key, value) => classData[key] ?? value);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Classe atualizada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar classe: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // UI helpers
  Widget _buildEquipmentPicker({
    required String title,
    required List<Map<String, dynamic>> selected,
    required ValueChanged<List<Map<String, dynamic>>> onChanged,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton.icon(
        onPressed: () async {
          final picked = await _showSelectEquipmentDialog(selected);
          if (picked != null) onChanged(picked);
        },
        icon: const Icon(Icons.add_shopping_cart),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade50,
          foregroundColor: Colors.green.shade800,
        ),
      ),
    );
  }

  Widget _buildSelectedEquipmentChips(
    List<Map<String, dynamic>> list,
    ValueChanged<Map<String, dynamic>> onRemove,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          list
              .map(
                (item) => Chip(
                  label: Text(
                    '${item['name']} (${item['quantity']}x)${item['cost'] != null ? ' - ${item['cost']}' : ''}',
                  ),
                  onDeleted: () => onRemove(item),
                ),
              )
              .toList(),
    );
  }

  Future<List<Map<String, dynamic>>?> _showSelectEquipmentDialog(
    List<Map<String, dynamic>> current,
  ) async {
    final all = await EquipmentService.loadAll();
    final selected = current.map((e) => e['name'] as String).toSet();

    return showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (context) {
        final TextEditingController search = TextEditingController();
        String? selectedType;
        List<Equipment> filtered = List.of(all);
        final Map<String, int> quantities = {};

        // Obter tipos únicos dos equipamentos
        final types = all.map((e) => e.type).toSet().toList()..sort();

        void apply() {
          filtered =
              all.where((e) {
                final matchesSearch = e.name.toLowerCase().contains(
                  search.text.toLowerCase(),
                );
                final matchesType =
                    selectedType == null || e.type == selectedType;
                return matchesSearch && matchesType;
              }).toList();
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Selecionar Itens'),
              content: SizedBox(
                width: 520,
                height: 420,
                child: Column(
                  children: [
                    TextField(
                      controller: search,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar item...',
                      ),
                      onChanged: (_) => setState(apply),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por tipo',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Todos os tipos'),
                        ),
                        ...types.map(
                          (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          apply();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final eq = filtered[index];
                          final isSel = selected.contains(eq.name);
                          final quantity = quantities[eq.name] ?? 1;

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: ListTile(
                              title: Text(eq.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eq.cost != null
                                        ? 'Custo: ${eq.cost}'
                                        : 'Sem custo',
                                  ),
                                  Text(
                                    'Tipo: ${eq.type}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isSel) ...[
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 1) {
                                            quantities[eq.name] = quantity - 1;
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text('$quantity'),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantities[eq.name] = quantity + 1;
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                  Checkbox(
                                    value: isSel,
                                    onChanged: (v) {
                                      setState(() {
                                        if (v == true) {
                                          selected.add(eq.name);
                                          quantities[eq.name] = 1;
                                        } else {
                                          selected.remove(eq.name);
                                          quantities.remove(eq.name);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
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
                ElevatedButton(
                  onPressed: () {
                    final result =
                        all
                            .where((e) => selected.contains(e.name))
                            .map(
                              (eq) => {
                                'name': eq.name,
                                'category': eq.category,
                                'cost': eq.cost,
                                'weight': eq.weight,
                                'quantity': quantities[eq.name] ?? 1,
                              },
                            )
                            .toList();
                    Navigator.pop(context, result);
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildProficiencyBonusTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tabela de Bônus de Proficiência',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Esta tabela mostra o bônus de proficiência padrão do D&D 5e para todos os níveis.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Cabeçalho da tabela
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Nível',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Bônus de Proficiência',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Linhas da tabela
                  ...List.generate(20, (index) {
                    final level = index + 1;
                    final bonus = ((level - 1) ~/ 4) + 2;
                    final isEven = index % 2 == 0;

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isEven ? Colors.white : Colors.grey[50],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '$level°',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '+$bonus',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[700],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700], size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'O bônus de proficiência é aplicado automaticamente em testes de perícia, ataques e CD de magias.',
                      style: TextStyle(color: Colors.blue[700], fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelFeatureDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialFeature;

  const _LevelFeatureDialog({required this.onSave, this.initialFeature});

  @override
  State<_LevelFeatureDialog> createState() => _LevelFeatureDialogState();
}

class _LevelFeatureDialogState extends State<_LevelFeatureDialog> {
  final _formKey = GlobalKey<FormState>();
  final _levelController = TextEditingController();
  final _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Campos para número de usos
  bool _hasUsageLimit = false;
  String? _usageType;
  final _usageValueController = TextEditingController();
  final _usageRecoveryController = TextEditingController();

  // Campos para dados que aumentam
  bool _hasDiceIncrease = false;
  final _diceController = TextEditingController();
  final List<Map<String, dynamic>> _diceIncreases = [];

  // Campos para proficiência dobrada
  bool _hasProficiencyDoubling = false;
  final _proficiencySkillCountController = TextEditingController();

  // UD state (por diálogo)
  bool _udEnabled = false;
  final TextEditingController _udBaseController = TextEditingController(
    text: '10',
  );
  final List<String> _udAbilities = [];
  bool _udAllowsShield = true;

  // Sub-habilidades (para carrossel na ficha)
  final List<Map<String, dynamic>> _subabilities = [];

  // Opções para tipo de uso
  final List<String> _usageTypeOptions = [
    'Por Nível',
    'Manual por Nível',
    'Por Modificador de Atributo',
    'Por Proficiência',
    'Fixo',
    'Por Longo Descanso',
    'Por Curto Descanso',
  ];

  // Opções para atributos
  final List<String> _attributeOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];

  String? _selectedAttribute;

  // Para aumentos manuais por nível
  final List<Map<String, dynamic>> _manualLevelIncreases = [];

  @override
  void dispose() {
    _levelController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _usageValueController.dispose();
    _usageRecoveryController.dispose();
    _diceController.dispose();
    _proficiencySkillCountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialFeature != null) {
      // Preencher campos na inicialização
      _levelController.text =
          (widget.initialFeature!["level"] as int).toString();
      _nameController.text = widget.initialFeature!["name"] ?? '';
      _descriptionController.text = widget.initialFeature!["description"] ?? '';

      // Carregar dados de uso se existirem
      _hasUsageLimit = (widget.initialFeature?['has_usage_limit'] ?? false);

      if (_hasUsageLimit) {
        _usageType = widget.initialFeature!["usage_type"];
        _usageValueController.text =
            widget.initialFeature!["usage_value"]?.toString() ?? '';
        _usageRecoveryController.text =
            widget.initialFeature!["usage_recovery"] ?? '';
        _selectedAttribute = widget.initialFeature!["usage_attribute"];

        // Carregar aumentos manuais se existirem
        if (widget.initialFeature!["manual_level_increases"] != null) {
          _manualLevelIncreases.clear();
          final rawIncreases =
              widget.initialFeature!["manual_level_increases"]
                  as List<dynamic>?;
          if (rawIncreases != null) {
            _manualLevelIncreases.addAll(
              rawIncreases.map((e) => Map<String, dynamic>.from(e)).toList(),
            );
          }
        }
      }

      // Carregar dados que aumentam se existirem
      _hasDiceIncrease = (widget.initialFeature?['has_dice_increase'] ?? false);
      if (_hasDiceIncrease) {
        _diceController.text = widget.initialFeature!["initial_dice"] ?? '';

        if (widget.initialFeature!["dice_increases"] != null) {
          _diceIncreases.clear();
          final rawDiceIncreases =
              widget.initialFeature!["dice_increases"] as List<dynamic>?;
          if (rawDiceIncreases != null) {
            _diceIncreases.addAll(
              rawDiceIncreases
                  .map((e) => Map<String, dynamic>.from(e))
                  .toList(),
            );
          }
        }
      }

      // Carregar proficiência dobrada se existir
      _hasProficiencyDoubling =
          (widget.initialFeature?['has_proficiency_doubling'] ?? false);
      if (_hasProficiencyDoubling) {
        _proficiencySkillCountController.text =
            widget.initialFeature!["proficiency_skill_count"]?.toString() ?? '';
      }

      // Carregar UD se existir
      final ud =
          widget.initialFeature!["unarmored_defense"] as Map<String, dynamic>?;
      if (ud != null) {
        _udEnabled = true;
        _udBaseController.text = (ud['base']?.toString() ?? '10');
        _udAbilities
          ..clear()
          ..addAll(
            List<String>.from(
              (ud['abilities'] as List?)?.map((e) => e.toString()) ?? const [],
            ),
          );
        _udAllowsShield = (ud['allows_shield'] ?? true) == true;
      } else {
        _udEnabled = false;
        _udAbilities.clear();
        _udBaseController.text = '10';
        _udAllowsShield = true;
      }
      // Carregar sub-habilidades se existirem
      final rawSubs = widget.initialFeature!["subabilities"];
      if (rawSubs is List) {
        _subabilities
          ..clear()
          ..addAll(rawSubs.map((e) => Map<String, dynamic>.from(e)).toList());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.initialFeature != null
                    ? 'Editar Característica por Nível'
                    : 'Adicionar Característica por Nível',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<int>(
                        value:
                            _levelController.text.isEmpty
                                ? null
                                : int.tryParse(_levelController.text),
                        decoration: const InputDecoration(
                          labelText: 'Nível *',
                          border: OutlineInputBorder(),
                        ),
                        items: List.generate(
                          20,
                          (i) => DropdownMenuItem(
                            value: i + 1,
                            child: Text('Nível ${i + 1}'),
                          ),
                        ),
                        onChanged:
                            (v) => setState(() {
                              _levelController.text = v?.toString() ?? '';
                            }),
                        validator: (value) {
                          if (value == null) return 'Nível é obrigatório';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome da Característica *',
                          hintText: 'Ex: Ataque Extra, Magia de Nível 1...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome é obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      FormattedTextEditor(
                        controller: _descriptionController,
                        label: 'Descrição *',
                        hint:
                            'Escreva a descrição com formatações (negrito, itálico, sublinhado)...',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Descrição é obrigatória';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Seção de Sub-habilidades
                      _buildSubabilitiesSection(),

                      const SizedBox(height: 16),

                      // Seção de número de usos
                      _buildUsageLimitSection(),

                      const SizedBox(height: 16),

                      // Seção de dados que aumentam
                      _buildDiceIncreaseSection(),

                      const SizedBox(height: 16),

                      // Seção de proficiência dobrada
                      _buildProficiencyDoublingSection(),

                      const SizedBox(height: 16),

                      // Seção de Defesa sem Armadura
                      _buildUnarmoredDefenseSection(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final feature = {
                          'level': int.parse(_levelController.text),
                          'name': _nameController.text.trim(),
                          'description': _descriptionController.text.trim(),
                          'has_usage_limit': _hasUsageLimit,
                          if (_hasUsageLimit) ...{
                            'usage_type': _usageType,
                            'usage_value':
                                _usageValueController.text.isNotEmpty
                                    ? int.tryParse(_usageValueController.text)
                                    : null,
                            'usage_recovery':
                                _usageRecoveryController.text.trim(),
                            'usage_attribute': _selectedAttribute,
                            if (_usageType == 'Manual por Nível') ...{
                              'manual_level_increases': _manualLevelIncreases,
                            },
                          },
                          'has_dice_increase': _hasDiceIncrease,
                          if (_hasDiceIncrease) ...{
                            'initial_dice': _diceController.text.trim(),
                            'dice_increases': _diceIncreases,
                          },
                          'has_proficiency_doubling': _hasProficiencyDoubling,
                          if (_hasProficiencyDoubling) ...{
                            'proficiency_skill_count':
                                int.tryParse(
                                  _proficiencySkillCountController.text,
                                ) ??
                                0,
                          },
                          if (_udEnabled)
                            'unarmored_defense': {
                              'base':
                                  int.tryParse(_udBaseController.text) ?? 10,
                              'abilities': List<String>.from(_udAbilities),
                              'allows_shield': _udAllowsShield,
                            },
                          if (_subabilities.isNotEmpty)
                            'subabilities': _subabilities,
                        };
                        widget.onSave(feature);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      widget.initialFeature != null ? 'Salvar' : 'Adicionar',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubabilitiesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub-habilidades (carrossel)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addSubability,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar sub-habilidade',
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_subabilities.isEmpty)
              const Text(
                'Nenhuma sub-habilidade adicionada. Use o + para incluir seções.',
                style: TextStyle(color: Colors.grey),
              )
            else
              ..._subabilities.asMap().entries.map((entry) {
                final index = entry.key;
                final sub = entry.value;
                final title =
                    (sub['name'] ?? sub['title'] ?? 'Seção') as String;
                // descrição não é mais usada na pré-visualização da lista
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(title),
                    subtitle: null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _editSubability(index, sub),
                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                        ),
                        IconButton(
                          onPressed: () async {
                            final confirmed = await showDeleteConfirmationDialog(
                              context,
                              title: 'Excluir Sub-habilidade',
                              itemName: sub['name'] ?? 'Sub-habilidade',
                              customMessage:
                                  'Deseja excluir a sub-habilidade "${sub['name'] ?? 'Sem nome'}"?',
                            );
                            if (confirmed) {
                              setState(() => _subabilities.removeAt(index));
                            }
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Future<void> _addSubability() async {
    final created = await _showEditSubabilityDialog();
    if (created != null) {
      setState(() => _subabilities.add(created));
    }
  }

  Future<void> _editSubability(int index, Map<String, dynamic> current) async {
    final edited = await _showEditSubabilityDialog(current: current);
    if (edited != null) {
      setState(() => _subabilities[index] = edited);
    }
  }

  Future<Map<String, dynamic>?> _showEditSubabilityDialog({
    Map<String, dynamic>? current,
  }) {
    final TextEditingController name = TextEditingController(
      text: (current?['name'] ?? current?['title'] ?? '')?.toString(),
    );
    final TextEditingController description = TextEditingController(
      text: (current?['description'] ?? current?['text'] ?? '')?.toString(),
    );
    return showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            current == null
                ? 'Adicionar Sub-habilidade'
                : 'Editar Sub-habilidade',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
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
            ElevatedButton(
              onPressed: () {
                final map = {
                  'name': name.text.trim(),
                  'description': description.text.trim(),
                };
                Navigator.pop(context, map);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUsageLimitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox para habilitar limite de usos
        CheckboxListTile(
          title: const Text(
            'Esta habilidade tem limite de usos',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se a habilidade tem número limitado de usos',
          ),
          value: _hasUsageLimit,
          onChanged: (value) {
            setState(() {
              _hasUsageLimit = value ?? false;
              if (!_hasUsageLimit) {
                _usageType = null;
                _usageValueController.clear();
                _usageRecoveryController.clear();
                _selectedAttribute = null;
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (_hasUsageLimit) ...[
          const SizedBox(height: 16),

          // Tipo de uso
          DropdownButtonFormField<String>(
            value: _usageType,
            decoration: const InputDecoration(
              labelText: 'Tipo de Limite de Uso *',
              border: OutlineInputBorder(),
            ),
            items:
                _usageTypeOptions
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                _usageType = value;
                // Limpar campos relacionados quando mudar o tipo
                _usageValueController.clear();
                _selectedAttribute = null;
              });
            },
            validator: (value) {
              if (_hasUsageLimit && (value == null || value.isEmpty)) {
                return 'Tipo de uso é obrigatório';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Campo de valor baseado no tipo selecionado
          _buildUsageValueField(),

          const SizedBox(height: 16),

          // Campo de recuperação
          TextFormField(
            controller: _usageRecoveryController,
            decoration: const InputDecoration(
              labelText: 'Recuperação de Usos',
              hintText: 'Ex: Recupera todos os usos após um longo descanso',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ],
    );
  }

  Widget _buildUsageValueField() {
    if (_usageType == null) return const SizedBox.shrink();

    switch (_usageType) {
      case 'Por Nível':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Usos por Nível *',
            hintText: 'Ex: 1 (1 uso por nível da classe)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      case 'Manual por Nível':
        return Column(
          children: [
            TextFormField(
              controller: _usageValueController,
              decoration: const InputDecoration(
                labelText: 'Usos Iniciais *',
                hintText: 'Ex: 2 (número de usos no nível 1)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
                  return 'Valor inicial é obrigatório';
                }
                final parsed = int.tryParse(value ?? '');
                if (value != null &&
                    value.isNotEmpty &&
                    (parsed == null || parsed < 1)) {
                  return 'Deve ser um número maior que 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildManualLevelIncreasesSection(),
          ],
        );

      case 'Por Modificador de Atributo':
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedAttribute,
              decoration: const InputDecoration(
                labelText: 'Atributo *',
                border: OutlineInputBorder(),
              ),
              items:
                  _attributeOptions
                      .map(
                        (attr) =>
                            DropdownMenuItem(value: attr, child: Text(attr)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAttribute = value;
                });
              },
              validator: (value) {
                if (_hasUsageLimit && (value == null || value.isEmpty)) {
                  return 'Atributo é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _usageValueController,
              decoration: const InputDecoration(
                labelText: 'Multiplicador (opcional)',
                hintText: 'Ex: 2 (2x o modificador)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 1) {
                    return 'Deve ser um número maior que 0';
                  }
                }
                return null;
              },
            ),
          ],
        );

      case 'Por Proficiência':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Multiplicador (opcional)',
            hintText: 'Ex: 2 (2x o bônus de proficiência)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final parsed = int.tryParse(value);
              if (parsed == null || parsed < 1) {
                return 'Deve ser um número maior que 0';
              }
            }
            return null;
          },
        );

      case 'Fixo':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Número Fixo de Usos *',
            hintText: 'Ex: 3',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      case 'Por Longo Descanso':
      case 'Por Curto Descanso':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Número de Usos *',
            hintText: 'Ex: 2',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildManualLevelIncreasesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aumentos por Nível',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addManualLevelIncrease,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar aumento',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Defina em quais níveis o número de usos aumenta (ex: nível 3, 6, 12, 17)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),
            if (_manualLevelIncreases.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Nenhum aumento definido. Clique no + para adicionar.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ..._manualLevelIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final increase = entry.value;
                return _buildManualLevelIncreaseCard(index, increase);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildManualLevelIncreaseCard(
    int index,
    Map<String, dynamic> increase,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<int>(
                value: increase['level'],
                decoration: const InputDecoration(
                  labelText: 'Nível',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _manualLevelIncreases[index]['level'] = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Selecione um nível';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: increase['increase']?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Aumento',
                  hintText: 'Ex: +1',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _manualLevelIncreases[index]['increase'] =
                      int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Valor obrigatório';
                  }
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 1) {
                    return 'Deve ser > 0';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Excluir Aumento Manual',
                  itemName: 'Aumento de nível',
                  customMessage: 'Deseja excluir este aumento manual de nível?',
                );
                if (confirmed) _removeManualLevelIncrease(index);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Remover',
            ),
          ],
        ),
      ),
    );
  }

  void _addManualLevelIncrease() {
    setState(() {
      _manualLevelIncreases.add({'level': 2, 'increase': 1});
    });
  }

  void _removeManualLevelIncrease(int index) {
    setState(() {
      _manualLevelIncreases.removeAt(index);
    });
  }

  Widget _buildDiceIncreaseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox para habilitar dados que aumentam
        CheckboxListTile(
          title: const Text(
            'Esta habilidade tem dados que aumentam',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se os dados da habilidade aumentam por nível',
          ),
          value: _hasDiceIncrease,
          onChanged: (value) {
            setState(() {
              _hasDiceIncrease = value ?? false;
              if (!_hasDiceIncrease) {
                _diceController.clear();
                _diceIncreases.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (_hasDiceIncrease) ...[
          const SizedBox(height: 16),

          // Dado inicial
          TextFormField(
            controller: _diceController,
            decoration: const InputDecoration(
              labelText: 'Dado Inicial *',
              hintText: 'Ex: 1d4, 1d6, 2d4...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (_hasDiceIncrease && (value == null || value.trim().isEmpty)) {
                return 'Dado inicial é obrigatório';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Aumentos de dados por nível
          _buildDiceIncreasesSection(),
        ],
      ],
    );
  }

  Widget _buildDiceIncreasesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aumentos de Dados por Nível',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addDiceIncrease,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar aumento de dado',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Defina em quais níveis o dado aumenta (ex: nível 5: 1d6, nível 11: 1d8)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),
            if (_diceIncreases.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Nenhum aumento de dado definido. Clique no + para adicionar.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ..._diceIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final increase = entry.value;
                return _buildDiceIncreaseCard(index, increase);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceIncreaseCard(int index, Map<String, dynamic> increase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<int>(
                value: increase['level'],
                decoration: const InputDecoration(
                  labelText: 'Nível',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _diceIncreases[index]['level'] = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Selecione um nível';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: increase['dice']?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Novo Dado',
                  hintText: 'Ex: 1d6',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                onChanged: (value) {
                  _diceIncreases[index]['dice'] = value.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Dado obrigatório';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Excluir Aumento de Dado',
                  itemName: 'Aumento de dado',
                  customMessage: 'Deseja excluir este aumento de dado?',
                );
                if (confirmed) _removeDiceIncrease(index);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Remover',
            ),
          ],
        ),
      ),
    );
  }

  void _addDiceIncrease() {
    setState(() {
      _diceIncreases.add({'level': 2, 'dice': '1d6'});
    });
  }

  void _removeDiceIncrease(int index) {
    setState(() {
      _diceIncreases.removeAt(index);
    });
  }

  Widget _buildProficiencyDoublingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox para habilitar proficiência dobrada
        CheckboxListTile(
          title: const Text(
            'Esta habilidade dobra proficiência',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se a habilidade dobra o valor de proficiência em perícias',
          ),
          value: _hasProficiencyDoubling,
          onChanged: (value) {
            setState(() {
              _hasProficiencyDoubling = value ?? false;
              if (!_hasProficiencyDoubling) {
                _proficiencySkillCountController.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (_hasProficiencyDoubling) ...[
          const SizedBox(height: 16),

          // Número de perícias afetadas
          TextFormField(
            controller: _proficiencySkillCountController,
            decoration: const InputDecoration(
              labelText: 'Número de Perícias *',
              hintText: 'Ex: 2, 4, 6...',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (_hasProficiencyDoubling &&
                  (value == null || value.trim().isEmpty)) {
                return 'Número de perícias é obrigatório';
              }
              if (_hasProficiencyDoubling &&
                  (int.tryParse(value ?? '') ?? 0) <= 0) {
                return 'Número deve ser maior que zero';
              }
              return null;
            },
          ),
        ],
      ],
    );
  }

  Widget _buildUnarmoredDefenseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text(
            'Defesa sem Armadura (UD) para esta característica',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text('Define uma fórmula de CA quando sem armadura'),
          value: _udEnabled,
          onChanged: (value) {
            setState(() {
              _udEnabled = value ?? false;
              if (!_udEnabled) {
                _udBaseController.text = '10';
                _udAbilities.clear();
                _udAllowsShield = true;
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (_udEnabled) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: _udBaseController,
            decoration: const InputDecoration(
              labelText: 'CA Base',
              hintText: 'Ex: 10',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const Text(
            'Atributos que somam na CA:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _attributeOptions.map((attr) {
                  final selected = _udAbilities.contains(attr);
                  return FilterChip(
                    label: Text(attr),
                    selected: selected,
                    onSelected: (v) {
                      setState(() {
                        if (v) {
                          if (!_udAbilities.contains(attr)) {
                            _udAbilities.add(attr);
                          }
                        } else {
                          _udAbilities.remove(attr);
                        }
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Permite Escudo'),
            subtitle: const Text('Se a UD permite somar +2 de escudo'),
            value: _udAllowsShield,
            onChanged: (v) => setState(() => _udAllowsShield = v),
            dense: true,
          ),
        ],
      ],
    );
  }
}

class _SpellLevelDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialSpellLevel;

  const _SpellLevelDialog({required this.onSave, this.initialSpellLevel});

  @override
  State<_SpellLevelDialog> createState() => _SpellLevelDialogState();
}

class _SpellLevelDialogState extends State<_SpellLevelDialog> {
  final _formKey = GlobalKey<FormState>();
  final _levelController = TextEditingController();
  final _knownSpellsController = TextEditingController();
  final _cantripsController = TextEditingController();

  @override
  void dispose() {
    _levelController.dispose();
    _knownSpellsController.dispose();
    _cantripsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialSpellLevel != null && _levelController.text.isEmpty) {
      _levelController.text =
          (widget.initialSpellLevel!['level'] as int).toString();
      _knownSpellsController.text =
          (widget.initialSpellLevel!['known_spells'] as int).toString();
      _cantripsController.text =
          (widget.initialSpellLevel!['cantrips'] as int).toString();
    }

    return AlertDialog(
      title: const Text('Adicionar Ganho de Magias por Nível'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value:
                  _levelController.text.isEmpty
                      ? null
                      : int.tryParse(_levelController.text),
              decoration: const InputDecoration(
                labelText: 'Nível *',
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                20,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text('Nível ${i + 1}'),
                ),
              ),
              onChanged:
                  (v) => setState(() {
                    _levelController.text = v?.toString() ?? '';
                  }),
              validator: (value) {
                if (value == null) return 'Nível é obrigatório';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _knownSpellsController,
              decoration: const InputDecoration(
                labelText: 'Magias Conhecidas *',
                hintText: 'Ex: 2',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Número de magias é obrigatório';
                }
                final spells = int.tryParse(value);
                if (spells == null || spells < 0) {
                  return 'Deve ser um número válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cantripsController,
              decoration: const InputDecoration(
                labelText: 'Truques Conhecidos *',
                hintText: 'Ex: 3',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Número de truques é obrigatório';
                }
                final cantrips = int.tryParse(value);
                if (cantrips == null || cantrips < 0) {
                  return 'Deve ser um número válido';
                }
                return null;
              },
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
            if (_formKey.currentState!.validate()) {
              final spellLevel = {
                'level': int.parse(_levelController.text),
                'known_spells': int.parse(_knownSpellsController.text),
                'cantrips': int.parse(_cantripsController.text),
              };
              widget.onSave(spellLevel);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}

class _SpellSlotsLevelDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialSlotsLevel;

  const _SpellSlotsLevelDialog({required this.onSave, this.initialSlotsLevel});

  @override
  State<_SpellSlotsLevelDialog> createState() => _SpellSlotsLevelDialogState();
}

class _SpellSlotsLevelDialogState extends State<_SpellSlotsLevelDialog> {
  final _formKey = GlobalKey<FormState>();
  final _levelController = TextEditingController();
  final List<TextEditingController> _slotControllers = List.generate(
    9,
    (i) => TextEditingController(),
  );

  @override
  void dispose() {
    _levelController.dispose();
    for (var controller in _slotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialSlotsLevel != null && _levelController.text.isEmpty) {
      _levelController.text =
          (widget.initialSlotsLevel!['level'] as int).toString();
      for (int i = 1; i <= 9; i++) {
        final slots = widget.initialSlotsLevel!['level_$i'] as int?;
        _slotControllers[i - 1].text = slots?.toString() ?? '';
      }
    }

    return AlertDialog(
      title: const Text('Adicionar Espaços de Magia por Nível'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value:
                    _levelController.text.isEmpty
                        ? null
                        : int.tryParse(_levelController.text),
                decoration: const InputDecoration(
                  labelText: 'Nível *',
                  border: OutlineInputBorder(),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged:
                    (v) => setState(() {
                      _levelController.text = v?.toString() ?? '';
                    }),
                validator: (value) {
                  if (value == null) return 'Nível é obrigatório';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Espaços de Magia por Nível:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...List.generate(9, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _slotControllers[i],
                    decoration: InputDecoration(
                      labelText: 'Nível ${i + 1}',
                      hintText: 'Ex: 2',
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final slots = int.tryParse(value);
                        if (slots == null || slots < 0) {
                          return 'Deve ser um número válido';
                        }
                      }
                      return null;
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final slotsLevel = {'level': int.parse(_levelController.text)};

              for (int i = 1; i <= 9; i++) {
                final slots = int.tryParse(_slotControllers[i - 1].text);
                if (slots != null && slots > 0) {
                  slotsLevel['level_$i'] = slots;
                }
              }

              widget.onSave(slotsLevel);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}

class _SubclassDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialSubclass;

  const _SubclassDialog({required this.onSave, this.initialSubclass});

  @override
  State<_SubclassDialog> createState() => _SubclassDialogState();
}

class _SubclassDialogState extends State<_SubclassDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> _features = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialSubclass != null) {
      _nameController.text = widget.initialSubclass!['name'] ?? '';
      _descriptionController.text =
          widget.initialSubclass!['description'] ?? '';
      _features.addAll(
        List<Map<String, dynamic>>.from(
          widget.initialSubclass!['features'] ?? [],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Subclasse'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Subclasse *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormattedTextEditor(
                controller: _descriptionController,
                label: 'Descrição da Subclasse',
                hint: 'Escreva a descrição com formatações...',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Habilidades por Nível',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addFeature,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_features.isEmpty)
                const Text(
                  'Nenhuma habilidade adicionada',
                  style: TextStyle(color: Colors.grey),
                )
              else
                ..._features.asMap().entries.map((entry) {
                  final index = entry.key;
                  final f = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text('Nível ${f['level']}: ${f['name']}'),
                      subtitle:
                          (f['description'] ?? '').toString().isEmpty
                              ? null
                              : CollapsibleRichText(
                                f['description'] ?? '',
                                initialMaxLines: 4,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editFeature(index, f),
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final confirmed = await showDeleteConfirmationDialog(
                                context,
                                title: 'Excluir Característica',
                                itemName: f['name'] ?? 'Característica',
                                customMessage:
                                    'Deseja excluir a característica "${f['name'] ?? 'Sem nome'}"?',
                              );
                              if (confirmed) {
                                setState(() => _features.removeAt(index));
                              }
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final subclass = {
                'name': _nameController.text.trim(),
                'description': _descriptionController.text.trim(),
                'features':
                    _features..sort(
                      (a, b) =>
                          (a['level'] as int).compareTo(b['level'] as int),
                    ),
              };
              widget.onSave(subclass);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  void _addFeature() {
    showDialog(
      context: context,
      builder:
          (context) => _SubclassFeatureDialog(
            onSave: (f) => setState(() => _features.add(f)),
          ),
    );
  }

  void _editFeature(int index, Map<String, dynamic> current) {
    showDialog(
      context: context,
      builder:
          (context) => _SubclassFeatureDialog(
            initialFeature: current,
            onSave: (f) => setState(() => _features[index] = f),
          ),
    );
  }
}

class _SubclassFeatureDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialFeature;

  const _SubclassFeatureDialog({required this.onSave, this.initialFeature});

  @override
  State<_SubclassFeatureDialog> createState() => _SubclassFeatureDialogState();
}

class _SubclassFeatureDialogState extends State<_SubclassFeatureDialog> {
  final _formKey = GlobalKey<FormState>();
  final _levelController = TextEditingController();
  final _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Campos para condições de uso
  bool _hasUsageLimit = false;
  String? _usageType;
  final _usageValueController = TextEditingController();
  String? _usageRecovery;
  String? _usageAttribute;

  // Campos para aumento de dados
  bool _hasDiceIncrease = false;
  final _initialDiceController = TextEditingController();
  final List<Map<String, dynamic>> _diceIncreases = [];

  // Campos para características adicionais
  bool _hasAdditionalFeatures = false;
  final _additionalFeatureNameController = TextEditingController();
  final _additionalFeatureDescriptionController = TextEditingController();

  // Campos para aumento de vida
  bool _hasHitPointIncrease = false;
  final _hitPointIncreaseController = TextEditingController();

  // Para aumentos manuais por nível
  final List<Map<String, dynamic>> _subclassManualLevelIncreases = [];

  // UD state (por diálogo)
  bool _udEnabled = false;
  final TextEditingController _udBaseController = TextEditingController(
    text: '10',
  );
  final List<String> _udAbilities = [];
  bool _udAllowsShield = true;

  final List<String> _usageTypeOptions = [
    'Por Nível',
    'Manual por Nível',
    'Por Modificador de Atributo',
    'Por Proficiência',
    'Fixo',
    'Por Longo Descanso',
    'Por Curto Descanso',
  ];

  final List<String> _usageRecoveryOptions = [
    'Descanso Longo',
    'Descanso Curto',
    'Dia',
    'Semana',
    'Nunca',
  ];

  final List<String> _attributeOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialFeature != null) {
      _loadInitialData();
    }
  }

  void _loadInitialData() {
    final feature = widget.initialFeature!;

    // Carregar dados básicos
    _levelController.text = (feature['level'] as int).toString();
    _nameController.text = feature['name'] ?? '';
    _descriptionController.text = feature['description'] ?? '';

    // Carregar condições de uso
    _hasUsageLimit = feature['has_usage_limit'] ?? false;
    _usageType = feature['usage_type'];
    _usageValueController.text = feature['usage_value']?.toString() ?? '';
    _usageRecovery = feature['usage_recovery'];
    _usageAttribute = feature['usage_attribute'];

    // Carregar aumentos manuais se existirem
    if (feature['manual_level_increases'] != null) {
      _subclassManualLevelIncreases.clear();
      final rawIncreases = feature['manual_level_increases'] as List<dynamic>?;
      if (rawIncreases != null) {
        _subclassManualLevelIncreases.addAll(
          rawIncreases.map((e) => Map<String, dynamic>.from(e)).toList(),
        );
      }
    }

    // Carregar aumento de dados
    _hasDiceIncrease = feature['has_dice_increase'] ?? false;
    _initialDiceController.text = feature['initial_dice'] ?? '';
    if (feature['dice_increases'] != null) {
      _diceIncreases.addAll(
        List<Map<String, dynamic>>.from(feature['dice_increases']),
      );
    }

    // Carregar características adicionais
    _hasAdditionalFeatures = feature['has_additional_features'] ?? false;
    _additionalFeatureNameController.text =
        feature['additional_feature_name'] ?? '';
    _additionalFeatureDescriptionController.text =
        feature['additional_feature_description'] ?? '';

    // Carregar aumento de vida
    _hasHitPointIncrease = feature['has_hit_point_increase'] ?? false;
    _hitPointIncreaseController.text =
        feature['hit_point_increase_per_level']?.toString() ?? '';

    // Carregar UD se existir
    final ud = feature['unarmored_defense'] as Map<String, dynamic>?;
    if (ud != null) {
      _udEnabled = true;
      _udBaseController.text = (ud['base']?.toString() ?? '10');
      _udAbilities
        ..clear()
        ..addAll(
          List<String>.from(
            (ud['abilities'] as List?)?.map((e) => e.toString()) ?? const [],
          ),
        );
      _udAllowsShield = (ud['allows_shield'] ?? true) == true;
    } else {
      _udEnabled = false;
      _udBaseController.text = '10';
      _udAbilities.clear();
      _udAllowsShield = true;
    }
  }

  @override
  void dispose() {
    _levelController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _usageValueController.dispose();
    _initialDiceController.dispose();
    _additionalFeatureNameController.dispose();
    _additionalFeatureDescriptionController.dispose();
    _hitPointIncreaseController.dispose();
    _udBaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Habilidade da Subclasse'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dados básicos
              DropdownButtonFormField<int>(
                value:
                    _levelController.text.isEmpty
                        ? null
                        : int.tryParse(_levelController.text),
                decoration: const InputDecoration(
                  labelText: 'Nível *',
                  border: OutlineInputBorder(),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged:
                    (v) => setState(
                      () => _levelController.text = v?.toString() ?? '',
                    ),
                validator: (v) => v == null ? 'Nível é obrigatório' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Habilidade *',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (v) =>
                        v == null || v.trim().isEmpty
                            ? 'Nome é obrigatório'
                            : null,
              ),
              const SizedBox(height: 16),
              FormattedTextEditor(
                controller: _descriptionController,
                label: 'Descrição *',
                hint: 'Escreva a descrição com formatações...',
                validator:
                    (v) =>
                        v == null || v.trim().isEmpty
                            ? 'Descrição é obrigatória'
                            : null,
              ),
              const SizedBox(height: 16),

              // Condições de uso
              _buildUsageLimitSection(),
              const SizedBox(height: 16),

              // Aumento de dados
              _buildDiceIncreaseSection(),
              const SizedBox(height: 16),

              // Características adicionais
              _buildAdditionalFeaturesSection(),
              const SizedBox(height: 16),

              // Aumento de vida
              _buildHitPointIncreaseSection(),
              const SizedBox(height: 16),

              // Defesa sem Armadura
              _buildUnarmoredDefenseSection(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final featureData = {
                'level': int.parse(_levelController.text),
                'name': _nameController.text.trim(),
                'description': _descriptionController.text.trim(),
                'has_usage_limit': _hasUsageLimit,
                'usage_type': _usageType,
                'usage_value':
                    _usageValueController.text.isNotEmpty
                        ? int.tryParse(_usageValueController.text)
                        : null,
                'usage_recovery': _usageRecovery,
                'usage_attribute': _usageAttribute,
                if (_usageType == 'Manual por Nível') ...{
                  'manual_level_increases': _subclassManualLevelIncreases,
                },
                'has_dice_increase': _hasDiceIncrease,
                'initial_dice':
                    _initialDiceController.text.isNotEmpty
                        ? _initialDiceController.text
                        : null,
                'dice_increases': _diceIncreases,
                'has_additional_features': _hasAdditionalFeatures,
                'additional_feature_name':
                    _additionalFeatureNameController.text.isNotEmpty
                        ? _additionalFeatureNameController.text
                        : null,
                'additional_feature_description':
                    _additionalFeatureDescriptionController.text.isNotEmpty
                        ? _additionalFeatureDescriptionController.text
                        : null,
                'has_hit_point_increase': _hasHitPointIncrease,
                'hit_point_increase_per_level':
                    _hitPointIncreaseController.text.isNotEmpty
                        ? int.tryParse(_hitPointIncreaseController.text)
                        : null,
                if (_udEnabled)
                  'unarmored_defense': {
                    'base': int.tryParse(_udBaseController.text) ?? 10,
                    'abilities': List<String>.from(_udAbilities),
                    'allows_shield': _udAllowsShield,
                  },
              };
              widget.onSave(featureData);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  Widget _buildUsageLimitSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Limite de Usos'),
              subtitle: const Text(
                'Esta habilidade tem número limitado de usos',
              ),
              value: _hasUsageLimit,
              onChanged: (value) {
                setState(() {
                  _hasUsageLimit = value ?? false;
                });
              },
            ),
            if (_hasUsageLimit) ...[
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _usageType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Uso *',
                  border: OutlineInputBorder(),
                ),
                items:
                    _usageTypeOptions.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _usageType = value;
                  });
                },
                validator: (value) {
                  if (_hasUsageLimit && (value == null || value.isEmpty)) {
                    return 'Tipo de uso é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              // Campo de valor baseado no tipo selecionado
              _buildSubclassUsageValueField(),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _usageRecovery,
                decoration: const InputDecoration(
                  labelText: 'Recuperação *',
                  border: OutlineInputBorder(),
                ),
                items:
                    _usageRecoveryOptions.map((recovery) {
                      return DropdownMenuItem(
                        value: recovery,
                        child: Text(recovery),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _usageRecovery = value;
                  });
                },
                validator: (value) {
                  if (_hasUsageLimit && (value == null || value.isEmpty)) {
                    return 'Recuperação é obrigatória';
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiceIncreaseSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Aumento de Dados'),
              subtitle: const Text(
                'Esta habilidade tem dados que aumentam com o nível',
              ),
              value: _hasDiceIncrease,
              onChanged: (value) {
                setState(() {
                  _hasDiceIncrease = value ?? false;
                });
              },
            ),
            if (_hasDiceIncrease) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _initialDiceController,
                decoration: const InputDecoration(
                  labelText: 'Dado Inicial *',
                  hintText: 'Ex: 1d6',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_hasDiceIncrease &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Dado inicial é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDiceIncreasesSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiceIncreasesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aumentos de Dados por Nível',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addDiceIncrease,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar aumento de dado',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Defina em quais níveis o dado aumenta (ex: nível 5: 1d6, nível 11: 1d8)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),
            if (_diceIncreases.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Nenhum aumento de dado definido. Clique no + para adicionar.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ..._diceIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final increase = entry.value;
                return _buildDiceIncreaseCard(index, increase);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceIncreaseCard(int index, Map<String, dynamic> increase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<int>(
                value: increase['level'],
                decoration: const InputDecoration(
                  labelText: 'Nível',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _diceIncreases[index]['level'] = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: increase['dice'],
                decoration: const InputDecoration(
                  labelText: 'Dado',
                  hintText: 'Ex: 1d8',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _diceIncreases[index]['dice'] = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Excluir Aumento de Dado',
                  itemName: 'Aumento de dado',
                  customMessage: 'Deseja excluir este aumento de dado?',
                );
                if (confirmed) {
                  setState(() {
                    _diceIncreases.removeAt(index);
                  });
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _addDiceIncrease() {
    setState(() {
      _diceIncreases.add({'level': 1, 'dice': '1d6'});
    });
  }

  Widget _buildAdditionalFeaturesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Características Adicionais'),
              subtitle: const Text(
                'Esta habilidade tem características extras',
              ),
              value: _hasAdditionalFeatures,
              onChanged: (value) {
                setState(() {
                  _hasAdditionalFeatures = value ?? false;
                });
              },
            ),
            if (_hasAdditionalFeatures) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _additionalFeatureNameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Característica',
                  hintText: 'Ex: Vantagem em testes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _additionalFeatureDescriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Descrição da Característica',
                  hintText: 'Descrição detalhada...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHitPointIncreaseSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Aumento de Vida'),
              subtitle: const Text('Esta habilidade aumenta os pontos de vida'),
              value: _hasHitPointIncrease,
              onChanged: (value) {
                setState(() {
                  _hasHitPointIncrease = value ?? false;
                });
              },
            ),
            if (_hasHitPointIncrease) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _hitPointIncreaseController,
                decoration: const InputDecoration(
                  labelText: 'Aumento por Nível *',
                  hintText: 'Ex: 1',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_hasHitPointIncrease &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Aumento por nível é obrigatório';
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubclassUsageValueField() {
    if (_usageType == null) return const SizedBox.shrink();

    switch (_usageType) {
      case 'Por Nível':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Usos por Nível *',
            hintText: 'Ex: 1 (1 uso por nível da classe)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      case 'Manual por Nível':
        return Column(
          children: [
            TextFormField(
              controller: _usageValueController,
              decoration: const InputDecoration(
                labelText: 'Usos Iniciais *',
                hintText: 'Ex: 2 (número de usos no nível 1)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
                  return 'Valor inicial é obrigatório';
                }
                final parsed = int.tryParse(value ?? '');
                if (value != null &&
                    value.isNotEmpty &&
                    (parsed == null || parsed < 1)) {
                  return 'Deve ser um número maior que 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildSubclassManualLevelIncreasesSection(),
          ],
        );

      case 'Por Modificador de Atributo':
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: _usageAttribute,
              decoration: const InputDecoration(
                labelText: 'Atributo *',
                border: OutlineInputBorder(),
              ),
              items:
                  _attributeOptions
                      .map(
                        (attr) =>
                            DropdownMenuItem(value: attr, child: Text(attr)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _usageAttribute = value;
                });
              },
              validator: (value) {
                if (_hasUsageLimit && (value == null || value.isEmpty)) {
                  return 'Atributo é obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _usageValueController,
              decoration: const InputDecoration(
                labelText: 'Multiplicador (opcional)',
                hintText: 'Ex: 2 (2x o modificador)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 1) {
                    return 'Deve ser um número maior que 0';
                  }
                }
                return null;
              },
            ),
          ],
        );

      case 'Por Proficiência':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Multiplicador (opcional)',
            hintText: 'Ex: 2 (2x o bônus de proficiência)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final parsed = int.tryParse(value);
              if (parsed == null || parsed < 1) {
                return 'Deve ser um número maior que 0';
              }
            }
            return null;
          },
        );

      case 'Fixo':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Número Fixo de Usos *',
            hintText: 'Ex: 3',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      case 'Por Longo Descanso':
      case 'Por Curto Descanso':
        return TextFormField(
          controller: _usageValueController,
          decoration: const InputDecoration(
            labelText: 'Número de Usos *',
            hintText: 'Ex: 2',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_hasUsageLimit && (value == null || value.trim().isEmpty)) {
              return 'Valor é obrigatório';
            }
            final parsed = int.tryParse(value ?? '');
            if (value != null &&
                value.isNotEmpty &&
                (parsed == null || parsed < 1)) {
              return 'Deve ser um número maior que 0';
            }
            return null;
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSubclassManualLevelIncreasesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aumentos por Nível',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _addSubclassManualLevelIncrease,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar aumento',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Defina em quais níveis o número de usos aumenta (ex: nível 3, 6, 12, 17)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),
            if (_subclassManualLevelIncreases.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Nenhum aumento definido. Clique no + para adicionar.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ..._subclassManualLevelIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final increase = entry.value;
                return _buildSubclassManualLevelIncreaseCard(index, increase);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildSubclassManualLevelIncreaseCard(
    int index,
    Map<String, dynamic> increase,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<int>(
                value: increase['level'],
                decoration: const InputDecoration(
                  labelText: 'Nível',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                items: List.generate(
                  20,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Nível ${i + 1}'),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _subclassManualLevelIncreases[index]['level'] = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Selecione um nível';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: increase['increase']?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Aumento',
                  hintText: 'Ex: +1',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _subclassManualLevelIncreases[index]['increase'] =
                      int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Valor obrigatório';
                  }
                  final parsed = int.tryParse(value);
                  if (parsed == null || parsed < 1) {
                    return 'Deve ser > 0';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Excluir Aumento Manual',
                  itemName: 'Aumento de nível',
                  customMessage: 'Deseja excluir este aumento manual de nível?',
                );
                if (confirmed) _removeSubclassManualLevelIncrease(index);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Remover',
            ),
          ],
        ),
      ),
    );
  }

  void _addSubclassManualLevelIncrease() {
    setState(() {
      _subclassManualLevelIncreases.add({'level': 2, 'increase': 1});
    });
  }

  void _removeSubclassManualLevelIncrease(int index) {
    setState(() {
      _subclassManualLevelIncreases.removeAt(index);
    });
  }

  Widget _buildUnarmoredDefenseSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Defesa sem Armadura (UD)'),
              subtitle: const Text('Define fórmula de CA quando sem armadura'),
              value: _udEnabled,
              onChanged: (value) {
                setState(() {
                  _udEnabled = value ?? false;
                  if (!_udEnabled) {
                    _udBaseController.text = '10';
                    _udAbilities.clear();
                    _udAllowsShield = true;
                  }
                });
              },
            ),
            if (_udEnabled) ...[
              const SizedBox(height: 8),
              TextFormField(
                controller: _udBaseController,
                decoration: const InputDecoration(
                  labelText: 'CA Base',
                  hintText: 'Ex: 10',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              const Text('Atributos para a CA:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    _attributeOptions.map((attr) {
                      final selected = _udAbilities.contains(attr);
                      return FilterChip(
                        label: Text(attr),
                        selected: selected,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              if (!_udAbilities.contains(attr)) {
                                _udAbilities.add(attr);
                              }
                            } else {
                              _udAbilities.remove(attr);
                            }
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Permite Escudo'),
                value: _udAllowsShield,
                onChanged: (v) => setState(() => _udAllowsShield = v),
                dense: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EditEquipmentChoiceDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialChoice;

  const _EditEquipmentChoiceDialog({required this.onSave, this.initialChoice});

  @override
  State<_EditEquipmentChoiceDialog> createState() =>
      _EditEquipmentChoiceDialogState();
}

class _EditEquipmentChoiceDialogState
    extends State<_EditEquipmentChoiceDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> _options = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialChoice != null) {
      _descriptionController.text = widget.initialChoice!['description'] ?? '';
      _options.addAll(
        List<Map<String, dynamic>>.from(widget.initialChoice!['options'] ?? []),
      );
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escolha de Equipamento'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição da Escolha *',
                  hintText: 'Ex: 1 instrumento musical à sua escolha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Descrição é obrigatória';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Opções Disponíveis',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addOption,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_options.isEmpty)
                const Text(
                  'Nenhuma opção adicionada',
                  style: TextStyle(color: Colors.grey),
                )
              else
                ..._options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(option['name'] ?? 'Opção sem nome'),
                      subtitle: CollapsibleRichText(
                        option['description'] ?? '',
                        initialMaxLines: 2,
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        onPressed: () => _editOption(index, option),
                        icon: const Icon(Icons.edit, color: Colors.blueGrey),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final choice = {
                'description': _descriptionController.text.trim(),
                'options': _options,
              };
              widget.onSave(choice);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  void _addOption() async {
    final selected = await _showSelectEquipmentDialog([]);
    if (selected != null && selected.isNotEmpty) {
      setState(() {
        for (final item in selected) {
          _options.add({
            'name': item['name'],
            'category': item['category'],
            'cost': item['cost'],
            'weight': item['weight'],
          });
        }
      });
    }
  }

  void _editOption(int index, Map<String, dynamic> current) async {
    // Carregar todas as opções existentes para edição
    final allOptions = List<Map<String, dynamic>>.from(_options);
    final selected = await _showSelectEquipmentDialog(allOptions);
    if (selected != null && selected.isNotEmpty) {
      setState(() {
        // Substituir todas as opções pelas selecionadas
        _options.clear();
        _options.addAll(selected);
      });
    }
  }

  Future<List<Map<String, dynamic>>?> _showSelectEquipmentDialog(
    List<Map<String, dynamic>> current,
  ) async {
    final all = await EquipmentService.loadAll();
    final selected = current.map((e) => e['name'] as String).toSet();

    return showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (context) {
        final TextEditingController search = TextEditingController();
        String? selectedType;
        List<Equipment> filtered = List.of(all);

        // Obter tipos únicos dos equipamentos
        final types = all.map((e) => e.type).toSet().toList()..sort();

        void apply() {
          filtered =
              all.where((e) {
                final matchesSearch = e.name.toLowerCase().contains(
                  search.text.toLowerCase(),
                );
                final matchesType =
                    selectedType == null || e.type == selectedType;
                return matchesSearch && matchesType;
              }).toList();
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Selecionar Item'),
              content: SizedBox(
                width: 520,
                height: 420,
                child: Column(
                  children: [
                    TextField(
                      controller: search,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar item...',
                      ),
                      onChanged: (_) => setState(apply),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por tipo',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Todos os tipos'),
                        ),
                        ...types.map(
                          (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          apply();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final eq = filtered[index];
                          final isSel = selected.contains(eq.name);

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: ListTile(
                              title: Text(eq.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eq.cost != null
                                        ? 'Custo: ${eq.cost}'
                                        : 'Sem custo',
                                  ),
                                  Text(
                                    'Tipo: ${eq.type}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Checkbox(
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      selected.add(eq.name);
                                    } else {
                                      selected.remove(eq.name);
                                    }
                                  });
                                },
                              ),
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
                ElevatedButton(
                  onPressed: () {
                    final result =
                        all
                            .where((e) => selected.contains(e.name))
                            .map(
                              (eq) => {
                                'name': eq.name,
                                'category': eq.category,
                                'cost': eq.cost,
                                'weight': eq.weight,
                              },
                            )
                            .toList();
                    Navigator.pop(context, result);
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
