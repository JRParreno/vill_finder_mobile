part of 'rental_bloc.dart';

sealed class RentalEvent extends Equatable {
  const RentalEvent();

  @override
  List<Object?> get props => [];
}

final class GetRentalEvent extends RentalEvent {
  final String? search;
  final int? categoryId;

  const GetRentalEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshRentalEvent extends RentalEvent {}

final class GetRentalPaginateEvent extends RentalEvent {}
