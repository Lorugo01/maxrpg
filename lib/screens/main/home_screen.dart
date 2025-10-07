import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/dice_roller_widget.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_type.dart';
import '../characters/character_list_screen.dart';
import '../characters/character_version_selection_screen.dart';
import '../data/data_migration_screen.dart';
import '../admin/admin_panel_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.watch(displayNameProvider);
    final userEmail = ref.watch(userEmailProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final userTypeAsync = ref.watch(userTypeProvider);

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
                  userTypeAsync.when(
                    data:
                        (userType) => _showProfileDialog(
                          context,
                          displayName,
                          userEmail,
                          userType,
                        ),
                    loading:
                        () => _showProfileDialog(
                          context,
                          displayName,
                          userEmail,
                          UserType.simple,
                        ),
                    error:
                        (_, __) => _showProfileDialog(
                          context,
                          displayName,
                          userEmail,
                          UserType.simple,
                        ),
                  );
                  break;
                case 'migration':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DataMigrationScreen(),
                    ),
                  );
                  break;
                case 'admin':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminPanelScreen(),
                    ),
                  );
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
                      value: 'admin',
                      child: Row(
                        children: [
                          Icon(Icons.admin_panel_settings),
                          SizedBox(width: 8),
                          Text('Painel Admin'),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com estatísticas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withAlpha(20),
                    Theme.of(context).primaryColor.withAlpha(5),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo, $displayName!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Seu assistente completo para D&D 5e',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // Ações rápidas
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ações Rápidas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      _buildActionCard(
                        context,
                        'Meus Personagens',
                        'Gerenciar fichas',
                        Icons.people,
                        Colors.blue,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CharacterListScreen(),
                          ),
                        ),
                      ),
                      _buildActionCard(
                        context,
                        'Criar Personagem',
                        'Nova ficha',
                        Icons.add_circle,
                        Colors.purple,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const CharacterVersionSelectionScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rolador de Dados
            const DiceRoller(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withAlpha(20), color.withAlpha(5)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: onTap != null ? color : Colors.grey),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: onTap != null ? color : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileDialog(
    BuildContext context,
    String displayName,
    String userEmail,
    UserType userType,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('Perfil'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: $displayName'),
                const SizedBox(height: 8),
                Text('Email: $userEmail'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Tipo: '),
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
                          color: userType.isAdmin ? Colors.red : Colors.blue,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        userType.displayName,
                        style: TextStyle(
                          color: userType.isAdmin ? Colors.red : Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Seus personagens são salvos de forma segura na nuvem e sincronizados entre dispositivos.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
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

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Logout'),
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
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout realizado com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao fazer logout: ${e.toString()}'),
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
          'Um assistente completo para D&D 5e, desenvolvido com Flutter.\n\n'
          'Funcionalidades:\n'
          '• Rolador de dados avançado\n'
          '• Gerenciamento de fichas de personagem\n'
          '• Cálculos automáticos de atributos\n'
          '• Inventário e equipamentos\n'
          '• Perícias e proficiências\n\n'
          'Desenvolvido seguindo as regras do SRD (System Reference Document).',
        ),
      ],
    );
  }
}
