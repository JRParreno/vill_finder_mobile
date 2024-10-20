import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class FavoriteRepository {
  Future<Either<Failure, RentalListResponseEntity>> getFavorites({
    String? next,
    String? previous,
  });
}
