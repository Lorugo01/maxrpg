import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../rules/add/add_class_screen.dart';
import '../rules/add/add_race_screen.dart';
import '../rules/add/add_background_screen.dart';
import '../rules/add/add_spell_screen.dart';
import '../rules/add/add_equipment_screen.dart';
import '../rules/add/add_feat_screen.dart';
import '../rules/list/equipment_list_screen.dart';
import '../rules/list/race_list_screen.dart';
import '../rules/list/class_list_screen.dart';
import '../rules/list/background_list_screen.dart';
import '../rules/list/spell_list_screen.dart';
import '../rules/list/feat_list_screen.dart';

class DataManagementScreen extends ConsumerWidget {
  const DataManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);

    // Verificar se o usuário é administrador
    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acesso Negado'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.block, size: 80, color: Colors.red),
                SizedBox(height: 24),
                Text(
                  'Acesso Restrito',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Apenas administradores podem gerenciar dados.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Dados'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 300) {
                          // Layout vertical para telas pequenas
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.storage, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Gerenciar Dados de Referência',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Adicione e gerencie dados de referência do D&D 5e no Supabase.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Layout horizontal para telas maiores
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.storage, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Gerenciar Dados de Referência',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Adicione e gerencie dados de referência do D&D 5e no Supabase.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Seção de Classes
            _buildSectionCard(
              context,
              'Classes',
              'Gerencie classes de personagem',
              Icons.person,
              Colors.purple,
              [
                _buildActionButton(
                  context,
                  'Adicionar Classe',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddClassScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Classes',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ClassListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seção de Raças
            _buildSectionCard(
              context,
              'Raças',
              'Gerencie raças de personagem',
              Icons.pets,
              Colors.green,
              [
                _buildActionButton(
                  context,
                  'Adicionar Raça',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddRaceScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Raças',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RaceListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seção de Antecedentes
            _buildSectionCard(
              context,
              'Antecedentes',
              'Gerencie antecedentes de personagem',
              Icons.history_edu,
              Colors.orange,
              [
                _buildActionButton(
                  context,
                  'Adicionar Antecedente',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddBackgroundScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Antecedentes',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BackgroundListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seção de Magias
            _buildSectionCard(
              context,
              'Magias',
              'Gerencie magias do D&D 5e',
              Icons.auto_awesome,
              Colors.indigo,
              [
                _buildActionButton(
                  context,
                  'Adicionar Magia',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddSpellScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Magias',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SpellListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seção de Equipamentos
            _buildSectionCard(
              context,
              'Equipamentos',
              'Gerencie equipamentos e itens',
              Icons.shield,
              Colors.brown,
              [
                _buildActionButton(
                  context,
                  'Adicionar Equipamento',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddEquipmentScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Equipamentos',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EquipmentListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seção de Talentos
            _buildSectionCard(
              context,
              'Talentos',
              'Gerencie talentos e habilidades especiais',
              Icons.star,
              Colors.orange,
              [
                _buildActionButton(
                  context,
                  'Adicionar Talento',
                  Icons.add,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddFeatScreen(),
                    ),
                  ),
                ),
                _buildActionButton(
                  context,
                  'Ver Talentos',
                  Icons.list,
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FeatListScreen(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Informações
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 300) {
                          // Layout vertical para telas pequenas
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Informações',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '• Dados salvos no Supabase\n'
                                '• Apenas admins podem editar\n'
                                '• Dados compartilhados\n'
                                '• Faça backup regular',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        } else {
                          // Layout horizontal para telas maiores
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Informações',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '• Todos os dados são salvos no Supabase\n'
                                '• Apenas administradores podem adicionar/editar dados\n'
                                '• Os dados são compartilhados entre todos os usuários\n'
                                '• Faça backup regular dos dados importantes',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<Widget> actions,
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
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Layout responsivo para os botões
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 300) {
                  // Layout vertical para telas muito pequenas
                  return Column(
                    children:
                        actions
                            .map(
                              (action) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: action,
                                ),
                              ),
                            )
                            .toList(),
                  );
                } else {
                  // Layout horizontal para telas maiores
                  return Row(
                    children:
                        actions
                            .map((action) => Expanded(child: action))
                            .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          minimumSize: const Size(0, 36),
        ),
      ),
    );
  }
}
