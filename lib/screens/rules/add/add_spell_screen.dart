import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/supabase_service.dart';

class AddSpellScreen extends ConsumerStatefulWidget {
  const AddSpellScreen({super.key});

  @override
  ConsumerState<AddSpellScreen> createState() => _AddSpellScreenState();
}

class _AddSpellScreenState extends ConsumerState<AddSpellScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _levelController = TextEditingController(text: '1');
  final _schoolController = TextEditingController();
  final _castingTimeController = TextEditingController();
  final _rangeController = TextEditingController();
  final _componentsController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  // Efeito mecânico
  String? _selectedEffectType; // 'Nenhum', 'Dano', 'Cura'
  final List<String> _effectTypeOptions = ['Nenhum', 'Dano', 'Cura'];
  final _baseDiceController = TextEditingController(); // ex: 2d8, 2d4
  final _upcastDiceController = TextEditingController(); // ex: 1d8, 2d4
  String? _selectedDamageType; // para dano
  final List<String> _damageTypeOptions = [
    'Ácido',
    'Concussão',
    'Fogo',
    'Frio',
    'Força',
    'Elétrico',
    'Necrótico',
    'Perfurante',
    'Psíquico',
    'Radiante',
    'Trovejante',
    'Corte',
    'Veneno',
  ];
  bool _includeSpellMod = false;
  // Opções de nível e escolas
  final List<int> _levelOptions = List.generate(10, (i) => i); // 0..9
  final List<String> _schoolOptions = [
    'Abjuração',
    'Adivinhação',
    'Conjuração',
    'Encantamento',
    'Evocação',
    'Ilusão',
    'Necromancia',
    'Transmutação',
  ];
  // Truque: aumentos de dado por nível
  final List<Map<String, dynamic>> _cantripDiceIncreases = [];
  String? _selectedSource;
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];
  String? _selectedRitual;
  String? _selectedConcentration;
  final List<String> _yesNoOptions = ['Não', 'Sim'];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedSource = _sourceOptions.first;
    _selectedRitual = _yesNoOptions.first; // 'Não'
    _selectedConcentration = _yesNoOptions.first; // 'Não'
    _selectedEffectType = _effectTypeOptions.first; // Nenhum
  }

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    _schoolController.dispose();
    _castingTimeController.dispose();
    _rangeController.dispose();
    _componentsController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _baseDiceController.dispose();
    _upcastDiceController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _levelController.text = '1';
      _schoolController.clear();
      _castingTimeController.clear();
      _rangeController.clear();
      _componentsController.clear();
      _durationController.clear();
      _descriptionController.clear();
      _baseDiceController.clear();
      _upcastDiceController.clear();

      _selectedSource = _sourceOptions.first;
      _selectedRitual = _yesNoOptions.first; // 'Não'
      _selectedConcentration = _yesNoOptions.first; // 'Não'
      _selectedEffectType = _effectTypeOptions.first; // 'Nenhum'
      _selectedDamageType = null;
      _includeSpellMod = false;

      _cantripDiceIncreases.clear();

      _formKey.currentState?.reset();
    });
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
          child: Text('Apenas administradores podem adicionar magias.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Magia'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveSpell,
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
                Icons.auto_awesome,
                Colors.indigo,
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nome da Magia *',
                    hint: 'Ex: Bola de Fogo',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isNarrow = constraints.maxWidth < 420;
                      if (isNarrow) {
                        return Column(
                          children: [
                            DropdownButtonFormField<int>(
                              value: int.tryParse(_levelController.text),
                              decoration: const InputDecoration(
                                labelText: 'Nível *',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items:
                                  _levelOptions
                                      .map(
                                        (lvl) => DropdownMenuItem(
                                          value: lvl,
                                          child: Text(lvl.toString()),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setState(
                                    () =>
                                        _levelController.text =
                                            (v ?? 0).toString(),
                                  ),
                              validator:
                                  (v) =>
                                      v == null ? 'Nível é obrigatório' : null,
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value:
                                  _schoolController.text.isEmpty
                                      ? null
                                      : _schoolController.text,
                              decoration: const InputDecoration(
                                labelText: 'Escola *',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items:
                                  _schoolOptions
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setState(
                                    () => _schoolController.text = v ?? '',
                                  ),
                              validator:
                                  (v) =>
                                      (v == null || v.isEmpty)
                                          ? 'Escola é obrigatória'
                                          : null,
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: int.tryParse(_levelController.text),
                              decoration: const InputDecoration(
                                labelText: 'Nível *',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items:
                                  _levelOptions
                                      .map(
                                        (lvl) => DropdownMenuItem(
                                          value: lvl,
                                          child: Text(lvl.toString()),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setState(
                                    () =>
                                        _levelController.text =
                                            (v ?? 0).toString(),
                                  ),
                              validator:
                                  (v) =>
                                      v == null ? 'Nível é obrigatório' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value:
                                  _schoolController.text.isEmpty
                                      ? null
                                      : _schoolController.text,
                              decoration: const InputDecoration(
                                labelText: 'Escola *',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              items:
                                  _schoolOptions
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (v) => setState(
                                    () => _schoolController.text = v ?? '',
                                  ),
                              validator:
                                  (v) =>
                                      (v == null || v.isEmpty)
                                          ? 'Escola é obrigatória'
                                          : null,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: 'Fonte *',
                    value: _selectedSource,
                    items: _sourceOptions,
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

              // Detalhes da Conjuração
              _buildSectionCard(
                context,
                'Detalhes da Conjuração',
                Icons.schedule,
                Colors.blue,
                [
                  _buildTextField(
                    controller: _castingTimeController,
                    label: 'Tempo de Conjuração',
                    hint: 'Ex: 1 ação',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _rangeController,
                    label: 'Alcance',
                    hint: 'Ex: 150 pés',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _componentsController,
                    label: 'Componentes',
                    hint: 'Ex: V, S, M (um pouco de enxofre)',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _durationController,
                    label: 'Duração',
                    hint: 'Ex: Instantâneo',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Propriedades Especiais
              _buildSectionCard(
                context,
                'Propriedades Especiais',
                Icons.star,
                Colors.purple,
                [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          label: 'Ritual',
                          value: _selectedRitual,
                          items: _yesNoOptions,
                          onChanged: (v) => setState(() => _selectedRitual = v),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdownField(
                          label: 'Concentração',
                          value: _selectedConcentration,
                          items: _yesNoOptions,
                          onChanged:
                              (v) => setState(() => _selectedConcentration = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Efeito Mecânico
                  _buildDropdownField(
                    label: 'Efeito Mecânico',
                    value: _selectedEffectType,
                    items: _effectTypeOptions,
                    onChanged: (v) => setState(() => _selectedEffectType = v),
                  ),
                  if (_selectedEffectType != null &&
                      _selectedEffectType != 'Nenhum') ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _baseDiceController,
                            label:
                                _selectedEffectType == 'Cura'
                                    ? 'Dados Base de Cura (ex: 2d4)'
                                    : 'Dados Base de Dano (ex: 2d8)',
                            hint: _selectedEffectType == 'Cura' ? '2d4' : '2d8',
                          ),
                        ),
                        if (!(_levelController.text == '0' ||
                            int.tryParse(_levelController.text) == 0)) ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _upcastDiceController,
                              label: 'Upcast por nível (ex: 1d8 ou 2d4)',
                              hint:
                                  _selectedEffectType == 'Cura' ? '2d4' : '1d8',
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_selectedEffectType == 'Dano')
                      _buildDropdownField(
                        label: 'Tipo de Dano',
                        value: _selectedDamageType,
                        items: _damageTypeOptions,
                        onChanged:
                            (v) => setState(() => _selectedDamageType = v),
                      ),
                    if (_selectedEffectType == 'Cura')
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Somar modificador de conjuração'),
                        value: _includeSpellMod,
                        onChanged:
                            (v) =>
                                setState(() => _includeSpellMod = v ?? false),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    const SizedBox(height: 12),
                    if ((_levelController.text == '0' ||
                        int.tryParse(_levelController.text) == 0))
                      _buildCantripDiceIncreasesSection(),
                  ],
                ],
              ),

              const SizedBox(height: 24),

              // Descrição
              _buildSectionCard(
                context,
                'Descrição',
                Icons.description,
                Colors.green,
                [
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Descrição',
                    hint: 'Descrição detalhada da magia...',
                    maxLines: 4,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botão Salvar
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveSpell,
                icon:
                    _isLoading
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.save),
                label: Text(_isLoading ? 'Salvando...' : 'Salvar Magia'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
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
                        '• Nível 0 = Truques (Cantrips)\n'
                        '• Use vírgulas para separar múltiplos itens\n'
                        '• As informações serão validadas antes de salvar\n'
                        '• A magia ficará disponível para todos os usuários',
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

  Widget _buildCantripDiceIncreasesSection() {
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
                  'Aumentos de Dado do Truque',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _cantripDiceIncreases.add({'level': 5, 'dice': '2d8'});
                    });
                  },
                  tooltip: 'Adicionar aumento',
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione aumentos como no exemplo: Nível 5 → 2d8, Nível 11 → 3d8, Nível 17 → 4d8.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 12),
            if (_cantripDiceIncreases.isEmpty)
              const Text(
                'Nenhum aumento definido',
                style: TextStyle(color: Colors.grey),
              )
            else
              ..._cantripDiceIncreases.asMap().entries.map((entry) {
                final index = entry.key;
                final inc = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: inc['level'] as int?,
                            decoration: const InputDecoration(
                              labelText: 'Nível',
                              border: OutlineInputBorder(),
                            ),
                            items:
                                const [5, 11, 17]
                                    .map(
                                      (l) => DropdownMenuItem(
                                        value: l,
                                        child: Text('Nível $l'),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) => setState(
                                  () =>
                                      _cantripDiceIncreases[index]['level'] = v,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: inc['dice']?.toString() ?? '',
                            decoration: const InputDecoration(
                              labelText: 'Dado',
                              hintText: 'Ex: 2d8 / 2d12',
                              border: OutlineInputBorder(),
                            ),
                            onChanged:
                                (v) =>
                                    _cantripDiceIncreases[index]['dice'] =
                                        v.trim(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed:
                              () => setState(
                                () => _cantripDiceIncreases.removeAt(index),
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

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items:
          items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
    );
  }

  Future<void> _saveSpell() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Verificar se já existe uma magia com o mesmo nome e fonte
      final existingSpells = await SupabaseService.client
          .from('spells')
          .select('id, name, source')
          .eq('name', _nameController.text.trim())
          .eq('source', _selectedSource!);

      if (existingSpells.isNotEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Já existe uma magia com o nome "${_nameController.text.trim()}" da fonte "$_selectedSource".',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return; // Parar o salvamento se encontrar duplicata
      }

      final spellData = {
        'name': _nameController.text.trim(),
        'level': int.parse(_levelController.text),
        'school': _schoolController.text.trim(),
        'source': _selectedSource,
        'casting_time': _castingTimeController.text.trim(),
        'range': _rangeController.text.trim(),
        'components': _componentsController.text.trim(),
        'duration': _durationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'ritual': _selectedRitual == 'Sim',
        'concentration': _selectedConcentration == 'Sim',
        // Efeito mecânico
        'effect_type':
            _selectedEffectType == 'Dano'
                ? 'damage'
                : _selectedEffectType == 'Cura'
                ? 'healing'
                : null,
        'base_dice':
            _baseDiceController.text.trim().isEmpty
                ? null
                : _baseDiceController.text.trim(),
        'include_spell_mod':
            _selectedEffectType == 'Cura' ? _includeSpellMod : null,
        'damage_type':
            _selectedEffectType == 'Dano' ? _selectedDamageType : null,
        'upcast_dice_per_level':
            _upcastDiceController.text.trim().isEmpty
                ? null
                : _upcastDiceController.text.trim(),
        'cantrip_dice_increases':
            _cantripDiceIncreases.isEmpty ? null : _cantripDiceIncreases,
        'created_at': DateTime.now().toIso8601String(),
      };

      await SupabaseService.client.from('spells').insert(spellData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Magia adicionada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Resetar o formulário
        _resetForm();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar magia: $e'),
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
}
