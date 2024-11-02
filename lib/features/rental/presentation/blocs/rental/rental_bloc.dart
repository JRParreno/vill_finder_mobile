import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/domain/usecases/index.dart';
import 'package:vill_finder/features/review/domain/usecases/index.dart';

part 'rental_event.dart';
part 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final GetRental _getRental;
  final SetFavoriteRental _setFavoriteRental;
  final AddReview _addReview;
  final UpdateReview _updateReview;

  RentalBloc({
    required GetRental getRental,
    required SetFavoriteRental setFavoriteRental,
    required AddReview addReview,
    required UpdateReview updateReview,
  })  : _getRental = getRental,
        _setFavoriteRental = setFavoriteRental,
        _addReview = addReview,
        _updateReview = updateReview,
        super(RentalInitial()) {
    on<GetRentalEvent>(onGetRentalEvent);
    on<AddFavoriteRentalEvent>(onAddFavoriteRentalEvent);
    on<RemoveFavoriteRentalEvent>(onRemoveFavoriteRentalEvent);
    on<SubmitAddReviewEvent>(onSubmitAddReviewEvent);
    on<SubmitUpdateReviewEvent>(onSubmitUpdateReviewEvent);
  }

  Future<void> onSubmitAddReviewEvent(
      SubmitAddReviewEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _addReview.call(event.params);

      response.fold((l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
          (r) {
        final place = state.rental.place.copyWith(
          userHasReviewed: true,
          reviewEntity: r,
          totalReview: state.rental.place.totalReview + 1,
        );

        emit(
          state.copyWith(
              rental: state.rental.copyWith(
                place: place,
              ),
              viewStatus: ViewStatus.successful,
              successMessage: "Successfully add your review."),
        );
      });
    }
  }

  Future<void> onSubmitUpdateReviewEvent(
      SubmitUpdateReviewEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _updateReview.call(event.params);

      final place = state.rental.place;

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(
          state.copyWith(
              rental: state.rental.copyWith(
                place: place.copyWith(
                  userHasReviewed: true,
                  reviewEntity: r,
                ),
              ),
              viewStatus: ViewStatus.successful,
              successMessage: "Successfully update your review."),
        ),
      );
    }
  }

  Future<void> onGetRentalEvent(
      GetRentalEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());

    final response = await _getRental.call(event.id);

    response.fold(
      (l) => emit(RentalFailure(l.message)),
      (r) => emit(RentalSuccess(rental: r)),
    );
  }

  Future<void> onAddFavoriteRentalEvent(
      AddFavoriteRentalEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));
      final response = await _setFavoriteRental.call(
        SetFavoriteRentalParams(
          id: state.rental.id,
          isFavorite: true,
        ),
      );

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(RentalSuccess(
            rental: r,
            viewStatus: ViewStatus.successful,
            successMessage: "Successfully added to your favorites.")),
      );
    }
  }

  Future<void> onRemoveFavoriteRentalEvent(
      RemoveFavoriteRentalEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _setFavoriteRental.call(
        SetFavoriteRentalParams(
          id: state.rental.id,
        ),
      );

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(RentalSuccess(
            rental: r,
            viewStatus: ViewStatus.successful,
            successMessage: "Successfully removed to your favorites.")),
      );
    }
  }
}
