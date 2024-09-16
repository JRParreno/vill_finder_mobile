import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/map/domain/repository/business_map_repository.dart';

class GetBusinessMapList
    implements UseCase<BusinessListResponseEntity, GetBusinessMapListParams> {
  final BusinessMapRepository _repository;

  const GetBusinessMapList(this._repository);

  @override
  Future<Either<Failure, BusinessListResponseEntity>> call(
      GetBusinessMapListParams params) async {
    return await _repository.getBusinessMapList(
      maxLatitude: params.maxLatitude,
      maxLongitude: params.maxLongitude,
      minLatitude: params.minLatitude,
      minLongitude: params.minLongitude,
      businessName: params.businessName,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetBusinessMapListParams {
  final double maxLatitude;
  final double minLatitude;
  final double maxLongitude;
  final double minLongitude;
  final String? businessName;
  final String? next;
  final String? previous;

  GetBusinessMapListParams({
    required this.maxLatitude,
    required this.minLatitude,
    required this.maxLongitude,
    required this.minLongitude,
    this.businessName,
    this.next,
    this.previous,
  });
}
