import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessUserProfileModel extends BusinessUserProfileEntity {
  BusinessUserProfileModel({
    required super.user,
  });

  factory BusinessUserProfileModel.fromJson(Map<String, dynamic> json) {
    return BusinessUserProfileModel(
      user: BusinessUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class BusinessUserModel extends BusinessUser {
  BusinessUserModel({
    required super.pk,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.getFullName,
  });

  factory BusinessUserModel.fromJson(Map<String, dynamic> json) {
    return BusinessUserModel(
      pk: json['pk'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      getFullName: json['get_full_name'] as String,
    );
  }
}
