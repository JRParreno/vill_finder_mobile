part of 'rental_list_bloc.dart';

sealed class RentalListState extends Equatable {
  const RentalListState();

  @override
  List<Object?> get props => [];
}

final class RentalListInitial extends RentalListState {}

final class RentalListLoading extends RentalListState {}

final class RentalListSuccess extends RentalListState {
  final RentalListResponseEntity data;
  final bool isPaginate;
  final String? search;
  final int? categoryId;

  const RentalListSuccess({
    required this.data,
    this.categoryId,
    this.search,
    this.isPaginate = false,
  });

  RentalListSuccess copyWith({
    RentalListResponseEntity? data,
    bool? isPaginate,
    int? categoryId,
    String? search,
  }) {
    return RentalListSuccess(
      data: data ?? this.data,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object?> get props => [
        data,
        isPaginate,
        categoryId,
        search,
      ];
}

final class RentalListFailure extends RentalListState {
  final String message;

  const RentalListFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
