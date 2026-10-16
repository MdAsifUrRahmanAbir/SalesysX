import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';
import '../models/product_model.dart';

final newSaleEntryRepositoryProvider = Provider<NewSaleEntryRepository>((ref) {
  return NewSaleEntryRepository(ref.watch(firebaseClientProvider));
});

class NewSaleEntryRepository {
  final FirebaseClient _client;
  NewSaleEntryRepository(this._client);

  Future<List<OutletModel>> getAssignedOutlets(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.outlets,
      filters: [FirestoreFilter('assignedSalesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(OutletModel.fromMap).toList();
  }

  Future<List<ProductModel>> getActiveProducts() async {
    final docs = await _client.getCollection(
      FirestoreCollections.products,
      filters: [FirestoreFilter('active', FirestoreOp.isEqualTo, true)],
    );
    return docs.map(ProductModel.fromMap).where((p) => p.active).toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  /// All of this salesman's sales — filtered to today client-side, same
  /// convention as `salesman_home_repository`.
  Future<List<SaleModel>> getSalesForSalesman(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('salesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return SaleModel.completedFrom(docs);
  }

  /// Adds the sale and updates the outlet's `lastVisit`/`lastOrderAmount`
  /// in one atomic batch, per the AI Agent Coding Instructions §4.
  Future<void> submitSale({
    required String salesmanEmail,
    required String teamId,
    required OutletModel outlet,
    required ProductModel product,
    required int quantity,
    required double unitPrice,
    required double discount,
  }) async {
    final amount = (quantity * unitPrice) - discount;
    final now = DateTime.now();
    await _client.runBatch((batch) {
      batch.add(FirestoreCollections.sales, {
        'salesmanEmail': salesmanEmail,
        'teamId': teamId,
        'outletId': outlet.id,
        'outletName': outlet.name,
        'productId': product.id,
        'productName': product.name,
        'category': product.category,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'listPrice': product.unitPrice,
        'discount': discount,
        'amount': amount,
        'date': now.toIso8601String(),
        'status': 'COMPLETED',
        'createdAt': now.toIso8601String(),
      });
      batch.update('${FirestoreCollections.outlets}/${outlet.id}', {
        'lastVisit': now.toIso8601String(),
        'lastOrderAmount': amount,
      });
    });
  }
}
