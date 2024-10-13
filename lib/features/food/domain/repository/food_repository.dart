import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class FoodRepository {
  Future<Either<Failure, FoodEstablishmentEntity>> getFoodEstablishment(int id);
}
