import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';

final outletsCustomersRepositoryProvider = Provider<OutletsCustomersRepository>((ref) {
  return OutletsCustomersRepository(ref.watch(firebaseClientProvider));
});

class OutletsCustomersRepository {
  final FirebaseClient _client;
  OutletsCustomersRepository(this._client);

  Future<List<OutletModel>> getAssignedOutlets(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.outlets,
      filters: [FirestoreFilter('assignedSalesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(OutletModel.fromMap).toList();
  }

  /// The "freedom feature" — lets a salesman or team head add a brand
  /// new sales point/shop directly from the app, instead of waiting on
  /// the Admin Web Panel. Newly added outlets default to `newCustomer`
  /// status and are assigned to whoever created them.
  Future<OutletModel> addOutlet({
    required String name,
    required String ownerName,
    required String phone,
    required String address,
    required String areaRoute,
    required String assignedSalesmanEmail,
    required String teamId,
  }) async {
    final data = {
      'name': name,
      'ownerName': ownerName,
      'phone': phone,
      'address': address,
      'areaRoute': areaRoute,
      'status': 'newCustomer',
      'assignedSalesmanEmail': assignedSalesmanEmail,
      'teamId': teamId,
      'lastVisit': null,
      'lastOrderAmount': 0,
    };
    final id = await _client.addDocument(FirestoreCollections.outlets, data);
    return OutletModel.fromMap({...data, 'id': id});
  }

  Future<List<SaleModel>> getSalesForOutlet(String outletId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('outletId', FirestoreOp.isEqualTo, outletId)],
    );
    final sales = SaleModel.completedFrom(docs)..sort((a, b) => b.date.compareTo(a.date));
    return sales;
  }
}
