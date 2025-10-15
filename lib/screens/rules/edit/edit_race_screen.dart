import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '/widgets/rich_text_helpers.dart';

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

  // Aumento de vida
  bool hasHitPointIncrease = false;
  final TextEditingController hitPointIncreasePerLevel;

  _TraitEntry({
    String name = '',
    String description = '',
    String usageValue = '',
    String usageRecovery = '',
    String initialDice = '',
    String hitPointIncreasePerLevel = '1',
  }) : name = TextEditingController(text: name),
       description = TextEditingController(text: description),
       usageValue = TextEditingController(text: usageValue),
       usageRecovery = TextEditingController(text: usageRecovery),
       initialDice = TextEditingController(text: initialDice),
       hitPointIncreasePerLevel = TextEditingController(
         text: hitPointIncreasePerLevel,
       );

  void dispose() {
    name.dispose();
    description.dispose();
    usageValue.dispose();
    usageRecovery.dispose();
    initialDice.dispose();
    hitPointIncreasePerLevel.dispose();
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

class EditRaceScreen extends ConsumerStatefulWidget {
  const EditRaceScreen({super.key, required this.race});

  final Map<String, dynamic> race;

  @override
  ConsumerState<EditRaceScreen> createState() => _EditRaceScreenState();
}

class _EditRaceScreenState extends ConsumerState<EditRaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _sizeController;
  late TextEditingController _speedController;
  late TextEditingController _abilityScoreIncreaseController;
  late TextEditingController _languagesController;
  late TextEditingController _subracesController;
  String? _selectedSource;

  // Controle de versão para campos diferentes
  bool _isPHB2014 = false;
  bool _isLoading = false;

  // Entradas dinâmicas de Traços Raciais (nome + descrição + limites de uso)
  final List<_TraitEntry> _traitEntries = [];

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

  // Entradas dinâmicas de Magias Raciais (nome + nível)
  final List<_SpellEntry> _spellEntries = [];
  List<Map<String, dynamic>> _allSpells = [];
  bool _loadingSpells = false;

  // Controle de subraças
  final List<Map<String, dynamic>> _subraces = [];

  @override
  void initState() {
    super.initState();
    final r = widget.race;
    _nameController = TextEditingController(text: r['name']?.toString() ?? '');

    // Tratar description como string ou lista
    final dynamic descriptionData = r['description'];
    String descriptionText = '';
    if (descriptionData is String) {
      descriptionText = descriptionData;
    } else if (descriptionData is List) {
      descriptionText = descriptionData.map((e) => e.toString()).join('\n');
    } else {
      descriptionText = descriptionData?.toString() ?? '';
    }
    _descriptionController = TextEditingController(text: descriptionText);

    // Tratar size como string ou lista
    final dynamic sizeData = r['size'];
    String sizeText = '';
    if (sizeData is String) {
      sizeText = sizeData;
    } else if (sizeData is List) {
      sizeText = sizeData.map((e) => e.toString()).join(', ');
    } else {
      sizeText = sizeData?.toString() ?? 'Médio';
    }
    _sizeController = TextEditingController(text: sizeText);
    _speedController = TextEditingController(
      text: (r['speed'] ?? 30).toString(),
    );
    // Banco antigo pode ter ability_score_increase (string) ou ability_score_increases (jsonb)
    final dynamic asi =
        r['ability_score_increases'] ?? r['ability_score_increase'];
    String asiText = '';
    if (asi is Map) {
      asiText = (asi['description'] ?? '').toString();
    } else if (asi != null) {
      asiText = asi.toString();
    }
    _abilityScoreIncreaseController = TextEditingController(text: asiText);

    // Tratar languages como string ou lista
    final dynamic languagesData = r['languages'];
    String languagesText = '';
    if (languagesData is String) {
      languagesText = languagesData;
    } else if (languagesData is List) {
      languagesText = languagesData.map((e) => e.toString()).join(', ');
    } else {
      languagesText = languagesData?.toString() ?? '';
    }
    _languagesController = TextEditingController(text: languagesText);

    // Tratar subraces como string ou lista
    final dynamic subracesData = r['subraces'];
    String subracesText = '';
    if (subracesData is String) {
      subracesText = subracesData;
    } else if (subracesData is List) {
      subracesText = subracesData.map((e) => e.toString()).join(', ');
    } else {
      subracesText = subracesData?.toString() ?? '';
    }
    _subracesController = TextEditingController(text: subracesText);

    _selectedSource = (r['source'] as String?) ?? _sourceOptions.first;

    // Carregar subraças existentes
    if (subracesData is List) {
      for (final subrace in subracesData) {
        if (subrace is Map<String, dynamic>) {
          final subraceMap = Map<String, dynamic>.from(subrace);
          // Criar controllers para os campos da subraça
          subraceMap['nameController'] = TextEditingController(
            text: subraceMap['name'] ?? '',
          );
          subraceMap['descriptionController'] = TextEditingController(
            text: subraceMap['description'] ?? '',
          );
          subraceMap['traitsController'] = TextEditingController(
            text: subraceMap['traits'] ?? '',
          );
          subraceMap['spellsController'] = TextEditingController(
            text: subraceMap['spells'] ?? '',
          );
          _subraces.add(subraceMap);
        }
      }
    }
    _isPHB2014 = _selectedSource == 'PHB 2014';

    // Inicializar traços a partir de traits (JSONB) ou traits_text (string)
    final dynamic traitsData = r['traits'];
    if (traitsData is List) {
      // Formato JSONB estruturado (preferido)
      for (final trait in traitsData) {
        if (trait is Map<String, dynamic>) {
          final entry = _TraitEntry(
            name: trait['name'] ?? '',
            description: trait['description'] ?? '',
            usageValue: trait['usage_value']?.toString() ?? '',
            usageRecovery: trait['usage_recovery'] ?? '',
            initialDice: trait['initial_dice'] ?? '',
          );
          entry.hasUsageLimit = trait['has_usage_limit'] ?? false;
          entry.usageType = trait['usage_type'];
          entry.usageAttribute = trait['usage_attribute'];
          entry.hasDiceIncrease = trait['has_dice_increase'] ?? false;
          entry.hasHitPointIncrease = trait['has_hit_point_increase'] ?? false;
          entry.hitPointIncreasePerLevel.text =
              (trait['hit_point_increase_per_level'] ?? 1).toString();

          // Carregar aumentos manuais
          if (trait['manual_level_increases'] is List) {
            entry.manualLevelIncreases.addAll(
              (trait['manual_level_increases'] as List).map(
                (e) => Map<String, dynamic>.from(e),
              ),
            );
          }

          // Carregar aumentos de dados
          if (trait['dice_increases'] is List) {
            entry.diceIncreases.addAll(
              (trait['dice_increases'] as List).map(
                (e) => Map<String, dynamic>.from(e),
              ),
            );
          }

          _traitEntries.add(entry);
        }
      }
    } else {
      // Fallback para traits_text (string)
      final dynamic traitsTextData = r['traits_text'];
      String traitsText = '';

      if (traitsTextData is String) {
        traitsText = traitsTextData;
      } else if (traitsTextData is List) {
        // Se for uma lista, converter para string
        traitsText = traitsTextData.map((e) => e.toString()).join('\n');
      } else {
        traitsText = traitsTextData?.toString() ?? '';
      }

      if (traitsText.trim().isEmpty) {
        _traitEntries.add(_TraitEntry());
      } else {
        final lines = traitsText.split('\n');
        for (final line in lines) {
          if (line.trim().isEmpty) continue;
          final int idx = line.indexOf(':');
          if (idx >= 0) {
            final name = line.substring(0, idx).trim();
            final desc = line.substring(idx + 1).trim();
            _traitEntries.add(_TraitEntry(name: name, description: desc));
          } else {
            _traitEntries.add(_TraitEntry(description: line.trim()));
          }
        }
      }
    }
    if (_traitEntries.isEmpty) _traitEntries.add(_TraitEntry());

    // Inicializar magias a partir de racial_spells
    final dynamic racialSpellsData = r['racial_spells'];
    String spellsText = '';

    if (racialSpellsData is String) {
      spellsText = racialSpellsData;
    } else if (racialSpellsData is List) {
      // Se for uma lista, converter para string
      spellsText = racialSpellsData.map((e) => e.toString()).join('\n');
    } else {
      spellsText = racialSpellsData?.toString() ?? '';
    }

    if (spellsText.trim().isNotEmpty) {
      final lines = spellsText.split('\n');
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final int idx = line.indexOf(': Nível ');
        if (idx >= 0) {
          final name = line.substring(0, idx).trim();
          final level = line.substring(idx + 7).trim();
          _spellEntries.add(_SpellEntry(name: name, level: level));
        } else {
          _spellEntries.add(_SpellEntry(name: line.trim()));
        }
      }
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
    _subracesController.dispose();
    for (final t in _traitEntries) {
      t.dispose();
    }
    for (final s in _spellEntries) {
      s.dispose();
    }
    // Dispose dos controllers das subraças
    for (final subrace in _subraces) {
      subrace['nameController']?.dispose();
      subrace['descriptionController']?.dispose();
      subrace['traitsController']?.dispose();
      subrace['spellsController']?.dispose();
    }
    super.dispose();
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
          .order('name', ascending: true);
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

  Widget _buildSubraceCard(int index) {
    final subrace = _subraces[index];

    // Criar controllers para esta subraça se não existirem
    if (subrace['nameController'] == null) {
      subrace['nameController'] = TextEditingController(
        text: subrace['name'] ?? '',
      );
    }
    if (subrace['descriptionController'] == null) {
      subrace['descriptionController'] = TextEditingController(
        text: subrace['description'] ?? '',
      );
    }
    if (subrace['traitsController'] == null) {
      subrace['traitsController'] = TextEditingController(
        text: subrace['traits'] ?? '',
      );
    }
    if (subrace['spellsController'] == null) {
      subrace['spellsController'] = TextEditingController(
        text: subrace['spells'] ?? '',
      );
    }

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: subrace['nameController'],
                    decoration: const InputDecoration(
                      labelText: 'Nome da Subraça *',
                      hintText: 'Ex: Abissal',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _subraces[index]['name'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Remover',
                  onPressed: () {
                    // Dispose dos controllers antes de remover
                    subrace['nameController']?.dispose();
                    subrace['descriptionController']?.dispose();
                    subrace['traitsController']?.dispose();
                    subrace['spellsController']?.dispose();
                    setState(() => _subraces.removeAt(index));
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FormattedTextEditor(
              controller: subrace['descriptionController'],
              label: 'Descrição da Subraça',
              hint: 'Descrição das habilidades específicas...',
              onChanged: (value) {
                _subraces[index]['description'] = value;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: subrace['traitsController'],
              decoration: const InputDecoration(
                labelText: 'Traços Específicos',
                hintText:
                    'Ex: Resistência a dano de Veneno, conhece truque Spray de Veneno',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) {
                _subraces[index]['traits'] = value;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: subrace['spellsController'],
              decoration: const InputDecoration(
                labelText: 'Magias Específicas',
                hintText:
                    'Ex: Raio da Doença (nível 3), Segurar Pessoa (nível 5)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              onChanged: (value) {
                _subraces[index]['spells'] = value;
              },
            ),
          ],
        ),
      ),
    );
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
          child: Text('Apenas administradores podem editar raças.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Raça'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _save,
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
                    validator:
                        (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                  ),
                  const SizedBox(height: 16),
                  FormattedTextEditor(
                    controller: _descriptionController,
                    label: 'Descrição',
                    hint: 'Descrição da raça...',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _sizeController,
                          label: 'Tamanho',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _speedController,
                          label: 'Velocidade',
                          keyboardType: TextInputType.number,
                          validator:
                              (v) =>
                                  (int.tryParse(v ?? '') == null)
                                      ? 'Número'
                                      : null,
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
                  if (_isPHB2014) ...[
                    _buildTextField(
                      controller: _abilityScoreIncreaseController,
                      label: 'Aumento de Atributos',
                      hint: 'Ex: +2 Força, +1 Constituição',
                    ),
                  ] else ...[
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
                              'PHB 2024: Aumentos de atributo são escolhidos na origem',
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
                        final index = entry.key;
                        final trait = entry.value;
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
                                  FormattedTextEditor(
                                    controller: trait.description,
                                    label: 'Descrição do Traço',
                                    hint: 'Detalhe o efeito do traço...',
                                  ),

                                  // Seção de limite de usos
                                  const SizedBox(height: 16),
                                  _buildTraitUsageLimitSection(trait),

                                  // Seção de dados que aumentam
                                  const SizedBox(height: 16),
                                  _buildTraitDiceIncreaseSection(trait),

                                  // Seção de aumento de vida
                                  const SizedBox(height: 16),
                                  _buildTraitHitPointIncreaseSection(trait),
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
                        final index = entry.key;
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

              _buildSectionCard(
                context,
                'Subraças',
                Icons.category,
                Colors.purple,
                [
                  Text(
                    'Subraças com habilidades específicas',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      ..._subraces.asMap().entries.map((entry) {
                        final index = entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildSubraceCard(index),
                        );
                      }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed:
                              () => setState(() {
                                _subraces.add({
                                  'name': '',
                                  'description': '',
                                  'traits': '',
                                  'spells': '',
                                });
                              }),
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Subraça'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _save,
                  icon:
                      _isLoading
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.save),
                  label: Text(_isLoading ? 'Salvando...' : 'Salvar Alterações'),
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final id = widget.race['id'];
      final update = <String, dynamic>{
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'size': _sizeController.text.trim(),
        'speed': int.tryParse(_speedController.text.trim()) ?? 30,
        'source': _selectedSource,
        'languages': _languagesController.text.trim(),
        'subraces':
            _subraces
                .where((s) => s['name']?.toString().trim().isNotEmpty == true)
                .toList(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // ability_score_increases (jsonb)
      final asiText = _abilityScoreIncreaseController.text.trim();
      update['ability_score_increases'] =
          asiText.isEmpty ? {} : {'description': asiText};

      // Serializar traços (ambas versões usam o mesmo sistema dinâmico)
      // 1) Formato estruturado em JSONB (preferido): preserva quebras de linha e inclui limites de uso
      update['traits'] =
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
                  'has_hit_point_increase': t.hasHitPointIncrease,
                  if (t.hasHitPointIncrease) ...{
                    'hit_point_increase_per_level':
                        int.tryParse(t.hitPointIncreasePerLevel.text) ?? 1,
                  },
                },
              )
              .toList();

      // 2) Compatibilidade: texto em linha única (para telas antigas que usam traits_text)
      String toSingleLine(String text) {
        return text
            .replaceAll('\r\n', '\n')
            .replaceAll('\r', '\n')
            .replaceAll(RegExp(r'\s*\n\s*'), ' ')
            .trim();
      }

      update['traits_text'] = _traitEntries
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

      // racial_spells
      update['racial_spells'] = _spellEntries
          .where(
            (s) =>
                s.name.text.trim().isNotEmpty || s.level.text.trim().isNotEmpty,
          )
          .map((s) => '${s.name.text.trim()}: Nível ${s.level.text.trim()}')
          .join('\n');

      await SupabaseService.client.from('races').update(update).eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Raça atualizada!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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

  Widget _buildTraitHitPointIncreaseSection(_TraitEntry trait) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text(
            'Este traço aumenta Pontos de Vida',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Marque se o traço aumenta os Pontos de Vida máximos por nível',
          ),
          value: trait.hasHitPointIncrease,
          onChanged: (value) {
            setState(() {
              trait.hasHitPointIncrease = value ?? false;
              if (!trait.hasHitPointIncrease) {
                trait.hitPointIncreasePerLevel.clear();
                trait.hitPointIncreasePerLevel.text = '1';
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (trait.hasHitPointIncrease) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: trait.hitPointIncreasePerLevel,
            decoration: const InputDecoration(
              labelText: 'Aumento por Nível *',
              hintText: 'Ex: 1 (aumenta 1 PV por nível)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ],
    );
  }
}
