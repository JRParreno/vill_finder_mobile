part of 'rental_bloc.dart';

sealed class RentalState extends Equatable {
  const RentalState();

  @override
  List<Object?> get props => [];
}

final class RentalInitial extends RentalState {}

final class RentalLoading extends RentalState {}

final class RentalSuccess extends RentalState {
  final RentalListResponseEntity data;
  final bool isPaginate;
  final String? search;
  final int? categoryId;

  const RentalSuccess({
    required this.data,
    this.categoryId,
    this.search,
    this.isPaginate = false,
  });

  RentalSuccess copyWith({
    RentalListResponseEntity? data,
    bool? isPaginate,
    int? categoryId,
    String? search,
  }) {
    return RentalSuccess(
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

final class RentalFailure extends RentalState {
  final String message;

  const RentalFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
