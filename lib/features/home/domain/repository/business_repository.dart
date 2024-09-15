import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class BusinessRepository {
  Future<Either<Failure, BusinessListResponseEntity>> getHomeBusinessList({
    int? categoryId,
    String? businessName,
    String? previous,
    String? next,
  });
  Future<Either<Failure, BusinessCategoryListResponseEntity>>
      getHomeBusinessCategoryList({
    String? previous,
    String? next,
  });
}
