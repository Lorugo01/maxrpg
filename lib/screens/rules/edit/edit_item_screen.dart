import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '/widgets/rich_text_helpers.dart';

class EditItemScreen extends ConsumerStatefulWidget {
  const EditItemScreen({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  ConsumerState<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends ConsumerState<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _quantity;
  late final TextEditingController _weight;
  late final TextEditingController _value;
  late final TextEditingController _type;
  bool _equipped = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final i = widget.item;
    _name = TextEditingController(text: i['name'] ?? '');
    _description = TextEditingController(text: i['description'] ?? '');
    _quantity = TextEditingController(text: (i['quantity']?.toString() ?? '1'));
    _weight = TextEditingController(text: (i['weight']?.toString() ?? '0'));
    _value = TextEditingController(text: (i['value']?.toString() ?? '0'));
    _type = TextEditingController(text: i['type'] ?? '');
    _equipped = (i['equipped'] == true);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _quantity.dispose();
    _weight.dispose();
    _value.dispose();
    _type.dispose();
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
          child: Text('Apenas administradores podem editar itens.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Item'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(
                _name,
                'Nome *',
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              FormattedTextEditor(
                controller: _description,
                label: 'Descrição',
                hint: 'Descrição do item...',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      _quantity,
                      'Qtd *',
                      keyboardType: TextInputType.number,
                      validator:
                          (v) =>
                              (int.tryParse(v ?? '') == null) ? 'Número' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      _weight,
                      'Peso',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      _value,
                      'Valor',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _field(
                _type,
                'Tipo *',
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _equipped,
                onChanged: (v) => setState(() => _equipped = v),
                title: const Text('Equipado'),
                contentPadding: EdgeInsets.zero,
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
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
      final id = widget.item['id'];
      final update = {
        'name': _name.text.trim(),
        'description': _description.text.trim(),
        'quantity': int.tryParse(_quantity.text.trim()) ?? 1,
        'weight': double.tryParse(_weight.text.trim()) ?? 0,
        'value': double.tryParse(_value.text.trim()) ?? 0,
        'type': _type.text.trim(),
        'equipped': _equipped,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await SupabaseService.client.from('items').update(update).eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item atualizado!'),
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
