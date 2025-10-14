import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../models/user_type.dart';
import 'character_provider.dart';

// Provider para o estado de autenticação
final authStateProvider = StreamProvider<AuthState>((ref) {
  return AuthService.authStateChanges;
});

// Provider para o usuário atual
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (authState) => authState.session?.user,
    loading: () => null,
    error: (_, __) => null,
  );
});

// Provider para verificar se está logado
final isLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

// Provider para o nome de exibição
final displayNameProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return '';

  // Tentar obter do metadata primeiro
  final metadataName = user.userMetadata?['display_name'] as String?;
  if (metadataName != null && metadataName.isNotEmpty) {
    return metadataName;
  }

  // Fallback para o email
  return user.email ?? '';
});

// Provider para o email do usuário
final userEmailProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.email ?? '';
});

// Provider para o ID do usuário
final userIdProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.id ?? '';
});

// Provider para verificar se o usuário tem perfil
final hasUserProfileProvider = FutureProvider<bool>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return false;

  try {
    final profile =
        await AuthService.client
            .from('user_profiles')
            .select('id')
            .eq('user_id', user.id)
            .maybeSingle();

    return profile != null;
  } catch (e) {
    return false;
  }
});

// Provider para verificar se email está confirmado
final isEmailConfirmedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.emailConfirmedAt != null;
});

// Notifier para operações de autenticação
class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier() : super(const AsyncValue.data(null));

  // Registrar novo usuário (sempre como simple)
  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();

    try {
      await AuthService.signUpWithType(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Fazer login
  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();

    try {
      await AuthService.signIn(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Fazer logout
  Future<void> signOut() async {
    state = const AsyncValue.loading();

    try {
      await AuthService.signOut();
      // Resetar instância do provider de personagens
      CharactersNotifier.resetInstance();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Redefinir senha
  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();

    try {
      await AuthService.resetPassword(email);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Atualizar perfil
  Future<void> updateProfile({String? displayName, String? avatarUrl}) async {
    state = const AsyncValue.loading();

    try {
      await AuthService.updateProfile(
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider para o AuthNotifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
      return AuthNotifier();
    });

// Provider para o tipo de usuário atual
final userTypeProvider = FutureProvider<UserType>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return UserType.simple;

  try {
    // Buscar tipo de usuário da tabela user_profiles
    final profile =
        await AuthService.client
            .from('user_profiles')
            .select('user_type')
            .eq('user_id', user.id)
            .maybeSingle();

    if (profile != null && profile['user_type'] != null) {
      return UserType.fromString(profile['user_type']);
    }

    // Fallback para userMetadata se não encontrar na tabela
    final userTypeString = user.userMetadata?['user_type'] as String?;
    if (userTypeString != null) {
      return UserType.fromString(userTypeString);
    }

    return UserType.simple;
  } catch (e) {
    debugPrint('Erro ao buscar tipo de usuário: $e');
    return UserType.simple;
  }
});

// Provider para verificar se é administrador
final isAdminProvider = Provider<bool>((ref) {
  final userTypeAsync = ref.watch(userTypeProvider);
  return userTypeAsync.when(
    data: (userType) => userType.isAdmin,
    loading: () => false,
    error: (_, __) => false,
  );
});

// Provider para verificar se é usuário simples
final isSimpleProvider = Provider<bool>((ref) {
  final userTypeAsync = ref.watch(userTypeProvider);
  return userTypeAsync.when(
    data: (userType) => userType.isSimple,
    loading: () => true,
    error: (_, __) => true,
  );
});
