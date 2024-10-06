import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';

class GetHomeRentalList
    implements UseCase<RentalListResponseEntity, GetHomeRentalListParams> {
  final BusinessRepository _repository;

  const GetHomeRentalList(this._repository);

  @override
  Future<Either<Failure, RentalListResponseEntity>> call(
      GetHomeRentalListParams params) async {
    return await _repository.getHomeRentalList(
      name: params.name,
      categoryId: params.categoryId,
      next: params.next,
      previous: params.previous,
      isFeatured: params.isFeatured,
    );
  }
}

class GetHomeRentalListParams {
  final String? name;
  final int? categoryId;
  final String? next;
  final String? previous;
  final bool? isFeatured;

  GetHomeRentalListParams({
    this.name,
    this.categoryId,
    this.next,
    this.previous,
    this.isFeatured,
  });
}
