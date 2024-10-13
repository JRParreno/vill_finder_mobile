import 'package:vill_finder/features/review/data/models/index.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';

class ReviewListResponseModel extends ReviewListResponseEntity {
  ReviewListResponseModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.reviews,
  });

  factory ReviewListResponseModel.fromJson(Map<String, dynamic> map) {
    return ReviewListResponseModel(
      count: map['count'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
      reviews: List<ReviewModel>.from(
        map['results'].map<ReviewModel>(
          (x) => ReviewModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
