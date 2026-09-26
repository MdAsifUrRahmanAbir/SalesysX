import '../../features/login/data/models/user_model.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthSessionState {
  final AuthStatus status;
  final UserModel? user;

  const AuthSessionState({this.status = AuthStatus.unknown, this.user});

  AuthSessionState copyWith({AuthStatus? status, UserModel? user}) {
    return AuthSessionState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}