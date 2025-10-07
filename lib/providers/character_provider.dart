import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/character.dart';
import '../services/character_service_supabase.dart';
import 'package:flutter/material.dart';

// Provider para lista de personagens
final charactersProvider =
    StateNotifierProvider<CharactersNotifier, List<Character>>((ref) {
      return CharactersNotifier();
    });

class CharactersNotifier extends StateNotifier<List<Character>> {
  CharactersNotifier() : super([]) {
    loadCharacters();
  }

  // Carregar todos os personagens
  Future<void> loadCharacters() async {
    try {
      debugPrint('CharacterProvider: Carregando personagens...');
      final characters = await CharacterService.loadCharacters();
      debugPrint(
        'CharacterProvider: ${characters.length} personagens carregados',
      );
      state = characters;
    } catch (e) {
      debugPrint('CharacterProvider: Erro ao carregar personagens: $e');
      // Em caso de erro, manter lista vazia
      state = [];
    }
  }

  // Adicionar novo personagem
  Future<void> addCharacter(Character character) async {
    try {
      debugPrint(
        'CharacterProvider: Adicionando personagem: ${character.name}',
      );
      final id = await CharacterService.saveCharacter(character);
      character.id = id;
      // Persistir perícias e inventário
      await CharacterService.saveSkills(id, character.skills);
      await CharacterService.saveItems(id, character.inventory);
      debugPrint('CharacterProvider: Personagem salvo com ID: $id');
      state = [...state, character];
      debugPrint('CharacterProvider: Personagem adicionado à lista local');
    } catch (e) {
      debugPrint('CharacterProvider: Erro ao salvar personagem: $e');
      throw Exception('Erro ao salvar personagem: $e');
    }
  }

  // Atualizar personagem existente
  Future<void> updateCharacter(Character character) async {
    try {
      debugPrint(
        'CharacterProvider: Atualizando personagem: ${character.name} (ID: ${character.id})',
      );
      await CharacterService.saveCharacter(character);
      // Atualizar perícias e inventário
      await CharacterService.saveSkills(character.id, character.skills);
      await CharacterService.saveItems(character.id, character.inventory);
      state = [
        for (final c in state)
          if (c.id == character.id) character else c,
      ];
      debugPrint('CharacterProvider: Personagem atualizado na lista local');
    } catch (e) {
      debugPrint('CharacterProvider: Erro ao atualizar personagem: $e');
      throw Exception('Erro ao atualizar personagem: $e');
    }
  }

  // Remover personagem
  Future<void> removeCharacter(String id) async {
    try {
      debugPrint('CharacterProvider: Removendo personagem com ID: $id');
      await CharacterService.removeCharacter(id);
      state = state.where((character) => character.id != id).toList();
      debugPrint('CharacterProvider: Personagem removido da lista local');
    } catch (e) {
      debugPrint('CharacterProvider: Erro ao remover personagem: $e');
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
}
