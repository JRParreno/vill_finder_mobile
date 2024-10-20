part of 'rental_favorite_bloc.dart';

sealed class RentalFavoriteState extends Equatable {
  const RentalFavoriteState();

  @override
  List<Object> get props => [];
}

final class RentalFavoriteInitial extends RentalFavoriteState {}

final class RentalFavoriteLoading extends RentalFavoriteState {}

final class RentalFavoriteSuccess extends RentalFavoriteState {
  final RentalListResponseEntity favorites;
  final ViewStatus viewStatus;

  const RentalFavoriteSuccess({
    required this.favorites,
    this.viewStatus = ViewStatus.none,
  });

  RentalFavoriteSuccess copyWith({
    RentalListResponseEntity? favorites,
    ViewStatus? viewStatus,
  }) {
    return RentalFavoriteSuccess(
      favorites: favorites ?? this.favorites,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }

  @override
  List<Object> get props => [favorites, viewStatus];
}

final class RentalFavoriteFailure extends RentalFavoriteState {
  final String message;

  const RentalFavoriteFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
