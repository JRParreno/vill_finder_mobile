import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class BusinessRepository {
  Future<Either<Failure, RentalListResponseEntity>> getHomeRentalList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
    bool? isFeatured,
  });
  Future<Either<Failure, FoodEstablishmentListResponseEntity>> getHomeFoodList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
  });
  Future<Either<Failure, BusinessCategoryListResponseEntity>>
      getHomeBusinessCategoryList({
    String? name,
    String? previous,
    String? next,
  });
}
