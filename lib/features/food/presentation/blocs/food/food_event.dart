part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodEvent extends FoodEvent {
  final int id;

  const GetFoodEvent(this.id);

  @override
  List<Object> get props => [
        id,
      ];
}

class SubmitAddFoodReviewEvent extends FoodEvent {
  final AddReviewParams params;

  const SubmitAddFoodReviewEvent(this.params);

  @override
  List<Object> get props => [params];
}

class SubmitUpdateFoodReviewEvent extends FoodEvent {
  final UpdateReviewParams params;

  const SubmitUpdateFoodReviewEvent(this.params);

  @override
  List<Object> get props => [params];
}
