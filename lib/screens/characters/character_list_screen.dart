import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/character_provider.dart';
import '/models/character.dart';
import '/models/skill.dart';
import '/models/item.dart';
import 'character_sheet_screen.dart';
import 'character_version_selection_screen.dart';

class CharacterListScreen extends ConsumerWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(charactersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Personagens',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const CharacterVersionSelectionScreen(),
                  ),
                ),
          ),
        ],
      ),
      body:
          characters.isEmpty
              ? _buildEmptyState(context, ref)
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: _getClassColor(character.className),
                          child: Text(
                            character.name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          character.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${character.race} ${character.className} - Nível ${character.level}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: Colors.red.shade400,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${character.currentHitPoints}/${character.maxHitPoints} PV',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.shield,
                                  size: 16,
                                  color: Colors.blue.shade400,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'CA ${character.getCalculatedArmorClass()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case 'duplicate':
                                _duplicateCharacter(context, ref, character);
                                break;
                              case 'delete':
                                _showDeleteDialog(context, ref, character);
                                break;
                            }
                          },
                          itemBuilder:
                              (context) => [
                                const PopupMenuItem(
                                  value: 'duplicate',
                                  child: Row(
                                    children: [
                                      Icon(Icons.copy, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text('Duplicar'),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CharacterSheetScreen(
                                    character: character,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 24),
            Text(
              'Nenhum personagem criado',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Crie seu primeiro personagem para começar sua aventura!',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const CharacterVersionSelectionScreen(),
                    ),
                  ),
              icon: const Icon(Icons.add),
              label: const Text('Criar Personagem'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getClassColor(String className) {
    switch (className.toLowerCase()) {
      case 'bárbaro':
        return Colors.red.shade600;
      case 'bardo':
        return Colors.purple.shade600;
      case 'bruxo':
        return Colors.deepPurple.shade600;
      case 'clérigo':
        return Colors.yellow.shade700;
      case 'druida':
        return Colors.green.shade600;
      case 'feiticeiro':
        return Colors.pink.shade600;
      case 'guerreiro':
        return Colors.brown.shade600;
      case 'ladino':
        return Colors.grey.shade700;
      case 'mago':
        return Colors.blue.shade600;
      case 'monge':
        return Colors.orange.shade600;
      case 'paladino':
        return Colors.amber.shade700;
      case 'patrulheiro':
        return Colors.teal.shade600;
      default:
        return Colors.indigo.shade600;
    }
  }

  void _duplicateCharacter(
    BuildContext context,
    WidgetRef ref,
    Character original,
  ) async {
    try {
      final duplicate = Character(
        name: '${original.name} (Cópia)',
        race: original.race,
        className: original.className,
        level: original.level,
        background: original.background,
        alignment: original.alignment,
        abilityScores: Map<String, int>.from(original.abilityScores),
        maxHitPoints: original.maxHitPoints,
        currentHitPoints: original.currentHitPoints,
        armorClass: original.armorClass,
        speed: original.speed,
        experiencePoints: original.experiencePoints,
        languages: List<String>.from(original.languages),
        proficiencies: List<String>.from(original.proficiencies),
        skills:
            original.skills
                .map(
                  (skill) => Skill(
                    name: skill.name,
                    baseAbility: skill.baseAbility,
                    isProficient: skill.isProficient,
                    hasExpertise: skill.hasExpertise,
                  ),
                )
                .toList(),
        inventory:
            original.inventory
                .map(
                  (item) => Item(
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    quantity: item.quantity,
                    weight: item.weight,
                    value: item.value,
                    type: item.type,
                    isEquipped: item.isEquipped,
                  ),
                )
                .toList(),
      );

      await ref.read(charactersProvider.notifier).addCharacter(duplicate);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Personagem duplicado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao duplicar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    Character character,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Excluir Personagem'),
            content: Text(
              'Tem certeza que deseja excluir "${character.name}"?\n\n'
              'Esta ação não pode ser desfeita.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);

                  try {
                    await ref
                        .read(charactersProvider.notifier)
                        .removeCharacter(character.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Personagem excluído com sucesso!'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao excluir: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }
}
