import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'login_screen.dart';
import '../main/main_tab_screen.dart';
import 'create_user_profile_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final hasProfile = ref.watch(hasUserProfileProvider);

    return authState.when(
      data: (authState) {
        // Se há uma sessão ativa
        if (authState.session != null) {
          return hasProfile.when(
            data: (hasProfile) {
              if (hasProfile) {
                // Usuário tem perfil, mostrar tela principal
                return const MainTabScreen();
              } else {
                // Usuário não tem perfil, mostrar tela de criação
                return const CreateUserProfileScreen();
              }
            },
            loading:
                () => const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
            error: (error, stackTrace) {
              // Em caso de erro ao verificar perfil, mostrar tela de criação
              return const CreateUserProfileScreen();
            },
          );
        }
        // Caso contrário, mostrar a tela de login
        return const LoginScreen();
      },
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) {
        // Em caso de erro, mostrar tela de login
        return const LoginScreen();
      },
    );
  }
}
