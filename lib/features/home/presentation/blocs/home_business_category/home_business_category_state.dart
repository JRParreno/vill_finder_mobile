part of 'home_business_category_bloc.dart';

sealed class HomeBusinessCategoryState extends Equatable {
  const HomeBusinessCategoryState();

  @override
  List<Object> get props => [];
}

final class HomeBusinessCategoryInitial extends HomeBusinessCategoryState {}

final class HomeBusinessCategoryLoading extends HomeBusinessCategoryState {}

final class HomeBusinessCategorySuccess extends HomeBusinessCategoryState {
  final BusinessCategoryListResponseEntity data;
  final bool isPaginate;
  final int selected;

  const HomeBusinessCategorySuccess({
    required this.data,
    this.isPaginate = false,
    this.selected = 0,
  });

  HomeBusinessCategorySuccess copyWith({
    BusinessCategoryListResponseEntity? data,
    bool? isPaginate,
    int? selected,
  }) {
    return HomeBusinessCategorySuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object> get props => [
        data,
        isPaginate,
        selected,
      ];
}

final class HomeBusinessCategoryFailure extends HomeBusinessCategoryState {
  final String message;

  const HomeBusinessCategoryFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
