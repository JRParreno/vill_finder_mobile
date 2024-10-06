import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/rental_entity.dart';
import 'package:vill_finder/features/rental/data/data_sources/rental_remote_data_source.dart';
import 'package:vill_finder/features/rental/domain/repository/rental_repository.dart';

class RentalRepositoryImpl implements RentalRepository {
  final RentalRemoteDataSource _remoteDataSource;

  const RentalRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, RentalEntity>> getRental(int id) async {
    try {
      final response = await _remoteDataSource.getRental(id);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, RentalEntity>> setFavoriteRental({
    required int id,
    bool isFavorite = false,
  }) async {
    try {
      final response = await _remoteDataSource.setFavoriteRental(
          id: id, isFavorite: isFavorite);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
