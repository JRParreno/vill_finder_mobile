import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class RentalRepository {
  Future<Either<Failure, RentalEntity>> getRental(int id);
  Future<Either<Failure, RentalEntity>> setFavoriteRental({
    required int id,
    bool isFavorite = false,
  });
}
