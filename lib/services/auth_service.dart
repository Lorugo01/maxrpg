import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';
import '../models/user_type.dart';

class AuthService {
  static SupabaseClient get client => SupabaseService.client;

  // Estado atual do usuário
  static User? get currentUser => client.auth.currentUser;

  // Stream de mudanças de autenticação
  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  // Verificar se usuário está logado
  static bool get isLoggedIn => currentUser != null;

  // Registrar novo usuário
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
      );

      if (response.user != null) {}

      return response;
    } catch (e) {
      debugPrint('Erro ao registrar usuário: $e');
      rethrow;
    }
  }

  // Fazer login
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {}

      return response;
    } catch (e) {
      debugPrint('AuthService: Erro ao fazer login: $e');
      rethrow;
    }
  }

  // Fazer logout
  static Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      debugPrint('Erro ao fazer logout: $e');
      rethrow;
    }
  }

  // Redefinir senha
  static Future<void> resetPassword(String email) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } catch (e) {
      debugPrint('Erro ao enviar email de redefinição: $e');
      rethrow;
    }
  }

  // Atualizar perfil do usuário
  static Future<UserResponse> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};

      if (displayName != null) {
        updates['display_name'] = displayName;
      }

      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      final response = await client.auth.updateUser(
        UserAttributes(data: updates),
      );

      return response;
    } catch (e) {
      debugPrint('Erro ao atualizar perfil: $e');
      rethrow;
    }
  }

  // Verificar se email está confirmado
  static bool get isEmailConfirmed => currentUser?.emailConfirmedAt != null;

  // Obter nome de exibição do usuário
  static String get displayName {
    final user = currentUser;
    if (user == null) return '';

    // Tentar obter do metadata primeiro
    final metadataName = user.userMetadata?['display_name'] as String?;
    if (metadataName != null && metadataName.isNotEmpty) {
      return metadataName;
    }

    // Fallback para o email
    return user.email ?? '';
  }

  // Obter email do usuário
  static String get userEmail => currentUser?.email ?? '';

  // Obter ID do usuário
  static String get userId => currentUser?.id ?? '';

  // Obter tipo do usuário atual
  static Future<UserType> getUserType() async {
    final user = currentUser;
    if (user == null) return UserType.simple;

    try {
      // Buscar tipo de usuário da tabela user_profiles
      final profile =
          await client
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
  }

  // Verificar se usuário é administrador
  static Future<bool> isAdmin() async => (await getUserType()).isAdmin;

  // Verificar se usuário é simples
  static Future<bool> isSimple() async => (await getUserType()).isSimple;

  // Atualizar tipo do usuário (apenas para admins)
  static Future<void> updateUserType(UserType userType) async {
    try {
      await client.auth.updateUser(
        UserAttributes(data: {'user_type': userType.value}),
      );
    } catch (e) {
      debugPrint('Erro ao atualizar tipo de usuário: $e');
      rethrow;
    }
  }

  // Registrar usuário (sempre como simple)
  static Future<AuthResponse> signUpWithType({
    required String email,
    required String password,
    String? displayName,
    UserType userType = UserType.simple, // Sempre simple por padrão
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {'display_name': displayName}, // Removido user_type do metadata
      );

      if (response.user != null) {
        // Aguardar um pouco para o trigger processar
        await Future.delayed(const Duration(seconds: 1));
        // Verificar se o perfil foi criado, se não, criar manualmente (sempre como simple)
        await _ensureUserProfile(
          response.user!.id,
          displayName ?? email,
          UserType.simple, // Sempre criar como simple
        );
      }

      return response;
    } catch (e) {
      debugPrint('Erro ao registrar usuário: $e');
      rethrow;
    }
  }

  // Garantir que o usuário tenha um perfil
  static Future<void> _ensureUserProfile(
    String userId,
    String displayName,
    UserType userType,
  ) async {
    try {
      // Verificar se o perfil já existe
      final existingProfile =
          await client
              .from('user_profiles')
              .select('id, user_type')
              .eq('user_id', userId)
              .maybeSingle();

      if (existingProfile == null) {
        // Criar perfil manualmente se não existir
        await client.from('user_profiles').insert({
          'user_id': userId,
          'display_name': displayName,
          'user_type': userType.value,
        });
      } else {
        // Se o perfil existe mas o tipo está errado, atualizar
        final currentType = existingProfile['user_type'] as String?;
        if (currentType != userType.value) {
          await client
              .from('user_profiles')
              .update({'user_type': userType.value})
              .eq('user_id', userId);
        }
      }
    } catch (e) {
      debugPrint('Erro ao criar/atualizar perfil de usuário: $e');
    }
  }

  // Criar perfil para usuário existente (método público para uso manual)
  static Future<void> createUserProfile({
    required String userId,
    required String displayName,
    UserType userType = UserType.simple,
  }) async {
    await _ensureUserProfile(userId, displayName, userType);
  }

  // Sincronizar tipo de usuário baseado no metadata do auth.users
  static Future<void> syncUserTypeFromMetadata() async {
    try {
      final user = currentUser;
      if (user == null) return;

      final metadataType = user.userMetadata?['user_type'] as String?;
      if (metadataType != null) {
        final userType = UserType.fromString(metadataType);
        await _ensureUserProfile(user.id, displayName, userType);
      }
    } catch (e) {
      debugPrint('Erro ao sincronizar tipo de usuário: $e');
    }
  }
}
