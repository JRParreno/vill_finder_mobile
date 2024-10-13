// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vill_finder/features/review/domain/entities/index.dart';

class ReviewListResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<ReviewEntity> reviews;

  ReviewListResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.reviews,
  });

  ReviewListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<ReviewEntity>? reviews,
  }) {
    return ReviewListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      reviews: reviews ?? this.reviews,
    );
  }
}
