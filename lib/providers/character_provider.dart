import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/character.dart';
import '../services/character_service_supabase.dart';

// Instância singleton do notifier
CharactersNotifier? _charactersNotifierInstance;

// Provider para lista de personagens
final charactersProvider =
    StateNotifierProvider<CharactersNotifier, List<Character>>((ref) {
      // Retornar instância existente ou criar nova se não existir
      _charactersNotifierInstance ??= CharactersNotifier();
      return _charactersNotifierInstance!;
    });

class CharactersNotifier extends StateNotifier<List<Character>> {
  CharactersNotifier() : super([]) {
    loadCharacters();
  }

  // Carregar todos os personagens
  Future<void> loadCharacters() async {
    try {
      final characters = await CharacterService.loadCharacters();

      // Remover duplicatas baseado no ID
      final uniqueCharacters = <String, Character>{};
      for (final character in characters) {
        if (character.id.isNotEmpty) {
          uniqueCharacters[character.id] = character;
        }
      }

      state = uniqueCharacters.values.toList();
    } catch (e) {
      // Em caso de erro, manter lista vazia
      state = [];
    }
  }

  // Adicionar novo personagem
  Future<void> addCharacter(Character character) async {
    try {
      final id = await CharacterService.saveCharacter(character);
      character.id = id;
      // Persistir perícias e inventário
      await CharacterService.saveSkills(id, character.skills);
      await CharacterService.saveItems(id, character.inventory);

      // Verificar se o personagem já existe na lista antes de adicionar
      if (!state.any((c) => c.id == character.id)) {
        state = [...state, character];
      }
    } catch (e) {
      throw Exception('Erro ao salvar personagem: $e');
    }
  }

  // Atualizar personagem existente
  Future<void> updateCharacter(Character character) async {
    try {
      await CharacterService.saveCharacter(character);
      // Atualizar perícias e inventário
      await CharacterService.saveSkills(character.id, character.skills);
      await CharacterService.saveItems(character.id, character.inventory);
      state = [
        for (final c in state)
          if (c.id == character.id) character else c,
      ];
    } catch (e) {
      throw Exception('Erro ao atualizar personagem: $e');
    }
  }

  // Remover personagem
  Future<void> removeCharacter(String id) async {
    try {
      await CharacterService.removeCharacter(id);
      state = state.where((character) => character.id != id).toList();
    } catch (e) {
      throw Exception('Erro ao remover personagem: $e');
    }
  }

  // Verificar se nome já existe
  bool nameExists(String name, {String? excludeId}) {
    return state.any(
      (character) =>
          character.name.toLowerCase() == name.toLowerCase() &&
          character.id != excludeId,
    );
  }

  // Resetar instância (útil para logout)
  static void resetInstance() {
    _charactersNotifierInstance = null;
  }
}
