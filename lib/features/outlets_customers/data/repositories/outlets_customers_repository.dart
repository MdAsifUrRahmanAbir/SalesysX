import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final outletsCustomersRepositoryProvider = Provider<OutletsCustomersRepository>((ref) {
  return OutletsCustomersRepository(ref.watch(apiClientProvider));
});

class OutletsCustomersRepository {
  final ApiClient _apiClient;
  OutletsCustomersRepository(this._apiClient);


}
