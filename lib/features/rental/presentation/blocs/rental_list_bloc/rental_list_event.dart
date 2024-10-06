part of 'rental_list_bloc.dart';

sealed class RentalListEvent extends Equatable {
  const RentalListEvent();

  @override
  List<Object?> get props => [];
}

final class GetRentalListEvent extends RentalListEvent {
  final String? search;
  final int? categoryId;

  const GetRentalListEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshRentalListEvent extends RentalListEvent {}

final class GetRentalListPaginateEvent extends RentalListEvent {}

final class SetRentalListStateEvent extends RentalListEvent {
  final RentalListResponseEntity data;
  final String? search;

  const SetRentalListStateEvent({
    required this.data,
    this.search,
  });

  @override
  List<Object?> get props => [
        data,
        search,
      ];
}
