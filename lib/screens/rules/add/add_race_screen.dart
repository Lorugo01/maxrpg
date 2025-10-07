import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/supabase_service.dart';
import '../../data/data_management_screen.dart';

// Entrada de traço racial (nome + descrição + limites de uso)
class _TraitEntry {
  final TextEditingController name;
  final TextEditingController description;

  // Campos para limite de usos
  bool hasUsageLimit = false;
  String? usageType;
  final TextEditingController usageValue;
  final TextEditingController usageRecovery;
  String? usageAttribute;

  // Campos para dados que aumentam
  bool hasDiceIncrease = false;
  final TextEditingController initialDice;
  final List<Map<String, dynamic>> diceIncreases = [];

  // Para aumentos manuais por nível
  final List<Map<String, dynamic>> manualLevelIncreases = [];

  // Funcionalidades adicionais
  bool hasAdditionalFeatures = false;
  final TextEditingController additionalFeatureName;
  final TextEditingController additionalFeatureDescription;

  _TraitEntry({
    String name = '',
    String description = '',
    String usageValue = '',
    String usageRecovery = '',
    String initialDice = '',
    String additionalFeatureName = '',
    String additionalFeatureDescription = '',
  }) : name = TextEditingController(text: name),
       description = TextEditingController(text: description),
       usageValue = TextEditingController(text: usageValue),
       usageRecovery = TextEditingController(text: usageRecovery),
       initialDice = TextEditingController(text: initialDice),
       additionalFeatureName = TextEditingController(
         text: additionalFeatureName,
       ),
       additionalFeatureDescription = TextEditingController(
         text: additionalFeatureDescription,
       );

  void dispose() {
    name.dispose();
    description.dispose();
    usageValue.dispose();
    usageRecovery.dispose();
    initialDice.dispose();
    additionalFeatureName.dispose();
    additionalFeatureDescription.dispose();
  }
}

// Entrada de magia racial (nome + nível)
class _SpellEntry {
  final TextEditingController name;
  final TextEditingController level;
  _SpellEntry({String name = '', String level = ''})
    : name = TextEditingController(text: name),
      level = TextEditingController(text: level);
  void dispose() {
    name.dispose();
    level.dispose();
  }
}

class AddRaceScreen extends ConsumerStatefulWidget {
  const AddRaceScreen({super.key});

  @override
  ConsumerState<AddRaceScreen> createState() => _AddRaceScreenState();
}

