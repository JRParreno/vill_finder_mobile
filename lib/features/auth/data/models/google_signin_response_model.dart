import 'package:vill_finder/features/auth/data/models/user_model.dart';
import 'package:vill_finder/features/auth/domain/entities/google_signin_response_entity.dart';

class GoogleSigninResponseModel extends GoogleSigninResponseEntity {
  const GoogleSigninResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory GoogleSigninResponseModel.fromJson(Map<String, dynamic> map) {
    return GoogleSigninResponseModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
      user: UserModel.fromJson(map),
    );
  }
}
