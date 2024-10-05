import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class GetHomeBusinessCategoryList
    implements
        UseCase<BusinessCategoryListResponseEntity,
            GetHomeBusinessCategoryListParams> {
  final BusinessRepository _repository;

  const GetHomeBusinessCategoryList(this._repository);

  @override
  Future<Either<Failure, BusinessCategoryListResponseEntity>> call(
      GetHomeBusinessCategoryListParams params) async {
    return await _repository.getHomeBusinessCategoryList(
      next: params.next,
      previous: params.previous,
      name: params.name,
    );
  }
}

class GetHomeBusinessCategoryListParams {
  final String? next;
  final String? previous;
  final String? name;

  GetHomeBusinessCategoryListParams({this.next, this.previous, this.name});
}
