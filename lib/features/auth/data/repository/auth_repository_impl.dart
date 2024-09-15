import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/common/entities/user_entity.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vill_finder/features/auth/domain/entities/google_signin_response_entity.dart';
import 'package:vill_finder/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, String>> signinWithGoogle() async {
    try {
      final response = await authRemoteDataSource.signinWithGoogle();
      return right(response);
    } on AuthenticationException catch (e) {
      return left(AuthenticationException(e.message));
    } on FirebaseException catch (e) {
      return left(FirebaseException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await authRemoteDataSource.logout();
      return right(response);
    } on AuthenticationException catch (e) {
      return left(AuthenticationException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GoogleSigninResponseEntity>> verifySigninToken(
      String idToken) async {
    try {
      final response = await authRemoteDataSource.verifySigninToken(idToken);
      return right(response);
    } on AuthenticationException catch (e) {
      return left(AuthenticationException(e.message));
    } catch (e) {
      return left(ServerException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final response = await authRemoteDataSource.currentUser();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
