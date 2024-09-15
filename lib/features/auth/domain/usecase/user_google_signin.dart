import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/auth/domain/repository/auth_repository.dart';

class UserGoogleSignin implements UseCase<String, NoParams> {
  final AuthRepository authRepository;

  const UserGoogleSignin(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.signinWithGoogle();
  }
}
