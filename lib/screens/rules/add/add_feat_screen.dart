import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/supabase_service.dart';
import '../../data/data_management_screen.dart';

class AddFeatScreen extends ConsumerStatefulWidget {
  const AddFeatScreen({super.key});

  @override
  ConsumerState<AddFeatScreen> createState() => _AddFeatScreenState();
}

class _AddFeatScreenState extends ConsumerState<AddFeatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prerequisiteController = TextEditingController();
  final _sourceController = TextEditingController();

  String? _selectedSource;
  String? _selectedCategory;
  bool _isRepeatable = false;

  // Lista de benefícios do talento (similar aos Traços em add_race_screen)
  final List<Map<String, TextEditingController>> _benefitEntries = [
    {'name': TextEditingController(), 'description': TextEditingController()},
  ];

  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  final List<String> _categoryOptions = [
    'Origem',
    'Estilo de Luta',
    'Dádiva Épica',
    'Geral',
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedSource = _sourceOptions.first;
    _selectedCategory = _categoryOptions.first;
  }

  // removido

  // (removido da tela principal; seção de extras ficará no diálogo)

  @override
  void dispose() {
    _nameController.dispose();
    _prerequisiteController.dispose();
    _sourceController.dispose();
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
          child: Text('Apenas administradores podem adicionar talentos.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Talento'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveFeat,
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
                Icons.star,
                Colors.orange,
                [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nome do Talento *',
                    hint: 'Ex: Iniciado em Magia',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Campo de descrição geral removido
                  _buildTextField(
                    controller: _prerequisiteController,
                    label: 'Pré-requisitos',
                    hint: 'Ex: Nível 4, Força 13 ou superior',
                    maxLines: 2,
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
                  const SizedBox(height: 16),
                  // Campos específicos para PHB 2024
                  if (_selectedSource == 'PHB 2024') ...[
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Categoria *',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items:
                          _categoryOptions
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _selectedCategory = v),
                      validator:
                          (v) =>
                              (v == null || v.isEmpty)
                                  ? 'Categoria é obrigatória para PHB 2024'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Repetível'),
                      subtitle: const Text(
                        'Pode ser adquirido múltiplas vezes',
                      ),
                      value: _isRepeatable,
                      onChanged:
                          (value) => setState(() => _isRepeatable = value),
                      activeColor: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),

              const SizedBox(height: 16),

              // Benefícios do Talento (estilo Traços)
              _buildSectionCard(
                context,
                'Benefícios do Talento',
                Icons.extension,
                Colors.purple,
                [
                  Column(
                    children: [
                      ..._benefitEntries.asMap().entries.map((entry) {
                        final i = entry.key;
                        final b = entry.value;
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
                                          controller: b['name']!,
                                          label: 'Nome do Benefício',
                                          hint: 'Ex: Personificação',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        tooltip: 'Remover',
                                        onPressed:
                                            _benefitEntries.length > 1
                                                ? () => setState(() {
                                                  b['name']!.dispose();
                                                  b['description']!.dispose();
                                                  _benefitEntries.removeAt(i);
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
                                    controller: b['description']!,
                                    label: 'Descrição do Benefício',
                                    hint:
                                        'Detalhe o que o benefício concede...',
                                    maxLines: 3,
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
                                () => _benefitEntries.add({
                                  'name': TextEditingController(),
                                  'description': TextEditingController(),
                                }),
                              ),
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar Benefício'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Botão Salvar
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveFeat,
                icon:
                    _isLoading
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.save),
                label: Text(_isLoading ? 'Salvando...' : 'Salvar Talento'),
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
                      Text(
                        _selectedSource == 'PHB 2024'
                            ? '• Campos marcados com * são obrigatórios\n'
                                '• Para PHB 2024: Categoria é obrigatória\n'
                                '• Descreva claramente os benefícios do talento\n'
                                '• Inclua pré-requisitos quando aplicável\n'
                                '• Marque "Repetível" se o talento pode ser adquirido múltiplas vezes\n'
                                '• O talento ficará disponível para todos os usuários'
                            : '• Campos marcados com * são obrigatórios\n'
                                '• Descreva claramente os benefícios do talento\n'
                                '• Inclua pré-requisitos quando aplicável\n'
                                '• O talento ficará disponível para todos os usuários',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
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

  Future<void> _saveFeat() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final featData = {
        'name': _nameController.text.trim(),
        'description': '',
        'prerequisite': _prerequisiteController.text.trim(),
        'benefit': '',
        'source': _selectedSource,
        'category': _selectedSource == 'PHB 2024' ? _selectedCategory : null,
        'is_repeatable': _selectedSource == 'PHB 2024' ? _isRepeatable : false,
        'abilities':
            _benefitEntries
                .where(
                  (b) =>
                      b['name']!.text.trim().isNotEmpty ||
                      b['description']!.text.trim().isNotEmpty,
                )
                .map(
                  (b) => {
                    'name': b['name']!.text.trim(),
                    'description': b['description']!.text.trim(),
                  },
                )
                .toList(),
        'created_at': DateTime.now().toIso8601String(),
      };

      await SupabaseService.client.from('feats').insert(featData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Talento adicionado com sucesso!'),
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
            content: Text('Erro ao salvar talento: $e'),
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

  // métodos antigos de ability removidos
}

class _AbilityDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? initialAbility;

  // ignore: unused_element_parameter
  const _AbilityDialog({required this.onSave, this.initialAbility});

  @override
  State<_AbilityDialog> createState() => _AbilityDialogState();
}

class _AbilityDialogState extends State<_AbilityDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Simplificado: somente nome + descrição e campos extras dinâmicos
  final List<Map<String, String>> _extraFields = [];

  // Sem tipos pré-definidos por enquanto

  // Opções antigas removidas (não usadas na versão simplificada)

  @override
  void initState() {
    super.initState();
    if (widget.initialAbility != null) {
      _loadInitialData();
    }
  }

  void _loadInitialData() {
    final ability = widget.initialAbility!;
    _nameController.text = ability['name'] ?? '';
    _descriptionController.text = ability['description'] ?? '';
    _extraFields.clear();
    final extras = ability['extras'] as List<dynamic>?;
    if (extras != null) {
      for (final e in extras) {
        final m = Map<String, dynamic>.from(e);
        _extraFields.add({
          'label': (m['label'] ?? '').toString(),
          'value': (m['value'] ?? '').toString(),
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    // extras não possuem controllers fixos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Benefício do Talento'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dados básicos
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Benefício *',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Nome é obrigatório'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição *',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Descrição é obrigatória'
                            : null,
              ),
              const SizedBox(height: 16),

              // Campos extras livres (vários campos por habilidade)
              _buildAbilityExtras(),
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
              final abilityData = {
                'name': _nameController.text.trim(),
                'description': _descriptionController.text.trim(),
                'extras': _extraFields,
              };
              widget.onSave(abilityData);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  Widget _buildAbilityExtras() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Campos Extras (opcionais)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _extraFields.add({'label': '', 'value': ''});
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Campo'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_extraFields.isEmpty)
          const Text(
            'Nenhum campo extra adicionado',
            style: TextStyle(color: Colors.grey),
          )
        else
          ..._extraFields.asMap().entries.map((entry) {
            final index = entry.key;
            final field = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: field['label'],
                      decoration: const InputDecoration(
                        labelText: 'Nome do Campo',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => _extraFields[index]['label'] = v,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: field['value'],
                      decoration: const InputDecoration(
                        labelText: 'Valor/Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      onChanged: (v) => _extraFields[index]['value'] = v,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _extraFields.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}
