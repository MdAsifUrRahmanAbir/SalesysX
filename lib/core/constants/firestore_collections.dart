class FirestoreCollections {
  FirestoreCollections._();

  static const String users = 'users';
  static const String teams = 'teams';
  static const String sales = 'sales';
  static const String targets = 'targets';
  static const String outlets = 'outlets';
  static const String notifications = 'notifications';

  static String userDoc(String uid) => '$users/$uid';
  static String teamDoc(String teamId) => '$teams/$teamId';
}