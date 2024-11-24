part of 'map_business_bloc.dart';

sealed class MapBusinessState extends Equatable {
  const MapBusinessState();

  @override
  List<Object?> get props => [];
}

final class MapBusinessInitial extends MapBusinessState {}

final class MapBusinessLoading extends MapBusinessState {}

final class MapBusinessEmpty extends MapBusinessState {}

final class MapBusinessRecentLoaded extends MapBusinessState {
  final List<String> keywords;

  const MapBusinessRecentLoaded(this.keywords);

  @override
  List<Object> get props => [
        keywords,
      ];
}

final class MapBusinessSuccess extends MapBusinessState {
  final SearchMapResponseEntity data;
  final bool isPaginate;
  final GetBusinessMapListParams params;
  final RentalEntity? rental;
  final FoodEstablishmentEntity? food;
  final bool isOverrideMap;
  final ViewStatus viewStatus;

  const MapBusinessSuccess({
    required this.data,
    required this.params,
    this.isPaginate = false,
    this.food,
    this.rental,
    this.isOverrideMap = false,
    this.viewStatus = ViewStatus.none,
  });

  MapBusinessSuccess copyWith({
    SearchMapResponseEntity? data,
    bool? isPaginate,
    GetBusinessMapListParams? params,
    RentalEntity? rental,
    FoodEstablishmentEntity? food,
    bool? isOverrideMap,
    ViewStatus? viewStatus,
  }) {
    return MapBusinessSuccess(
      data: data ?? this.data,
      params: params ?? this.params,
      isPaginate: isPaginate ?? this.isPaginate,
      food: food ?? this.food,
      rental: rental ?? this.rental,
      isOverrideMap: isOverrideMap ?? this.isOverrideMap,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }

  @override
  List<Object?> get props =>
      [data, isPaginate, params, isOverrideMap, food, rental, viewStatus];
}

final class MapBusinessFailure extends MapBusinessState {
  final String message;

  const MapBusinessFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
