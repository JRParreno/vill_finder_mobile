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

final class SetRentalStateEvent extends RentalEvent {
  final RentalListResponseEntity data;
  final String? search;

  const SetRentalStateEvent({
    required this.data,
    this.search,
  });

  @override
  List<Object?> get props => [
        data,
        search,
      ];
}
