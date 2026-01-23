import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_session.dart';
import 'repository_providers.dart';

class AuthNotifier extends AsyncNotifier<UserSession?> {
  @override
  Future<UserSession?> build() async {
    final repository = ref.read(authRepositoryProvider);
    return await repository.getSession();
  }

  Future<void> login(String userId, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return await repository.login(userId, password);
    });
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AsyncValue.data(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserSession?>(
  AuthNotifier.new,
);
