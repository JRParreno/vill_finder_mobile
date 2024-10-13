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
