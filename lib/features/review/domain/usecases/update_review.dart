import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';
import 'package:vill_finder/features/review/domain/repository/review_repository.dart';

class UpdateReview implements UseCase<ReviewEntity, UpdateReviewParams> {
  final ReviewRepository _repository;

  const UpdateReview(this._repository);

  @override
  Future<Either<Failure, ReviewEntity>> call(UpdateReviewParams params) async {
    return await _repository.updateReview(
      id: params.id,
      comments: params.comments,
      reviewType: params.reviewType,
      stars: params.stars,
    );
  }
}

class UpdateReviewParams {
  final int id;
  final ReviewType reviewType;
  final int stars;
  final String comments;

  UpdateReviewParams({
    required this.id,
    required this.reviewType,
    required this.stars,
    required this.comments,
  });
}
