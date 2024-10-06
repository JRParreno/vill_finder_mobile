import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/domain/usecases/index.dart';

part 'rental_event.dart';
part 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final GetRental _getRental;
  final SetFavoriteRental _setFavoriteRental;

  RentalBloc({
    required GetRental getRental,
    required SetFavoriteRental setFavoriteRental,
  })  : _getRental = getRental,
        _setFavoriteRental = setFavoriteRental,
        super(RentalInitial()) {
    on<GetRentalEvent>(onGetRentalEvent);
    on<AddFavoriteRentalEvent>(onAddFavoriteRentalEvent);
    on<RemoveFavoriteRentalEvent>(onRemoveFavoriteRentalEvent);
  }

  Future<void> onGetRentalEvent(
      GetRentalEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());

    final response = await _getRental.call(event.id);

    response.fold(
      (l) => emit(RentalFailure(l.message)),
      (r) => emit(RentalSuccess(r)),
    );
  }

  Future<void> onAddFavoriteRentalEvent(
      AddFavoriteRentalEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      // TODO loading indicator
      final response = await _setFavoriteRental.call(
        SetFavoriteRentalParams(
          id: state.rental.id,
          isFavorite: true,
        ),
      );

      response.fold(
        (l) => emit(RentalFailure(l.message)),
        (r) => emit(RentalSuccess(r)),
      );
    }
  }

  Future<void> onRemoveFavoriteRentalEvent(
      RemoveFavoriteRentalEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      // TODO loading indicator

      final response = await _setFavoriteRental.call(
        SetFavoriteRentalParams(
          id: state.rental.id,
        ),
      );

      response.fold(
        (l) => emit(RentalFailure(l.message)),
        (r) => emit(RentalSuccess(r)),
      );
    }
  }
}
