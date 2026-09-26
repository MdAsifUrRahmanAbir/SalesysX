import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_client_exception.dart';

final firebaseClientProvider = Provider<FirebaseClient>((ref) => FirebaseClient());

enum FirestoreOp {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
}

/// One `.where()` clause, built generically so repositories can compose
/// queries without importing `cloud_firestore` themselves.
class FirestoreFilter {
  final String field;
  final FirestoreOp op;
  final dynamic value;
  const FirestoreFilter(this.field, this.op, this.value);
}

/// Firestore wrapper — the Firebase-backed sibling of `ApiClient`. Every
/// repository should call through here instead of touching
/// `FirebaseFirestore.instance` directly, so error handling and query
/// building stay consistent app-wide. Works in plain
/// `Map<String, dynamic>` — repositories own `fromMap`/`toMap` on their
/// models, the same way they'd own `fromJson`/`toJson` for a REST body.
class FirebaseClient {
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  // ---- single document ----

  /// Returns the document's data with its id folded in as `'id'`, or
  /// null if it doesn't exist. [path] is a full doc path, e.g. `'users/$uid'`.
  Future<Map<String, dynamic>?> getDocument(String path) async {
    try {
      final snap = await _db.doc(path).get();
      if (!snap.exists || snap.data() == null) return null;
      return {...snap.data()!, 'id': snap.id};
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  /// Creates a document with an auto-generated id under [collectionPath]
  /// and returns that id.
  Future<String> addDocument(String collectionPath, Map<String, dynamic> data) async {
    try {
      final ref = await _db.collection(collectionPath).add(data);
      return ref.id;
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  /// Creates/overwrites the document at the exact [path] — use when you
  /// already know the id (e.g. `'users/$uid'`). [merge] leaves fields not
  /// present in [data] untouched instead of wiping the document.
  Future<void> setDocument(String path, Map<String, dynamic> data, {bool merge = false}) async {
    try {
      await _db.doc(path).set(data, SetOptions(merge: merge));
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    try {
      await _db.doc(path).update(data);
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      await _db.doc(path).delete();
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  // ---- collections / queries ----

  /// Generic query. [collectionPath] can be nested, e.g. `'teams/T1/members'`.
  /// Results include `'id'` per document. [startAfterDocId] is a simple
  /// pagination cursor — pairs well with `PaginationControls`.
  Future<List<Map<String, dynamic>>> getCollection(
      String collectionPath, {
        List<FirestoreFilter> filters = const [],
        String? orderBy,
        bool descending = false,
        int? limit,
        String? startAfterDocId,
      }) async {
    try {
      Query<Map<String, dynamic>> query = _buildQuery(
        _db.collection(collectionPath),
        filters: filters,
        orderBy: orderBy,
        descending: descending,
        limit: limit,
      );

      if (startAfterDocId != null) {
        final cursorDoc = await _db.collection(collectionPath).doc(startAfterDocId).get();
        if (cursorDoc.exists) query = query.startAfterDocument(cursorDoc);
      }

      final snap = await query.get();
      return [for (final doc in snap.docs) {...doc.data(), 'id': doc.id}];
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }

  Query<Map<String, dynamic>> _buildQuery(
      Query<Map<String, dynamic>> query, {
        required List<FirestoreFilter> filters,
        String? orderBy,
        bool descending = false,
        int? limit,
      }) {
    for (final f in filters) {
      query = switch (f.op) {
        FirestoreOp.isEqualTo => query.where(f.field, isEqualTo: f.value),
        FirestoreOp.isNotEqualTo => query.where(f.field, isNotEqualTo: f.value),
        FirestoreOp.isLessThan => query.where(f.field, isLessThan: f.value),
        FirestoreOp.isLessThanOrEqualTo => query.where(f.field, isLessThanOrEqualTo: f.value),
        FirestoreOp.isGreaterThan => query.where(f.field, isGreaterThan: f.value),
        FirestoreOp.isGreaterThanOrEqualTo => query.where(f.field, isGreaterThanOrEqualTo: f.value),
        FirestoreOp.arrayContains => query.where(f.field, arrayContains: f.value),
        FirestoreOp.arrayContainsAny => query.where(f.field, arrayContainsAny: f.value as List<dynamic>),
        FirestoreOp.whereIn => query.where(f.field, whereIn: f.value as List<dynamic>),
        FirestoreOp.whereNotIn => query.where(f.field, whereNotIn: f.value as List<dynamic>),
      };
    }
    if (orderBy != null) query = query.orderBy(orderBy, descending: descending);
    if (limit != null) query = query.limit(limit);
    return query;
  }

  // ---- realtime streams ----

  Stream<Map<String, dynamic>?> streamDocument(String path) {
    return _db.doc(path).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return {...snap.data()!, 'id': snap.id};
    });
  }

  Stream<List<Map<String, dynamic>>> streamCollection(
      String collectionPath, {
        List<FirestoreFilter> filters = const [],
        String? orderBy,
        bool descending = false,
        int? limit,
      }) {
    final query = _buildQuery(
      _db.collection(collectionPath),
      filters: filters,
      orderBy: orderBy,
      descending: descending,
      limit: limit,
    );
    return query.snapshots().map((snap) {
      return [for (final doc in snap.docs) {...doc.data(), 'id': doc.id}];
    });
  }

  // ---- atomic helpers ----

  /// `FieldValue.increment` passthrough — put this inside an
  /// `updateDocument` data map for counters (e.g. a running sales total)
  /// without a read-modify-write race.
  dynamic increment(num delta) => FieldValue.increment(delta);

  dynamic serverTimestamp() => FieldValue.serverTimestamp();

  /// Groups several writes into one atomic commit — e.g. logging a sale
  /// *and* incrementing that salesman's target progress in one go.
  Future<void> runBatch(void Function(FirebaseBatchScope batch) build) async {
    try {
      final batch = _db.batch();
      build(FirebaseBatchScope._(batch, _db));
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseClientException.fromFirebaseException(e);
    }
  }
}

class FirebaseBatchScope {
  final WriteBatch _batch;
  final FirebaseFirestore _db;
  FirebaseBatchScope._(this._batch, this._db);

  void set(String path, Map<String, dynamic> data, {bool merge = false}) =>
      _batch.set(_db.doc(path), data, SetOptions(merge: merge));

  void update(String path, Map<String, dynamic> data) => _batch.update(_db.doc(path), data);

  void delete(String path) => _batch.delete(_db.doc(path));
}