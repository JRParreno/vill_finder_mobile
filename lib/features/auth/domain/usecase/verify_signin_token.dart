import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/auth/domain/entities/google_signin_response_entity.dart';
import 'package:vill_finder/features/auth/domain/repository/auth_repository.dart';

class VerifySigninToken implements UseCase<GoogleSigninResponseEntity, String> {
  final AuthRepository authRepository;

  const VerifySigninToken(this.authRepository);

  @override
  Future<Either<Failure, GoogleSigninResponseEntity>> call(
      String params) async {
    return await authRepository.verifySigninToken(params);
  }
}
