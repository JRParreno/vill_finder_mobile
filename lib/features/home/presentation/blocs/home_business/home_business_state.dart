part of 'home_business_bloc.dart';

sealed class HomeBusinessState extends Equatable {
  const HomeBusinessState();

  @override
  List<Object?> get props => [];
}

final class HomeBusinessInitial extends HomeBusinessState {}

final class HomeBusinessLoading extends HomeBusinessState {}

final class HomeBusinessSuccess extends HomeBusinessState {
  final BusinessListResponseEntity data;
  final bool isPaginate;
  final String? search;
  final int? categoryId;

  const HomeBusinessSuccess({
    required this.data,
    this.categoryId,
    this.search,
    this.isPaginate = false,
  });

  HomeBusinessSuccess copyWith({
    BusinessListResponseEntity? data,
    bool? isPaginate,
    int? categoryId,
    String? search,
  }) {
    return HomeBusinessSuccess(
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

final class HomeBusinessFailure extends HomeBusinessState {
  final String message;

  const HomeBusinessFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
