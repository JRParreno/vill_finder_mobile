part of 'home_food_bloc.dart';

sealed class HomeFoodListState extends Equatable {
  const HomeFoodListState();

  @override
  List<Object?> get props => [];
}

final class HomeFoodInitial extends HomeFoodListState {}

final class HomeFoodLoading extends HomeFoodListState {}

final class HomeFoodSuccess extends HomeFoodListState {
  final FoodEstablishmentListResponseEntity data;
  final String? search;
  final int? categoryId;

  const HomeFoodSuccess({
    required this.data,
    this.categoryId,
    this.search,
  });

  HomeFoodSuccess copyWith({
    FoodEstablishmentListResponseEntity? data,
    int? categoryId,
    String? search,
  }) {
    return HomeFoodSuccess(
      data: data ?? this.data,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
        data,
        categoryId,
        search,
      ];
}

final class HomeFoodFailure extends HomeFoodListState {
  final String message;

  const HomeFoodFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
