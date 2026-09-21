import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final teamMemberRepositoryProvider = Provider<TeamMemberRepository>((ref) {
  return TeamMemberRepository(ref.watch(apiClientProvider));
});

class TeamMemberRepository {
  final ApiClient _apiClient;
  TeamMemberRepository(this._apiClient);


}
