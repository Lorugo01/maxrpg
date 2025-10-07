import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/supabase_service.dart';
import '../../models/user_type.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);

    try {
      final response = await SupabaseService.client
          .from('user_profiles')
          .select('''
            id,
            user_id,
            display_name,
            user_type,
            created_at,
            updated_at
          ''')
          .order('created_at', ascending: false);

      setState(() {
        _users = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar usuários: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateUserType(String userId, UserType newType) async {
    try {
      await SupabaseService.client
          .from('user_profiles')
          .update({'user_type': newType.value})
          .eq('user_id', userId);

      await _loadUsers(); // Recarregar lista

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Tipo de usuário atualizado para: ${newType.displayName}',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar tipo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Usuários'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadUsers),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
              ? const Center(child: Text('Nenhum usuário encontrado'))
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  final userType = UserType.fromString(
                    user['user_type'] ?? 'simple',
                  );
                  // Usar user_id como identificador (email não disponível via relacionamento)
                  final email = 'ID: ${user['user_id']}';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    userType.isAdmin ? Colors.red : Colors.blue,
                                child: Icon(
                                  userType.isAdmin
                                      ? Icons.admin_panel_settings
                                      : Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['display_name'] ??
                                          'Nome não informado',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      email,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      userType.isAdmin
                                          ? Colors.red.withAlpha(20)
                                          : Colors.blue.withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        userType.isAdmin
                                            ? Colors.red
                                            : Colors.blue,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  userType.displayName,
                                  style: TextStyle(
                                    color:
                                        userType.isAdmin
                                            ? Colors.red
                                            : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed:
                                      () => _updateUserType(
                                        user['user_id'],
                                        UserType.simple,
                                      ),
                                  icon: const Icon(Icons.person, size: 16),
                                  label: const Text('Simples'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        userType.isSimple
                                            ? Colors.blue
                                            : Colors.grey,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed:
                                      () => _updateUserType(
                                        user['user_id'],
                                        UserType.admin,
                                      ),
                                  icon: const Icon(
                                    Icons.admin_panel_settings,
                                    size: 16,
                                  ),
                                  label: const Text('Admin'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        userType.isAdmin
                                            ? Colors.red
                                            : Colors.grey,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Criado em: ${_formatDate(user['created_at'])}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Data não disponível';

    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year} às '
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Data inválida';
    }
  }
}
