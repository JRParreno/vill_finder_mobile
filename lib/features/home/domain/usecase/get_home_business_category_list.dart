import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class GetHomeBusinessCategoryList
    implements UseCase<BusinessCategoryListResponseEntity, PaginationParams> {
  final BusinessRepository _repository;

  const GetHomeBusinessCategoryList(this._repository);

  @override
  Future<Either<Failure, BusinessCategoryListResponseEntity>> call(
      PaginationParams params) async {
    return await _repository.getHomeBusinessCategoryList(
      next: params.next,
      previous: params.previous,
    );
  }
}
