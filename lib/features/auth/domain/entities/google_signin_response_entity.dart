import 'package:vill_finder/core/common/entities/user_entity.dart';

class GoogleSigninResponseEntity {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const GoogleSigninResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
