part of 'rental_bloc.dart';

sealed class RentalEvent extends Equatable {
  const RentalEvent();

  @override
  List<Object> get props => [];
}

class GetRentalEvent extends RentalEvent {
  final int id;

  const GetRentalEvent(this.id);

  @override
  List<Object> get props => [
        id,
      ];
}

class AddFavoriteRentalEvent extends RentalEvent {}

class RemoveFavoriteRentalEvent extends RentalEvent {}

class SubmitAddReviewEvent extends RentalEvent {
  final AddReviewParams params;

  const SubmitAddReviewEvent(this.params);

  @override
  List<Object> get props => [params];
}
