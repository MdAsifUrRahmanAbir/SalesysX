import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salesysx/core/network/api_client.dart';

final helpSupportRepositoryProvider = Provider<HelpSupportRepository>((ref) {
  return HelpSupportRepository(ref.watch(apiClientProvider));
});

class HelpSupportRepository {
  final ApiClient _apiClient;
  HelpSupportRepository(this._apiClient);
}
