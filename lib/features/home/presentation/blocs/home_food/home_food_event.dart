part of 'home_food_bloc.dart';

sealed class HomeFoodEvent extends Equatable {
  const HomeFoodEvent();

  @override
  List<Object?> get props => [];
}

final class GetHomeFoodEvent extends HomeFoodEvent {
  final String? search;
  final int? categoryId;

  const GetHomeFoodEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshHomeFoodEvent extends HomeFoodEvent {}
