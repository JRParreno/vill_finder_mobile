import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/features/food/domain/usecases/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/review/domain/usecases/index.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodEstablishment _getFoodEstablishment;
  final AddReview _addReview;
  final UpdateReview _updateReview;

  FoodBloc({
    required GetFoodEstablishment getFoodEstablishment,
    required AddReview addReview,
    required UpdateReview updateReview,
  })  : _getFoodEstablishment = getFoodEstablishment,
        _addReview = addReview,
        _updateReview = updateReview,
        super(FoodInitial()) {
    on<GetFoodEvent>(onGetFoodEvent);
    on<SubmitAddFoodReviewEvent>(onSubmitAddReviewEvent);
    on<SubmitUpdateFoodReviewEvent>(onSubmitUpdateFoodReviewEvent);
  }

  Future<void> onGetFoodEvent(
      GetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());

    final response = await _getFoodEstablishment.call(event.id);

    response.fold(
      (l) => emit(FoodFailure(l.message)),
      (r) => emit(FoodSuccess(food: r)),
    );
  }

  Future<void> onSubmitAddReviewEvent(
      SubmitAddFoodReviewEvent event, Emitter<FoodState> emit) async {
    final state = this.state;

    if (state is FoodSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _addReview.call(event.params);

      final place = state.food.place.copyWith(userHasReviewed: true);

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(
          state.copyWith(
              food: state.food.copyWith(
                place: place,
              ),
              viewStatus: ViewStatus.successful,
              successMessage: "Successfully add your review."),
        ),
      );
    }
  }

  Future<void> onSubmitUpdateFoodReviewEvent(
      SubmitUpdateFoodReviewEvent event, Emitter<FoodState> emit) async {
    final state = this.state;

    if (state is FoodSuccess) {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final response = await _updateReview.call(event.params);

      final place = state.food.place.copyWith(
          userHasReviewed: true,
          reviewEntity: response
              .getRight()
              .getOrElse(() => throw Exception('something went wrong')));

      response.fold(
        (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
        (r) => emit(
          state.copyWith(
              food: state.food.copyWith(
                place: place,
              ),
              viewStatus: ViewStatus.successful,
              successMessage: "Successfully update your review."),
        ),
      );
    }
  }
}
