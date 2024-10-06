import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/domain/repository/rental_repository.dart';

class GetRental implements UseCase<RentalEntity, int> {
  final RentalRepository _repository;

  const GetRental(this._repository);

  @override
  Future<Either<Failure, RentalEntity>> call(int params) async {
    return await _repository.getRental(params);
  }
}
