import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/character.dart';
import '/models/dnd_class.dart';
import '/models/level_up.dart';
import '/providers/character_provider.dart';
import '/services/character_service_supabase.dart';
import '/services/class_service.dart';
import '/services/feat_service.dart';

class LevelUpScreen extends ConsumerStatefulWidget {
  final Character character;

  const LevelUpScreen({super.key, required this.character});

  @override
  ConsumerState<LevelUpScreen> createState() => _LevelUpScreenState();
}

class _LevelUpScreenState extends ConsumerState<LevelUpScreen> {
  LevelUp? levelUp;
  DndClass? dndClass;
  int hitPointsRoll = 0;
  bool useAverage = true;
  bool useManual = false;
  final TextEditingController _hitPointsController = TextEditingController();
  Map<String, int> abilityScoreChanges = {};
  List<String> selectedFeatures = [];
  Set<String> expandedFeatures = {};
  bool chooseFeat = false;
  String? selectedFeat;
  List<Map<String, dynamic>> availableFeats = [];
  bool isLoading = true;

  // Variáveis para seleção de perícias de Especialização
  List<String> selectedProficiencySkills = [];
  int proficiencySkillCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeLevelUp();
  }

  @override
  void dispose() {
    _hitPointsController.dispose();
    super.dispose();
  }

  Future<void> _initializeLevelUp() async {
    try {
      dndClass =
          await ClassService.getByName(widget.character.className) ??
          (throw Exception(
            'Classe ${widget.character.className} não encontrada',
          ));
      levelUp = LevelUp.fromClass(dndClass!, widget.character.level);

      // Carregar talentos do JSON
      await _loadFeatsFromJson();

      // Inicializar mudanças de atributos
      for (final ability in widget.character.abilityScores.keys) {
        abilityScoreChanges[ability] = 0;
      }

      // Verificar se há habilidade de Especialização no novo nível
      _checkProficiencyDoubling();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
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

  Future<void> _loadFeatsFromJson() async {
    try {
      // Carregar talentos do banco de dados Supabase
      final feats = await FeatService.loadAll();

      availableFeats =
          feats.map((feat) {
            return {
              'name': feat.name,
              'description': feat.prerequisite ?? 'Sem pré-requisitos',
              'details': feat.description,
              'source': feat.source ?? 'PHB 2024',
            };
          }).toList();

      debugPrint('Talentos carregados para level up: ${availableFeats.length}');
    } catch (e) {
      debugPrint('Erro ao carregar talentos: $e');
      // Fallback para lista básica se houver erro
      availableFeats = _getBasicFeats();
    }
  }

  void _showFeatDetailsDialog(Map<String, dynamic> feat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.star, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feat['name']!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fonte
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      feat['source'] ?? 'PHB 2024',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Pré-requisitos
                  if (feat['description'] != null &&
                      feat['description'] != 'Sem pré-requisitos') ...[
                    Text(
                      'Pré-requisitos:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feat['description'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Efeitos/Detalhes
                  Text(
                    'Efeitos:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    feat['details'] ?? 'Detalhes não disponíveis',
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getBasicFeats() {
    // Lista básica de fallback
    return [
      {
        'name': 'Aumento no Valor de Atributo',
        'description': 'Aumente um atributo em +2 ou dois atributos em +1 cada',
        'details':
            'Você pode aumentar um atributo em +2 ou dois atributos em +1 cada. Não pode aumentar um atributo acima de 20.',
      },
      {
        'name': 'Atleta',
        'description': 'Você tem treinamento extensivo em movimentação',
        'details':
            'Você tem proficiência em Atletismo e Acrobacia. Pode escalar sem reduzir velocidade.',
      },
      {
        'name': 'Especialista em Perícia',
        'description': 'Você é proficiente em perícias específicas',
        'details':
            'Escolha duas perícias nas quais você não seja proficiente. Você ganha proficiência nelas.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Verificar se levelUp foi inicializado
    if (levelUp == null || dndClass == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Level Up - ${widget.character.name}'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _canCompleteLevelUp() ? _completeLevelUp : null,
            child: const Text(
              'Confirmar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header com informações do level up
            _buildLevelUpHeader(),
            const SizedBox(height: 24),

            // Pontos de Vida
            _buildHitPointsSection(),
            const SizedBox(height: 24),

            // Melhorias de Atributo
            if (levelUp!.abilityScoreImprovements.isNotEmpty)
              _buildAbilityScoreSection(),
            if (levelUp!.abilityScoreImprovements.isNotEmpty)
              const SizedBox(height: 24),

            // Novas Características (inclui seleção de subclasse no nível 3)
            if (levelUp!.newFeatures.isNotEmpty ||
                levelUp!.availableSubclasses.isNotEmpty)
              _buildFeaturesSection(),
            if (levelUp!.newFeatures.isNotEmpty ||
                levelUp!.availableSubclasses.isNotEmpty)
              const SizedBox(height: 24),

            // Progressão de Magias
            if (levelUp!.spellProgression.isNotEmpty)
              _buildSpellProgressionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelUpHeader() {
    return Card(
      elevation: 4,
      child: Container(
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Nível ${levelUp!.newLevel}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.character.className} - ${widget.character.race}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatChip(
                  'Bônus de Proficiência',
                  '+${levelUp!.proficiencyBonus}',
                  Colors.blue,
                ),
                const SizedBox(width: 8),
                _buildStatChip(
                  'PV Ganhos',
                  _getTotalHitPointsGained(),
                  Colors.green,
                ),
                if (_getRacialHitPointIncrease() > 0) ...[
                  const SizedBox(width: 8),
                  _buildStatChip(
                    'PV Racial',
                    '+${_getRacialHitPointIncrease()}',
                    Colors.red,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHitPointsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Pontos de Vida',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Dado de Vida: d${dndClass!.hitDie}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_getRacialHitPointIncrease() > 0) ...[
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withAlpha(50)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '+${_getRacialHitPointIncrease()} PV racial',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Usar Média'),
                    subtitle: Text(
                      '${levelUp!.hitPointsGained + _getRacialHitPointIncrease()} PV',
                    ),
                    value: true,
                    groupValue: useAverage && !useManual,
                    onChanged: (value) {
                      setState(() {
                        useAverage = value!;
                        useManual = false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Rolar Dado'),
                    subtitle: Text(
                      hitPointsRoll > 0
                          ? '${hitPointsRoll + _getRacialHitPointIncrease()} PV'
                          : 'Toque para rolar',
                    ),
                    value: false,
                    groupValue: useAverage && !useManual,
                    onChanged: (value) {
                      setState(() {
                        useAverage = value!;
                        useManual = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            RadioListTile<bool>(
              title: const Text('Inserir Manualmente'),
              subtitle: const Text('Digite o valor desejado'),
              value: true,
              groupValue: useManual,
              onChanged: (value) {
                setState(() {
                  useManual = value!;
                  useAverage = false;
                });
              },
            ),
            if (useManual) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _hitPointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Pontos de Vida',
                  hintText: 'Digite os PV ganhos',
                  border: const OutlineInputBorder(),
                  suffixText: 'PV',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ],
            if (!useAverage && !useManual) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _rollHitPoints,
                  icon: const Icon(Icons.casino),
                  label: Text('Rolar d${dndClass!.hitDie}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAbilityScoreSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.fitness_center, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Melhoria de Atributo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Escolha uma opção:',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),

            // Opção 1: Melhoria de Atributo
            RadioListTile<bool>(
              title: const Text('Melhoria de Atributo'),
              subtitle: const Text(
                'Aumentar um atributo em +2 ou dois atributos em +1 cada',
              ),
              value: false,
              groupValue: chooseFeat,
              onChanged: (value) {
                setState(() {
                  chooseFeat = value!;
                  selectedFeat = null;
                });
              },
            ),

            // Opção 2: Escolher Talento
            RadioListTile<bool>(
              title: const Text('Escolher Talento'),
              subtitle: const Text('Selecionar um talento especial'),
              value: true,
              groupValue: chooseFeat,
              onChanged: (value) {
                setState(() {
                  chooseFeat = value!;
                  // Limpar mudanças de atributo
                  abilityScoreChanges = Map.fromEntries(
                    widget.character.abilityScores.keys.map(
                      (key) => MapEntry(key, 0),
                    ),
                  );
                });
              },
            ),

            const SizedBox(height: 16),

            if (!chooseFeat) ...[
              Text(
                'Você pode aumentar um atributo em +2 ou dois atributos em +1 cada.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ...widget.character.abilityScores.keys.map((ability) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          ability,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${widget.character.abilityScores[ability]}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed:
                                  abilityScoreChanges[ability]! > 0
                                      ? () => _changeAbilityScore(ability, -1)
                                      : null,
                              icon: const Icon(Icons.remove),
                              iconSize: 20,
                            ),
                            Container(
                              width: 40,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    abilityScoreChanges[ability]! > 0
                                        ? Colors.green.withAlpha(20)
                                        : Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                abilityScoreChanges[ability]! > 0
                                    ? '+${abilityScoreChanges[ability]}'
                                    : '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      abilityScoreChanges[ability]! > 0
                                          ? Colors.green
                                          : Colors.grey,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  abilityScoreChanges[ability]! < 2
                                      ? () => _changeAbilityScore(ability, 1)
                                      : null,
                              icon: const Icon(Icons.add),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ] else ...[
              Text(
                'Escolha um talento:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              _buildFeatSelection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatSelection() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: availableFeats.length,
        itemBuilder: (context, index) {
          final feat = availableFeats[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: RadioListTile<String>(
              title: Text(
                feat['name']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                feat['description']!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              value: feat['name']!,
              groupValue: selectedFeat,
              onChanged: (value) {
                setState(() {
                  selectedFeat = value;
                });
              },
              secondary: IconButton(
                icon: Icon(Icons.info_outline, color: Colors.orange),
                onPressed: () {
                  _showFeatDetailsDialog(feat);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Novas Características',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Se for nível 3, mostrar seleção de subclasse
            if (levelUp!.newLevel == 3 &&
                levelUp!.availableSubclasses.isNotEmpty) ...[
              Text(
                'Escolha uma subclasse para seu personagem:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              ...levelUp!.availableSubclasses.map((subclass) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          subclass,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Subclasse de classe'),
                        value: subclass,
                        groupValue: levelUp!.selectedSubclass,
                        onChanged: (value) {
                          setState(() {
                            levelUp!.selectedSubclass = value;
                          });
                        },
                        secondary: IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.indigo),
                          onPressed: () {
                            _showSubclassDetailsDialog(subclass);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ] else ...[
              // Para outros níveis, mostrar características como tabs informativos expansíveis
              ...levelUp!.newFeatures.map((feature) {
                final isExpanded = expandedFeatures.contains(feature);
                final featureDetails = _getFeatureDetails(feature);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          feature,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Nova característica de classe'),
                        leading: Icon(Icons.star_outline, color: Colors.purple),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Botão para seleção de perícias se for Especialização
                            if (feature.toLowerCase().contains(
                                  'especialização',
                                ) &&
                                proficiencySkillCount > 0)
                              IconButton(
                                icon: Icon(
                                  selectedProficiencySkills.length ==
                                          proficiencySkillCount
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color:
                                      selectedProficiencySkills.length ==
                                              proficiencySkillCount
                                          ? Colors.green
                                          : Colors.orange,
                                ),
                                onPressed: _showProficiencySelectionDialog,
                                tooltip:
                                    'Selecionar perícias para Especialização',
                              ),
                            Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              expandedFeatures.remove(feature);
                            } else {
                              expandedFeatures.add(feature);
                            }
                          });
                        },
                      ),
                      if (isExpanded && featureDetails != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 1,
                                color: Colors.purple.withAlpha(30),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Descrição:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                featureDetails.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              // Mostrar perícias selecionadas para Especialização
                              if (feature.toLowerCase().contains(
                                    'especialização',
                                  ) &&
                                  selectedProficiencySkills.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Perícias selecionadas para Especialização:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        children:
                                            selectedProficiencySkills.map((
                                              skill,
                                            ) {
                                              return Chip(
                                                label: Text(skill),
                                                backgroundColor: Colors.green
                                                    .withAlpha(30),
                                                labelStyle: TextStyle(
                                                  color: Colors.green.shade700,
                                                  fontSize: 12,
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              const SizedBox(height: 8),
                              Text(
                                'Nível: ${featureDetails.level}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Subclass? _getSubclassDetails(String subclassName) {
    if (dndClass == null) return null;

    // Buscar a subclasse na classe do personagem
    for (final subclass in dndClass!.subclasses) {
      if (subclass.name == subclassName) {
        return subclass;
      }
    }

    return null;
  }

  void _showSubclassDetailsDialog(String subclassName) {
    final subclass = _getSubclassDetails(subclassName);
    if (subclass == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.category, color: Colors.indigo),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  subclass.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Habilidades da Subclasse:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...subclass.features.map((feature) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withAlpha(10),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.indigo.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.indigo.shade600,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  feature.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.withAlpha(20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Nível ${feature.level}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.indigo.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feature.description,
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  dynamic _getFeatureDetails(String featureName) {
    if (dndClass == null) return null;

    // Buscar a característica na classe do personagem
    for (final feature in dndClass!.features) {
      if (feature.name == featureName) {
        return feature;
      }
    }

    // Buscar nas subclasses se existirem
    for (final subclass in dndClass!.subclasses) {
      for (final feature in subclass.features) {
        if (feature.name == featureName) {
          return feature;
        }
      }
    }

    return null;
  }

  Widget _buildSpellProgressionSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  'Progressão de Magias',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...levelUp!.spellProgression.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        _formatSpellProgressionKey(entry.key),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        entry.value.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatSpellProgressionKey(String key) {
    switch (key) {
      case 'cantrips':
        return 'Truques';
      case 'preparedSpells':
        return 'Magias Preparadas';
      case 'spellSlots':
        return 'Espaços de Magia';
      case 'invocations':
        return 'Invocações (Bruxo)';
      case 'slotLevel':
        return 'Nível dos Espaços';
      default:
        return key;
    }
  }

  void _rollHitPoints() {
    setState(() {
      hitPointsRoll =
          (dndClass!.hitDie *
                  (0.5 + (DateTime.now().millisecondsSinceEpoch % 100) / 100))
              .round();
    });
  }

  int _getRacialHitPointIncrease() {
    // Por enquanto, assumir que Anão tem +1 PV por nível
    if (widget.character.race.toLowerCase().contains('anão')) {
      return 1;
    }
    return 0;
  }

  String _getTotalHitPointsGained() {
    final racialIncrease = _getRacialHitPointIncrease();
    final baseHitPoints =
        useManual
            ? (_hitPointsController.text.isNotEmpty
                ? _hitPointsController.text
                : '0')
            : useAverage
            ? '${levelUp!.hitPointsGained}'
            : hitPointsRoll > 0
            ? '$hitPointsRoll'
            : 'Rolar';

    if (racialIncrease > 0) {
      final baseValue =
          useManual
              ? (int.tryParse(_hitPointsController.text) ?? 0)
              : useAverage
              ? levelUp!.hitPointsGained
              : hitPointsRoll;
      return '${baseValue + racialIncrease}';
    }

    return baseHitPoints;
  }

  void _changeAbilityScore(String ability, int change) {
    setState(() {
      // Calcular total de pontos já distribuídos
      final totalDistributed = abilityScoreChanges.values.reduce(
        (a, b) => a + b,
      );

      // Novo valor para este atributo
      final newValue = abilityScoreChanges[ability]! + change;

      // Novo total se essa mudança for aplicada
      final newTotal =
          totalDistributed - abilityScoreChanges[ability]! + newValue;

      // Regras:
      // 1. Máximo +2 por atributo individual
      // 2. Máximo +2 no total (pode ser +2 em um OU +1 em dois)
      if (newValue >= 0 && newValue <= 2 && newTotal <= 2) {
        abilityScoreChanges[ability] = newValue;
      }
    });
  }

  void _checkProficiencyDoubling() {
    if (dndClass == null) return;

    // Verificar se há habilidade de Especialização no novo nível
    for (final feature in dndClass!.features) {
      if (feature.level == levelUp!.newLevel &&
          feature.name.toLowerCase().contains('especialização')) {
        // Para Especialização, usar valor padrão baseado no nível
        // Nível 2: 2 perícias, Nível 9: 2 perícias adicionais
        proficiencySkillCount = 2;
        break;
      }
    }
  }

  List<String> _getAvailableSkillsForProficiency() {
    if (dndClass == null) return [];

    // Obter perícias proficientes do personagem
    final proficientSkills =
        widget.character.skills
            .where((skill) => skill.isProficient)
            .map((skill) => skill.name)
            .toList();

    // Debug: verificar perícias proficientes
    debugPrint('=== DEBUG PERÍCIAS PROFICIENTES ===');
    debugPrint(
      'Total de perícias do personagem: ${widget.character.skills.length}',
    );
    debugPrint('Perícias proficientes encontradas: $proficientSkills');
    debugPrint('=== FIM DEBUG ===');

    return proficientSkills;
  }

  void _showProficiencySelectionDialog() {
    final availableSkills = _getAvailableSkillsForProficiency();

    // Debug: verificar se há perícias disponíveis
    debugPrint('=== DEBUG DIÁLOGO DE ESPECIALIZAÇÃO ===');
    debugPrint('Perícias disponíveis: $availableSkills');
    debugPrint('Perícias já selecionadas: $selectedProficiencySkills');
    debugPrint('Número necessário: $proficiencySkillCount');
    debugPrint('=== FIM DEBUG ===');

    if (availableSkills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nenhuma perícia proficiente encontrada para especialização.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.star, color: Colors.purple),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Selecionar Perícias para Especialização',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Escolha $proficiencySkillCount perícias nas quais você já é proficiente para obter Especialização (dobrar o bônus de proficiência):',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    ...availableSkills.map((skill) {
                      final isSelected = selectedProficiencySkills.contains(
                        skill,
                      );
                      return CheckboxListTile(
                        title: Text(skill),
                        value: isSelected,
                        onChanged: (value) {
                          setDialogState(() {
                            if (value == true) {
                              if (selectedProficiencySkills.length <
                                  proficiencySkillCount) {
                                selectedProficiencySkills.add(skill);
                              }
                            } else {
                              selectedProficiencySkills.remove(skill);
                            }
                          });
                        },
                        secondary: Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected ? Colors.green : Colors.grey,
                        ),
                      );
                    }),
                    if (selectedProficiencySkills.length >=
                        proficiencySkillCount)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Você selecionou ${selectedProficiencySkills.length} perícias. Desmarque uma para selecionar outra.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      selectedProficiencySkills.clear();
                    });
                  },
                  child: const Text('Limpar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed:
                      selectedProficiencySkills.length == proficiencySkillCount
                          ? () {
                            setState(() {});
                            Navigator.of(context).pop();
                          }
                          : null,
                  child: Text(
                    'Confirmar (${selectedProficiencySkills.length}/$proficiencySkillCount)',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool _canCompleteLevelUp() {
    if (levelUp == null) return false;

    // Verificar melhoria de atributo ou seleção de talento (se aplicável)
    if (levelUp!.abilityScoreImprovements.isNotEmpty) {
      if (chooseFeat) {
        // Se escolheu talento, deve ter selecionado um
        if (selectedFeat == null) return false;
      } else {
        // Se escolheu melhoria de atributo, deve ter feito mudanças
        final totalChanges = abilityScoreChanges.values.fold(
          0,
          (sum, change) => sum + change,
        );
        if (totalChanges == 0) return false;
      }
    }

    // Verificar entrada manual de PV
    if (useManual) {
      final manualValue = int.tryParse(_hitPointsController.text);
      if (manualValue == null || manualValue <= 0) return false;
    }

    // Verificar seleção de subclasse (se aplicável)
    if (levelUp!.availableSubclasses.isNotEmpty &&
        levelUp!.selectedSubclass == null) {
      return false;
    }

    // Verificar se há habilidade de Especialização que precisa de seleção
    if (proficiencySkillCount > 0 &&
        selectedProficiencySkills.length != proficiencySkillCount) {
      return false;
    }

    return true;
  }

  Future<void> _completeLevelUp() async {
    try {
      // Aplicar mudanças ao personagem
      final character = widget.character;

      // Atualizar nível
      character.level = levelUp!.newLevel;

      // Atualizar pontos de vida
      final hitPointsToAdd =
          useManual
              ? int.tryParse(_hitPointsController.text) ??
                  levelUp!.hitPointsGained
              : useAverage
              ? levelUp!.hitPointsGained
              : hitPointsRoll;

      // Calcular aumento de vida racial
      int racialHitPointIncrease = 0;
      // Por enquanto, assumir que Anão tem +1 PV por nível
      if (character.race.toLowerCase().contains('anão')) {
        racialHitPointIncrease = 1;
      }

      final totalHitPointsToAdd = hitPointsToAdd + racialHitPointIncrease;
      character.maxHitPoints += totalHitPointsToAdd;
      character.currentHitPoints += totalHitPointsToAdd;

      debugPrint(
        'Level up PV: $hitPointsToAdd (classe) + $racialHitPointIncrease (racial) = $totalHitPointsToAdd',
      );

      // Aplicar melhorias de atributos
      for (final entry in abilityScoreChanges.entries) {
        if (entry.value > 0) {
          character.abilityScores[entry.key] =
              character.abilityScores[entry.key]! + entry.value;
        }
      }

      // Aplicar especialização nas perícias selecionadas
      if (selectedProficiencySkills.isNotEmpty) {
        for (final skillName in selectedProficiencySkills) {
          final skillIndex = character.skills.indexWhere(
            (skill) => skill.name == skillName,
          );
          if (skillIndex != -1) {
            character.skills[skillIndex].hasExpertise = true;
            debugPrint('Aplicada especialização na perícia: $skillName');
          }
        }
      }

      // Aplicar seleção de subclasse (geralmente no nível 3)
      if (levelUp!.selectedSubclass != null && dndClass != null) {
        final selectedSubclassName = levelUp!.selectedSubclass!;

        // Buscar a subclasse na classe
        Subclass? selectedSubclass;
        for (final subclass in dndClass!.subclasses) {
          if (subclass.name == selectedSubclassName) {
            selectedSubclass = subclass;
            break;
          }
        }

        if (selectedSubclass != null) {
          character.subclassName = selectedSubclass.name;
          character.subclassLevel = levelUp!.newLevel;

          // Converter features da subclasse para Map
          character.subclassFeatures =
              selectedSubclass.features
                  .map((feature) => feature.toJson())
                  .toList();

          debugPrint(
            'Subclasse selecionada: ${selectedSubclass.name} (Nível ${levelUp!.newLevel})',
          );
          debugPrint(
            'Features da subclasse: ${character.subclassFeatures?.length ?? 0}',
          );
        }
      }

      // Salvar personagem
      await ref.read(charactersProvider.notifier).updateCharacter(character);

      // Recarregar personagem com dndClass completo
      final reloadedCharacter = await CharacterService.loadCharacter(
        character.id,
      );
      if (reloadedCharacter == null) {
        throw Exception('Falha ao recarregar personagem');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Level up concluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, reloadedCharacter);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao completar level up: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
