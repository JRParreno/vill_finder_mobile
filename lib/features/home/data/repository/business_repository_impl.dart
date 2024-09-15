import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/data/data_sources/business_remote_data_source.dart';
import 'package:vill_finder/features/home/domain/entities/business_category_list_response_entity.dart';
import 'package:vill_finder/features/home/domain/entities/business_list_response_entity.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  const BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, BusinessListResponseEntity>> getHomeBusinessList({
    int? categoryId,
    String? businessName,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await _remoteDataSource.getHomeBusinessList(
        businessName: businessName,
        categoryId: categoryId,
        next: next,
        previous: previous,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, BusinessCategoryListResponseEntity>>
      getHomeBusinessCategoryList({String? previous, String? next}) async {
    try {
      final response = await _remoteDataSource.getHomeBusinessCategoryList(
        next: next,
        previous: previous,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
