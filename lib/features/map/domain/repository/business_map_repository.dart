import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';

abstract interface class BusinessMapRepository {
  Future<Either<Failure, SearchMapResponseEntity>> getBusinessMapList({
    double? longitude,
    double? latitude,
    String? name,
    String? previous,
    String? next,
  });
}
