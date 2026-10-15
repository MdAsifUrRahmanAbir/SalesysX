import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';
import '../models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(firebaseClientProvider));
});

class NotificationRepository {
  final FirebaseClient _client;
  NotificationRepository(this._client);

  /// `whereIn` on a single field — still no composite index needed.
  Future<List<NotificationModel>> getForUser(String email) async {
    final docs = await _client.getCollection(
      FirestoreCollections.notifications,
      filters: [FirestoreFilter('targetEmail', FirestoreOp.whereIn, [email, 'all'])],
    );
    final items = docs.map(NotificationModel.fromMap).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  Future<void> markAsRead(String id) {
    return _client.updateDocument('${FirestoreCollections.notifications}/$id', {'isRead': true});
  }

  Future<void> markAllAsRead(List<String> ids) async {
    if (ids.isEmpty) return;
    await _client.runBatch((batch) {
      for (final id in ids) {
        batch.update('${FirestoreCollections.notifications}/$id', {'isRead': true});
      }
    });
  }
}
