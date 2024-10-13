part of 'food_list_bloc.dart';

sealed class FoodListState extends Equatable {
  const FoodListState();

  @override
  List<Object?> get props => [];
}

final class FoodInitial extends FoodListState {}

final class FoodLoading extends FoodListState {}

final class FoodSuccess extends FoodListState {
  final FoodEstablishmentListResponseEntity data;
  final bool isPaginate;
  final String? search;
  final int? categoryId;

  const FoodSuccess({
    required this.data,
    this.categoryId,
    this.search,
    this.isPaginate = false,
  });

  FoodSuccess copyWith({
    FoodEstablishmentListResponseEntity? data,
    bool? isPaginate,
    int? categoryId,
    String? search,
  }) {
    return FoodSuccess(
      data: data ?? this.data,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object?> get props => [
        data,
        isPaginate,
        categoryId,
        search,
      ];
}

final class FoodFailure extends FoodListState {
  final String message;

  const FoodFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
