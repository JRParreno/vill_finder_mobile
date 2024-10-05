part of 'map_business_bloc.dart';

sealed class MapBusinessState extends Equatable {
  const MapBusinessState();

  @override
  List<Object?> get props => [];
}

final class MapBusinessInitial extends MapBusinessState {}

final class MapBusinessLoading extends MapBusinessState {}

final class MapBusinessSuccess extends MapBusinessState {
  final SearchMapResponseEntity data;
  final bool isPaginate;
  final GetBusinessMapListParams params;

  const MapBusinessSuccess({
    required this.data,
    required this.params,
    this.isPaginate = false,
  });

  MapBusinessSuccess copyWith({
    SearchMapResponseEntity? data,
    bool? isPaginate,
    GetBusinessMapListParams? params,
  }) {
    return MapBusinessSuccess(
      data: data ?? this.data,
      params: params ?? this.params,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object?> get props => [
        data,
        isPaginate,
        params,
      ];
}

final class MapBusinessFailure extends MapBusinessState {
  final String message;

  const MapBusinessFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
