part of 'home_rental_bloc.dart';

sealed class HomeRentalListState extends Equatable {
  const HomeRentalListState();

  @override
  List<Object?> get props => [];
}

final class HomeRentalInitial extends HomeRentalListState {}

final class HomeRentalListLoading extends HomeRentalListState {}

final class HomeRentalListSuccess extends HomeRentalListState {
  final RentalListResponseEntity featureRentals;
  final RentalListResponseEntity nonFeatureRentals;

  final String? search;
  final int? categoryId;

  const HomeRentalListSuccess({
    required this.featureRentals,
    required this.nonFeatureRentals,
    this.categoryId,
    this.search,
  });

  HomeRentalListSuccess copyWith({
    RentalListResponseEntity? featureRentals,
    RentalListResponseEntity? nonFeatureRentals,
    int? categoryId,
    String? search,
  }) {
    return HomeRentalListSuccess(
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

final class HomeRentalListFailure extends HomeRentalListState {
  final String message;

  const HomeRentalListFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
