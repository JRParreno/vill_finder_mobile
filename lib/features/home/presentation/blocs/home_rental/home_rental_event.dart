part of 'home_rental_bloc.dart';

sealed class HomeRentalEvent extends Equatable {
  const HomeRentalEvent();

  @override
  List<Object?> get props => [];
}

final class GetHomeRentalEvent extends HomeRentalEvent {
  final String? search;
  final int? categoryId;

  const GetHomeRentalEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshHomeRentalEvent extends HomeRentalEvent {}

final class UpdateHomeFavoriteRentalEvent extends HomeRentalEvent {
  final int id;
  final bool value;

  const UpdateHomeFavoriteRentalEvent({
    required this.id,
    this.value = false,
  });

  @override
  List<Object?> get props => [id, value];
}
