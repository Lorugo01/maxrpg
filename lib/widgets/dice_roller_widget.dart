import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> with TickerProviderStateMixin {
  String _lastResult = "Role um dado!";
  int _lastRoll = 0;
  int _lastDiceType = 0;
  final _random = Random();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isRolling = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _rollDice(int sides) async {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
      _lastResult = "Rolando...";
    });

    // Animação de rolagem
    _animationController.forward();

    // Simular tempo de rolagem
    await Future.delayed(const Duration(milliseconds: 600));

    int result = 1 + _random.nextInt(sides);

    setState(() {
      _lastRoll = result;
      _lastDiceType = sides;
      _lastResult = "d$sides: $result";
      _isRolling = false;
    });

    _animationController.reverse();
  }

  void _rollMultipleDice(int sides, int quantity) async {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
      _lastResult = "Rolando...";
    });

    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 600));

    List<int> rolls = [];
    int total = 0;

    for (int i = 0; i < quantity; i++) {
      int roll = 1 + _random.nextInt(sides);
      rolls.add(roll);
      total += roll;
    }

    setState(() {
      _lastRoll = total;
      _lastDiceType = sides;
      _lastResult = "${quantity}d$sides: ${rolls.join(' + ')} = $total";
      _isRolling = false;
    });

    _animationController.reverse();
  }

  void _rollWithModifier(int sides, int modifier) async {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
      _lastResult = "Rolando...";
    });

    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 600));

    int baseRoll = 1 + _random.nextInt(sides);
    int total = baseRoll + modifier;
    String modifierText = modifier >= 0 ? '+$modifier' : '$modifier';

    setState(() {
      _lastRoll = total;
      _lastDiceType = sides;
      _lastResult = "d$sides$modifierText: $baseRoll$modifierText = $total";
      _isRolling = false;
    });

    _animationController.reverse();
  }

  Color _getResultColor() {
    if (_lastRoll == 0 || _lastDiceType == 0) return Colors.grey;

    // Crítico (valor máximo)
    if (_lastRoll >= _lastDiceType) return Colors.green;

    // Falha crítica (valor mínimo em d20)
    if (_lastDiceType == 20 && _lastRoll == 1) return Colors.red;

    // Alto
    if (_lastRoll > (_lastDiceType * 0.75)) return Colors.blue;

    // Baixo
    if (_lastRoll <= (_lastDiceType * 0.25)) return Colors.orange;

    return Colors.grey.shade700;
  }

  Widget _buildDiceButton(int sides, {String? label, IconData? icon}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: _isRolling ? null : () => _rollDice(sides),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon, size: 20),
              Text(
                label ?? 'd$sides',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Rolador de Dados',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),

              // Resultado
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getResultColor().withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getResultColor(), width: 2),
                      ),
                      child: Text(
                        _lastResult,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: _getResultColor(),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Dados básicos
              Text(
                'Dados Básicos',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildDiceButton(4, icon: Icons.change_history),
                  _buildDiceButton(6, icon: Icons.crop_square),
                  _buildDiceButton(8, icon: Icons.stop),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildDiceButton(10, icon: Icons.lens),
                  _buildDiceButton(12, icon: Icons.hexagon_outlined),
                  _buildDiceButton(20, icon: Icons.casino, label: 'd20'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildDiceButton(100, label: 'd100'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        onPressed:
                            _isRolling ? null : () => _rollMultipleDice(6, 4),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.amber.shade100,
                          foregroundColor: Colors.amber.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.casino, size: 20),
                            Text(
                              '4d6',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),

              const SizedBox(height: 20),

              // Rolagens rápidas para D&D
              Text(
                'Rolagens Rápidas',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickRollButton(
                    'Ataque',
                    () => _rollWithModifier(20, 5),
                  ),
                  _buildQuickRollButton('Dano', () => _rollMultipleDice(8, 1)),
                  _buildQuickRollButton(
                    'Teste',
                    () => _rollWithModifier(20, 3),
                  ),
                  _buildQuickRollButton(
                    'Iniciativa',
                    () => _rollWithModifier(20, 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickRollButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _isRolling ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(20),
        foregroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
