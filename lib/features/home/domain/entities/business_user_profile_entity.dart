class BusinessUserProfileEntity {
  final int id;
  final String? birthdate;
  final String? contactNumber;
  final String? profilePhoto;
  final BusinessUser user;

  BusinessUserProfileEntity({
    required this.id,
    this.birthdate,
    this.contactNumber,
    this.profilePhoto,
    required this.user,
  });
}

class BusinessUser {
  final int pk;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String getFullName;

  BusinessUser({
    required this.pk,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.getFullName,
  });
}
