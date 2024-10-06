part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchGetRecentSearches extends SearchEvent {}

final class SearchTriggerEvent extends SearchEvent {
  final String keyword;

  const SearchTriggerEvent(this.keyword);

  @override
  List<Object> get props => [
        keyword,
      ];
}

final class SearchClearRecentSearches extends SearchEvent {}
