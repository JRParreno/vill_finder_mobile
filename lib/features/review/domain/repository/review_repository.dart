import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';

abstract interface class ReviewRepository {
  Future<Either<Failure, ReviewListResponseEntity>> getReviewList({
    required int placeId,
    required ReviewType reviewType,
    String? previous,
    String? next,
  });
  Future<Either<Failure, ReviewEntity>> addReview({
    required int objectId,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  });
  Future<Either<Failure, ReviewEntity>> updateReview({
    required int id,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  });
}
