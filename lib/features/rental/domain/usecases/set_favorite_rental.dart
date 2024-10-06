import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/domain/repository/rental_repository.dart';

class SetFavoriteRental
    implements UseCase<RentalEntity, SetFavoriteRentalParams> {
  final RentalRepository _repository;

  const SetFavoriteRental(this._repository);

  @override
  Future<Either<Failure, RentalEntity>> call(
      SetFavoriteRentalParams params) async {
    return await _repository.setFavoriteRental(
      id: params.id,
      isFavorite: params.isFavorite,
    );
  }
}

class SetFavoriteRentalParams {
  final int id;
  final bool isFavorite;

  SetFavoriteRentalParams({
    required this.id,
    this.isFavorite = false,
  });
}
