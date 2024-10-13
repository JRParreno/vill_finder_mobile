import 'package:vill_finder/features/home/domain/entities/index.dart';

class ReviewEntity {
  final int id;
  final int stars;
  final String comment;
  final BusinessUserProfileEntity userProfile;

  ReviewEntity({
    required this.id,
    required this.stars,
    required this.comment,
    required this.userProfile,
  });
}
