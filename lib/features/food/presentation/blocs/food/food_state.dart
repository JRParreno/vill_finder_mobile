part of 'food_bloc.dart';

sealed class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

final class FoodInitial extends FoodState {}

final class FoodLoading extends FoodState {}

final class FoodSuccess extends FoodState {
  final FoodEstablishmentEntity food;
  final ViewStatus viewStatus;
  final String? successMessage;

  const FoodSuccess({
    required this.food,
    this.viewStatus = ViewStatus.none,
    this.successMessage,
  });

  FoodSuccess copyWith({
    FoodEstablishmentEntity? food,
    ViewStatus? viewStatus,
    String? successMessage,
  }) {
    return FoodSuccess(
      food: food ?? this.food,
      viewStatus: viewStatus ?? this.viewStatus,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        food,
        viewStatus,
        successMessage,
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
