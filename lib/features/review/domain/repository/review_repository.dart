import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/review/domain/entities/review_list_response_entity.dart';

abstract interface class ReviewRepository {
  Future<Either<Failure, ReviewListResponseEntity>> getReviewList({
    required int placeId,
    required ReviewType reviewType,
    String? previous,
    String? next,
  });
}
