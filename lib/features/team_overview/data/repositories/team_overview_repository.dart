import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final teamOverviewRepositoryProvider = Provider<TeamOverviewRepository>((ref) {
  return TeamOverviewRepository(ref.watch(apiClientProvider));
});

class TeamOverviewRepository {
  final ApiClient _apiClient;
  TeamOverviewRepository(this._apiClient);


}
