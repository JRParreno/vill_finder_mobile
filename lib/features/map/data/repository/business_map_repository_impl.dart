import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/map/data/data_source/business_map_remote_data_source.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/repository/business_map_repository.dart';

class BusinessMapRepositoryImpl implements BusinessMapRepository {
  final BusinessMapRemoteDataSource _remoteDataSource;

  const BusinessMapRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, SearchMapResponseEntity>> getBusinessMapList({
    double? longitude,
    double? latitude,
    String? name,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await _remoteDataSource.getBusinessMapList(
        longitude: longitude,
        latitude: latitude,
        name: name,
        next: next,
        previous: previous,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
