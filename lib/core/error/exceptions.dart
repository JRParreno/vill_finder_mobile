import 'package:vill_finder/core/error/failure.dart';

class ServerException extends Failure {
  ServerException(super.message);
}

class AuthenticationException extends Failure {
  AuthenticationException(super.message);
}

class FirebaseException extends Failure {
  FirebaseException(super.message);
}
