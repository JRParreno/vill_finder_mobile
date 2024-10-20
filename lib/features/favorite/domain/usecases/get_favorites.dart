import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/favorite/domain/repository/favorite_repository.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class GetFavorites
    implements UseCase<RentalListResponseEntity, GetFavoritesParams> {
  final FavoriteRepository _repository;

  const GetFavorites(this._repository);

  @override
  Future<Either<Failure, RentalListResponseEntity>> call(
      GetFavoritesParams params) async {
    return await _repository.getFavorites(
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetFavoritesParams {
  final String? next;
  final String? previous;

  GetFavoritesParams({
    this.next,
    this.previous,
  });
}
