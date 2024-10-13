part of 'food_list_bloc.dart';

sealed class FoodListEvent extends Equatable {
  const FoodListEvent();

  @override
  List<Object?> get props => [];
}

final class GetFoodListEvent extends FoodListEvent {
  final String? search;
  final int? categoryId;

  const GetFoodListEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshFoodListEvent extends FoodListEvent {}

final class GetFoodPaginateEvent extends FoodListEvent {}

final class SetFoodListStateEvent extends FoodListEvent {
  final FoodEstablishmentListResponseEntity data;
  final String? search;

  const SetFoodListStateEvent({
    required this.data,
    this.search,
  });

  @override
  List<Object?> get props => [
        data,
        search,
      ];
}
