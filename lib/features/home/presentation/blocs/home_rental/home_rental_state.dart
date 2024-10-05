part of 'home_rental_bloc.dart';

sealed class HomeRentalState extends Equatable {
  const HomeRentalState();

  @override
  List<Object?> get props => [];
}

final class HomeRentalInitial extends HomeRentalState {}

final class HomeRentalLoading extends HomeRentalState {}

final class HomeRentalSuccess extends HomeRentalState {
  final RentalListResponseEntity data;
  final String? search;
  final int? categoryId;

  const HomeRentalSuccess({
    required this.data,
    this.categoryId,
    this.search,
  });

  HomeRentalSuccess copyWith({
    RentalListResponseEntity? data,
    int? categoryId,
    String? search,
  }) {
    return HomeRentalSuccess(
      data: data ?? this.data,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
        data,
        categoryId,
        search,
      ];
}

final class HomeRentalFailure extends HomeRentalState {
  final String message;

  const HomeRentalFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
