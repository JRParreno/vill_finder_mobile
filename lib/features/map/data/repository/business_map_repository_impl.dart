import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/business_list_response_entity.dart';
import 'package:vill_finder/features/map/data/data_source/business_map_remote_data_source.dart';
import 'package:vill_finder/features/map/domain/repository/business_map_repository.dart';

class BusinessMapRepositoryImpl implements BusinessMapRepository {
  final BusinessMapRemoteDataSource _remoteDataSource;

  const BusinessMapRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, BusinessListResponseEntity>> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? businessName,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await _remoteDataSource.getBusinessMapList(
        maxLatitude: maxLatitude,
        maxLongitude: maxLongitude,
        minLatitude: minLatitude,
        minLongitude: minLongitude,
        businessName: businessName,
        next: next,
        previous: previous,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
