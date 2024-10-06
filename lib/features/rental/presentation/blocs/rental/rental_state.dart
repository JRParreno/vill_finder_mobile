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
  const RentalSuccess(this.rental);

  @override
  List<Object> get props => [
        rental,
      ];
}

final class RentalFailure extends RentalState {
  final String message;

  const RentalFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
