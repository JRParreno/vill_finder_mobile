import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/features/home/domain/entities/business_list_response_entity.dart';

abstract interface class BusinessMapRepository {
  Future<Either<Failure, BusinessListResponseEntity>> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? businessName,
    String? previous,
    String? next,
  });
}
