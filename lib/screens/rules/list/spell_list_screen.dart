import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/auth_provider.dart';
import '/services/supabase_service.dart';
import '../edit/edit_spell_screen.dart';

class SpellListScreen extends ConsumerStatefulWidget {
  const SpellListScreen({super.key});

  @override
  ConsumerState<SpellListScreen> createState() => _SpellListScreenState();
}

class _SpellListScreenState extends ConsumerState<SpellListScreen> {
  List<Map<String, dynamic>> _spells = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSpells();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSpells() async {
    setState(() => _isLoading = true);
    try {
      final response = await SupabaseService.client
          .from('spells')
          .select()
          .order('name');

      setState(() {
        _spells = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar magias: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  List<Map<String, dynamic>> get _filteredSpells {
    if (_searchQuery.isEmpty) return _spells;

    return _spells.where((spell) {
      final name = spell['name']?.toString().toLowerCase() ?? '';
      final description = spell['description']?.toString().toLowerCase() ?? '';
      final source = spell['source']?.toString().toLowerCase() ?? '';
      final school = spell['school']?.toString().toLowerCase() ?? '';

      return name.contains(_searchQuery.toLowerCase()) ||
          description.contains(_searchQuery.toLowerCase()) ||
          source.contains(_searchQuery.toLowerCase()) ||
          school.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  Future<void> _deleteSpell(Map<String, dynamic> spell) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text(
              'Tem certeza que deseja excluir a magia "${spell['name']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await SupabaseService.client
            .from('spells')
            .delete()
            .eq('id', spell['id']);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Magia excluída com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          await _loadSpells();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao excluir magia: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  String _getSchoolIcon(String? school) {
    switch (school?.toLowerCase()) {
      case 'abjuração':
        return '🛡️';
      case 'adivinhação':
        return '🔮';
      case 'conjuração':
        return '✨';
      case 'encantamento':
        return '💫';
      case 'evocação':
        return '⚡';
      case 'ilusão':
        return '👻';
      case 'necromancia':
        return '💀';
      case 'transmutação':
        return '🔄';
      default:
        return '🔮';
    }
  }

  Color _getSchoolColor(String? school) {
    switch (school?.toLowerCase()) {
      case 'abjuração':
        return Colors.blue;
      case 'adivinhação':
        return Colors.purple;
      case 'conjuração':
        return Colors.orange;
      case 'encantamento':
        return Colors.pink;
      case 'evocação':
        return Colors.red;
      case 'ilusão':
        return Colors.indigo;
      case 'necromancia':
        return Colors.grey[800]!;
      case 'transmutação':
        return Colors.green;
      default:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);

    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Magias'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text(
            'Acesso negado. Apenas administradores podem ver esta tela.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Magias'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _loadSpells, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar magias...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchQuery.isNotEmpty
                        ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          icon: const Icon(Icons.clear),
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Lista de magias
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredSpells.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'Nenhuma magia encontrada'
                                : 'Nenhuma magia corresponde à pesquisa',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredSpells.length,
                      itemBuilder: (context, index) {
                        final spell = _filteredSpells[index];
                        return _buildSpellCard(spell);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpellCard(Map<String, dynamic> spell) {
    final school = spell['school']?.toString() ?? 'Desconhecida';
    final schoolColor = _getSchoolColor(school);
    final schoolIcon = _getSchoolIcon(school);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: schoolColor.withAlpha(32),
          child: Text(schoolIcon, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(
          spell['name'] ?? 'Sem nome',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (spell['description'] != null &&
                spell['description'].toString().isNotEmpty)
              Text(
                spell['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            const SizedBox(height: 4),
            if (spell['source'] != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigo.withAlpha(32),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  spell['source'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.indigo,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                final changed = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => EditSpellScreen(spell: spell),
                  ),
                );
                if (changed == true) await _loadSpells();
                break;
              case 'delete':
                await _deleteSpell(spell);
                break;
            }
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Editar'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Excluir'),
                    ],
                  ),
                ),
              ],
        ),
        onTap: () async {
          final changed = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (_) => EditSpellScreen(spell: spell)),
          );
          if (changed == true) await _loadSpells();
        },
      ),
    );
  }
}
