import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class GetHomeBusinessList
    implements UseCase<BusinessListResponseEntity, GetHomeBusinessListParams> {
  final BusinessRepository _repository;

  const GetHomeBusinessList(this._repository);

  @override
  Future<Either<Failure, BusinessListResponseEntity>> call(
      GetHomeBusinessListParams params) async {
    return await _repository.getHomeBusinessList(
      businessName: params.businessName,
      categoryId: params.categoryId,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetHomeBusinessListParams {
  final String? businessName;
  final int? categoryId;
  final String? next;
  final String? previous;

  GetHomeBusinessListParams({
    this.businessName,
    this.categoryId,
    this.next,
    this.previous,
  });
}
