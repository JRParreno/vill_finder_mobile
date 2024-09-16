import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
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
            businessName: state.params.businessName,
            next: state.data.next,
            previous: state.data.previous,
          ),
        );

        response.fold(
          (l) => emit(MapBusinessFailure(l.message)),
          (r) => emit(
            state.copyWith(
              data: r.copyWith(
                results: [...state.data.results, ...r.results],
              ),
              isPaginate: false,
            ),
          ),
        );
      }
    }
  }
}
