import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:vill_finder/features/food/domain/repository/food_repository.dart';
import 'package:vill_finder/features/home/domain/entities/food_establishment_entity.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource _remoteDataSource;

  const FoodRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, FoodEstablishmentEntity>> getFoodEstablishment(
      int id) async {
    try {
      final response = await _remoteDataSource.getFoodEstablishment(id);
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
