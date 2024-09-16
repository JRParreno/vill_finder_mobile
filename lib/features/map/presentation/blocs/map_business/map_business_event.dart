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
