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

  /// Live list of this user's notifications plus company-wide ones,
  /// newest first. `whereIn` on a single field — no composite index.
  Stream<List<NotificationModel>> watchForUser(String email) {
    return _client
        .streamCollection(
          FirestoreCollections.notifications,
          filters: [FirestoreFilter('targetEmail', FirestoreOp.whereIn, [email, 'all'])],
        )
        .map((docs) => [for (final d in docs) NotificationModel.fromMap(d, viewer: email)]
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
  }

  Future<void> markAsRead(NotificationModel item, String email) {
    return _client.updateDocument('${FirestoreCollections.notifications}/${item.id}', _readFields(item, email));
  }

  Future<void> markAllAsRead(List<NotificationModel> items, String email) async {
    for (var i = 0; i < items.length; i += 450) {
      final chunk = items.skip(i).take(450);
      await _client.runBatch((batch) {
        for (final item in chunk) {
          batch.update('${FirestoreCollections.notifications}/${item.id}', _readFields(item, email));
        }
      });
    }
  }

  /// Only `readBy` (and `isRead` on a personal notification) may change —
  /// see firestore.rules.
  Map<String, dynamic> _readFields(NotificationModel item, String email) => {
    'readBy': _client.arrayUnion([email]),
    if (!item.isBroadcast) 'isRead': true,
  };
}
