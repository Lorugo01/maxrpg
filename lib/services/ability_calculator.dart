import 'package:flutter/foundation.dart';
import '/models/character.dart';

/// Classe para cálculo automático de habilidades com limites de uso e dados que aumentam
class AbilityCalculator {
  /// Calcula uma habilidade baseada nos dados do traço e características do personagem
  static AbilityCalculation calculateAbility(
    Map<String, dynamic> traitData,
    Character character,
  ) {
    final name = traitData['name'] ?? '';
    final description = traitData['description'] ?? '';

    int currentUses = 0;
    String currentDie = '';
    String recoveryType = '';

    // Debug: log dos dados recebidos
    debugPrint('=== ABILITY CALCULATOR DEBUG ===');
    debugPrint('Habilidade: $name');
    debugPrint('has_usage_limit: ${traitData['has_usage_limit']}');
    debugPrint('usage_type: ${traitData['usage_type']}');
    debugPrint('usage_value: ${traitData['usage_value']}');
    debugPrint('usage_attribute: ${traitData['usage_attribute']}');

    // Calcular limite de usos
    if (traitData['has_usage_limit'] == true) {
      currentUses = _calculateUsageLimit(traitData, character);
      recoveryType = traitData['usage_recovery'] ?? '';
      debugPrint('currentUses calculado: $currentUses');
    }

    // Calcular dado atual
    if (traitData['has_dice_increase'] == true) {
      currentDie = _calculateCurrentDie(traitData, character.level);
      debugPrint('currentDie calculado: $currentDie');
    }

    // Verificar funcionalidades adicionais
    final hasAdditionalFeatures = traitData['has_additional_features'] == true;
    final additionalFeatureName =
        traitData['additional_feature_name'] as String?;
    final additionalFeatureDescription =
        traitData['additional_feature_description'] as String?;

    return AbilityCalculation(
      name: name,
      description: description,
      type: _determineType(traitData),
      calculationData: traitData,
      currentUses: currentUses,
      currentDie: currentDie,
      recoveryType: recoveryType,
      hasAdditionalFeatures: hasAdditionalFeatures,
      additionalFeatureName: additionalFeatureName,
      additionalFeatureDescription: additionalFeatureDescription,
    );
  }

  /// Calcula o limite de usos baseado no tipo e nível do personagem
  static int _calculateUsageLimit(
    Map<String, dynamic> traitData,
    Character character,
  ) {
    final usageType = traitData['usage_type'];
    final usageValue = traitData['usage_value'];

    switch (usageType) {
      case 'Por Nível':
        return ((usageValue ?? 1) * character.level).toInt();

      case 'Manual por Nível':
        final manualIncreases =
            traitData['manual_level_increases'] as List? ?? [];

        // Para "Manual por Nível", encontrar o valor mais alto para o nível atual
        int highestValue = (usageValue ?? 0).toInt();

        for (final increase in manualIncreases) {
          if (increase['level'] <= character.level) {
            final increaseValue = increase['increase'];
            if (increaseValue is int) {
              highestValue = increaseValue; // Substituir, não somar
            } else if (increaseValue is num) {
              highestValue = increaseValue.toInt(); // Substituir, não somar
            }
          }
        }

        debugPrint(
          'Manual por Nível - usageValue: $usageValue, highestValue: $highestValue',
        );
        return highestValue;

      case 'Por Modificador de Atributo':
        final attribute = traitData['usage_attribute'];
        final multiplier = usageValue ?? 1;
        final modifier = _getAttributeModifier(character, attribute);
        debugPrint(
          'Por Modificador - attribute: $attribute, multiplier: $multiplier, modifier: $modifier',
        );
        // Para modificador de atributo, garantir mínimo de 1 uso
        final result =
            (modifier * multiplier).clamp(1, double.infinity).toInt();
        debugPrint('Por Modificador - result: $result');
        return result;

      case 'Por Proficiência':
        final multiplier = usageValue ?? 1;
        final proficiencyBonus = 2 + ((character.level - 1) ~/ 4);
        return (proficiencyBonus * multiplier).toInt();

      case 'Fixo':
        return usageValue ?? 0;

      case 'Por Longo Descanso':
      case 'Por Curto Descanso':
        return usageValue ?? 0;

      default:
        return 0;
    }
  }

  /// Calcula o dado atual baseado no nível do personagem
  static String _calculateCurrentDie(
    Map<String, dynamic> traitData,
    int characterLevel,
  ) {
    final initialDice = traitData['initial_dice'] ?? '1d6';
    final diceIncreases = traitData['dice_increases'] as List? ?? [];

    String currentDie = initialDice;

    for (final increase in diceIncreases) {
      if (increase['level'] <= characterLevel) {
        currentDie = increase['dice'] ?? currentDie;
      }
    }

    return currentDie;
  }

  /// Obtém o modificador de atributo do personagem
  static int _getAttributeModifier(Character character, String? attribute) {
    if (attribute == null) return 0;

    // Usar o método getAbilityModifier do Character
    final modifier = character.getAbilityModifier(attribute);
    debugPrint(
      '_getAttributeModifier - attribute: $attribute, modifier: $modifier',
    );
    return modifier;
  }

  /// Determina o tipo da habilidade
  static AbilityType _determineType(Map<String, dynamic> traitData) {
    final hasUsageLimit = traitData['has_usage_limit'] == true;
    final hasDiceIncrease = traitData['has_dice_increase'] == true;

    if (hasUsageLimit && hasDiceIncrease) return AbilityType.both;
    if (hasUsageLimit) return AbilityType.usageLimit;
    if (hasDiceIncrease) return AbilityType.diceIncrease;
    return AbilityType.none;
  }
}

/// Resultado do cálculo de uma habilidade
class AbilityCalculation {
  final String name;
  final String description;
  final AbilityType type;
  final Map<String, dynamic> calculationData;

  // Resultado calculado
  final int currentUses;
  final String currentDie;
  final String recoveryType;

  // Funcionalidades adicionais
  final bool hasAdditionalFeatures;
  final String? additionalFeatureName;
  final String? additionalFeatureDescription;

  AbilityCalculation({
    required this.name,
    required this.description,
    required this.type,
    required this.calculationData,
    this.currentUses = 0,
    this.currentDie = '',
    this.recoveryType = '',
    this.hasAdditionalFeatures = false,
    this.additionalFeatureName,
    this.additionalFeatureDescription,
  });
}

/// Tipos de habilidades
enum AbilityType { usageLimit, diceIncrease, both, none }
