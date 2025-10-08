import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/character.dart';
import '/models/item.dart';
import '/providers/character_provider.dart';
import '/services/supabase_service.dart';
import 'character_sheet_screen.dart';

class CharacterCreationStepsScreen extends ConsumerStatefulWidget {
  const CharacterCreationStepsScreen({super.key});

  @override
  ConsumerState<CharacterCreationStepsScreen> createState() =>
      _CharacterCreationStepsScreenState();
}

class _CharacterCreationStepsScreenState
    extends ConsumerState<CharacterCreationStepsScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Dados do personagem
  String _characterName = '';
  Map<String, dynamic>? _selectedClass;
  Map<String, dynamic>? _selectedRace;
  Map<String, dynamic>? _selectedBackground;
  Map<String, int> _abilityScores = {
    'Força': 10,
    'Destreza': 10,
    'Constituição': 10,
    'Inteligência': 10,
    'Sabedoria': 10,
    'Carisma': 10,
  };

  // Métodos de distribuição de atributos
  String _distributionMethod = 'custom'; // 'custom', 'point_buy'
  int _pointBuyPoints = 27; // Pontos disponíveis para compra
  Map<String, int> _baseAbilityScores = {
    'Força': 8,
    'Destreza': 8,
    'Constituição': 8,
    'Inteligência': 8,
    'Sabedoria': 8,
    'Carisma': 8,
  };

  // Distribuição de bônus da origem
  String _originBonusMethod =
      'equal'; // 'equal' (+1/+1/+1) ou 'unequal' (+2/+1)
  final Map<String, int> _originBonusDistribution = {
    'Força': 0,
    'Destreza': 0,
    'Constituição': 0,
    'Inteligência': 0,
    'Sabedoria': 0,
    'Carisma': 0,
  };

  String _alignment = '';
  final List<String> _languages = [];

  // Perícias selecionadas
  final List<String> _selectedSkills = [];

  // Equipamentos selecionados
  String? _selectedClassOption; // 'A' ou 'B'
  String? _selectedBackgroundOption; // 'A', 'B' ou '2014'

  // Escolhas de equipamento selecionadas
  final Map<String, Map<String, dynamic>> _selectedEquipmentChoices = {};

  // Dados carregados
  List<Map<String, dynamic>> _classes = [];
  List<Map<String, dynamic>> _races = [];
  List<Map<String, dynamic>> _backgrounds = [];
  bool _isLoading = true;

  final List<String> _steps = [
    'Escolha uma Classe',
    'Escolha a Raça',
    'Escolha o Antecedente',
    'Determine os Valores de Atributos',
    'Escolha as Perícias',
    'Escolha os Equipamentos',
    'Escolha um Alinhamento',
    'Preencha os Detalhes',
  ];

  final List<String> _stepDescriptions = [
    'Todo aventureiro pertence a uma classe. Esta descreve, de forma geral, a vocação de um personagem, seus talentos especiais e quais são suas principais táticas.',
    'Escolha a espécie (raça) do personagem.',
    'Escolha o antecedente (origem) do personagem.',
    'Muito do que seu personagem faz no jogo depende de seus seis atributos.',
    'Escolha as perícias nas quais seu personagem é proficiente. Sua classe e antecedente determinam quais perícias estão disponíveis.',
    'Escolha os equipamentos iniciais baseados na sua classe e antecedente.',
    'O alinhamento é uma maneira abreviada de representar a bússola moral de seu personagem.',
    'Com base nas escolhas que fez, preencha os detalhes restantes na sua ficha de personagem.',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Carregar apenas dados PHB 2024
      final classesResponse = await SupabaseService.client
          .from('classes')
          .select()
          .eq('source', 'PHB 2024')
          .order('name');

      final racesResponse = await SupabaseService.client
          .from('races')
          .select()
          .eq('source', 'PHB 2024')
          .order('name');

      final backgroundsResponse = await SupabaseService.client
          .from('backgrounds')
          .select()
          .eq('source', 'PHB 2024')
          .order('name');

      setState(() {
        _classes = List<Map<String, dynamic>>.from(classesResponse);
        _races = List<Map<String, dynamic>>.from(racesResponse);
        _backgrounds = List<Map<String, dynamic>>.from(backgroundsResponse);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
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

  void _nextStep() {
    // Validar etapa atual antes de prosseguir
    if (_currentStep == 3) {
      // Etapa de atributos
      if (_distributionMethod == 'point_buy' && _pointBuyPoints != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _pointBuyPoints > 0
                  ? 'Você ainda tem $_pointBuyPoints ponto(s) para distribuir'
                  : 'Você excedeu o limite em ${-_pointBuyPoints} ponto(s). Ajuste os atributos.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    }
    if (_currentStep == 4) {
      // Etapa de perícias
      final classSkills = _getClassSkills();
      final maxSelections = _getClassSkillCount();
      if (classSkills.isNotEmpty && _selectedSkills.length != maxSelections) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selecione exatamente $maxSelections perícia(s) da classe',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
    }

    if (_currentStep == 5) {
      // Etapa de equipamentos - verificar escolhas SOMENTE quando a opção A for selecionada
      final classChoices = _getClassEquipmentChoices();
      if (_selectedClassOption == 'A' && classChoices.isNotEmpty) {
        for (final choice in classChoices) {
          final choiceKey = 'class_${choice['description']}';
          if (!_selectedEquipmentChoices.containsKey(choiceKey)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Selecione uma opção para: ${choice['description']}',
                ),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }
        }
      }

      final backgroundChoices = _getBackgroundEquipmentChoices();
      if (_selectedBackgroundOption == 'A' && backgroundChoices.isNotEmpty) {
        for (final choice in backgroundChoices) {
          final choiceKey = 'background_${choice['description']}';
          if (!_selectedEquipmentChoices.containsKey(choiceKey)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Selecione uma opção para: ${choice['description']}',
                ),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }
        }
      }
    }

    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _setSpellcastingInfo(Character character) {
    if (_selectedClass == null) return;

    // Verificar se a classe tem conjuração
    final hasSpells = _selectedClass!['has_spells'] as bool? ?? false;
    final spellcasting = _selectedClass!['spellcasting'];

    // Se tem spellcasting definido ou has_spells = true
    if (hasSpells || spellcasting != null) {
      character.isSpellcaster = true;

      // Tentar obter o atributo de conjuração da estrutura spellcasting
      if (spellcasting is Map<String, dynamic>) {
        final ability = spellcasting['ability'] as String?;
        if (ability != null && ability.isNotEmpty) {
          character.customSpellcastingAbility = ability;
          debugPrint('Atributo de conjuração detectado: $ability');
        }
      }

      // Se não encontrou no spellcasting, usar o atributo primário da classe
      if (character.customSpellcastingAbility == null) {
        final primaryAbility = _selectedClass!['primary_ability'] as String?;
        if (primaryAbility != null && primaryAbility.isNotEmpty) {
          character.customSpellcastingAbility = primaryAbility;
          debugPrint(
            'Usando atributo primário como conjuração: $primaryAbility',
          );
        }
      }

      debugPrint(
        'Personagem configurado como conjurador: ${character.className}',
      );
    } else {
      character.isSpellcaster = false;
      debugPrint('Personagem NÃO é conjurador: ${character.className}');
    }
  }

  Future<void> _createCharacter() async {
    if (_characterName.isEmpty ||
        _selectedClass == null ||
        _selectedRace == null ||
        _selectedBackground == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Validar compra de pontos também ao finalizar
    if (_distributionMethod == 'point_buy' && _pointBuyPoints != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _pointBuyPoints > 0
                ? 'Distribua todos os pontos restantes ($_pointBuyPoints) antes de criar o personagem'
                : 'Você excedeu o limite em ${-_pointBuyPoints} ponto(s). Ajuste os atributos.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Verificar se as perícias foram selecionadas corretamente
    final classSkills = _getClassSkills();
    final maxSelections = _getClassSkillCount();
    if (classSkills.isNotEmpty && _selectedSkills.length != maxSelections) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selecione exatamente $maxSelections perícia(s) da classe',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Verificar se ao menos uma fonte de equipamento foi escolhida
    if (_selectedClassOption == null && _selectedBackgroundOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione pelo menos uma opção de equipamento da classe ou do antecedente',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Se a classe for 'A', garantir escolhas obrigatórias da classe
    final classChoices = _getClassEquipmentChoices();
    if (_selectedClassOption == 'A' && classChoices.isNotEmpty) {
      for (final choice in classChoices) {
        final choiceKey = 'class_${choice['description']}';
        if (!_selectedEquipmentChoices.containsKey(choiceKey)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Selecione uma opção para: ${choice['description']}',
              ),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }
      }
    }

    // Se o antecedente for 'A', garantir escolhas obrigatórias do antecedente
    final backgroundChoices = _getBackgroundEquipmentChoices();
    if (_selectedBackgroundOption == 'A' && backgroundChoices.isNotEmpty) {
      for (final choice in backgroundChoices) {
        final choiceKey = 'background_${choice['description']}';
        if (!_selectedEquipmentChoices.containsKey(choiceKey)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Selecione uma opção para: ${choice['description']}',
              ),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }
      }
    }

    // Calcular atributos finais com bônus da origem
    Map<String, int> finalAbilityScores = {};
    for (final entry in _abilityScores.entries) {
      final baseValue =
          _distributionMethod == 'custom'
              ? entry.value
              : _baseAbilityScores[entry.key]!;
      final bonus = _getOriginBonus(entry.key);
      finalAbilityScores[entry.key] = baseValue + bonus;
    }

    // Combinar todas as proficiências (salvaguardas + perícias do antecedente + perícias da classe)
    final savingThrows = _getSavingThrows();
    final backgroundSkills = _getBackgroundSkills();
    final allProficiencies = [
      ...savingThrows,
      ...backgroundSkills,
      ..._selectedSkills,
    ];

    // Debug: verificar proficiências antes de criar o personagem
    debugPrint('=== DEBUG CRIAÇÃO DE PERSONAGEM ===');
    debugPrint('Salvaguardas: $savingThrows');
    debugPrint('Perícias do antecedente: $backgroundSkills');
    debugPrint('Perícias escolhidas: $_selectedSkills');
    debugPrint('Todas as proficiências: $allProficiencies');
    debugPrint('=====================================');

    // Criar inventário inicial com equipamentos selecionados
    final initialInventory = <Item>[];

    // Adicionar equipamentos da classe selecionada
    if (_selectedClassOption != null) {
      final classEquipment = _getSelectedClassEquipment();
      debugPrint(
        'Equipamentos da classe selecionados: ${classEquipment.length}',
      );
      for (final equipment in classEquipment) {
        debugPrint('Adicionando item da classe: ${equipment['name']}');
        initialInventory.add(
          Item(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: equipment['name'],
            description: 'Equipamento inicial da classe',
            quantity: equipment['quantity'] ?? 1,
            weight:
                double.tryParse(equipment['weight']?.toString() ?? '0') ?? 0.0,
            value: int.tryParse(equipment['cost']?.toString() ?? '0') ?? 0,
            type: _getItemTypeFromCategory(equipment['category']),
            isEquipped: false,
          ),
        );
      }
    }

    // Adicionar equipamentos do antecedente selecionado
    if (_selectedBackgroundOption != null) {
      final backgroundEquipment = _getSelectedBackgroundEquipment();
      debugPrint(
        'Equipamentos do antecedente selecionados: ${backgroundEquipment.length}',
      );
      for (final equipment in backgroundEquipment) {
        debugPrint('Adicionando item do antecedente: ${equipment['name']}');
        initialInventory.add(
          Item(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: equipment['name'],
            description: 'Equipamento inicial do antecedente',
            quantity: equipment['quantity'] ?? 1,
            weight:
                double.tryParse(equipment['weight']?.toString() ?? '0') ?? 0.0,
            value: int.tryParse(equipment['cost']?.toString() ?? '0') ?? 0,
            type: _getItemTypeFromCategory(equipment['category']),
            isEquipped: false,
          ),
        );
      }
    }

    // Adicionar equipamentos das escolhas selecionadas
    for (final entry in _selectedEquipmentChoices.entries) {
      final selectedOption = entry.value;

      debugPrint('Adicionando item da escolha: ${selectedOption['name']}');
      initialInventory.add(
        Item(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: selectedOption['name'],
          description: 'Equipamento escolhido',
          quantity: 1,
          weight:
              double.tryParse(selectedOption['weight']?.toString() ?? '0') ??
              0.0,
          value: int.tryParse(selectedOption['cost']?.toString() ?? '0') ?? 0,
          type: _getItemTypeFromCategory(selectedOption['category']),
          isEquipped: false,
        ),
      );
    }

    debugPrint(
      'Inventário inicial criado com ${initialInventory.length} itens',
    );
    debugPrint('PO total: ${_calculateTotalPO()}');

    final character = Character(
      name: _characterName,
      className: _selectedClass!['name'],
      race: _selectedRace!['name'],
      background: _selectedBackground!['name'],
      level: 1,
      abilityScores: finalAbilityScores,
      languages: _languages,
      alignment: _alignment,
      proficiencies: allProficiencies,
      inventory: initialInventory,
      goldPieces: _calculateTotalPO(),
    );

    // Sincronizar proficiências com skills
    _syncProficienciesWithSkills(character, allProficiencies);

    // Calcular vida inicial (dado de vida + modificador de constituição)
    final hitDie = _selectedClass!['hit_die'] as int? ?? 8;
    final constitutionModifier = character.getAbilityModifier('Constituição');
    final baseHitPoints = hitDie + constitutionModifier;

    // Verificar aumento de vida racial
    int racialHitPointIncrease = 0;
    if (_selectedRace != null && _selectedRace!['traits'] is List) {
      final traits = _selectedRace!['traits'] as List;
      for (final trait in traits) {
        if (trait is Map<String, dynamic> &&
            trait['has_hit_point_increase'] == true) {
          final increasePerLevel = trait['hit_point_increase_per_level'];
          if (increasePerLevel is int) {
            racialHitPointIncrease += increasePerLevel * character.level;
          } else if (increasePerLevel is double) {
            racialHitPointIncrease +=
                (increasePerLevel * character.level).round();
          } else {
            racialHitPointIncrease += character.level; // padrão 1 por nível
          }
        }
      }
    }

    final totalHitPoints = baseHitPoints + racialHitPointIncrease;
    character.maxHitPoints = totalHitPoints;
    character.currentHitPoints = totalHitPoints;

    debugPrint(
      'Vida inicial calculada: $hitDie (dado) + $constitutionModifier (mod) + $racialHitPointIncrease (racial) = $totalHitPoints',
    );

    // Detectar automaticamente se é conjurador e o atributo de conjuração
    _setSpellcastingInfo(character);

    await ref.read(charactersProvider.notifier).addCharacter(character);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Personagem criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Aguardar um pouco para garantir que o provider foi atualizado
      await Future.delayed(const Duration(milliseconds: 500));

      // Navegar para a tela do personagem criado
      final result = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CharacterSheetScreen(character: character),
        ),
      );

      // Se retornou da tela, recarregar os personagens para garantir sincronização
      if (result != null) {
        ref.read(charactersProvider.notifier).loadCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Personagem - ${_steps[_currentStep]}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  // Indicador de progresso
                  _buildProgressIndicator(),

                  // Conteúdo das etapas
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentStep = index);
                      },
                      children: [
                        _buildStep1(), // Classe
                        _buildStep2Race(), // Raça
                        _buildStep2Background(), // Antecedente
                        _buildStep3(), // Valores de Atributos
                        _buildStep4(), // Perícias
                        _buildStep5(), // Equipamentos
                        _buildStep6(), // Alinhamento
                        _buildStep7(), // Detalhes finais
                      ],
                    ),
                  ),

                  // Botões de navegação
                  _buildNavigationButtons(),
                ],
              ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Barra de progresso
          LinearProgressIndicator(
            value: (_currentStep + 1) / _steps.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          const SizedBox(height: 8),
          // Texto do progresso
          Text(
            'Etapa ${_currentStep + 1} de ${_steps.length}',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _steps[0],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _stepDescriptions[0],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),
            ..._classes.map((clazz) {
              final isSelected = _selectedClass?['id'] == clazz['id'];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: isSelected ? 4 : 1,
                color: isSelected ? Colors.green.withAlpha(30) : null,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isSelected ? Colors.green : Colors.grey,
                    child: Text(
                      clazz['name'].substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    clazz['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.green[700] : null,
                    ),
                  ),
                  subtitle:
                      clazz['description'] != null
                          ? Text(
                            clazz['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                          : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => _showClassDetails(clazz),
                        tooltip: 'Ver detalhes',
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  onTap: () {
                    setState(() => _selectedClass = clazz);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2Race() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _steps[1],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _stepDescriptions[1],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Seleção de Raça
            Text(
              'Espécie (Raça)',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._races.map((race) {
              final isSelected = _selectedRace?['id'] == race['id'];

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                elevation: isSelected ? 4 : 1,
                color: isSelected ? Colors.green.withAlpha(30) : null,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isSelected ? Colors.green : Colors.grey,
                    child: Text(
                      race['name'].substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    race['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.green[700] : null,
                    ),
                  ),
                  subtitle:
                      race['description'] != null
                          ? Text(
                            race['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                          : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => _showRaceDetails(race),
                        tooltip: 'Ver detalhes',
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectedRace = race;
                      _updateOriginBonusDistribution();
                    });
                  },
                ),
              );
            }),

            // Fim da etapa 2 (somente raça)
          ],
        ),
      ),
    );
  }

  Widget _buildStep2Background() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _steps[2],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _stepDescriptions[2],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Seleção de Antecedente
            Text(
              'Antecedente',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._backgrounds.map((background) {
              final isSelected = _selectedBackground?['id'] == background['id'];

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                elevation: isSelected ? 4 : 1,
                color: isSelected ? Colors.green.withAlpha(30) : null,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isSelected ? Colors.green : Colors.grey,
                    child: Text(
                      background['name'].substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    background['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.green[700] : null,
                    ),
                  ),
                  subtitle:
                      background['description'] != null
                          ? Text(
                            background['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                          : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => _showBackgroundDetails(background),
                        tooltip: 'Ver detalhes',
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _selectedBackground = background;
                      _updateOriginBonusDistribution();
                    });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _steps[2],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _stepDescriptions[2],
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Seleção do método de distribuição
              _buildDistributionMethodSelector(),
              const SizedBox(height: 24),

              // Bônus da origem
              if (_selectedRace != null && _selectedBackground != null) ...[
                _buildOriginBonuses(),
                const SizedBox(height: 24),
              ],

              // Distribuição de atributos
              ..._abilityScores.entries.map((entry) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _getAbilityName(entry.key),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            // Mostrar bônus da origem se aplicável
                            if (_getOriginBonus(entry.key) > 0) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withAlpha(30),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Text(
                                  '+${_getOriginBonus(entry.key)}',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value:
                                    _distributionMethod == 'custom'
                                        ? entry.value.toDouble()
                                        : _baseAbilityScores[entry.key]!
                                            .toDouble(),
                                min: _distributionMethod == 'custom' ? 8 : 8,
                                max: _distributionMethod == 'custom' ? 20 : 15,
                                divisions:
                                    _distributionMethod == 'custom' ? 12 : 7,
                                label:
                                    _distributionMethod == 'custom'
                                        ? entry.value.toString()
                                        : _baseAbilityScores[entry.key]
                                            .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    if (_distributionMethod == 'custom') {
                                      _abilityScores[entry.key] = value.round();
                                    } else {
                                      _baseAbilityScores[entry.key] =
                                          value.round();
                                      _updatePointBuyCost();
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 60,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(30),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Text(
                                _distributionMethod == 'custom'
                                    ? entry.value.toString()
                                    : _baseAbilityScores[entry.key].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Mostrar valor final com bônus
                        if (_distributionMethod == 'point_buy') ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Valor Final: ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${_baseAbilityScores[entry.key]! + _getOriginBonus(entry.key)}',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),

              // Espaço extra no final para melhor scroll
              const SizedBox(height: 24),
            ],
          ),
        ),
        if (_distributionMethod == 'point_buy')
          Positioned(
            top: 12,
            right: 16,
            child: _buildPointBuyFloatingIndicator(),
          ),
      ],
    );
  }

  Widget _buildPointBuyFloatingIndicator() {
    final bool isExact = _pointBuyPoints == 0;
    final bool isOver = _pointBuyPoints < 0;
    final Color base =
        isExact
            ? Colors.green.shade700
            : (isOver ? Colors.red.shade700 : Colors.deepOrange.shade700);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: base,
        border: Border.all(color: Colors.white.withAlpha(180)),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExact ? Icons.check_circle : (isOver ? Icons.error : Icons.info),
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            _pointBuyPoints > 0
                ? 'Pontos restantes: $_pointBuyPoints'
                : (_pointBuyPoints < 0
                    ? 'Excedido: ${-_pointBuyPoints}'
                    : 'Pontos distribuídos'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _steps[3],
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _stepDescriptions[3],
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Salvaguardas da classe (fixas)
          if (_selectedClass != null) ...[
            _buildSavingThrows(),
            const SizedBox(height: 24),
          ],

          // Perícias do antecedente (fixas)
          if (_selectedBackground != null) ...[
            _buildBackgroundSkills(),
            const SizedBox(height: 24),
          ],

          // Perícias da classe (escolha)
          if (_selectedClass != null) ...[
            _buildClassSkills(),
            const SizedBox(height: 24),
          ],

          // Resumo das proficiências obtidas
          if (_getSavingThrows().isNotEmpty ||
              _getBackgroundSkills().isNotEmpty ||
              _selectedSkills.isNotEmpty) ...[
            _buildSelectedSkillsSummary(),
            const SizedBox(height: 24),
          ],

          // Espaço extra no final para melhor scroll
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStep5() {
    final classOptions = _getClassEquipmentOptions();
    final backgroundOptions = _getBackgroundEquipmentOptions();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escolha os Equipamentos Iniciais',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Selecione os equipamentos baseados na sua classe e antecedente.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Equipamentos da Classe
          if (classOptions.isNotEmpty) ...[
            _buildEquipmentSection(
              title: 'Equipamentos da Classe (${_selectedClass!['name']})',
              options: classOptions,
              selectedOption: _selectedClassOption,
              onSelectionChanged: (option) {
                setState(() {
                  _selectedClassOption = option;
                });
              },
            ),
            const SizedBox(height: 24),
          ],

          // Equipamentos do Antecedente
          if (backgroundOptions.isNotEmpty) ...[
            _buildEquipmentSection(
              title:
                  'Equipamentos do Antecedente (${_selectedBackground!['name']})',
              options: backgroundOptions,
              selectedOption: _selectedBackgroundOption,
              onSelectionChanged: (option) {
                setState(() {
                  _selectedBackgroundOption = option;
                });
              },
            ),
            const SizedBox(height: 24),
          ],

          // Escolhas de Equipamento
          _buildEquipmentChoicesSection(),

          // Resumo
          if (_selectedClassOption != null ||
              _selectedBackgroundOption != null) ...[
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumo dos Equipamentos',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Total de PO: ${_calculateTotalPO()}'),
                    Text('Itens selecionados: ${_calculateTotalItems()}'),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStep6() {
    final alignments = [
      'Leal e Bom',
      'Neutro e Bom',
      'Caótico e Bom',
      'Leal e Neutro',
      'Neutro',
      'Caótico e Neutro',
      'Leal e Mau',
      'Neutro e Mau',
      'Caótico e Mau',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _steps[6],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _stepDescriptions[6],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: alignments.length,
              itemBuilder: (context, index) {
                final alignment = alignments[index];
                final isSelected = _alignment == alignment;

                return Card(
                  elevation: isSelected ? 4 : 1,
                  color: isSelected ? Colors.green.withAlpha(30) : null,
                  child: InkWell(
                    onTap: () {
                      setState(() => _alignment = alignment);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            alignment,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.green[700] : null,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep7() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _steps[7],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _stepDescriptions[7],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Nome do personagem
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome do Personagem',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Digite o nome do personagem',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        setState(() => _characterName = value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Resumo das escolhas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumo das Escolhas',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryItem(
                      'Classe',
                      _selectedClass?['name'] ?? 'Não selecionada',
                    ),
                    _buildSummaryItem(
                      'Raça',
                      _selectedRace?['name'] ?? 'Não selecionada',
                    ),
                    _buildSummaryItem(
                      'Antecedente',
                      _selectedBackground?['name'] ?? 'Não selecionado',
                    ),
                    _buildSummaryItem(
                      'Alinhamento',
                      _alignment.isEmpty ? 'Não selecionado' : _alignment,
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

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color:
                    value.startsWith('Não') ? Colors.grey[600] : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Anterior'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed:
                  _currentStep == _steps.length - 1
                      ? _createCharacter
                      : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(
                _currentStep == _steps.length - 1
                    ? 'Criar Personagem'
                    : 'Próximo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAbilityName(String key) {
    // Agora todos os atributos já estão em português
    return key;
  }

  Widget _buildDistributionMethodSelector() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isNarrow = screenWidth < 380;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Método de Distribuição',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Personalizado'),
                    subtitle: Text(
                      isNarrow ? 'Livre (8-20)' : 'Distribua livremente (8-20)',
                    ),
                    value: 'custom',
                    groupValue: _distributionMethod,
                    onChanged: (value) {
                      setState(() {
                        _distributionMethod = value!;
                        if (value == 'custom') {
                          // Converter valores base para personalizado
                          _abilityScores = Map.from(_baseAbilityScores);
                        } else {
                          // Converter valores personalizados para base
                          _baseAbilityScores = Map.from(_abilityScores);
                          _clampPointBuyBaseScores();
                          _updatePointBuyCost();
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Compra de Pontos'),
                    subtitle: Text(
                      isNarrow
                          ? 'Pts: $_pointBuyPoints'
                          : '$_pointBuyPoints pontos restantes',
                    ),
                    value: 'point_buy',
                    groupValue: _distributionMethod,
                    onChanged: (value) {
                      setState(() {
                        _distributionMethod = value!;
                        if (value == 'custom') {
                          _abilityScores = Map.from(_baseAbilityScores);
                        } else {
                          _baseAbilityScores = Map.from(_abilityScores);
                          _clampPointBuyBaseScores();
                          _updatePointBuyCost();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOriginBonuses() {
    final originAbilities = _getOriginAbilities();
    if (originAbilities.isEmpty) return const SizedBox.shrink();

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isNarrow = screenWidth < 380;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bônus da Origem',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Baseado na sua raça e antecedente selecionados',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 16),

            // Seleção do método de distribuição
            Text(
              'Escolha como distribuir os bônus:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(isNarrow ? '+1 em cada' : '+1 em cada'),
                    subtitle: Text(
                      isNarrow
                          ? '${originAbilities.length} atrib.'
                          : '${originAbilities.length} atributos',
                    ),
                    value: 'equal',
                    groupValue: _originBonusMethod,
                    onChanged: (value) {
                      setState(() {
                        _originBonusMethod = value!;
                        _updateOriginBonusDistribution();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('+2 e +1'),
                    subtitle: Text(isNarrow ? '2 atrib.' : '2 atributos'),
                    value: 'unequal',
                    groupValue: _originBonusMethod,
                    onChanged: (value) {
                      setState(() {
                        _originBonusMethod = value!;
                        _updateOriginBonusDistribution();
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Seleção dos atributos específicos
            if (_originBonusMethod == 'unequal') ...[
              Text(
                'Escolha qual atributo recebe +2:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    originAbilities.map((ability) {
                      final isSelected = _originBonusDistribution[ability] == 2;
                      return FilterChip(
                        label: Text(_getAbilityName(ability)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              // Limpar outros +2
                              for (final key in _originBonusDistribution.keys) {
                                if (_originBonusDistribution[key] == 2) {
                                  _originBonusDistribution[key] = 0;
                                }
                              }
                              _originBonusDistribution[ability] = 2;
                            } else {
                              _originBonusDistribution[ability] = 0;
                            }
                          });
                        },
                        selectedColor: Colors.blue.withAlpha(30),
                        checkmarkColor: Colors.blue[700],
                      );
                    }).toList(),
              ),
              const SizedBox(height: 12),
              Text(
                'Escolha qual atributo recebe +1:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    originAbilities.map((ability) {
                      final isSelected = _originBonusDistribution[ability] == 1;
                      return FilterChip(
                        label: Text(_getAbilityName(ability)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              // Limpar outros +1
                              for (final key in _originBonusDistribution.keys) {
                                if (_originBonusDistribution[key] == 1) {
                                  _originBonusDistribution[key] = 0;
                                }
                              }
                              _originBonusDistribution[ability] = 1;
                            } else {
                              _originBonusDistribution[ability] = 0;
                            }
                          });
                        },
                        selectedColor: Colors.green.withAlpha(30),
                        checkmarkColor: Colors.green[700],
                      );
                    }).toList(),
              ),
            ],

            const SizedBox(height: 16),

            // Mostrar distribuição atual
            Text(
              'Distribuição atual:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  originAbilities.map((ability) {
                    final bonus = _originBonusDistribution[ability] ?? 0;
                    if (bonus > 0) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              bonus == 2
                                  ? Colors.orange.withAlpha(30)
                                  : Colors.blue.withAlpha(30),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: bonus == 2 ? Colors.orange : Colors.blue,
                          ),
                        ),
                        child: Text(
                          '${_getAbilityName(ability)} +$bonus',
                          style: TextStyle(
                            color:
                                bonus == 2
                                    ? Colors.orange[700]
                                    : Colors.blue[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  int _getOriginBonus(String ability) {
    return _originBonusDistribution[ability] ?? 0;
  }

  List<String> _getOriginAbilities() {
    Set<String> abilities = {};

    // Bônus da raça (PHB 2024)
    if (_selectedRace != null) {
      final raceAbilityScores =
          _selectedRace!['ability_scores']?.toString() ?? '';
      if (raceAbilityScores.isNotEmpty) {
        final raceAbilities =
            raceAbilityScores.split(', ').map((s) => s.trim()).toList();
        for (final abilityName in raceAbilities) {
          // Converter nome do atributo para chave
          final abilityKey = _getAbilityKeyFromName(abilityName);
          if (abilityKey != null) {
            abilities.add(abilityKey);
          }
        }
      }
    }

    // Bônus do antecedente (PHB 2024)
    if (_selectedBackground != null) {
      final backgroundAbilityScores =
          _selectedBackground!['ability_scores']?.toString() ?? '';
      if (backgroundAbilityScores.isNotEmpty) {
        final backgroundAbilities =
            backgroundAbilityScores.split(', ').map((s) => s.trim()).toList();
        for (final abilityName in backgroundAbilities) {
          // Converter nome do atributo para chave
          final abilityKey = _getAbilityKeyFromName(abilityName);
          if (abilityKey != null) {
            abilities.add(abilityKey);
          }
        }
      }
    }

    return abilities.toList();
  }

  String? _getAbilityKeyFromName(String abilityName) {
    // Agora todos os atributos já estão em português
    return abilityName;
  }

  void _updateOriginBonusDistribution() {
    // Limpar distribuição atual
    for (final key in _originBonusDistribution.keys) {
      _originBonusDistribution[key] = 0;
    }

    final originAbilities = _getOriginAbilities();

    if (_originBonusMethod == 'equal') {
      // +1 em cada atributo da origem
      for (final ability in originAbilities) {
        _originBonusDistribution[ability] = 1;
      }
    } else {
      // +2 em um e +1 em outro - deixar nenhum selecionado inicialmente
      // O usuário deve escolher manualmente
    }
  }

  void _updatePointBuyCost() {
    int totalCost = 0;
    for (final score in _baseAbilityScores.values) {
      if (score <= 8) {
        totalCost += 0;
      } else if (score <= 13) {
        totalCost += (score - 8);
      } else {
        totalCost += (score - 8) + (score - 13); // Custo dobrado para 14+
      }
    }
    _pointBuyPoints = 27 - totalCost;
  }

  void _clampPointBuyBaseScores() {
    // Garante intervalo válido 8..15 ao entrar em point_buy
    for (final key in _baseAbilityScores.keys) {
      final v = _baseAbilityScores[key] ?? 8;
      if (v < 8) {
        _baseAbilityScores[key] = 8;
      } else if (v > 15) {
        _baseAbilityScores[key] = 15;
      }
    }
  }

  void _showClassDetails(Map<String, dynamic> clazz) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    clazz['name'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    clazz['name'],
                    style: const TextStyle(fontSize: 20),
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
                    // Descrição
                    if (clazz['description'] != null) ...[
                      Text(
                        'Descrição',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        clazz['description'],
                        style: TextStyle(color: Colors.grey[700], height: 1.4),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Tabela de Progressão
                    Text(
                      'Tabela de Progressão',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildProgressionTable(clazz),
                    const SizedBox(height: 16),

                    // Dados de Vida
                    if (clazz['hit_die'] != null) ...[
                      _buildDetailRow('Dado de Vida', 'd${clazz['hit_die']}'),
                      _buildDetailRow(
                        'Vida Inicial',
                        '${clazz['hit_die']} + modificador de Constituição',
                      ),
                    ],

                    // Proficiências
                    if (clazz['saving_throws'] != null &&
                        clazz['saving_throws'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Testes de Resistência',
                        clazz['saving_throws'],
                      ),
                    ],
                    if (clazz['armor_proficiencies'] != null &&
                        clazz['armor_proficiencies'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiência em Armaduras',
                        clazz['armor_proficiencies'],
                      ),
                    ],
                    if (clazz['weapon_proficiencies'] != null &&
                        clazz['weapon_proficiencies']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiência em Armas',
                        clazz['weapon_proficiencies'],
                      ),
                    ],
                    if (clazz['tool_proficiencies'] != null &&
                        clazz['tool_proficiencies'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiência em Ferramentas',
                        clazz['tool_proficiencies'],
                      ),
                    ],
                    if (clazz['skill_proficiencies'] != null &&
                        clazz['skill_proficiencies'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiência em Perícias',
                        clazz['skill_proficiencies'],
                      ),
                    ],

                    // Equipamentos Iniciais
                    if (clazz['equipment_lado_a'] != null &&
                        clazz['equipment_lado_a'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Equipamentos Iniciais - Lado A',
                        clazz['equipment_lado_a'],
                      ),
                    ],
                    if (clazz['equipment_lado_b'] != null &&
                        clazz['equipment_lado_b'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Equipamentos Iniciais - Lado B',
                        clazz['equipment_lado_b'],
                      ),
                    ],

                    // Magias
                    if (clazz['has_spells'] == true) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple.withAlpha(30),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.purple.withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.purple[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Esta classe pode conjurar magias',
                              style: TextStyle(
                                color: Colors.purple[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Ganhos por Nível
                    if (clazz['level_features'] != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Ganhos por Nível',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildLevelFeaturesList(clazz['level_features']),
                    ],

                    // Subclasses
                    if (clazz['subclasses_details'] != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Subclasses',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildSubclassesList(clazz['subclasses_details']),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => _selectedClass = clazz);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Selecionar'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLevelFeaturesList(dynamic levelFeatures) {
    if (levelFeatures == null) return [];

    try {
      final List<dynamic> features = List<dynamic>.from(levelFeatures);
      return features.map((feature) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nível ${feature['level']}: ${feature['name']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (feature['description'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    feature['description'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList();
    } catch (e) {
      return [Text('Erro ao carregar ganhos por nível: $e')];
    }
  }

  List<Widget> _buildSubclassesList(dynamic subclassesDetails) {
    if (subclassesDetails == null) return [];

    try {
      final List<dynamic> subclasses = List<dynamic>.from(subclassesDetails);
      return subclasses.map((subclass) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subclass['name'] ?? 'Subclasse',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (subclass['description'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subclass['description'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
                if (subclass['features'] != null) ...[
                  const SizedBox(height: 8),
                  ..._buildSubclassFeaturesList(subclass['features']),
                ],
              ],
            ),
          ),
        );
      }).toList();
    } catch (e) {
      return [Text('Erro ao carregar subclasses: $e')];
    }
  }

  List<Widget> _buildSubclassFeaturesList(dynamic features) {
    if (features == null) return [];

    try {
      final List<dynamic> featuresList = List<dynamic>.from(features);
      return featuresList.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(color: Colors.grey[600])),
              Expanded(
                child: Text(
                  'Nível ${feature['level']}: ${feature['name']}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ],
          ),
        );
      }).toList();
    } catch (e) {
      return [Text('Erro ao carregar características: $e')];
    }
  }

  Widget _buildProgressionTable(Map<String, dynamic> clazz) {
    return _buildDesktopProgressionTable(clazz);
  }

  Widget _buildDesktopProgressionTable(Map<String, dynamic> clazz) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Cabeçalho da tabela
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Nível',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Bônus',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Características',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ..._getLimitedUseFeatures(clazz).map((f) {
                  return Expanded(
                    flex: 1,
                    child: Text(
                      (f['name'] ?? '').toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                  // ignore: unnecessary_to_list_in_spreads
                }).toList(),
              ],
            ),
          ),
          // Linhas da tabela
          ...List.generate(20, (index) {
            final level = index + 1;
            final bonus = ((level - 1) ~/ 4) + 2;
            final isEven = index % 2 == 0;

            // Calcular valores baseados no nível
            final features = _getLimitedUseFeatures(clazz);
            final characteristics = _getLevelCharacteristics(clazz, level);

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: isEven ? Colors.white : Colors.grey[50],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '$level°',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '+$bonus',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      characteristics,
                      style: TextStyle(color: Colors.grey[700], fontSize: 10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ...features.map((f) {
                    final value = _getFeatureValueAtLevel(f, level);
                    return Expanded(
                      flex: 1,
                      child: Text(
                        value.isEmpty ? '—' : value,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Removidos helpers legados (_calculateFury/_calculateDamage/_calculateMastery)

  String _getLevelCharacteristics(Map<String, dynamic> clazz, int level) {
    // Buscar características específicas do nível nos dados da classe
    if (clazz['level_features'] != null) {
      try {
        final List<dynamic> features = List<dynamic>.from(
          clazz['level_features'],
        );
        final levelFeatures =
            features.where((feature) => feature['level'] == level).toList();

        if (levelFeatures.isNotEmpty) {
          return levelFeatures.map((f) => f['name']).join(', ');
        }
      } catch (e) {
        // Fallback para características padrão
      }
    }

    // Características padrão baseadas no nível (exemplo para Bárbaro)
    switch (level) {
      case 1:
        return 'Raiva, Defesa sem blindagem, Maestria em Armas';
      case 2:
        return 'Sentido de Perigo, Ataque imprudente';
      case 3:
        return 'Subclasse Bárbara, Conhecimento Primordial';
      case 4:
        return 'Aumento de Atributo';
      case 5:
        return 'Ataque Extra, Movimento rápido';
      case 6:
        return 'Característica de Subclasse';
      case 7:
        return 'Instinto Selvagem';
      case 8:
        return 'Aumento de Atributo';
      case 9:
        return 'Ataque Brutal';
      case 10:
        return 'Característica de Subclasse';
      case 11:
        return 'Raiva Relentless';
      case 12:
        return 'Aumento de Atributo';
      case 13:
        return 'Ataque Brutal (2 dados)';
      case 14:
        return 'Característica de Subclasse';
      case 15:
        return 'Raiva Persistente';
      case 16:
        return 'Aumento de Atributo';
      case 17:
        return 'Ataque Brutal (3 dados)';
      case 18:
        return 'Característica de Subclasse';
      case 19:
        return 'Aumento de Atributo';
      case 20:
        return 'Campeão Primordial';
      default:
        return '';
    }
  }

  void _showRaceDetails(Map<String, dynamic> race) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    race['name'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    race['name'],
                    style: const TextStyle(fontSize: 20),
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
                    // Descrição
                    if (race['description'] != null) ...[
                      Text(
                        'Descrição',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        race['description'],
                        style: TextStyle(color: Colors.grey[700], height: 1.4),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Informações básicas
                    if (race['size'] != null) ...[
                      _buildDetailRow('Tamanho', race['size']),
                    ],
                    if (race['speed'] != null) ...[
                      _buildDetailRow('Velocidade', race['speed']),
                    ],
                    if (race['languages'] != null) ...[
                      _buildDetailRow('Idiomas', race['languages']),
                    ],

                    // Traços Raciais (priorizar JSON estruturado)
                    if (race['traits'] != null &&
                        race['traits'].toString().isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Traços Raciais',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildRacialTraitsFromJson(race['traits']),
                    ] else if (race['traits_text'] != null &&
                        race['traits_text'].toString().isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Traços Raciais',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._buildRacialTraitsList(race['traits_text']),
                    ],

                    // Magias Raciais
                    if (race['racial_spells'] != null &&
                        race['racial_spells'].toString().isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Magias Raciais',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple.withAlpha(30),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.purple.withAlpha(50),
                          ),
                        ),
                        child: Text(
                          race['racial_spells'],
                          style: TextStyle(color: Colors.purple[700]),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedRace = race;
                    _updateOriginBonusDistribution();
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Selecionar'),
              ),
            ],
          ),
    );
  }

  List<Widget> _buildRacialTraitsList(String traitsText) {
    if (traitsText.isEmpty) return [];

    // Dividir por linhas e processar cada traço
    final lines =
        traitsText.split('\n').where((line) => line.trim().isNotEmpty).toList();

    return lines.map((line) {
      // Procurar por padrão "Nome: Descrição" (com ou sem **)
      final colonIndex = line.indexOf(':');

      if (colonIndex > 0) {
        final traitName = line.substring(0, colonIndex).trim();
        final traitDescription = line.substring(colonIndex + 1).trim();

        // Remover ** se existir
        final cleanName = traitName.replaceAll('**', '');

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                if (traitDescription.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    traitDescription,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      } else {
        // Se não tiver dois pontos, exibir como texto simples
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              line,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
        );
      }
    }).toList();
  }

  List<Widget> _buildRacialTraitsFromJson(dynamic traits) {
    try {
      final List<dynamic> list =
          traits is String
              ? List<dynamic>.from([])
              : List<dynamic>.from(traits);
      return list.map((t) {
        final name = (t['name'] ?? 'Traço').toString();
        final description = (t['description'] ?? '').toString();
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList();
    } catch (_) {
      return [const Text('Erro ao ler traços JSON. Exibindo formato texto.')];
    }
  }

  // Removida função antiga de síntese de usos limitados por nível.

  String _currentDieForFeature(Map<String, dynamic> feature, int level) {
    try {
      final bool hasDiceIncrease =
          (feature['has_dice_increase'] == true) ||
          (feature['has_dice_increase']?.toString() == 'true');
      if (!hasDiceIncrease) return '';

      String current = (feature['initial_dice'] ?? '').toString();
      final increasesRaw = feature['dice_increases'];
      final List<dynamic> increases =
          increasesRaw is List
              ? increasesRaw
              : (increasesRaw is String
                  ? []
                  : List<dynamic>.from(increasesRaw ?? []));
      for (final inc in increases) {
        final int? incLevel = _toIntSafe(inc['level']);
        final String dice = (inc['dice'] ?? '').toString();
        if (incLevel != null && level >= incLevel && dice.isNotEmpty) {
          current = dice;
        }
      }
      return current;
    } catch (_) {
      return '';
    }
  }

  int? _toIntSafe(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  List<Map<String, dynamic>> _getLimitedUseFeatures(
    Map<String, dynamic> clazz,
  ) {
    try {
      final dynamic raw = clazz['level_features'];
      final List<dynamic> features =
          raw is String
              ? []
              : (raw is List ? raw : List<dynamic>.from(raw ?? []));
      return features
          .where((f) {
            final bool hasUsage =
                (f['has_usage_limit'] == true) ||
                (f['has_usage_limit']?.toString() == 'true');
            final bool hasDice =
                (f['has_dice_increase'] == true) ||
                (f['has_dice_increase']?.toString() == 'true');
            return hasUsage || hasDice;
          })
          .map<Map<String, dynamic>>((f) => Map<String, dynamic>.from(f))
          .toList();
    } catch (_) {
      return [];
    }
  }

  String _getFeatureValueAtLevel(Map<String, dynamic> feature, int level) {
    // Se tiver dado crescente, prioriza mostrar o dado (ex: 1d6, 1d8...)
    final String die = _currentDieForFeature(feature, level);
    if (die.isNotEmpty) return die;

    // Caso contrário, tenta calcular número de usos
    final String usageType = (feature['usage_type'] ?? '').toString();
    final dynamic manualIncRaw = feature['manual_level_increases'];
    final bool hasManualIncreases =
        manualIncRaw != null &&
        (manualIncRaw is List || (manualIncRaw is! String));
    if (usageType.isEmpty &&
        feature['has_usage_limit'] != true &&
        !hasManualIncreases) {
      return '';
    }

    // Por Modificador de Atributo — sem personagem aqui; mostrar mínimo 1
    if (usageType.toLowerCase().contains('modificador')) {
      return '× mod';
    }

    // Manual por nível: aplicar aumentos por nível
    if (usageType.toLowerCase().contains('manual') || hasManualIncreases) {
      final int base = _toIntSafe(feature['usage_value']) ?? 0;
      int result = base;
      try {
        final List<dynamic> incs =
            manualIncRaw is List
                ? manualIncRaw
                : (manualIncRaw is String
                    ? []
                    : List<dynamic>.from(manualIncRaw ?? []));
        for (final inc in incs) {
          final int? incLevel = _toIntSafe(inc['level']);
          final int? incValue = _toIntSafe(inc['increase']);
          if (incLevel != null && incValue != null && level >= incLevel) {
            result = incValue;
          }
        }
      } catch (_) {}
      return result > 0 ? result.toString() : '';
    }

    // Valor fixo de uso se existir
    final int? valueInt = _toIntSafe(feature['usage_value']);
    if (valueInt != null) return valueInt.toString();

    // Sem dado e sem valor claro
    return '';
  }

  void _showBackgroundDetails(Map<String, dynamic> background) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    background['name'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    background['name'],
                    style: const TextStyle(fontSize: 20),
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
                    // Descrição
                    if (background['description'] != null) ...[
                      Text(
                        'Descrição',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        background['description'],
                        style: TextStyle(color: Colors.grey[700], height: 1.4),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // PHB 2024 - Valores de Atributo
                    if (background['ability_scores'] != null &&
                        background['ability_scores'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Valores de Atributo',
                        background['ability_scores'],
                      ),
                    ],

                    // PHB 2024 - Talento
                    if (background['feat'] != null &&
                        background['feat'].toString().isNotEmpty) ...[
                      _buildDetailRow('Talento', background['feat']),
                    ],

                    // PHB 2024 - Proficiências em Perícias
                    if (background['skill_proficiencies_2024'] != null &&
                        background['skill_proficiencies_2024']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiências em Perícias',
                        background['skill_proficiencies_2024'],
                      ),
                    ],

                    // PHB 2024 - Proficiência com Ferramentas
                    if (background['tool_proficiency'] != null &&
                        background['tool_proficiency']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiência com Ferramentas',
                        background['tool_proficiency'],
                      ),
                    ],

                    // PHB 2024 - Equipamento Escolha A
                    if (background['equipment_choice_a'] != null &&
                        background['equipment_choice_a']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Equipamento - Escolha A',
                        background['equipment_choice_a'],
                      ),
                    ],

                    // PHB 2024 - Equipamento Escolha B
                    if (background['equipment_choice_b'] != null &&
                        background['equipment_choice_b']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Equipamento - Escolha B',
                        background['equipment_choice_b'],
                      ),
                    ],

                    // PHB 2014 - Proficiências em Perícias
                    if (background['skill_proficiencies_2014'] != null &&
                        background['skill_proficiencies_2014']
                            .toString()
                            .isNotEmpty) ...[
                      _buildDetailRow(
                        'Proficiências em Perícias (PHB 2014)',
                        background['skill_proficiencies_2014'],
                      ),
                    ],

                    // PHB 2014 - Idiomas
                    if (background['languages'] != null &&
                        background['languages'].toString().isNotEmpty) ...[
                      _buildDetailRow('Idiomas', background['languages']),
                    ],

                    // PHB 2014 - Equipamento
                    if (background['equipment_2014'] != null &&
                        background['equipment_2014'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Equipamento (PHB 2014)',
                        background['equipment_2014'],
                      ),
                    ],

                    // PHB 2014 - Características
                    if (background['features_2014'] != null &&
                        background['features_2014'].toString().isNotEmpty) ...[
                      _buildDetailRow(
                        'Características (PHB 2014)',
                        background['features_2014'],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedBackground = background;
                    _updateOriginBonusDistribution();
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Selecionar'),
              ),
            ],
          ),
    );
  }

  Widget _buildSavingThrows() {
    final savingThrows = _getSavingThrows();
    if (savingThrows.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shield, color: Colors.purple[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Salvaguardas da Classe',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Estas salvaguardas são automáticas e não podem ser alteradas:',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  savingThrows.map((savingThrow) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.purple),
                      ),
                      child: Text(
                        savingThrow,
                        style: TextStyle(
                          color: Colors.purple[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundSkills() {
    final backgroundSkills = _getBackgroundSkills();
    if (backgroundSkills.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.work, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Perícias do Antecedente',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Estas perícias são automáticas e não podem ser alteradas:',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  backgroundSkills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassSkills() {
    final classSkills = _getClassSkills();
    final maxSelections = _getClassSkillCount();
    final backgroundSkills = _getBackgroundSkills();

    if (classSkills.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.green[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Perícias da Classe',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Escolha $maxSelections perícia(s) da lista abaixo:',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            if (backgroundSkills.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perícias já obtidas pela origem:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children:
                          backgroundSkills.map((skill) {
                            return Chip(
                              label: Text(
                                skill,
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: Colors.blue.withAlpha(30),
                              labelStyle: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 11,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  classSkills.map((skill) {
                    final isSelected = _selectedSkills.contains(skill);
                    final canSelect =
                        _selectedSkills.length < maxSelections || isSelected;

                    return FilterChip(
                      label: Text(skill),
                      selected: isSelected,
                      onSelected:
                          canSelect
                              ? (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedSkills.add(skill);
                                  } else {
                                    _selectedSkills.remove(skill);
                                  }
                                });
                              }
                              : null,
                      selectedColor: Colors.green.withAlpha(30),
                      checkmarkColor: Colors.green[700],
                      disabledColor: Colors.grey.withAlpha(30),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Selecionadas: ${_selectedSkills.length}/$maxSelections',
              style: TextStyle(
                color:
                    _selectedSkills.length == maxSelections
                        ? Colors.green[700]
                        : Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedSkillsSummary() {
    final savingThrows = _getSavingThrows();
    final backgroundSkills = _getBackgroundSkills();
    final allProficiencies = [
      ...savingThrows,
      ...backgroundSkills,
      ..._selectedSkills,
    ];

    if (allProficiencies.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Proficiências Obtidas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Salvaguardas
            if (savingThrows.isNotEmpty) ...[
              _buildProficiencyCategory(
                'Salvaguardas',
                savingThrows,
                Colors.purple,
              ),
              const SizedBox(height: 12),
            ],

            // Perícias do antecedente
            if (backgroundSkills.isNotEmpty) ...[
              _buildProficiencyCategory(
                'Perícias do Antecedente',
                backgroundSkills,
                Colors.blue,
              ),
              const SizedBox(height: 12),
            ],

            // Perícias escolhidas da classe
            if (_selectedSkills.isNotEmpty) ...[
              _buildProficiencyCategory(
                'Perícias da Classe',
                _selectedSkills,
                Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProficiencyCategory(
    String title,
    List<String> proficiencies,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              proficiencies.map((proficiency) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    proficiency,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  List<String> _getSavingThrows() {
    if (_selectedClass == null) return [];

    final savingThrowsText = _selectedClass!['saving_throws']?.toString() ?? '';
    debugPrint('Texto de salvaguardas da classe: "$savingThrowsText"');

    if (savingThrowsText.isEmpty) return [];

    final result =
        savingThrowsText
            .split(', ')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

    debugPrint('Salvaguardas processadas: $result');
    return result;
  }

  List<String> _getBackgroundSkills() {
    if (_selectedBackground == null) return [];

    final skillsText =
        _selectedBackground!['skill_proficiencies_2024']?.toString() ?? '';
    debugPrint('Texto de perícias do antecedente: "$skillsText"');

    if (skillsText.isEmpty) return [];

    final result =
        skillsText
            .split(', ')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

    debugPrint('Perícias do antecedente processadas: $result');
    return result;
  }

  List<String> _getClassSkills() {
    if (_selectedClass == null) return [];

    final skillsText = _selectedClass!['skill_proficiencies']?.toString() ?? '';
    if (skillsText.isEmpty) return [];

    final allClassSkills =
        skillsText
            .split(', ')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();

    // Filtrar perícias que já são dadas pela origem
    final backgroundSkills = _getBackgroundSkills();
    final availableSkills =
        allClassSkills.where((skill) {
          return !backgroundSkills.contains(skill);
        }).toList();

    debugPrint('Perícias da classe: $allClassSkills');
    debugPrint('Perícias da origem: $backgroundSkills');
    debugPrint('Perícias disponíveis para seleção: $availableSkills');

    return availableSkills;
  }

  /// Sincroniza a lista de proficiências com os objetos Skill
  void _syncProficienciesWithSkills(
    Character character,
    List<String> proficiencies,
  ) {
    // Atualizar perícias proficientes
    for (final skill in character.skills) {
      if (proficiencies.contains(skill.name)) {
        skill.isProficient = true;
        debugPrint('Marcando perícia como proficiente: ${skill.name}');
      }
    }

    // As salvaguardas proficientes serão calculadas automaticamente
    // pelo método isSavingThrowProficient() usando a lista proficiencies
  }

  int _getClassSkillCount() {
    if (_selectedClass == null) return 0;

    // Usar o valor do banco de dados se disponível
    final skillCount = _selectedClass!['skill_count'];
    if (skillCount != null) {
      return skillCount is int
          ? skillCount
          : int.tryParse(skillCount.toString()) ?? 2;
    }

    // Fallback para classes sem o campo skill_count
    final className = _selectedClass!['name']?.toString().toLowerCase() ?? '';

    switch (className) {
      case 'bárbaro':
      case 'bardo':
      case 'bruxo':
      case 'clérigo':
      case 'druida':
      case 'feiticeiro':
      case 'guerreiro':
      case 'ladino':
      case 'mago':
      case 'monge':
      case 'paladino':
      case 'patrulheiro':
        return 2;
      default:
        return 2; // Padrão
    }
  }

  // Métodos para equipamentos
  ItemType _getItemTypeFromCategory(String? category) {
    if (category == null) return ItemType.misc;

    switch (category.toLowerCase()) {
      case 'arma':
      case 'weapon':
        return ItemType.weapon;
      case 'armadura':
      case 'armor':
        return ItemType.armor;
      case 'escudo':
      case 'shield':
        return ItemType.shield;
      case 'ferramenta':
      case 'tool':
        return ItemType.tool;
      case 'consumível':
      case 'consumable':
        return ItemType.consumable;
      case 'tesouro':
      case 'treasure':
        return ItemType.treasure;
      default:
        return ItemType.misc;
    }
  }

  List<Map<String, dynamic>> _getClassEquipmentOptions() {
    if (_selectedClass == null) return [];

    final equipmentA = _selectedClass!['equipment_lado_a_items'] as List? ?? [];
    final equipmentB = _selectedClass!['equipment_lado_b_items'] as List? ?? [];

    return [
      {
        'name': 'Lado A - ${equipmentA.map((e) => e['name']).join(', ')}',
        'items': equipmentA,
        'source': 'A',
        'po': _selectedClass!['po_lado_a'] as int? ?? 0,
      },
      {
        'name': 'Lado B - ${equipmentB.map((e) => e['name']).join(', ')}',
        'items': equipmentB,
        'source': 'B',
        'po': _selectedClass!['po_lado_b'] as int? ?? 0,
      },
    ];
  }

  List<Map<String, dynamic>> _getBackgroundEquipmentOptions() {
    if (_selectedBackground == null) return [];

    final equipmentA =
        _selectedBackground!['equipment_choice_a_items'] as List? ?? [];
    final equipmentB =
        _selectedBackground!['equipment_choice_b_items'] as List? ?? [];
    final equipment2014 =
        _selectedBackground!['equipment_2014_items'] as List? ?? [];

    final options = <Map<String, dynamic>>[];

    // Sempre mostrar Escolha A se tiver itens ou PO
    final poA = _selectedBackground!['equipment_choice_a_po'] as int? ?? 0;
    if (equipmentA.isNotEmpty || poA > 0) {
      options.add({
        'name':
            equipmentA.isNotEmpty
                ? 'Escolha A - ${equipmentA.map((e) => e['name']).join(', ')}'
                : 'Escolha A - Apenas PO',
        'items': equipmentA,
        'source': 'A',
        'po': poA,
      });
    }

    // Sempre mostrar Escolha B se tiver itens ou PO
    final poB = _selectedBackground!['equipment_choice_b_po'] as int? ?? 0;
    if (equipmentB.isNotEmpty || poB > 0) {
      options.add({
        'name':
            equipmentB.isNotEmpty
                ? 'Escolha B - ${equipmentB.map((e) => e['name']).join(', ')}'
                : 'Escolha B - Apenas PO',
        'items': equipmentB,
        'source': 'B',
        'po': poB,
      });
    }

    // Sempre mostrar PHB 2014 se tiver itens ou PO
    final po2014 = _selectedBackground!['equipment_2014_po'] as int? ?? 0;
    if (equipment2014.isNotEmpty || po2014 > 0) {
      options.add({
        'name':
            equipment2014.isNotEmpty
                ? 'PHB 2014 - ${equipment2014.map((e) => e['name']).join(', ')}'
                : 'PHB 2014 - Apenas PO',
        'items': equipment2014,
        'source': '2014',
        'po': po2014,
      });
    }

    return options;
  }

  Widget _buildEquipmentSection({
    required String title,
    required List<Map<String, dynamic>> options,
    required String? selectedOption,
    required Function(String?) onSelectionChanged,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Lista de equipamentos
            ...options.map(
              (option) => _buildEquipmentOption(
                option,
                selectedOption,
                onSelectionChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentOption(
    Map<String, dynamic> option,
    String? selectedOption,
    Function(String?) onSelectionChanged,
  ) {
    return RadioListTile<String>(
      title: Text(option['name'] ?? 'Opção sem nome'),
      subtitle: Text(
        'PO: ${option['po'] ?? 0} | '
        'Itens: ${(option['items'] as List).length}',
      ),
      value: option['source'],
      groupValue: selectedOption,
      onChanged: (value) {
        onSelectionChanged(value);
      },
    );
  }

  List<Map<String, dynamic>> _getSelectedClassEquipment() {
    if (_selectedClassOption == null || _selectedClass == null) return [];

    final equipment =
        _selectedClassOption == 'A'
            ? _selectedClass!['equipment_lado_a_items'] as List? ?? []
            : _selectedClass!['equipment_lado_b_items'] as List? ?? [];

    debugPrint('Opção da classe selecionada: $_selectedClassOption');
    debugPrint('Equipamentos encontrados: ${equipment.length}');
    debugPrint('Equipamentos: $equipment');

    return equipment.cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> _getSelectedBackgroundEquipment() {
    if (_selectedBackgroundOption == null || _selectedBackground == null) {
      return [];
    }

    List<dynamic> equipment = [];
    if (_selectedBackgroundOption == 'A') {
      equipment =
          _selectedBackground!['equipment_choice_a_items'] as List? ?? [];
    } else if (_selectedBackgroundOption == 'B') {
      equipment =
          _selectedBackground!['equipment_choice_b_items'] as List? ?? [];
    } else if (_selectedBackgroundOption == '2014') {
      equipment = _selectedBackground!['equipment_2014_items'] as List? ?? [];
    }

    debugPrint('Opção do antecedente selecionada: $_selectedBackgroundOption');
    debugPrint('Equipamentos encontrados: ${equipment.length}');
    debugPrint('Equipamentos: $equipment');

    return equipment.cast<Map<String, dynamic>>();
  }

  // --- Escolhas de Equipamento ---
  Widget _buildEquipmentChoicesSection() {
    final classChoices = _getClassEquipmentChoices();
    final backgroundChoices = _getBackgroundEquipmentChoices();

    // Só mostrar se o usuário selecionou a opção A da classe e/ou antecedente
    // E se eles tiverem escolhas de equipamento disponíveis
    final hasClassChoices =
        _selectedClassOption == 'A' && classChoices.isNotEmpty;
    final hasBackgroundChoices =
        _selectedBackgroundOption == 'A' && backgroundChoices.isNotEmpty;

    if (!hasClassChoices && !hasBackgroundChoices) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escolhas de Equipamento',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecione uma opção para cada escolha disponível.',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),

        // Escolhas da Classe
        if (hasClassChoices) ...[
          _buildEquipmentChoicesList(
            'Escolhas da Classe',
            classChoices,
            'class',
          ),
          const SizedBox(height: 16),
        ],

        // Escolhas do Antecedente
        if (hasBackgroundChoices) ...[
          _buildEquipmentChoicesList(
            'Escolhas do Antecedente',
            backgroundChoices,
            'background',
          ),
        ],
      ],
    );
  }

  Widget _buildEquipmentChoicesList(
    String title,
    List<Map<String, dynamic>> choices,
    String source,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade700,
              ),
            ),
            const SizedBox(height: 12),
            ...choices.map(
              (choice) => _buildEquipmentChoiceOption(choice, source),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipmentChoiceOption(
    Map<String, dynamic> choice,
    String source,
  ) {
    final choiceKey = '${source}_${choice['description']}';
    final selectedOption = _selectedEquipmentChoices[choiceKey];

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              choice['description'] ?? 'Escolha',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 8),
            if (choice['options'] != null &&
                (choice['options'] as List).isNotEmpty) ...[
              ...(choice['options'] as List).map((option) {
                return RadioListTile<Map<String, dynamic>>(
                  title: Text(option['name'] ?? 'Opção sem nome'),
                  subtitle:
                      option['cost'] != null
                          ? Text('Custo: ${option['cost']}')
                          : null,
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedEquipmentChoices[choiceKey] = value!;
                    });
                  },
                  dense: true,
                );
              }),
            ] else ...[
              const Text(
                'Nenhuma opção disponível',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getClassEquipmentChoices() {
    if (_selectedClass == null) return [];

    final choices = _selectedClass!['equipment_choices'] as List? ?? [];
    return choices.cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> _getBackgroundEquipmentChoices() {
    if (_selectedBackground == null) return [];

    final choices = _selectedBackground!['equipment_choices'] as List? ?? [];
    return choices.cast<Map<String, dynamic>>();
  }

  int _calculateTotalPO() {
    int total = 0;

    // PO da classe
    if (_selectedClassOption != null && _selectedClass != null) {
      if (_selectedClassOption == 'A') {
        total += _selectedClass!['po_lado_a'] as int? ?? 0;
      } else if (_selectedClassOption == 'B') {
        total += _selectedClass!['po_lado_b'] as int? ?? 0;
      }
    }

    // PO do antecedente
    if (_selectedBackgroundOption != null && _selectedBackground != null) {
      if (_selectedBackgroundOption == 'A') {
        total += _selectedBackground!['equipment_choice_a_po'] as int? ?? 0;
      } else if (_selectedBackgroundOption == 'B') {
        total += _selectedBackground!['equipment_choice_b_po'] as int? ?? 0;
      } else if (_selectedBackgroundOption == '2014') {
        total += _selectedBackground!['equipment_2014_po'] as int? ?? 0;
      }
    }

    return total;
  }

  int _calculateTotalItems() {
    int total = 0;

    // Itens da classe
    final classEquipment = _getSelectedClassEquipment();
    for (final item in classEquipment) {
      total += item['quantity'] as int? ?? 1;
    }

    // Itens do antecedente
    final backgroundEquipment = _getSelectedBackgroundEquipment();
    for (final item in backgroundEquipment) {
      total += item['quantity'] as int? ?? 1;
    }

    return total;
  }
}
