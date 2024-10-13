import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/review/domain/entities/review_list_response_entity.dart';
import 'package:vill_finder/features/review/domain/repository/review_repository.dart';

class GetReviewList
    implements UseCase<ReviewListResponseEntity, GetReviewListParams> {
  final ReviewRepository _repository;

  const GetReviewList(this._repository);

  @override
  Future<Either<Failure, ReviewListResponseEntity>> call(
      GetReviewListParams params) async {
    return await _repository.getReviewList(
      placeId: params.placeId,
      reviewType: params.reviewType,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetReviewListParams {
  final int placeId;
  final ReviewType reviewType;
  final String? next;
  final String? previous;

  GetReviewListParams({
    required this.placeId,
    required this.reviewType,
    this.next,
    this.previous,
  });
}
