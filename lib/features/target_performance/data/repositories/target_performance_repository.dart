import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final targetPerformanceRepositoryProvider = Provider<TargetPerformanceRepository>((ref) {
  return TargetPerformanceRepository(ref.watch(apiClientProvider));
});

class TargetPerformanceRepository {
  final ApiClient _apiClient;
  TargetPerformanceRepository(this._apiClient);


}
