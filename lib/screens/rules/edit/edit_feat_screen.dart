import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '/widgets/rich_text_helpers.dart';

class EditFeatScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> feat;

  const EditFeatScreen({super.key, required this.feat});

  @override
  ConsumerState<EditFeatScreen> createState() => _EditFeatScreenState();
}

class _EditFeatScreenState extends ConsumerState<EditFeatScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _prerequisiteController;
  // sem descrição geral; benefícios são itens abaixo

  String? _selectedSource;
  String? _selectedCategory;
  bool _isRepeatable = false;

  // Lista de benefícios com controllers (nome + descrição)
  final List<Map<String, TextEditingController>> _benefitEntries = [];

  final List<String> _sourceOptions = [
    'PHB 2014',
    'PHB 2024',
    'SRD',
    'Homebrew',
    'Outros',
  ];

  final List<String> _categoryOptions = [
    'Origem',
    'Combatente',
    'Especialista',
    'Mágico',
    'Social',
    'Explorador',
    'Geral',
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.feat['name'] ?? '');
    _prerequisiteController = TextEditingController(
      text: widget.feat['prerequisite'] ?? '',
    );
    // Removido: descrição geral não é mais usada
    _selectedSource = widget.feat['source'] ?? _sourceOptions.first;
    _selectedCategory = widget.feat['category'] ?? _categoryOptions.first;
    _isRepeatable = widget.feat['is_repeatable'] ?? false;

    // Carregar benefícios existentes
    final rawAbilities = widget.feat['abilities'] as List<dynamic>?;
    if (rawAbilities != null) {
      for (final a in rawAbilities) {
        final m = Map<String, dynamic>.from(a as Map);
        _benefitEntries.add({
          'name': TextEditingController(text: (m['name'] ?? '').toString()),
          'description': TextEditingController(
            text: (m['description'] ?? '').toString(),
          ),
        });
      }
    }
    if (_benefitEntries.isEmpty) {
      _benefitEntries.add({
        'name': TextEditingController(),
        'description': TextEditingController(),
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prerequisiteController.dispose();
    for (final b in _benefitEntries) {
      b['name']!.dispose();
      b['description']!.dispose();
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
          child: Text('Apenas administradores podem editar talentos.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Talento'),
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
                  // Descrição geral removida
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

              // Benefícios do Talento (edição inline como em add_race_screen)
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
                                  FormattedTextEditor(
                                    controller: b['description']!,
                                    label: 'Descrição do Benefício',
                                    hint:
                                        'Detalhe o que o benefício concede...',
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
                      Text(
                        _selectedSource == 'PHB 2024'
                            ? '• Campos marcados com * são obrigatórios\n'
                                '• Para PHB 2024: Categoria é obrigatória\n'
                                '• Descreva claramente os benefícios do talento\n'
                                '• Inclua pré-requisitos quando aplicável\n'
                                '• Marque "Repetível" se o talento pode ser adquirido múltiplas vezes\n'
                                '• As alterações afetarão todos os usuários'
                            : '• Campos marcados com * são obrigatórios\n'
                                '• Descreva claramente os benefícios do talento\n'
                                '• Inclua pré-requisitos quando aplicável\n'
                                '• As alterações afetarão todos os usuários',
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
        'updated_at': DateTime.now().toIso8601String(),
      };

      await SupabaseService.client
          .from('feats')
          .update(featData)
          .eq('id', widget.feat['id']);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Talento atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar talento: $e'),
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

  // métodos antigos de editar benefícios removidos
}
