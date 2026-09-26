import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../data/repositories/login_repository.dart';

class AuthController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  LoginRepository get _repository => ref.read(loginRepositoryProvider);

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.signIn(email: email, password: password);

      if (user.role == UserRole.admin) {
        state = AsyncValue.error(const AuthFailure(AppStrings.adminUseWebPanel), StackTrace.current);
        return false;
      }

      await ref.read(authSessionControllerProvider.notifier).onLoginSuccess(user);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final authControllerProvider =
NotifierProvider<AuthController, AsyncValue<void>>(AuthController.new);