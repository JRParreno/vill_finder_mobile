part of 'home_business_category_bloc.dart';

sealed class HomeBusinessCategoryEvent extends Equatable {
  const HomeBusinessCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetHomeBusinessCategoryEvent extends HomeBusinessCategoryEvent {}

final class GetHomeBusinessCategoryPaginateEvent
    extends HomeBusinessCategoryEvent {}

final class OnTapHomeBusinessCategoryEvent extends HomeBusinessCategoryEvent {
  final int index;

  const OnTapHomeBusinessCategoryEvent(this.index);

  @override
  List<Object> get props => [index];
}
