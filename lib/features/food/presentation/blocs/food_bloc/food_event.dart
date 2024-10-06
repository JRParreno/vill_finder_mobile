part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object?> get props => [];
}

final class GetFoodEvent extends FoodEvent {
  final String? search;
  final int? categoryId;

  const GetFoodEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshFoodEvent extends FoodEvent {}

final class GetFoodPaginateEvent extends FoodEvent {}

final class SetFoodStateEvent extends FoodEvent {
  final FoodEstablishmentListResponseEntity data;
  final String? search;

  const SetFoodStateEvent({
    required this.data,
    this.search,
  });

  @override
  List<Object?> get props => [
        data,
        search,
      ];
}
