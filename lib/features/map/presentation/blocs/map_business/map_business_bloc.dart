import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';

part 'map_business_event.dart';
part 'map_business_state.dart';

class MapBusinessBloc extends Bloc<MapBusinessEvent, MapBusinessState> {
  final GetBusinessMapList _getBusinessMapList;

  MapBusinessBloc(GetBusinessMapList getBusinessMapList)
      : _getBusinessMapList = getBusinessMapList,
        super(MapBusinessInitial()) {
    on<GetMapBusinessEvent>(onGetMapBusinessEvent, transformer: restartable());
    on<GetMapBusinessPaginateEvent>(onGetMapBusinessPaginateEvent,
        transformer: restartable());
    on<RefreshMapBusinessEvent>(onRefreshMapBusinessEvent,
        transformer: restartable());
  }

  FutureOr<void> onRefreshMapBusinessEvent(
      RefreshMapBusinessEvent event, Emitter<MapBusinessState> emit) async {
    emit(MapBusinessLoading());
  }

  FutureOr<void> onGetMapBusinessEvent(
      GetMapBusinessEvent event, Emitter<MapBusinessState> emit) async {
    emit(MapBusinessLoading());

    final response = await _getBusinessMapList.call(event.params);

    response.fold(
      (l) => emit(MapBusinessFailure(l.message)),
      (r) => emit(MapBusinessSuccess(
        params: event.params,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetMapBusinessPaginateEvent(
      GetMapBusinessPaginateEvent event, Emitter<MapBusinessState> emit) async {
    final state = this.state;

    if (state is MapBusinessSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getBusinessMapList.call(
          GetBusinessMapListParams(
            maxLatitude: state.params.maxLatitude,
            maxLongitude: state.params.maxLongitude,
            minLatitude: state.params.minLatitude,
            minLongitude: state.params.minLongitude,
            name: state.params.name,
            next: state.data.next,
            previous: state.data.previous,
          ),
        );

        response.fold(
          (l) => emit(MapBusinessFailure(l.message)),
          (r) => emit(
            state.copyWith(
              data: r.copyWith(
                results: state.data.results.copyWith(foods: [
                  ...state.data.results.foods,
                  ...r.results.foods
                ], rentals: [
                  ...state.data.results.rentals,
                  ...r.results.rentals
                ]),
              ),
              isPaginate: false,
            ),
          ),
        );
      }
    }
  }
}
