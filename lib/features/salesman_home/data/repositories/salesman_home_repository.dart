import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final salesmanHomeRepositoryProvider = Provider<SalesmanHomeRepository>((ref) {
  return SalesmanHomeRepository(ref.watch(apiClientProvider));
});

class SalesmanHomeRepository {
  final ApiClient _apiClient;
  SalesmanHomeRepository(this._apiClient);


}
