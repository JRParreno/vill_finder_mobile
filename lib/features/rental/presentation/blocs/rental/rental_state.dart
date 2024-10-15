part of 'rental_bloc.dart';

sealed class RentalState extends Equatable {
  const RentalState();

  @override
  List<Object> get props => [];
}

final class RentalInitial extends RentalState {}

final class RentalLoading extends RentalState {}

final class RentalSuccess extends RentalState {
  final RentalEntity rental;
  final ViewStatus viewStatus;
  const RentalSuccess({
    required this.rental,
    this.viewStatus = ViewStatus.none,
  });

  RentalSuccess copyWith({
    RentalEntity? rental,
    ViewStatus? viewStatus,
  }) {
    return RentalSuccess(
      rental: rental ?? this.rental,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }

  @override
  List<Object> get props => [rental, viewStatus];
}

final class RentalFailure extends RentalState {
  final String message;

  const RentalFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
