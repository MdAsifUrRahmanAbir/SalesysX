/// A business-rule violation with a ready-to-show message — e.g. "a user
/// with this email already exists" or "remove the members first".
/// Mapped straight through by `getErrorMessage()`.
class AppFailure implements Exception {
  final String message;
  const AppFailure(this.message);

  @override
  String toString() => message;
}
