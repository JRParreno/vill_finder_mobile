import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.sentimentScore,
    required super.comment,
    required super.userProfile,
    required super.sentimentLabel,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> map) {
    return ReviewModel(
        id: map['id'] as int,
        sentimentScore: map['sentiment_score'] as double,
        sentimentLabel: map['sentiment_label'] as String,
        comment: map['comment'] as String,
        userProfile: BusinessUserProfileModel.fromJson(map['user_profile']));
  }
}
