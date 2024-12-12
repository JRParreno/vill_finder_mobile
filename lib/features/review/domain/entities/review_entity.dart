import 'package:vill_finder/features/home/domain/entities/index.dart';

class ReviewEntity {
  final int id;
  final double sentimentScore;
  final String sentimentLabel;
  final String comment;
  final BusinessUserProfileEntity userProfile;

  ReviewEntity({
    required this.id,
    required this.sentimentScore,
    required this.comment,
    required this.userProfile,
    required this.sentimentLabel,
  });
}
