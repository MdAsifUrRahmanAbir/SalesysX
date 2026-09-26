import '../network/api_exception.dart';
import '../network/firebase_client_exception.dart';
import '../../features/login/data/repositories/login_repository.dart';

String getErrorMessage(Object error) {
  if (error is ApiException) return error.message;
  if (error is FirebaseClientException) return error.message;
  if (error is AuthFailure) return error.message;
  return 'Something went wrong. Please try again.';
}