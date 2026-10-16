import '../network/api_exception.dart';
import '../network/firebase_client_exception.dart';
import '../../features/change_password/data/repositories/change_password_repository.dart';
import '../../features/login/data/repositories/login_repository.dart';
import 'app_failure.dart';

String getErrorMessage(Object error) {
  if (error is ApiException) return error.message;
  if (error is FirebaseClientException) return error.message;
  if (error is AuthFailure) return error.message;
  if (error is ChangePasswordFailure) return error.message;
  if (error is AppFailure) return error.message;
  return 'Something went wrong. Please try again.';
}