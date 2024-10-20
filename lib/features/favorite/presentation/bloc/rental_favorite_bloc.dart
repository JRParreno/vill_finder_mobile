import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/features/favorite/domain/usecases/get_favorites.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

part 'rental_favorite_event.dart';
part 'rental_favorite_state.dart';

class RentalFavoriteBloc
    extends Bloc<RentalFavoriteEvent, RentalFavoriteState> {
  final GetFavorites _getFavorites;

  RentalFavoriteBloc(GetFavorites getFavorites)
      : _getFavorites = getFavorites,
        super(RentalFavoriteInitial()) {
    on<GetFavoriteEvent>(onGetFavoriteEvent);
    on<PaginateFavoriteEvent>(onPaginateFavoriteEvent);
  }

  Future<void> onGetFavoriteEvent(
      GetFavoriteEvent event, Emitter<RentalFavoriteState> emit) async {
    emit(RentalFavoriteLoading());

    final response = await _getFavorites(GetFavoritesParams());

    response.fold(
      (l) => emit(RentalFavoriteFailure(l.message)),
      (r) => emit(RentalFavoriteSuccess(favorites: r)),
    );
  }

  Future<void> onPaginateFavoriteEvent(
      PaginateFavoriteEvent event, Emitter<RentalFavoriteState> emit) async {
    final state = this.state;

    if (state is RentalFavoriteSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.isPaginated));

      final response = await _getFavorites(GetFavoritesParams(
          next: state.favorites.next, previous: state.favorites.previous));

      response.fold(
        (l) => emit(RentalFavoriteFailure(l.message)),
        (r) => emit(
          state.copyWith(
            favorites: r.copyWith(
              results: [...state.favorites.results, ...r.results],
            ),
            viewStatus: ViewStatus.none,
          ),
        ),
      );
    }
  }
}
