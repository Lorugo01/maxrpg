import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../characters/character_list_screen.dart';
import '../data/data_migration_screen.dart';
import '../admin/admin_panel_screen.dart';
import '../data/data_management_screen.dart';
import '../profile/user_profile_screen.dart';
import '../../widgets/dice_roller_widget.dart';

class MainTabScreen extends ConsumerStatefulWidget {
  const MainTabScreen({super.key});

  @override
  ConsumerState<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends ConsumerState<MainTabScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _isAdmin = false; // Inicializar como usuário simples
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _updateTabController(bool isAdmin) {
    if (_isAdmin != isAdmin) {
      _tabController?.dispose();
      _isAdmin = isAdmin;
      final int tabCount = isAdmin ? 3 : 2;
      _tabController = TabController(length: tabCount, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);

    // Atualizar TabController se necessário
    _updateTabController(isAdmin);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MaxRPG - D&D 5e',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          // Menu do usuário
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (value) async {
              switch (value) {
                case 'profile':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserProfileScreen(),
                    ),
                  );
                  break;
                case 'migration':
                  if (isAdmin) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DataMigrationScreen(),
                      ),
                    );
                  }
                  break;
                case 'data_management':
                  if (isAdmin) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DataManagementScreen(),
                      ),
                    );
                  }
                  break;
                case 'logout':
                  await _showLogoutDialog(context, ref);
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text('Perfil'),
                      ],
                    ),
                  ),
                  if (isAdmin)
                    const PopupMenuItem(
                      value: 'migration',
                      child: Row(
                        children: [
                          Icon(Icons.cloud_upload),
                          SizedBox(width: 8),
                          Text('Migração de Dados'),
                        ],
                      ),
                    ),
                  if (isAdmin)
                    const PopupMenuItem(
                      value: 'data_management',
                      child: Row(
                        children: [
                          Icon(Icons.storage),
                          SizedBox(width: 8),
                          Text('Gerenciar Dados'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ],
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController!,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            const Tab(icon: Icon(Icons.person), text: 'Personagens'),
            const Tab(icon: Icon(Icons.casino), text: 'Dados'),
            if (isAdmin)
              const Tab(icon: Icon(Icons.admin_panel_settings), text: 'Admin'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController!,
        children: [
          // Aba Personagens
          const CharacterListScreen(),
          // Aba Dados
          const DiceRoller(),
          // Aba Admin (só para administradores)
          if (isAdmin) const AdminPanelScreen(),
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text('Confirmar Logout'),
              ],
            ),
            content: const Text('Tem certeza que deseja sair?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sair'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await ref.read(authNotifierProvider.notifier).signOut();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao fazer logout: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'MaxRPG',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.casino, size: 48),
      children: [
        const Text(
          'Seu assistente completo para D&D 5e. Crie e gerencie personagens, role dados e acompanhe suas aventuras épicas!',
        ),
      ],
    );
  }
}
