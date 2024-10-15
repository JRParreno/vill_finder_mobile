import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';
import 'package:vill_finder/features/review/domain/repository/review_repository.dart';

class AddReview implements UseCase<ReviewEntity, AddReviewParams> {
  final ReviewRepository _repository;

  const AddReview(this._repository);

  @override
  Future<Either<Failure, ReviewEntity>> call(AddReviewParams params) async {
    return await _repository.addReview(
      comments: params.comments,
      objectId: params.objectId,
      reviewType: params.reviewType,
      stars: params.stars,
    );
  }
}

class AddReviewParams {
  final int objectId;
  final ReviewType reviewType;
  final int stars;
  final String comments;

  AddReviewParams({
    required this.objectId,
    required this.reviewType,
    required this.stars,
    required this.comments,
  });
}
