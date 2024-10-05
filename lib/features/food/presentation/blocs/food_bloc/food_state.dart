part of 'food_bloc.dart';

sealed class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

final class FoodInitial extends FoodState {}

final class FoodLoading extends FoodState {}

final class FoodSuccess extends FoodState {
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

final class FoodFailure extends FoodState {
  final String message;

  const FoodFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
