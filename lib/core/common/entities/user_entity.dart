class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? contactNumber;
  final String? birthdate;
  final String? photoUrl;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.contactNumber,
    this.birthdate,
    this.photoUrl,
  });
}