class _AddRaceScreenState extends ConsumerState<AddRaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sizeController = TextEditingController(text: 'Médio');
  final _speedController = TextEditingController(text: '30');
  final _abilityScoreIncreaseController = TextEditingController();
  final _languagesController = TextEditingController();
  final _traitsController = TextEditingController();
  final _subracesController = TextEditingController();

  String? _selectedSource;
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  // Controle de versão para campos diferentes
  bool _isPHB2014 = false;

  bool _isLoading = false;

  // Entradas dinâmicas de Traços Raciais (nome + descrição + limites de uso)
  final List<_TraitEntry> _traitEntries = [_TraitEntry()];

  // Opções para tipo de uso (requerido pela UI de traços com limite)
  final List<String> _usageTypeOptions = [
    'Por Nível',
    'Manual por Nível',
    'Por Modificador de Atributo',
    'Por Proficiência',
    'Fixo',
    'Por Longo Descanso',
    'Por Curto Descanso',
  ];

  // Opções de atributos
  final List<String> _attributeOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];

  // Opções para tipo de uso e atributos serão reativadas quando a UI de limites de uso for habilitada

  // Entradas dinâmicas de Magias Raciais (nome + nível)
  final List<_SpellEntry> _spellEntries = [];
  List<Map<String, dynamic>> _allSpells = [];
  bool _loadingSpells = false;

  @override
  void initState() {
    super.initState();
    _selectedSource = _sourceOptions.first;
    _updateVersionFields();
  }

  Widget _buildTraitUsageLimitSection(_TraitEntry trait) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text(
            'Este traço tem limite de usos',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text('Marque se o traço tem número limitado de usos'),
          value: trait.hasUsageLimit,
          onChanged: (value) {
            setState(() {
              trait.hasUsageLimit = value ?? false;
              if (!trait.hasUsageLimit) {
                trait.usageType = null;
                trait.usageValue.clear();
                trait.usageRecovery.clear();
                trait.usageAttribute = null;
                trait.manualLevelIncreases.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (trait.hasUsageLimit) ...[
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: trait.usageType,
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
                trait.usageType = value;
                trait.usageValue.clear();
                trait.usageAttribute = null;
                trait.manualLevelIncreases.clear();
              });
            },
          ),

          const SizedBox(height: 12),
          _buildTraitUsageValueField(trait),

          const SizedBox(height: 12),
          TextFormField(
            controller: trait.usageRecovery,
            decoration: const InputDecoration(
              labelText: 'Recuperação de Usos',
              hintText: 'Ex: Longo Descanso',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ],
    );
  }

  Widget _buildTraitUsageValueField(_TraitEntry trait) {
    if (trait.usageType == null) return const SizedBox.shrink();
    switch (trait.usageType) {
      case 'Por Nível':
        return TextFormField(
          controller: trait.usageValue,
          decoration: const InputDecoration(
            labelText: 'Usos por Nível *',
            hintText: 'Ex: 1 (1 uso por nível da classe)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        );
      case 'Manual por Nível':
        return Column(
          children: [
            TextFormField(
              controller: trait.usageValue,
              decoration: const InputDecoration(
                labelText: 'Usos Iniciais *',
                hintText: 'Ex: 2 (no nível 1)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildTraitManualLevelIncreasesSection(trait),
          ],
        );
      case 'Por Modificador de Atributo':
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: trait.usageAttribute,
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
              onChanged:
                  (value) => setState(() => trait.usageAttribute = value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: trait.usageValue,
              decoration: const InputDecoration(
                labelText: 'Multiplicador (opcional)',
                hintText: 'Ex: 2 (2x o modificador)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      case 'Por Proficiência':
        return TextFormField(
          controller: trait.usageValue,
          decoration: const InputDecoration(
            labelText: 'Multiplicador (opcional)',
            hintText: 'Ex: 2 (2x proficiência)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        );
      case 'Fixo':
        return TextFormField(
          controller: trait.usageValue,
          decoration: const InputDecoration(
            labelText: 'Número Fixo de Usos *',
            hintText: 'Ex: 3',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        );
      case 'Por Longo Descanso':
      case 'Por Curto Descanso':
        return TextFormField(
          controller: trait.usageValue,
          decoration: const InputDecoration(
            labelText: 'Número de Usos *',
            hintText: 'Ex: 2',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTraitManualLevelIncreasesSection(_TraitEntry trait) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aumentos por Nível',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      trait.manualLevelIncreases.add({
                        'level': 2,
                        'increase': 1,
                      });
                    });
                  },
                  icon: const Icon(Icons.add, size: 16),
                  tooltip: 'Adicionar aumento',
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (trait.manualLevelIncreases.isEmpty)
              const Text(
                'Nenhum aumento definido',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...trait.manualLevelIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final increase = entry.value;
                return Card(
                  margin: const EdgeInsets.only(top: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: increase['level'],
                            decoration: const InputDecoration(
                              labelText: 'Nível',
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
                                (value) => setState(
                                  () =>
                                      trait.manualLevelIncreases[index]['level'] =
                                          value,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            initialValue:
                                increase['increase']?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Aumento',
                              hintText: 'Ex: +1',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged:
                                (v) =>
                                    trait.manualLevelIncreases[index]['increase'] =
                                        int.tryParse(v) ?? 0,
                          ),
                        ),
                        IconButton(
                          onPressed:
                              () => setState(
                                () =>
                                    trait.manualLevelIncreases.removeAt(index),
                              ),
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

  Widget _buildTraitDiceIncreaseSection(_TraitEntry trait) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text(
            'Este traço tem dados que aumentam',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se os dados do traço aumentam por nível',
          ),
          value: trait.hasDiceIncrease,
          onChanged: (value) {
            setState(() {
              trait.hasDiceIncrease = value ?? false;
              if (!trait.hasDiceIncrease) {
                trait.initialDice.clear();
                trait.diceIncreases.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (trait.hasDiceIncrease) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: trait.initialDice,
            decoration: const InputDecoration(
              labelText: 'Dado Inicial *',
              hintText: 'Ex: 1d6',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aumentos de Dados por Nível',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed:
                            () => setState(
                              () => trait.diceIncreases.add({
                                'level': 2,
                                'dice': '1d6',
                              }),
                            ),
                        icon: const Icon(Icons.add, size: 16),
                      ),
                    ],
                  ),
                  if (trait.diceIncreases.isEmpty)
                    const Text(
                      'Nenhum aumento de dado definido',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    ...trait.diceIncreases.asMap().entries.map((entry) {
                      final index = entry.key;
                      final inc = entry.value;
                      return Card(
                        margin: const EdgeInsets.only(top: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<int>(
                                  value: inc['level'],
                                  decoration: const InputDecoration(
                                    labelText: 'Nível',
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
                                        () =>
                                            trait.diceIncreases[index]['level'] =
                                                v,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  initialValue: inc['dice']?.toString() ?? '',
                                  decoration: const InputDecoration(
                                    labelText: 'Novo Dado',
                                    hintText: 'Ex: 1d8',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged:
                                      (v) =>
                                          trait.diceIncreases[index]['dice'] =
                                              v.trim(),
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    () => setState(
                                      () => trait.diceIncreases.removeAt(index),
                                    ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
        ],
      ],
    );
  }

  void _updateVersionFields() {
    setState(() {
      _isPHB2014 = _selectedSource == 'PHB 2014';
    });
  }

  Future<void> _ensureSpellsLoaded() async {
    if (_allSpells.isNotEmpty || _loadingSpells) return;
    setState(() => _loadingSpells = true);
    try {
      final data = await SupabaseService.client
          .from('spells')
          .select('name, level')
          .order('name');
      _allSpells = List<Map<String, dynamic>>.from(data);
    } catch (_) {
      _allSpells = [];
    } finally {
      if (mounted) setState(() => _loadingSpells = false);
    }
  }

  Future<void> _pickSpell(int index) async {
    await _ensureSpellsLoaded();
    if (!mounted) return;
    final controller = _spellEntries[index];
    String query = '';
    List<Map<String, dynamic>> filtered = _allSpells;
    final selected = await showDialog<Map<String, dynamic>>(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder: (context, setStateDlg) {
              void applyFilter(String q) {
                query = q;
                setStateDlg(() {
                  filtered =
                      _allSpells
                          .where(
                            (s) => (s['name'] ?? '')
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()),
                          )
                          .toList();
                });
              }

              return AlertDialog(
                title: const Text('Selecionar Magia'),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 400,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Buscar magia...',
                        ),
                        onChanged: applyFilter,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child:
                            _loadingSpells
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : ListView.builder(
                                  itemCount: filtered.length,
                                  itemBuilder: (context, i) {
                                    final s = filtered[i];
                                    return ListTile(
                                      title: Text(s['name'] ?? ''),
                                      subtitle: Text(
                                        'Nível ${s['level'] ?? ''}',
                                      ),
                                      onTap: () => Navigator.pop(context, s),
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
            },
          ),
    );
    if (selected != null) {
      setState(() {
        controller.name.text = (selected['name'] ?? '').toString();
        controller.level.text = (selected['level'] ?? '').toString();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _sizeController.dispose();
    _speedController.dispose();
    _abilityScoreIncreaseController.dispose();
    _languagesController.dispose();
    _traitsController.dispose();
    _subracesController.dispose();
    for (final t in _traitEntries) {
      t.dispose();
    }
    for (final s in _spellEntries) {
      s.dispose();
    }
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
          child: Text('Apenas administradores podem adicionar raças.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Raça'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveRace,
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
              _buildSectionCard(
                context,
                'Informações Básicas',
                Icons.pets,
                Colors.green,
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nome da Raça *',
                    hint: 'Ex: Humano',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Descrição',
                    hint: 'Descrição da raça...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _sizeController,
                          label: 'Tamanho',
                          hint: 'Ex: Médio',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _speedController,
                          label: 'Velocidade',
                          hint: '30',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Velocidade é obrigatória';
                            }
                            final speed = int.tryParse(value);
                            if (speed == null || speed < 0) {
                              return 'Velocidade deve ser um número positivo';
                            }
                            return null;
                          },
                        ),
                      ),
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
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedSource = v;
                        _updateVersionFields();
                      });
                    },
                    validator:
                        (v) =>
                            (v == null || v.isEmpty)
                                ? 'Fonte é obrigatória'
                                : null,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Características da Raça
              _buildSectionCard(
                context,
                'Características da Raça',
                Icons.star,
                Colors.orange,
                [
                  // Campo Aumento de Atributo (diferente por versão)
                  if (_isPHB2014) ...[
                    // PHB 2014: Valores fixos definidos pela raça
                    _buildTextField(
                      controller: _abilityScoreIncreaseController,
                      label: 'Aumento de Atributos',
                      hint: 'Ex: +2 Força, +1 Constituição',
                    ),
                  ] else ...[
                    // PHB 2024: Sem aumento de atributo (escolha do jogador)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'PHB 2024: Aumentos de atributo são escolhidos na escolha da origem durante a criação do personagem',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _languagesController,
                    label: 'Idiomas',
                    hint: 'Ex: Comum, Élfico',
                  ),
                  const SizedBox(height: 16),
                  // Traços Raciais (ambas versões têm traços dinâmicos)
                  Text(
                    _isPHB2014
                        ? 'Traços Raciais (PHB 2014)'
                        : 'Traços Raciais (PHB 2024)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      ..._traitEntries.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final _TraitEntry trait = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildTextField(
                                          controller: trait.name,
                                          label: 'Nome do Traço',
                                          hint: 'Ex: Visão no Escuro',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        tooltip: 'Remover',
                                        onPressed:
                                            _traitEntries.length > 1
                                                ? () => setState(() {
                                                  trait.dispose();
                                                  _traitEntries.removeAt(index);
                                                })
                                                : null,
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    controller: trait.description,
                                    label: 'Descrição do Traço',
                                    hint: 'Detalhe o efeito do traço...',
                                    maxLines: 3,
                                  ),

                                  // Seção de limite de usos
                                  const SizedBox(height: 16),
                                  _buildTraitUsageLimitSection(trait),

                                  // Seção de dados que aumentam
                                  const SizedBox(height: 16),
                                  _buildTraitDiceIncreaseSection(trait),

                                  // Seção de funcionalidades adicionais
                                  const SizedBox(height: 16),
                                  _buildTraitAdditionalFeaturesSection(trait),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed:
                              () => setState(
                                () => _traitEntries.add(_TraitEntry()),
                              ),
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Traço'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Magias Raciais
              _buildSectionCard(
                context,
                'Magias Raciais',
                Icons.auto_awesome,
                Colors.indigo,
                [
                  Text(
                    'Magias que a raça conhece naturalmente',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      ..._spellEntries.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final _SpellEntry spell = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () => _pickSpell(index),
                                          child: IgnorePointer(
                                            child: _buildTextField(
                                              controller: spell.name,
                                              label:
                                                  'Nome da Magia (toque para escolher)',
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: IgnorePointer(
                                          child: _buildTextField(
                                            controller: spell.level,
                                            label: 'Nível',
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        tooltip: 'Remover',
                                        onPressed:
                                            () => setState(() {
                                              spell.dispose();
                                              _spellEntries.removeAt(index);
                                            }),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed:
                              () => setState(
                                () => _spellEntries.add(_SpellEntry()),
                              ),
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Magia'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Subraças
              _buildSectionCard(
                context,
                'Subraças',
                Icons.category,
                Colors.purple,
                [
                  _buildTextField(
                    controller: _subracesController,
                    label: 'Subraças',
                    hint: 'Ex: Alto Elfo, Elfo da Floresta...',
                    maxLines: 2,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botão Salvar
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveRace,
                icon:
                    _isLoading
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.save),
                label: Text(_isLoading ? 'Salvando...' : 'Salvar Raça'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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
                        '• A raça ficará disponível para todos os usuários',
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
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Future<void> _saveRace() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final raceData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'size': _sizeController.text.trim(),
        'speed': int.parse(_speedController.text),
        'source': _selectedSource,
        'ability_score_increases':
            _abilityScoreIncreaseController.text.trim().isEmpty
                ? {}
                : {'description': _abilityScoreIncreaseController.text.trim()},
        'languages': _languagesController.text.trim(),
        'subraces': _subracesController.text.trim(),
        'created_at': DateTime.now().toIso8601String(),
      };

      // Serializar traços (ambas versões usam o mesmo sistema dinâmico)
      // 1) Formato estruturado em JSONB (preferido): preserva quebras de linha e inclui limites de uso
      raceData['traits'] =
          _traitEntries
              .where(
                (t) =>
                    t.name.text.trim().isNotEmpty ||
                    t.description.text.trim().isNotEmpty,
              )
              .map(
                (t) => {
                  'name': t.name.text.trim(),
                  'description': t.description.text.trim(),
                  'has_usage_limit': t.hasUsageLimit,
                  if (t.hasUsageLimit) ...{
                    'usage_type': t.usageType,
                    'usage_value':
                        t.usageValue.text.isNotEmpty
                            ? int.tryParse(t.usageValue.text)
                            : null,
                    'usage_recovery': t.usageRecovery.text.trim(),
                    'usage_attribute': t.usageAttribute,
                    if (t.usageType == 'Manual por Nível') ...{
                      'manual_level_increases': t.manualLevelIncreases,
                    },
                  },
                  'has_dice_increase': t.hasDiceIncrease,
                  if (t.hasDiceIncrease) ...{
                    'initial_dice': t.initialDice.text.trim(),
                    'dice_increases': t.diceIncreases,
                  },
                  'has_additional_features': t.hasAdditionalFeatures,
                  if (t.hasAdditionalFeatures) ...{
                    'additional_feature_name':
                        t.additionalFeatureName.text.trim(),
                    'additional_feature_description':
                        t.additionalFeatureDescription.text.trim(),
                  },
                },
              )
              .toList();

      // 2) Compatibilidade: texto em linha única (para telas antigas que usam traits_text)
      // Observação: descrição pode conter quebras de linha quando o usuário pressiona Enter.
      // Para evitar que cada linha vire um traço separado na leitura (split por \n),
      // normalizamos as quebras de linha para espaços simples.
      String toSingleLine(String text) {
        return text
            .replaceAll('\r\n', '\n')
            .replaceAll('\r', '\n')
            .replaceAll(RegExp(r'\s*\n\s*'), ' ')
            .trim();
      }

      raceData['traits_text'] = _traitEntries
          .where(
            (t) =>
                t.name.text.trim().isNotEmpty ||
                t.description.text.trim().isNotEmpty,
          )
          .map(
            (t) =>
                '${toSingleLine(t.name.text)}: ${toSingleLine(t.description.text)}',
          )
          .join('\n');

      // Serializar magias raciais
      raceData['racial_spells'] = _spellEntries
          .where(
            (s) =>
                s.name.text.trim().isNotEmpty || s.level.text.trim().isNotEmpty,
          )
          .map((s) => '${s.name.text.trim()}: Nível ${s.level.text.trim()}')
          .join('\n');

      await SupabaseService.client.from('races').insert(raceData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Raça adicionada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Ir para Gerenciar Dados
        // ignore: use_build_context_synchronously
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DataManagementScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar raça: $e'),
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

  Widget _buildTraitAdditionalFeaturesSection(_TraitEntry trait) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text(
            'Este traço tem funcionalidades adicionais',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se o traço tem funcionalidades extras que podem ser ativadas',
          ),
          value: trait.hasAdditionalFeatures,
          onChanged: (value) {
            setState(() {
              trait.hasAdditionalFeatures = value ?? false;
              if (!trait.hasAdditionalFeatures) {
                trait.additionalFeatureName.clear();
                trait.additionalFeatureDescription.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (trait.hasAdditionalFeatures) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: trait.additionalFeatureName,
            decoration: const InputDecoration(
              labelText: 'Nome da Funcionalidade *',
              hintText: 'Ex: Vantagem em Ataques',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: trait.additionalFeatureDescription,
            decoration: const InputDecoration(
              labelText: 'Descrição da Funcionalidade',
              hintText: 'Descreva o que esta funcionalidade faz...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ],
    );
  }
}
