part of 'home_rental_bloc.dart';

sealed class HomeRentalState extends Equatable {
  const HomeRentalState();

  @override
  List<Object?> get props => [];
}

final class HomeRentalInitial extends HomeRentalState {}

final class HomeRentalLoading extends HomeRentalState {}

final class HomeRentalSuccess extends HomeRentalState {
  final RentalListResponseEntity featureRentals;
  final RentalListResponseEntity nonFeatureRentals;

  final String? search;
  final int? categoryId;

  const HomeRentalSuccess({
    required this.featureRentals,
    required this.nonFeatureRentals,
    this.categoryId,
    this.search,
  });

  HomeRentalSuccess copyWith({
    RentalListResponseEntity? featureRentals,
    RentalListResponseEntity? nonFeatureRentals,
    int? categoryId,
    String? search,
  }) {
    return HomeRentalSuccess(
      featureRentals: featureRentals ?? this.featureRentals,
      nonFeatureRentals: nonFeatureRentals ?? this.nonFeatureRentals,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
        featureRentals,
        nonFeatureRentals,
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
