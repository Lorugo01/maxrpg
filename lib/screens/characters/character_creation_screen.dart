import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/character.dart';
import '/providers/character_provider.dart';
import '../../services/supabase_service.dart';
import 'character_sheet_screen.dart';

class CharacterCreationScreen extends ConsumerStatefulWidget {
  final String version;

  const CharacterCreationScreen({super.key, required this.version});

  @override
  ConsumerState<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState
    extends ConsumerState<CharacterCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // Dados filtrados por versão
  List<Map<String, dynamic>> _classes = [];
  List<Map<String, dynamic>> _races = [];
  List<Map<String, dynamic>> _backgrounds = [];

  // Seleções
  Map<String, dynamic>? _selectedClass;
  Map<String, dynamic>? _selectedRace;
  Map<String, dynamic>? _selectedBackground;

  bool _isLoading = true;
  String _loadingMessage = 'Carregando dados...';

  @override
  void initState() {
    super.initState();
    _loadVersionData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadVersionData() async {
    setState(() {
      _isLoading = true;
      _loadingMessage = 'Carregando classes...';
    });

    try {
      // Carregar classes da versão selecionada
      final classesResponse = await SupabaseService.client
          .from('classes')
          .select()
          .eq('source', widget.version)
          .order('name', ascending: true);

      setState(() {
        _classes = List<Map<String, dynamic>>.from(classesResponse);
        _loadingMessage = 'Carregando raças...';
      });

      // Carregar raças da versão selecionada
      final racesResponse = await SupabaseService.client
          .from('races')
          .select()
          .eq('source', widget.version)
          .order('name', ascending: true);

      setState(() {
        _races = List<Map<String, dynamic>>.from(racesResponse);
        _loadingMessage = 'Carregando antecedentes...';
      });

      // Carregar antecedentes da versão selecionada
      final backgroundsResponse = await SupabaseService.client
          .from('backgrounds')
          .select()
          .eq('source', widget.version)
          .order('name', ascending: true);

      setState(() {
        _backgrounds = List<Map<String, dynamic>>.from(backgroundsResponse);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar dados: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _createCharacter() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClass == null ||
        _selectedRace == null ||
        _selectedBackground == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione classe, raça e antecedente'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Criar personagem básico
    final character = Character(
      name: _nameController.text.trim(),
      className: _selectedClass!['name'],
      race: _selectedRace!['name'],
      background: _selectedBackground!['name'],
      level: 1,
      abilityScores: {
        'Força': 10,
        'Destreza': 10,
        'Constituição': 10,
        'Inteligência': 10,
        'Sabedoria': 10,
        'Carisma': 10,
      },
    );

    // Salvar no provider
    ref.read(charactersProvider.notifier).addCharacter(character);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Personagem criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      // Navegar para a tela do personagem criado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CharacterSheetScreen(character: character),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Personagem - ${widget.version}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      _loadingMessage,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add,
                                size: 48,
                                color:
                                    widget.version == 'PHB 2024'
                                        ? Colors.green
                                        : Colors.blue,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Criar Personagem',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Versão: ${widget.version}',
                                style: TextStyle(
                                  color:
                                      widget.version == 'PHB 2024'
                                          ? Colors.green
                                          : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Nome do Personagem
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome do Personagem',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Digite o nome do personagem',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nome é obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Seleção de Classe
                      _buildSelectionCard(
                        'Classe',
                        Icons.person,
                        _selectedClass?['name'] ?? 'Selecione uma classe',
                        _classes,
                        (clazz) => setState(() => _selectedClass = clazz),
                        'Nenhuma classe disponível para ${widget.version}',
                      ),

                      const SizedBox(height: 16),

                      // Seleção de Raça
                      _buildSelectionCard(
                        'Raça',
                        Icons.pets,
                        _selectedRace?['name'] ?? 'Selecione uma raça',
                        _races,
                        (race) => setState(() => _selectedRace = race),
                        'Nenhuma raça disponível para ${widget.version}',
                      ),

                      const SizedBox(height: 16),

                      // Seleção de Antecedente
                      _buildSelectionCard(
                        'Antecedente',
                        Icons.history_edu,
                        _selectedBackground?['name'] ??
                            'Selecione um antecedente',
                        _backgrounds,
                        (background) =>
                            setState(() => _selectedBackground = background),
                        'Nenhum antecedente disponível para ${widget.version}',
                      ),

                      const SizedBox(height: 32),

                      // Botão Criar
                      ElevatedButton.icon(
                        onPressed: _createCharacter,
                        icon: const Icon(Icons.add),
                        label: const Text('Criar Personagem'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              widget.version == 'PHB 2024'
                                  ? Colors.green
                                  : Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildSelectionCard(
    String title,
    IconData icon,
    String selectedValue,
    List<Map<String, dynamic>> options,
    Function(Map<String, dynamic>) onSelect,
    String emptyMessage,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (options.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  emptyMessage,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              InkWell(
                onTap: () => _showSelectionDialog(title, options, onSelect),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedValue,
                          style: TextStyle(
                            color:
                                selectedValue.startsWith('Selecione')
                                    ? Colors.grey[600]
                                    : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showSelectionDialog(
    String title,
    List<Map<String, dynamic>> options,
    Function(Map<String, dynamic>) onSelect,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Selecionar $title'),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    title: Text(option['name'] ?? 'Sem nome'),
                    subtitle:
                        option['description'] != null
                            ? Text(
                              option['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            )
                            : null,
                    onTap: () {
                      onSelect(option);
                      Navigator.of(context).pop();
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
            ],
          ),
    );
  }
}
