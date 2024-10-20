import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/favorite/data/data_sources/favorite_remote_data_source.dart';
import 'package:vill_finder/features/favorite/domain/repository/favorite_repository.dart';
import 'package:vill_finder/features/home/domain/entities/rental_list_response_entity.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _remoteDataSource;

  const FavoriteRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, RentalListResponseEntity>> getFavorites({
    String? next,
    String? previous,
  }) async {
    try {
      final response = await _remoteDataSource.getFavorites(
        next: next,
        previous: previous,
      );
      return right(response);
    } on Failure catch (e) {
      return left(Failure(e.message));
    }
  }
}
