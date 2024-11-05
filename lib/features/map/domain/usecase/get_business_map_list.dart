import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/repository/business_map_repository.dart';

class GetBusinessMapList
    implements UseCase<SearchMapResponseEntity, GetBusinessMapListParams> {
  final BusinessMapRepository _repository;

  const GetBusinessMapList(this._repository);

  @override
  Future<Either<Failure, SearchMapResponseEntity>> call(
      GetBusinessMapListParams params) async {
    return await _repository.getBusinessMapList(
      longitude: params.longitude,
      latitude: params.latitude,
      name: params.name,
      next: params.next,
      previous: params.previous,
      categoryIds: params.categoryIds,
    );
  }
}

class GetBusinessMapListParams {
  final double? longitude;
  final double? latitude;
  final String? name;
  final String? next;
  final String? previous;
  final List<int>? categoryIds;

  GetBusinessMapListParams({
    this.latitude,
    this.longitude,
    this.name,
    this.next,
    this.previous,
    this.categoryIds,
  });
}
