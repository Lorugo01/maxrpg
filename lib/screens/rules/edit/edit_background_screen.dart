import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '../../../services/equipment_service.dart';
import '../../../models/equipment.dart';
import '../../../widgets/rich_text_helpers.dart';

class EditBackgroundScreen extends ConsumerStatefulWidget {
  const EditBackgroundScreen({super.key, required this.background});

  final Map<String, dynamic> background;

  @override
  ConsumerState<EditBackgroundScreen> createState() =>
      _EditBackgroundScreenState();
}

class _EditBackgroundScreenState extends ConsumerState<EditBackgroundScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Campos PHB 2014 (compatibilidade)
  final _skillProficiencies2014Controller = TextEditingController();
  final _languagesController = TextEditingController();
  final _equipment2014Controller = TextEditingController();
  final _feature2014Controller = TextEditingController();

  // Campos PHB 2024
  final _toolProficiencyController = TextEditingController();
  final _equipmentChoiceAController = TextEditingController();
  final _equipmentChoiceBController = TextEditingController();

  // Seleção estruturada de itens + PO
  final List<Map<String, dynamic>> _equipmentChoiceAItems = [];
  final List<Map<String, dynamic>> _equipmentChoiceBItems = [];
  final _poChoiceAController = TextEditingController();
  final _poChoiceBController = TextEditingController();

  // PHB 2014 estruturado
  final List<Map<String, dynamic>> _equipment2014Items = [];
  final _po2014Controller = TextEditingController();

  // Escolhas de equipamento (ex.: instrumento musical à escolha)
  final List<Map<String, dynamic>> _equipmentChoices = [];

  // Talento selecionado
  String? _selectedFeat;
  List<Map<String, dynamic>> _availableFeats = [];

  // Lista de atributos para seleção
  final List<String> _abilityOptions = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];
  List<String> _selectedAbilityScores = [];

  // Lista de perícias para seleção
  final List<String> _skillOptions = [
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
  List<String> _selectedSkills = [];

  String? _selectedSource;
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  bool _isLoading = false;
  bool _isLoadingFeats = false;
  bool get _isPHB2024 => _selectedSource == 'PHB 2024';

  @override
  void initState() {
    super.initState();
    final b = widget.background;

    // Campos básicos
    _nameController.text = b['name'] ?? '';
    _descriptionController.text = b['description'] ?? '';
    _selectedSource = b['source'] ?? _sourceOptions.first;

    // Campos PHB 2014
    _skillProficiencies2014Controller.text =
        b['skill_proficiencies_2014'] ?? '';
    _languagesController.text = b['languages'] ?? '';
    _equipment2014Controller.text = b['equipment_2014'] ?? '';
    _feature2014Controller.text = b['features_2014'] ?? '';

    // Campos PHB 2024
    final abilityScoresText = b['ability_scores']?.toString() ?? '';
    _selectedAbilityScores =
        abilityScoresText.isNotEmpty
            ? abilityScoresText
                .split(', ')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList()
            : <String>[];

    final skillsText = b['skill_proficiencies_2024']?.toString() ?? '';
    _selectedSkills =
        skillsText.isNotEmpty
            ? skillsText
                .split(', ')
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList()
            : <String>[];

    // Talento selecionado (usar feat_id se disponível, senão buscar por nome)
    _selectedFeat = b['feat_id'];

    // Se não tem feat_id mas tem feat (nome), vamos buscar o ID depois que carregar os talentos
    final featName = b['feat']?.toString();
    if (_selectedFeat == null && featName != null && featName.isNotEmpty) {
      // Vamos buscar o ID do talento pelo nome depois que carregar os talentos
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _findFeatIdByName(featName);
      });
    }

    _toolProficiencyController.text = b['tool_proficiency'] ?? '';
    _equipmentChoiceAController.text = b['equipment_choice_a'] ?? '';
    _equipmentChoiceBController.text = b['equipment_choice_b'] ?? '';
    _equipmentChoiceAItems.addAll(
      List<Map<String, dynamic>>.from(b['equipment_choice_a_items'] ?? []),
    );
    _equipmentChoiceBItems.addAll(
      List<Map<String, dynamic>>.from(b['equipment_choice_b_items'] ?? []),
    );
    _poChoiceAController.text = (b['equipment_choice_a_po'] ?? 0).toString();
    _poChoiceBController.text = (b['equipment_choice_b_po'] ?? 0).toString();

    // Carregar escolhas de equipamento
    if (b['equipment_choices'] != null) {
      _equipmentChoices.clear();
      _equipmentChoices.addAll(
        List<Map<String, dynamic>>.from(b['equipment_choices']),
      );
    }

    // Carregar talentos
    _loadFeats();
  }

  // UI helpers de itens
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
        List<Equipment> filtered = List.of(all);
        final Map<String, int> quantities = {};

        void apply() {
          filtered =
              all
                  .where(
                    (e) => e.name.toLowerCase().contains(
                      search.text.toLowerCase(),
                    ),
                  )
                  .toList();
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
                              subtitle: Text(
                                eq.cost != null
                                    ? 'Custo: ${eq.cost}'
                                    : 'Sem custo',
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

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    // PHB 2014 controllers
    _skillProficiencies2014Controller.dispose();
    _languagesController.dispose();
    _equipment2014Controller.dispose();
    _feature2014Controller.dispose();

    // PHB 2024 controllers
    _toolProficiencyController.dispose();
    _equipmentChoiceAController.dispose();
    _equipmentChoiceBController.dispose();
    _poChoiceAController.dispose();
    _poChoiceBController.dispose();
    _po2014Controller.dispose();

    super.dispose();
  }

  Future<void> _loadFeats() async {
    setState(() => _isLoadingFeats = true);
    try {
      final response = await SupabaseService.client
          .from('feats')
          .select('id, name, description, prerequisite, source, category')
          .order('name', ascending: true);

      setState(() {
        _availableFeats = List<Map<String, dynamic>>.from(response);
        _isLoadingFeats = false;
      });
    } catch (e) {
      setState(() => _isLoadingFeats = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar talentos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _findFeatIdByName(String featName) {
    if (_availableFeats.isEmpty) return;

    try {
      final feat = _availableFeats.firstWhere(
        (f) => f['name']?.toString().toLowerCase() == featName.toLowerCase(),
        orElse: () => <String, dynamic>{},
      );

      if (feat.isNotEmpty && feat['id'] != null) {
        setState(() {
          _selectedFeat = feat['id'];
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar talento por nome: $e');
    }
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
          child: Text('Apenas administradores podem editar antecedentes.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Antecedente'),
        backgroundColor: Colors.orange,
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
                Icons.history_edu,
                Colors.orange,
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nome do Antecedente *',
                    hint: 'Ex: Soldado',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FormattedTextEditor(
                    controller: _descriptionController,
                    label: 'Descrição',
                    hint: 'Descrição do antecedente...',
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

              // Campos específicos por versão
              if (_isPHB2024) ...[
                // Estrutura PHB 2024
                _buildSectionCard(
                  context,
                  'Valores de Atributo',
                  Icons.trending_up,
                  Colors.red,
                  [
                    _buildMultiSelectField(
                      label: 'Valores de Atributo *',
                      hint: 'Selecione 3 atributos',
                      selectedItems: _selectedAbilityScores,
                      options: _abilityOptions,
                      validator: (value) {
                        if (_isPHB2024 && _selectedAbilityScores.length != 3) {
                          return 'Selecione exatamente 3 atributos para PHB 2024';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildSectionCard(
                  context,
                  'Talento',
                  Icons.star,
                  Colors.amber,
                  [_buildFeatDropdown()],
                ),
                const SizedBox(height: 24),

                _buildSectionCard(
                  context,
                  'Proficiências',
                  Icons.school,
                  Colors.blue,
                  [
                    _buildMultiSelectField(
                      label: 'Proficiências em Perícias *',
                      hint: 'Selecione 2 perícias',
                      selectedItems: _selectedSkills,
                      options: _skillOptions,
                      validator: (value) {
                        if (_isPHB2024 && _selectedSkills.length != 2) {
                          return 'Selecione exatamente 2 perícias para PHB 2024';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _toolProficiencyController,
                      label: 'Proficiência com Ferramentas *',
                      hint: 'Ex: Suprimentos de Calígrafo',
                      validator: (value) {
                        if (_isPHB2024 && (value == null || value.isEmpty)) {
                          return 'Proficiência com ferramentas é obrigatória para PHB 2024';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildSectionCard(
                  context,
                  'Equipamentos',
                  Icons.inventory,
                  Colors.green,
                  [
                    _buildEquipmentPicker(
                      title: 'Selecionar Itens (Escolha A)',
                      selected: _equipmentChoiceAItems,
                      onChanged:
                          (items) => setState(() {
                            _equipmentChoiceAItems
                              ..clear()
                              ..addAll(items);
                          }),
                    ),
                    if (_equipmentChoiceAItems.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildSelectedEquipmentChips(
                        _equipmentChoiceAItems,
                        (e) => setState(() => _equipmentChoiceAItems.remove(e)),
                      ),
                    ],
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _poChoiceAController,
                      label: 'PO (Peças de Ouro) - Escolha A',
                      hint: 'Ex: 50',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildEquipmentPicker(
                      title: 'Selecionar Itens (Escolha B)',
                      selected: _equipmentChoiceBItems,
                      onChanged:
                          (items) => setState(() {
                            _equipmentChoiceBItems
                              ..clear()
                              ..addAll(items);
                          }),
                    ),
                    if (_equipmentChoiceBItems.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildSelectedEquipmentChips(
                        _equipmentChoiceBItems,
                        (e) => setState(() => _equipmentChoiceBItems.remove(e)),
                      ),
                    ],
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _poChoiceBController,
                      label: 'PO (Peças de Ouro) - Escolha B',
                      hint: 'Ex: 50',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildEquipmentChoicesSection(),
                  ],
                ),
              ] else ...[
                // Estrutura PHB 2014 e outras versões
                _buildSectionCard(
                  context,
                  'Proficiências e Equipamentos',
                  Icons.inventory,
                  Colors.blue,
                  [
                    _buildTextField(
                      controller: _skillProficiencies2014Controller,
                      label: 'Proficiência em Perícias',
                      hint: 'Ex: Escolha 2 entre Atletismo, Intimidação...',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _languagesController,
                      label: 'Idiomas',
                      hint: 'Ex: Um idioma à sua escolha',
                    ),
                    const SizedBox(height: 16),
                    _buildEquipmentPicker(
                      title: 'Selecionar Itens (PHB 2014)',
                      selected: _equipment2014Items,
                      onChanged:
                          (items) => setState(() {
                            _equipment2014Items
                              ..clear()
                              ..addAll(items);
                          }),
                    ),
                    if (_equipment2014Items.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _buildSelectedEquipmentChips(
                        _equipment2014Items,
                        (e) => setState(() => _equipment2014Items.remove(e)),
                      ),
                    ],
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _po2014Controller,
                      label: 'PO (Peças de Ouro) - PHB 2014',
                      hint: 'Ex: 15',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildEquipmentChoicesSection(),
                  ],
                ),
                const SizedBox(height: 24),

                _buildSectionCard(
                  context,
                  'Característica Especial',
                  Icons.star,
                  Colors.purple,
                  [
                    _buildTextField(
                      controller: _feature2014Controller,
                      label: 'Característica do Antecedente',
                      hint: 'Característica especial do antecedente...',
                      maxLines: 3,
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 32),

              // Botão Salvar
              ElevatedButton.icon(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
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
                        '• O antecedente ficará disponível para todos os usuários',
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

  Widget _buildMultiSelectField({
    required String label,
    required String hint,
    required List<String> selectedItems,
    required List<String> options,
    String? Function(String?)? validator,
  }) {
    return InkWell(
      onTap:
          () => _showMultiSelectDialog(
            title: label,
            options: options,
            selectedItems: selectedItems,
            onSelectionChanged: (items) {
              setState(() {
                selectedItems.clear();
                selectedItems.addAll(items);
              });
            },
          ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          selectedItems.isEmpty ? hint : selectedItems.join(', '),
          style: TextStyle(
            color: selectedItems.isEmpty ? Colors.grey[600] : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isLoadingFeats)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          )
        else
          DropdownButtonFormField<String>(
            value: _selectedFeat,
            decoration: const InputDecoration(
              labelText: 'Talento *',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
            hint: const Text('Selecione um talento'),
            isExpanded: true,
            items:
                _availableFeats.map((feat) {
                  return DropdownMenuItem<String>(
                    value: feat['id'],
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  feat['name'] ?? 'Sem nome',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                if (feat['source'] != null) ...[
                                  const SizedBox(height: 1),
                                  Text(
                                    feat['source'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() => _selectedFeat = value);
            },
            validator: (value) {
              if (_isPHB2024 && (value == null || value.isEmpty)) {
                return 'Talento é obrigatório para PHB 2024';
              }
              return null;
            },
          ),
        if (_selectedFeat != null) ...[
          const SizedBox(height: 12),
          _buildSelectedFeatInfo(),
        ],
      ],
    );
  }

  Widget _buildSelectedFeatInfo() {
    final selectedFeat = _availableFeats.firstWhere(
      (feat) => feat['id'] == _selectedFeat,
      orElse: () => <String, dynamic>{},
    );

    if (selectedFeat.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withAlpha(32),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withAlpha(128)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber[700], size: 16),
              const SizedBox(width: 4),
              Text(
                'Talento Selecionado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            selectedFeat['name'] ?? 'Sem nome',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          if (selectedFeat['description'] != null &&
              selectedFeat['description'].toString().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              selectedFeat['description'],
              style: const TextStyle(fontSize: 12),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (selectedFeat['prerequisite'] != null &&
              selectedFeat['prerequisite'].toString().isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: 12),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Pré-requisito: ${selectedFeat['prerequisite']}',
                    style: TextStyle(fontSize: 11, color: Colors.blue[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showMultiSelectDialog({
    required String title,
    required List<String> options,
    required List<String> selectedItems,
    required Function(List<String>) onSelectionChanged,
  }) async {
    final tempSelectedItems = List<String>.from(selectedItems);

    await showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: Text(title),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = tempSelectedItems.contains(option);

                        return CheckboxListTile(
                          title: Text(option),
                          value: isSelected,
                          onChanged: (value) {
                            setDialogState(() {
                              if (value == true) {
                                tempSelectedItems.add(option);
                              } else {
                                tempSelectedItems.remove(option);
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
                        onSelectionChanged(tempSelectedItems);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
          ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final Map<String, dynamic> backgroundData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'source': _selectedSource,
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Adicionar campos específicos baseados na versão
      if (_isPHB2024) {
        // Buscar o nome do talento selecionado
        String featName = '';
        if (_selectedFeat != null) {
          final selectedFeat = _availableFeats.firstWhere(
            (feat) => feat['id'] == _selectedFeat,
            orElse: () => <String, dynamic>{},
          );
          featName = selectedFeat['name'] ?? '';
        }

        backgroundData.addAll({
          'ability_scores': _selectedAbilityScores.join(', '),
          'feat': featName,
          'skill_proficiencies_2024': _selectedSkills.join(', '),
          'tool_proficiency': _toolProficiencyController.text.trim(),
          'equipment_choice_a_items': _equipmentChoiceAItems,
          'equipment_choice_b_items': _equipmentChoiceBItems,
          'equipment_choice_a_po': int.tryParse(_poChoiceAController.text) ?? 0,
          'equipment_choice_b_po': int.tryParse(_poChoiceBController.text) ?? 0,
          'equipment_choices': _equipmentChoices,
        });

        // Tentar salvar feat_id se a coluna existir
        if (_selectedFeat != null) {
          backgroundData['feat_id'] = _selectedFeat;
        }
      } else {
        // PHB 2014 e outras versões
        backgroundData.addAll({
          'skill_proficiencies_2014':
              _skillProficiencies2014Controller.text.trim().isEmpty
                  ? ''
                  : _skillProficiencies2014Controller.text.trim(),
          'languages':
              _languagesController.text.trim().isEmpty
                  ? ''
                  : _languagesController.text.trim(),
          'equipment_2014_items': _equipment2014Items,
          'equipment_2014_po': int.tryParse(_po2014Controller.text) ?? 0,
          'equipment_choices': _equipmentChoices,
          'features_2014':
              _feature2014Controller.text.trim().isEmpty
                  ? ''
                  : _feature2014Controller.text.trim(),
        });
      }

      await SupabaseService.client
          .from('backgrounds')
          .update(backgroundData)
          .eq('id', widget.background['id']);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Antecedente atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar antecedente: $e'),
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

  // --- Escolhas de Equipamento ---
  Widget _buildEquipmentChoicesSection() {
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
                    'Escolhas de Equipamento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addEquipmentChoice,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Adicionar Escolha'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Escolhas de Equipamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton.icon(
                  onPressed: _addEquipmentChoice,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Adicionar Escolha'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Defina escolhas como: "1 instrumento musical à sua escolha"',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                title: Text(choice['description'] ?? 'Escolha'),
                subtitle:
                    (choice['options'] is List &&
                            (choice['options'] as List).isNotEmpty)
                        ? Text(
                          (choice['options'] as List)
                              .map((e) => e['name'])
                              .whereType<String>()
                              .take(5)
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
                      onPressed:
                          () => setState(() {
                            _equipmentChoices.removeAt(index);
                          }),
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
  final _descriptionController = TextEditingController();
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
              FormattedTextEditor(
                controller: _descriptionController,
                label: 'Descrição da Escolha *',
                hint: 'Ex: 1 instrumento musical à sua escolha',
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
                      subtitle: Text(option['description'] ?? ''),
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
        List<Equipment> filtered = List.of(all);

        void apply() {
          filtered =
              all
                  .where(
                    (e) => e.name.toLowerCase().contains(
                      search.text.toLowerCase(),
                    ),
                  )
                  .toList();
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
                              subtitle: Text(
                                eq.cost != null
                                    ? 'Custo: ${eq.cost}'
                                    : 'Sem custo',
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
