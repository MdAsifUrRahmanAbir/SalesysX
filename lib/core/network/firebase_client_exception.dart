import 'package:cloud_firestore/cloud_firestore.dart';

/// The Firestore-backed sibling of [ApiException] — every FirebaseException
/// a repository can hit, mapped to a message safe to show in a snackbar.
class FirebaseClientException implements Exception {
  final String message;
  final String? code;

  const FirebaseClientException(this.message, {this.code});

  factory FirebaseClientException.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const FirebaseClientException("You don't have permission to do that.", code: 'permission-denied');
      case 'unavailable':
        return const FirebaseClientException('No connection to the server. Please try again.', code: 'unavailable');
      case 'not-found':
        return const FirebaseClientException('The requested data was not found.', code: 'not-found');
      case 'already-exists':
        return const FirebaseClientException('This already exists.', code: 'already-exists');
      case 'deadline-exceeded':
        return const FirebaseClientException('The request timed out. Please try again.', code: 'deadline-exceeded');
      case 'resource-exhausted':
        return const FirebaseClientException('Too many requests. Please try again shortly.', code: 'resource-exhausted');
      case 'unauthenticated':
        return const FirebaseClientException('Please sign in again to continue.', code: 'unauthenticated');
      case 'cancelled':
        return const FirebaseClientException('Request was cancelled.', code: 'cancelled');
      case 'failed-precondition':
        return const FirebaseClientException(
          "This query needs a database index that hasn't been created yet.",
          code: 'failed-precondition',
        );
      default:
        return FirebaseClientException(e.message ?? 'Something went wrong. Please try again.', code: e.code);
    }
  }

  @override
  String toString() => 'FirebaseClientException: $message (code: $code)';
}