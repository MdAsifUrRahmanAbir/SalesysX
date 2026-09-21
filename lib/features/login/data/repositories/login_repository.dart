import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salesysx/core/network/api_client.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(ref.watch(apiClientProvider));
});

class LoginRepository {
  final ApiClient _apiClient;
  LoginRepository(this._apiClient);
}
