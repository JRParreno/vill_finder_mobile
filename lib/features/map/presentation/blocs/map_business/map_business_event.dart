part of 'map_business_bloc.dart';

sealed class MapBusinessEvent extends Equatable {
  const MapBusinessEvent();

  @override
  List<Object?> get props => [];
}

final class GetMapBusinessEvent extends MapBusinessEvent {
  final GetBusinessMapListParams params;

  const GetMapBusinessEvent(this.params);

  @override
  List<Object?> get props => [params];
}

final class RefreshMapBusinessEvent extends MapBusinessEvent {}

final class GetMapBusinessPaginateEvent extends MapBusinessEvent {}

final class GetRecentSearches extends MapBusinessEvent {}

final class ClearRecentSearches extends MapBusinessEvent {}

final class TapSearchResultEvent extends MapBusinessEvent {
  final RentalEntity? rental;
  final FoodEstablishmentEntity? food;

  const TapSearchResultEvent({
    this.rental,
    this.food,
  });

  @override
  List<Object?> get props => [
        rental,
        food,
      ];
}

final class ResetMapOverrideStatus extends MapBusinessEvent {}
