part of 'rental_bloc.dart';

sealed class RentalState extends Equatable {
  const RentalState();

  @override
  List<Object?> get props => [];
}

final class RentalInitial extends RentalState {}

final class RentalLoading extends RentalState {}

final class RentalSuccess extends RentalState {
  final RentalEntity rental;
  final ViewStatus viewStatus;
  final String? successMessage;

  const RentalSuccess({
    required this.rental,
    this.viewStatus = ViewStatus.none,
    this.successMessage,
  });

  RentalSuccess copyWith({
    RentalEntity? rental,
    ViewStatus? viewStatus,
    String? successMessage,
  }) {
    return RentalSuccess(
      rental: rental ?? this.rental,
      viewStatus: viewStatus ?? this.viewStatus,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [rental, viewStatus, successMessage];
}

final class RentalFailure extends RentalState {
  final String message;

  const RentalFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
