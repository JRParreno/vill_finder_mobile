import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/data/data_sources/business_remote_data_source.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  const BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, RentalListResponseEntity>> getHomeRentalList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
    bool? isFeatured,
  }) async {
    try {
      final response = await _remoteDataSource.getHomeRentalList(
        name: name,
        categoryId: categoryId,
        next: next,
        previous: previous,
        isFeatured: isFeatured,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, FoodEstablishmentListResponseEntity>> getHomeFoodList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await _remoteDataSource.getHomeFoodList(
        name: name,
        categoryId: categoryId,
        next: next,
        previous: previous,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, BusinessCategoryListResponseEntity>>
      getHomeBusinessCategoryList({
    String? previous,
    String? next,
    String? name,
  }) async {
    try {
      final response = await _remoteDataSource.getHomeBusinessCategoryList(
        next: next,
        previous: previous,
        name: name,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
