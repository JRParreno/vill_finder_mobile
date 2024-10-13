import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/review/data/datasources/review_remote_data_source.dart';
import 'package:vill_finder/features/review/domain/entities/review_list_response_entity.dart';
import 'package:vill_finder/features/review/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  const ReviewRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ReviewListResponseEntity>> getReviewList({
    required int placeId,
    required ReviewType reviewType,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await _remoteDataSource.getReviewList(
        placeId: placeId,
        reviewType: reviewType,
        next: next,
        previous: previous,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
