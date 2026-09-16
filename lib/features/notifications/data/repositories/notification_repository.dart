import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salesysx/core/network/api_client.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
});

class NotificationRepository {
  final ApiClient _apiClient;
  NotificationRepository(this._apiClient);
}
