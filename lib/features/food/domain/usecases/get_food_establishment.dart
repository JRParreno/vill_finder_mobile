import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/food/domain/repository/food_repository.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class GetFoodEstablishment implements UseCase<FoodEstablishmentEntity, int> {
  final FoodRepository _repository;

  const GetFoodEstablishment(this._repository);

  @override
  Future<Either<Failure, FoodEstablishmentEntity>> call(int params) async {
    return await _repository.getFoodEstablishment(params);
  }
}
