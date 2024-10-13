part of 'home_food_bloc.dart';

sealed class HomeFoodListEvent extends Equatable {
  const HomeFoodListEvent();

  @override
  List<Object?> get props => [];
}

final class GetHomeFoodListEvent extends HomeFoodListEvent {
  final String? search;
  final int? categoryId;

  const GetHomeFoodListEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshHomeFoodListEvent extends HomeFoodListEvent {}
