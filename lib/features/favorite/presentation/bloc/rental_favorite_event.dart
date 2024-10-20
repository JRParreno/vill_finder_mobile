part of 'rental_favorite_bloc.dart';

sealed class RentalFavoriteEvent extends Equatable {
  const RentalFavoriteEvent();

  @override
  List<Object> get props => [];
}

final class GetFavoriteEvent extends RentalFavoriteEvent {}

final class PaginateFavoriteEvent extends RentalFavoriteEvent {}
