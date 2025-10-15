import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/supabase_service.dart';
import '../../../widgets/rich_text_helpers.dart';

class AddEquipmentScreen extends ConsumerStatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  ConsumerState<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends ConsumerState<AddEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _weightController = TextEditingController();
  final _damageController = TextEditingController();
  final _damageTypeController = TextEditingController();
  final _armorClassController = TextEditingController();
  final _strengthController = TextEditingController();
  final _stealthController = TextEditingController();

  String? _selectedType;
  String? _selectedSource;
  bool _isLoading = false;
  bool _isRangedWeapon = false;
  bool _hasStealthDisadvantage = false;
  bool _hasRequirement = false;
  final List<String> _selectedAttributes = [];
  final Map<String, int> _attributeRequirements = {};
  String? _armorClassModifier;

  // Lista de tipos de equipamentos do D&D 5e
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

  // Fontes disponíveis
  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  // Moedas disponíveis
  final List<String> _currencyOptions = [
    'PO', // Peças de Ouro
    'PP', // Peças de Prata
    'PC', // Peças de Cobre
    'PE', // Peças de Electrum
    'PL', // Peças de Platina
  ];
  String? _selectedCurrency;

  // Propriedades das armas com suas descrições
  final Map<String, String> _weaponProperties = {
    'Acuidade':
        'Ao realizar um ataque com uma arma que possui Acuidade, utilize seu modificador de Força ou Destreza, à sua escolha, para as jogadas de ataque e dano. Você deve aplicar o mesmo modificador em ambas as jogadas.',
    'Alcance':
        'Uma arma com Alcance possui um alcance indicado entre parênteses após a propriedade Munição ou Arremesso. O alcance apresenta dois números: o primeiro representa o alcance normal da arma em metros, enquanto o segundo indica o alcance máximo.',
    'Arremesso':
        'Se uma arma possui a propriedade Arremesso, você pode arremessá-la para realizar um ataque à distância, e pode sacar essa arma como parte do ataque.',
    'Duas Mãos':
        'Uma arma de Duas Mãos exige o uso de duas mãos quando você ataca com ela.',
    'Extensão':
        'Uma arma de Extensão adiciona 1,5 metro ao seu alcance quando você ataca com ela, bem como ao determinar seu alcance para realizar Ataques de Oportunidade com ela.',
    'Leve':
        'Quando você executa a ação Atacar em seu turno e usa uma arma Leve, pode realizar um ataque adicional como uma Ação Bônus mais tarde no mesmo turno.',
    'Munição':
        'Você só pode usar uma arma com a propriedade Munição para realizar um ataque à distância se tiver munição disponível. O tipo de munição necessária é especificado junto ao alcance da arma.',
    'Pesada':
        'Você tem Desvantagem em jogadas de ataque com uma arma Pesada se for uma arma Corpo a Corpo e seu valor de Força for inferior a 13, ou se for uma arma à Distância e seu valor de Destreza for inferior a 13.',
    'Recarga':
        'Você pode disparar apenas uma única peça de munição de uma arma com Recarga ao executar uma ação, uma Ação Bônus ou uma Reação para dispará-la.',
    'Versátil':
        'Uma arma Versátil pode ser usada com uma ou duas mãos. Um valor de dano entre parênteses aparece com a propriedade. A arma causa esse dano quando usada com as duas mãos.',
  };

  // Estado das propriedades selecionadas
  final Map<String, bool> _selectedProperties = {};
  final _thrownRangeController = TextEditingController();

  // Tipos de dano padronizados
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

  // Maestrias (PHB 2024) – nomes e descrições em PT-BR
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

  // Verificar se o tipo selecionado é uma armadura
  bool get _isArmorType {
    if (_selectedType == null) return false;
    return _selectedType!.contains('Armadura') || _selectedType == 'Escudo';
  }

  // Verificar se o tipo selecionado é uma arma
  bool get _isWeaponType {
    if (_selectedType == null) return false;
    // Atenção: "Armadura" contém a substring "Arma". Para evitar falso positivo,
    // fazemos a verificação por igualdade apenas para os tipos de arma válidos.
    return _selectedType == 'Arma Simples' || _selectedType == 'Arma Marcial';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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

  void _resetForm() {
    setState(() {
      // Limpar todos os campos de texto
      _nameController.clear();
      _descriptionController.clear();
      _costController.clear();
      _weightController.clear();
      _damageController.clear();
      _damageTypeController.clear();
      _armorClassController.clear();
      _strengthController.clear();
      _stealthController.clear();
      _thrownRangeController.clear();

      // Resetar seleções
      _selectedType = null;
      _selectedSource = null;
      _selectedCurrency = null;
      _selectedDamageType = null;
      _selectedWeaponMastery = null;
      _armorClassModifier = null;

      // Resetar checkboxes e flags
      _isRangedWeapon = false;
      _hasStealthDisadvantage = false;
      _hasRequirement = false;

      // Limpar listas e mapas
      _selectedAttributes.clear();
      _attributeRequirements.clear();
      _selectedProperties.clear();

      // Resetar o formulário
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
          child: Text('Apenas administradores podem adicionar equipamentos.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Equipamento'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveEquipment,
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
                Icons.shield,
                Colors.brown,
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nome do Equipamento *',
                    hint: 'Ex: Espada Longa',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Layout responsivo para Tipo e Custo
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 400) {
                        // Layout vertical para telas pequenas
                        return Column(
                          children: [
                            _buildDropdownField(
                              label: 'Tipo *',
                              value: _selectedType,
                              items: _equipmentTypes,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tipo é obrigatório';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildTextField(
                                    controller: _costController,
                                    label: 'Custo',
                                    hint: 'Ex: 15',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Moeda',
                                    value: _selectedCurrency,
                                    items: _currencyOptions,
                                    onChanged:
                                        (v) => setState(
                                          () => _selectedCurrency = v,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Layout horizontal para telas maiores
                        return Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: 'Tipo *',
                                value: _selectedType,
                                items: _equipmentTypes,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tipo é obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _buildTextField(
                                      controller: _costController,
                                      label: 'Custo',
                                      hint: 'Ex: 15',
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildDropdownField(
                                      label: 'Moeda',
                                      value: _selectedCurrency,
                                      items: _currencyOptions,
                                      onChanged:
                                          (v) => setState(
                                            () => _selectedCurrency = v,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: 'Fonte *',
                    value: _selectedSource,
                    items: _sourceOptions,
                    onChanged: (value) {
                      setState(() {
                        _selectedSource = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fonte é obrigatória';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _weightController,
                    label: 'Peso',
                    hint: 'Ex: 3 lb',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Propriedades de Armas (apenas para armas)
              if (_isWeaponType) ...[
                _buildSectionCard(
                  context,
                  'Propriedades de Armas',
                  Icons.flash_on,
                  Colors.red,
                  [
                    _buildTextField(
                      controller: _damageController,
                      label: 'Dano',
                      hint: 'Ex: 1d8 + modificador de Força',
                    ),
                    const SizedBox(height: 16),
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
                                (t) =>
                                    DropdownMenuItem(value: t, child: Text(t)),
                              )
                              .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedDamageType = v;
                          _damageTypeController.text = v ?? '';
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    if (_selectedSource == 'PHB 2024') ...[
                      _buildDropdownField(
                        label: 'Maestria (PHB 2024)',
                        value: _selectedWeaponMastery,
                        items: _weaponMasteryOptions,
                        onChanged:
                            (v) => setState(() => _selectedWeaponMastery = v),
                      ),
                      const SizedBox(height: 16),
                      if (_selectedWeaponMastery != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withAlpha(16),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.orange.withAlpha(80),
                            ),
                          ),
                          child: Text(
                            _weaponMasteryDescriptions[_selectedWeaponMastery!] ??
                                '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                    _buildRangedWeaponCheckbox(),
                    const SizedBox(height: 16),
                    _buildWeaponPropertiesSection(),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // Propriedades de Armaduras (apenas para armaduras)
              if (_isArmorType) ...[
                _buildSectionCard(
                  context,
                  'Propriedades de Armaduras',
                  Icons.security,
                  Colors.green,
                  [
                    _buildArmorClassSection(),
                    const SizedBox(height: 16),
                    _buildRequirementSection(),
                    const SizedBox(height: 16),
                    _buildStealthDisadvantageCheckbox(),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              const SizedBox(height: 24),

              // Descrição (opcional) - por último
              _buildSectionCard(
                context,
                'Descrição',
                Icons.description,
                Colors.blue,
                [
                  FormattedTextEditor(
                    controller: _descriptionController,
                    label: 'Descrição (Opcional)',
                    hint: 'Descrição detalhada do equipamento...',
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botão Salvar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveEquipment,
                  icon:
                      _isLoading
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.save),
                  label: Text(
                    _isLoading ? 'Salvando...' : 'Salvar Equipamento',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
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
                        '• Preencha apenas os campos relevantes para o tipo de equipamento\n'
                        '• Use vírgulas para separar múltiplos itens\n'
                        '• As informações serão validadas antes de salvar\n'
                        '• O equipamento ficará disponível para todos os usuários',
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
        labelStyle: const TextStyle(color: Colors.black87),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
    );
  }

  Widget _buildRangedWeaponCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isRangedWeapon,
          onChanged: (value) {
            setState(() {
              _isRangedWeapon = value ?? false;
            });
          },
          activeColor: Colors.red,
        ),
        Expanded(
          child: Text(
            'Arma à Distância',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, size: 18, color: Colors.blue),
          onPressed: () => _showRangedWeaponInfo(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
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
              child: _buildTextField(
                controller: _armorClassController,
                label: 'Valor Base',
                hint: 'Ex: 11',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: _buildDropdownField(
                label: 'Modificador',
                value: _armorClassModifier,
                items: _armorClassModifiers,
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

  Widget _buildWeaponPropertiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Propriedades da Arma',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ..._weaponProperties.keys.map(
          (property) => _buildPropertyCheckbox(property),
        ),
      ],
    );
  }

  Widget _buildPropertyCheckbox(String property) {
    final isChecked = _selectedProperties[property] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    _selectedProperties[property] = value ?? false;
                  });
                },
                activeColor: Colors.red,
              ),
              Expanded(
                child: Text(
                  property,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: Colors.blue,
                ),
                onPressed: () => _showPropertyInfo(property),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
          if (property == 'Arremesso' && isChecked) ...[
            const SizedBox(height: 8),
            _buildTextField(
              controller: _thrownRangeController,
              label: 'Distância de Arremesso (ex: 20/60 pés)',
              hint: 'ex: 20/60 pés',
            ),
          ],
        ],
      ),
    );
  }

  void _showRangedWeaponInfo() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Arma à Distância'),
            content: const SingleChildScrollView(
              child: Text(
                'Armas à distância são projetadas para atacar alvos que estão longe do usuário. Elas incluem arcos, bestas, fundas e armas arremessadas. Geralmente usam Destreza para ataques e podem ter propriedades especiais como Alcance e Munição.',
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

  void _showPropertyInfo(String property) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(property),
            content: SingleChildScrollView(
              child: Text(
                _weaponProperties[property] ?? 'Descrição não disponível',
                style: const TextStyle(fontSize: 14),
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

  String _getSelectedPropertiesString() {
    final selectedProps =
        _selectedProperties.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();
    return selectedProps.join(', ');
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
        labelStyle: const TextStyle(color: Colors.black87),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      dropdownColor: Colors.white,
      iconEnabledColor: Colors.black87,
    );
  }

  Future<void> _saveEquipment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Verificar se já existe um item com o mesmo nome e fonte
      final existingItems = await SupabaseService.client
          .from('equipment')
          .select('id, name, source')
          .eq('name', _nameController.text.trim())
          .eq('source', _selectedSource!);

      if (existingItems.isNotEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Já existe um equipamento com o nome "${_nameController.text.trim()}" da fonte "$_selectedSource".',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }
      final equipmentData = {
        'name': _nameController.text.trim(),
        'type': _selectedType!,
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
        // Campos de arma (apenas se for arma)
        if (_isWeaponType) ...{
          'damage': _damageController.text.trim(),
          'damage_type': _damageTypeController.text.trim(),
          'weapon_properties': _getSelectedPropertiesString(),
          'is_ranged': _isRangedWeapon,
          'weapon_mastery': _selectedWeaponMastery,
          if (_selectedProperties['Arremesso'] == true)
            'thrown_range': _thrownRangeController.text.trim(),
        },
        // Campos de armadura (apenas se for armadura)
        if (_isArmorType) ...{
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
        },
        'created_at': DateTime.now().toIso8601String(),
      };

      await SupabaseService.client.from('equipment').insert(equipmentData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item adicionado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Reiniciar o formulário para adicionar mais itens
        _resetForm();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar equipamento: $e'),
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
