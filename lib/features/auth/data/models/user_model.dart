import 'package:vill_finder/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.birthdate,
    super.contactNumber,
    super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['pk'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      contactNumber:
          map['contactNumber'] != null ? map['contactNumber'] as String : null,
      birthdate: map['birthdate'] != null ? map['birthdate'] as String : null,
      photoUrl: map['photo'] != null ? map['photo'] as String : null,
    );
  }
}
