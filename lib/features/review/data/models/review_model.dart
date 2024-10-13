import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.stars,
    required super.comment,
    required super.userProfile,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> map) {
    return ReviewModel(
        id: map['id'] as int,
        stars: map['stars'] as int,
        comment: map['comment'] as String,
        userProfile: BusinessUserProfileModel.fromJson(map['user_profile']));
  }
}
