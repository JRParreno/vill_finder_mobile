import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/common/entities/user_entity.dart';
import 'package:vill_finder/features/auth/domain/entities/google_signin_response_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signinWithGoogle();
  Future<Either<Failure, GoogleSigninResponseEntity>> verifySigninToken(
      String idToken);
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, UserEntity>> currentUser();
}
