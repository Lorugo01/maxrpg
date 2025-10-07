import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/data_migration_service.dart';

class DataMigrationScreen extends ConsumerStatefulWidget {
  const DataMigrationScreen({super.key});

  @override
  ConsumerState<DataMigrationScreen> createState() =>
      _DataMigrationScreenState();
}

class _DataMigrationScreenState extends ConsumerState<DataMigrationScreen> {
  bool _isMigrating = false;
  String _currentMigration = '';
  final List<String> _completedMigrations = [];
  final List<String> _failedMigrations = [];

  Future<void> _migrateAllData() async {
    setState(() {
      _isMigrating = true;
      _completedMigrations.clear();
      _failedMigrations.clear();
    });

    try {
      // Migrar Classes
      setState(() => _currentMigration = 'Migrando Classes...');
      await DataMigrationService.migrateClasses();
      _completedMigrations.add('Classes');

      // Migrar Raças
      setState(() => _currentMigration = 'Migrando Raças...');
      await DataMigrationService.migrateRaces();
      _completedMigrations.add('Raças');

      // Migrar Antecedentes
      setState(() => _currentMigration = 'Migrando Antecedentes...');
      await DataMigrationService.migrateBackgrounds();
      _completedMigrations.add('Antecedentes');

      // Migrar Talentos
      setState(() => _currentMigration = 'Migrando Talentos...');
      await DataMigrationService.migrateFeats();
      _completedMigrations.add('Talentos');

      // Migrar Equipamentos
      setState(() => _currentMigration = 'Migrando Equipamentos...');
      await DataMigrationService.migrateEquipment();
      _completedMigrations.add('Equipamentos');

      // Migrar Magias
      setState(() => _currentMigration = 'Migrando Magias...');
      await DataMigrationService.migrateSpells();
      _completedMigrations.add('Magias');

      setState(() => _currentMigration = 'Migração Concluída!');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Migração concluída com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _failedMigrations.add('Erro geral: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro na migração: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isMigrating = false;
        _currentMigration = '';
      });
    }
  }

  Future<void> _migrateIndividual(String type) async {
    setState(() => _isMigrating = true);

    try {
      switch (type) {
        case 'Classes':
          setState(() => _currentMigration = 'Migrando Classes...');
          await DataMigrationService.migrateClasses();
          break;
        case 'Raças':
          setState(() => _currentMigration = 'Migrando Raças...');
          await DataMigrationService.migrateRaces();
          break;
        case 'Antecedentes':
          setState(() => _currentMigration = 'Migrando Antecedentes...');
          await DataMigrationService.migrateBackgrounds();
          break;
        case 'Talentos':
          setState(() => _currentMigration = 'Migrando Talentos...');
          await DataMigrationService.migrateFeats();
          break;
        case 'Equipamentos':
          setState(() => _currentMigration = 'Migrando Equipamentos...');
          await DataMigrationService.migrateEquipment();
          break;
        case 'Magias':
          setState(() => _currentMigration = 'Migrando Magias...');
          await DataMigrationService.migrateSpells();
          break;
      }

      _completedMigrations.add(type);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$type migrados com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      _failedMigrations.add('$type: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao migrar $type: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isMigrating = false;
        _currentMigration = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Migração de Dados'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Text(
              'Migração para Supabase',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Migre os dados de referência dos arquivos JSON para o Supabase',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Status da migração
            if (_isMigrating) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        _currentMigration,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Botão para migrar tudo
            ElevatedButton.icon(
              onPressed: _isMigrating ? null : _migrateAllData,
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Migrar Todos os Dados'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // Migração individual
            Text(
              'Migração Individual',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Grid de botões para migração individual
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children:
                    [
                      'Classes',
                      'Raças',
                      'Antecedentes',
                      'Talentos',
                      'Equipamentos',
                      'Magias',
                    ].map((type) {
                      final isCompleted = _completedMigrations.contains(type);
                      final isFailed = _failedMigrations.any(
                        (f) => f.startsWith(type),
                      );

                      return Card(
                        child: InkWell(
                          onTap:
                              _isMigrating
                                  ? null
                                  : () => _migrateIndividual(type),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _getIconForType(type),
                                  size: 32,
                                  color:
                                      isCompleted
                                          ? Colors.green
                                          : isFailed
                                          ? Colors.red
                                          : Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  type,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                if (isCompleted)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  )
                                else if (isFailed)
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            // Status das migrações
            if (_completedMigrations.isNotEmpty ||
                _failedMigrations.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status das Migrações',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (_completedMigrations.isNotEmpty) ...[
                        Text(
                          '✅ Concluídas: ${_completedMigrations.join(', ')}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                      if (_failedMigrations.isNotEmpty) ...[
                        Text(
                          '❌ Falharam: ${_failedMigrations.join(', ')}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Classes':
        return Icons.class_;
      case 'Raças':
        return Icons.pets;
      case 'Antecedentes':
        return Icons.history_edu;
      case 'Talentos':
        return Icons.star;
      case 'Equipamentos':
        return Icons.shield;
      case 'Magias':
        return Icons.auto_awesome;
      default:
        return Icons.data_object;
    }
  }
}
