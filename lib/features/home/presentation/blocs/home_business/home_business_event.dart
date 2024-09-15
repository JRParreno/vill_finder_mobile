part of 'home_business_bloc.dart';

sealed class HomeBusinessEvent extends Equatable {
  const HomeBusinessEvent();

  @override
  List<Object?> get props => [];
}

final class GetHomeBusinessEvent extends HomeBusinessEvent {
  final String? search;
  final int? categoryId;

  const GetHomeBusinessEvent({
    this.categoryId,
    this.search,
  });

  @override
  List<Object?> get props => [search];
}

final class RefreshHomeBusinessEvent extends HomeBusinessEvent {}

final class GetHomeBusinessPaginateEvent extends HomeBusinessEvent {}
