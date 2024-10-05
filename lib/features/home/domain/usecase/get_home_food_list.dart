import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class GetHomeFoodList
    implements
        UseCase<FoodEstablishmentListResponseEntity, GetHomeFoodListParams> {
  final BusinessRepository _repository;

  const GetHomeFoodList(this._repository);

  @override
  Future<Either<Failure, FoodEstablishmentListResponseEntity>> call(
      GetHomeFoodListParams params) async {
    return await _repository.getHomeFoodList(
      name: params.name,
      categoryId: params.categoryId,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetHomeFoodListParams {
  final String? name;
  final int? categoryId;
  final String? next;
  final String? previous;

  GetHomeFoodListParams({
    this.name,
    this.categoryId,
    this.next,
    this.previous,
  });
}
