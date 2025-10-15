import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '/widgets/rich_text_helpers.dart';

class EditEquipmentScreen extends ConsumerStatefulWidget {
  const EditEquipmentScreen({super.key, required this.equipment});

  final Map<String, dynamic> equipment;

  @override
  ConsumerState<EditEquipmentScreen> createState() =>
      _EditEquipmentScreenState();
}

class _EditEquipmentScreenState extends ConsumerState<EditEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _typeController;
  String? _selectedSource;
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];
  final List<String> _currencyOptions = ['PO', 'PP', 'PC', 'PE', 'PL'];
  String? _selectedCurrency;
  late final TextEditingController _costController;
  late final TextEditingController _weightController;
  late final TextEditingController _damageController;
  late final TextEditingController _damageTypeController;
  late final TextEditingController _armorClassController;
  late final TextEditingController _strengthController;
  late final TextEditingController _stealthController;

  // Novas variáveis para funcionalidades implementadas
  bool _hasStealthDisadvantage = false;
  bool _hasRequirement = false;
  final List<String> _selectedAttributes = [];
  final Map<String, int> _attributeRequirements = {};
  String? _armorClassModifier;

  // Opções de tipo (igual à criação)
  final List<String> _equipmentTypes = [
    'Arma Simples',
    'Arma Marcial',
    'Armadura Leve',
    'Armadura Média',
    'Armadura Pesada',
    'Escudo',
    'Ferramenta',
    'Foco em conjuração',
    'Kit',
    'Instrumento Musical',
    'Item de Aventura',
    'Item Mágico',
    'Poção',
    'Pergaminho',
    'Outro',
  ];

  // Propriedades de armas e seleção
  final Map<String, String> _weaponProperties = {
    'Acuidade': 'Usa Força ou Destreza para ataque/dano.',
    'Alcance': 'Possui alcance indicado (normal/máximo).',
    'Arremesso': 'Pode ser arremessada para ataque à distância.',
    'Duas Mãos': 'Exige duas mãos ao atacar.',
    'Extensão': 'Adiciona 1,5m ao alcance para ataques/oportunidade.',
    'Leve': 'Permite ataque adicional com Ação Bônus.',
    'Munição': 'Requer munição apropriada.',
    'Pesada': 'Desvantagem se atributo < 13.',
    'Recarga': 'Dispara apenas uma munição por ação/bônus/reação.',
    'Versátil': 'Dano alternativo ao usar duas mãos.',
  };
  final Map<String, bool> _selectedProperties = {};
  bool _isRangedWeapon = false;
  final _thrownRangeController = TextEditingController();
  final List<String> _damageTypes = const [
    'Cortante',
    'Perfurante',
    'Concussão',
    'Ácido',
    'Fogo',
    'Gelo',
    'Relâmpago',
    'Trovão',
    'Veneno',
    'Psíquico',
    'Radiante',
    'Necrótico',
    'Força',
  ];
  String? _selectedDamageType;
  final List<String> _weaponMasteryOptions = [
    'Afligir',
    'Ágil',
    'Derrubar',
    'Drenar',
    'Empurrar',
    'Garantido',
    'Lentidão',
    'Trespassar',
  ];
  final Map<String, String> _weaponMasteryDescriptions = const {
    'Afligir':
        'Se atingir e causar dano, você tem Vantagem no próximo ataque contra a mesma criatura até o fim do seu próximo turno.',
    'Ágil':
        'Ao usar Leve, o ataque adicional pode ser parte da ação Atacar (uma vez por turno), em vez de Ação Bônus.',
    'Derrubar':
        'Ao atingir, a criatura faz salvaguarda de Constituição (CD 8 + mod. do atributo de ataque + bônus de prof.). Se falhar, fica Caída.',
    'Drenar':
        'Ao atingir, a criatura tem Desvantagem na próxima jogada de ataque dela antes do início do seu próximo turno.',
    'Empurrar':
        'Ao atingir, você pode empurrar a criatura em até 3 m para longe se ela for Grande ou menor.',
    'Garantido':
        'Se errar o ataque, causa dano igual ao modificador do atributo usado (mesmo tipo da arma). Só aumenta se o modificador aumentar.',
    'Lentidão':
        'Ao atingir e causar dano, reduz o Deslocamento da criatura em 3 m até o início do seu próximo turno (não acumula além de 3 m).',
    'Trespassar':
        'Ao acertar um ataque corpo a corpo, pode fazer um ataque corpo a corpo adicional contra uma segunda criatura a 1,5 m (sem adicionar o modificador ao dano; uma vez por turno).',
  };
  String? _selectedWeaponMastery;

  // Atributos disponíveis para requisitos
  final List<String> _availableAttributes = [
    'Força',
    'Destreza',
    'Constituição',
    'Inteligência',
    'Sabedoria',
    'Carisma',
  ];

  // Modificadores disponíveis para classe de armadura
  final List<String> _armorClassModifiers = [
    'Destreza',
    'Constituição',
    'Força',
    'Nenhum',
  ];

  bool get _isArmorType {
    final t = _typeController.text;
    if (t.isEmpty) return false;
    return t.contains('Armadura') || t == 'Escudo';
  }

  bool get _isWeaponType {
    final t = _typeController.text;
    if (t.isEmpty) return false;
    return t == 'Arma Simples' || t == 'Arma Marcial';
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final e = widget.equipment;
    _nameController = TextEditingController(text: e['name'] ?? '');
    _descriptionController = TextEditingController(
      text: e['description'] ?? '',
    );
    _typeController = TextEditingController(text: e['type'] ?? '');
    _selectedSource = e['source'];
    _costController = TextEditingController(
      text: (e['cost_text'] ?? e['cost']?.toString() ?? ''),
    );
    _selectedCurrency = e['cost_currency'];
    _weightController = TextEditingController(
      text: e['weight']?.toString() ?? '',
    );
    _damageController = TextEditingController(text: e['damage'] ?? '');
    _damageTypeController = TextEditingController(text: e['damage_type'] ?? '');
    _selectedDamageType =
        _damageTypeController.text.isEmpty ? null : _damageTypeController.text;
    _armorClassController = TextEditingController(text: e['armor_class'] ?? '');
    _strengthController = TextEditingController(
      text: e['strength']?.toString() ?? '',
    );
    _stealthController = TextEditingController(
      text: e['stealth']?.toString() ?? '',
    );

    // Inicializar novas funcionalidades
    _hasStealthDisadvantage = e['stealth'] == true;
    _armorClassModifier = e['armor_class_modifier'];

    // Carregar requisitos de atributo
    if (e['attribute_requirements'] != null) {
      _hasRequirement = true;
      final requirements = e['attribute_requirements'] as Map<String, dynamic>;
      requirements.forEach((key, value) {
        _selectedAttributes.add(key);
        _attributeRequirements[key] = value as int;
      });
    }

    // Carregar atributos obrigatórios se não houver requirements
    if (!_hasRequirement && e['required_attributes'] != null) {
      final requiredAttrs = e['required_attributes'] as String;
      if (requiredAttrs.isNotEmpty) {
        _hasRequirement = true;
        _selectedAttributes.addAll(requiredAttrs.split(', '));
        // Definir valor padrão de 1 para atributos sem valor específico
        for (final attr in _selectedAttributes) {
          _attributeRequirements[attr] = 1;
        }
      }
    }

    // Defaults seguros para evitar travamentos por valores nulos/fora das opções
    if (_typeController.text.isEmpty ||
        !_equipmentTypes.contains(_typeController.text)) {
      _typeController.text = 'Outro';
    }
    // Normalizar valores para opções válidas
    _selectedSource =
        _sourceOptions.contains(_selectedSource)
            ? _selectedSource
            : _sourceOptions.first;
    _selectedCurrency =
        _currencyOptions.contains(_selectedCurrency) ? _selectedCurrency : 'PO';

    // Inicializar propriedades selecionadas e flag "à distância"
    final props = (e['weapon_properties'] ?? '') as String;
    for (final p in props.split(',')) {
      final k = p.trim();
      if (k.isNotEmpty) _selectedProperties[k] = true;
    }
    _isRangedWeapon = e['is_ranged'] == true;
    _thrownRangeController.text = (e['thrown_range'] ?? '') as String;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _costController.dispose();
    _weightController.dispose();
    _damageController.dispose();
    _damageTypeController.dispose();
    _armorClassController.dispose();
    _strengthController.dispose();
    _stealthController.dispose();
    _thrownRangeController.dispose();
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
          child: Text('Apenas administradores podem editar equipamentos.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Equipamento'),
        backgroundColor: Colors.brown,
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
            children: [
              _field(
                _nameController,
                'Nome *',
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value:
                    _equipmentTypes.contains(_typeController.text)
                        ? _typeController.text
                        : null,
                decoration: const InputDecoration(
                  labelText: 'Tipo *',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                items:
                    _equipmentTypes
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                onChanged:
                    (v) => setState(() => _typeController.text = v ?? ''),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
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
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                onChanged: (v) => setState(() => _selectedSource = v),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(flex: 2, child: _field(_costController, 'Custo')),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                      decoration: const InputDecoration(
                        labelText: 'Moeda',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items:
                          _currencyOptions
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _selectedCurrency = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _field(_weightController, 'Peso (deixe vazio se não tiver)'),
              const SizedBox(height: 12),
              if (_isWeaponType) ...[
                _field(_damageController, 'Dano'),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedDamageType,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Dano',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items:
                      _damageTypes
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                  onChanged: (v) {
                    setState(() {
                      _selectedDamageType = v;
                      _damageTypeController.text = v ?? '';
                    });
                  },
                ),
                const SizedBox(height: 12),
                if (_selectedProperties['Arremesso'] == true)
                  _field(
                    _thrownRangeController,
                    'Distância de Arremesso (ex: 20/60 pés)',
                  ),
                if (_selectedProperties['Arremesso'] == true)
                  const SizedBox(height: 12),
                if (_selectedSource == 'PHB 2024') ...[
                  DropdownButtonFormField<String>(
                    value: _selectedWeaponMastery,
                    decoration: const InputDecoration(
                      labelText: 'Maestria (PHB 2024)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items:
                        _weaponMasteryOptions
                            .map(
                              (m) => DropdownMenuItem(value: m, child: Text(m)),
                            )
                            .toList(),
                    onChanged:
                        (v) => setState(() => _selectedWeaponMastery = v),
                  ),
                  const SizedBox(height: 12),
                  if (_selectedWeaponMastery != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(16),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withAlpha(80)),
                      ),
                      child: Text(
                        _weaponMasteryDescriptions[_selectedWeaponMastery!] ??
                            '',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    Checkbox(
                      value: _isRangedWeapon,
                      onChanged:
                          (value) =>
                              setState(() => _isRangedWeapon = value ?? false),
                    ),
                    const Expanded(child: Text('Arma à Distância')),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Propriedades da Arma',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._weaponProperties.keys.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedProperties[p] ?? false,
                              onChanged:
                                  (v) => setState(
                                    () => _selectedProperties[p] = v ?? false,
                                  ),
                            ),
                            Expanded(child: Text(p)),
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 18),
                              onPressed:
                                  () => showDialog(
                                    context: context,
                                    builder:
                                        (_) => AlertDialog(
                                          title: Text(p),
                                          content: Text(
                                            _weaponProperties[p] ??
                                                'Descrição não disponível',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text('Fechar'),
                                            ),
                                          ],
                                        ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              if (_isArmorType) ...[
                _buildArmorClassSection(),
                const SizedBox(height: 12),
                _buildRequirementSection(),
                const SizedBox(height: 12),
                _buildStealthDisadvantageCheckbox(),
              ],
              const SizedBox(height: 12),
              FormattedTextEditor(
                controller: _descriptionController,
                label: 'Descrição',
                hint: 'Descrição do equipamento...',
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

  Widget _field(
    TextEditingController c,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildArmorClassSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Classe de Armadura',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _field(
                _armorClassController,
                'Valor Base',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final parsed = int.tryParse(value);
                    if (parsed == null) {
                      return 'Digite um número válido';
                    }
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<String>(
                value: _armorClassModifier,
                decoration: const InputDecoration(
                  labelText: 'Modificador',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                items:
                    _armorClassModifiers
                        .map(
                          (modifier) => DropdownMenuItem(
                            value: modifier,
                            child: Text(modifier),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _armorClassModifier = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _hasRequirement,
              onChanged: (value) {
                setState(() {
                  _hasRequirement = value ?? false;
                  if (!_hasRequirement) {
                    _selectedAttributes.clear();
                    _attributeRequirements.clear();
                  }
                });
              },
              activeColor: Colors.blue,
            ),
            Expanded(
              child: Text(
                'Tem Requisito de Atributo',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.blue,
              ),
              onPressed: () => _showRequirementInfo(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ),
        if (_hasRequirement) ...[
          const SizedBox(height: 12),
          _buildAttributeSelection(),
        ],
      ],
    );
  }

  Widget _buildAttributeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecionar Atributos e Valores:',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._availableAttributes.map(
          (attribute) => _buildAttributeRequirement(attribute),
        ),
      ],
    );
  }

  Widget _buildAttributeRequirement(String attribute) {
    final isSelected = _selectedAttributes.contains(attribute);
    final value = _attributeRequirements[attribute] ?? 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (checked) {
              setState(() {
                if (checked == true) {
                  _selectedAttributes.add(attribute);
                  _attributeRequirements[attribute] = 1;
                } else {
                  _selectedAttributes.remove(attribute);
                  _attributeRequirements.remove(attribute);
                }
              });
            },
            activeColor: Colors.blue,
          ),
          Expanded(
            child: Text(
              attribute,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: TextFormField(
                initialValue: value.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 12),
                onChanged: (text) {
                  final newValue = int.tryParse(text) ?? 1;
                  if (newValue >= 1 && newValue <= 20) {
                    _attributeRequirements[attribute] = newValue;
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStealthDisadvantageCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _hasStealthDisadvantage,
          onChanged: (value) {
            setState(() {
              _hasStealthDisadvantage = value ?? false;
            });
          },
          activeColor: Colors.green,
        ),
        Expanded(
          child: Text(
            'Desvantagem em Furtividade',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, size: 18, color: Colors.blue),
          onPressed: () => _showStealthDisadvantageInfo(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }

  void _showRequirementInfo() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Requisito de Atributo'),
            content: const SingleChildScrollView(
              child: Text(
                'Algumas armaduras podem ter requisitos de atributo para serem usadas efetivamente. Selecione os atributos necessários e defina o valor mínimo (1-20) que o personagem deve ter para usar a armadura sem penalidades.',
                style: TextStyle(fontSize: 14),
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

  void _showStealthDisadvantageInfo() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Desvantagem em Furtividade'),
            content: const SingleChildScrollView(
              child: Text(
                'Algumas armaduras são tão pesadas ou barulhentas que impedem o movimento furtivo. Quando você usa uma armadura que causa desvantagem em furtividade, você tem desvantagem em qualquer teste de Furtividade que fizer.',
                style: TextStyle(fontSize: 14),
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      // Verificar se já existe outro item com o mesmo nome e fonte (excluindo o atual)
      final currentId = widget.equipment['id'];
      final existingItems = await SupabaseService.client
          .from('equipment')
          .select('id, name, source')
          .eq('name', _nameController.text.trim())
          .eq('source', _selectedSource!)
          .neq('id', currentId);

      if (existingItems.isNotEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Já existe outro equipamento com o nome "${_nameController.text.trim()}" da fonte "$_selectedSource".',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      final id = widget.equipment['id'];
      final selectedProps = _selectedProperties.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList()
          .join(', ');

      final update = {
        'name': _nameController.text.trim(),
        'type': _typeController.text.trim(),
        'source': _selectedSource,
        'description': _descriptionController.text.trim(),
        'cost':
            double.tryParse(
              _costController.text.trim() == ''
                  ? '0'
                  : _costController.text.trim(),
            ) ??
            0,
        'cost_text': _costController.text.trim(),
        'cost_currency': _selectedCurrency,
        'weight':
            _weightController.text.trim().isEmpty
                ? null
                : double.tryParse(_weightController.text.trim()),
        'weight_text': _weightController.text.trim(),
        'damage': _damageController.text.trim(),
        'damage_type': _damageTypeController.text.trim(),
        'armor_class':
            _armorClassController.text.trim().isEmpty
                ? null
                : int.tryParse(_armorClassController.text.trim()),
        'armor_class_modifier': _armorClassModifier,
        'strength':
            _strengthController.text.trim().isEmpty
                ? null
                : int.tryParse(_strengthController.text.trim()),
        'stealth': _hasStealthDisadvantage,
        'attribute_requirements':
            _hasRequirement ? _attributeRequirements : null,
        'required_attributes':
            _hasRequirement ? _selectedAttributes.join(', ') : null,
        'weapon_properties': selectedProps,
        'is_ranged': _isRangedWeapon,
        if (_selectedProperties['Arremesso'] == true)
          'thrown_range': _thrownRangeController.text.trim(),
        if (_selectedSource == 'PHB 2024')
          'weapon_mastery': _selectedWeaponMastery,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await SupabaseService.client
          .from('equipment')
          .update(update)
          .eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Equipamento atualizado!'),
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
}
