import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';

final newSaleEntryRepositoryProvider = Provider<NewSaleEntryRepository>((ref) {
  return NewSaleEntryRepository(ref.watch(apiClientProvider));
});

class NewSaleEntryRepository {
  final ApiClient _apiClient;
  NewSaleEntryRepository(this._apiClient);


}
