import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';

part 'map_business_event.dart';
part 'map_business_state.dart';

class MapBusinessBloc extends Bloc<MapBusinessEvent, MapBusinessState> {
  final GetBusinessMapList _getBusinessMapList;
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final CategoryCubit _categoryCubit;

  MapBusinessBloc({
    required GetBusinessMapList getBusinessMapList,
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required CategoryCubit categoryCubit,
  })  : _getBusinessMapList = getBusinessMapList,
        _sharedPreferencesNotifier = sharedPreferencesNotifier,
        _categoryCubit = categoryCubit,
        super(MapBusinessInitial()) {
    on<GetMapBusinessEvent>(onGetMapBusinessEvent, transformer: restartable());
    on<GetMapBusinessPaginateEvent>(onGetMapBusinessPaginateEvent,
        transformer: restartable());
    on<RefreshMapBusinessEvent>(onRefreshMapBusinessEvent,
        transformer: restartable());
    on<GetRecentSearches>(onGetRecentSearches, transformer: restartable());
    on<ClearRecentSearches>(onClearRecentSearches, transformer: restartable());
    on<TapSearchResultEvent>(onTapSearchResultEvent, transformer: sequential());
    on<ResetMapOverrideStatus>(onResetMapOverrideStatus,
        transformer: sequential());
  }

  FutureOr<void> onResetMapOverrideStatus(
      ResetMapOverrideStatus event, Emitter<MapBusinessState> emit) async {
    final state = this.state;

    if (state is MapBusinessSuccess) {
      emit(
        state.copyWith(
          isOverrideMap: false,
        ),
      );
    }
  }

  FutureOr<void> onRefreshMapBusinessEvent(
      RefreshMapBusinessEvent event, Emitter<MapBusinessState> emit) async {
    emit(MapBusinessLoading());
  }

  FutureOr<void> onTapSearchResultEvent(
      TapSearchResultEvent event, Emitter<MapBusinessState> emit) async {
    final state = this.state;

    if (state is MapBusinessSuccess) {
      emit(
        state.copyWith(
          food: event.food,
          isOverrideMap: true,
          rental: event.rental,
        ),
      );
    }
  }

  FutureOr<void> onGetRecentSearches(
      GetRecentSearches event, Emitter<MapBusinessState> emit) async {
    final List<String> recentSearches = _sharedPreferencesNotifier
        .getValue(SharedPreferencesKeys.recentSearches, []);

    emit(MapBusinessRecentLoaded(recentSearches));
  }

  void onClearRecentSearches(
      ClearRecentSearches event, Emitter<MapBusinessState> emit) {
    final List<String> recentSearches = [];
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.recentSearches, recentSearches);

    emit(const MapBusinessRecentLoaded([]));
  }

  FutureOr<void> onGetMapBusinessEvent(
      GetMapBusinessEvent event, Emitter<MapBusinessState> emit) async {
    emit(MapBusinessLoading());
    final params = GetBusinessMapListParams(
        latitude: event.params.latitude,
        longitude: event.params.longitude,
        name: event.params.name,
        next: event.params.next,
        previous: event.params.previous,
        categoryIds: _categoryCubit.state.filteredCategories
            .map(
              (e) => e.id,
            )
            .toList());

    final response = await _getBusinessMapList.call(params);

    response.fold(
      (l) => emit(MapBusinessFailure(l.message)),
      (r) {
        emit(MapBusinessSuccess(
          params: event.params,
          data: r,
        ));

        final keyword = event.params.name;

        if (keyword != null && keyword.isNotEmpty) {
          saveLocalRecentSearches(keyword);
        }
      },
    );
  }

  void saveLocalRecentSearches(String keyword) {
    // set local recent searches

    final List<String> recentSearches = _sharedPreferencesNotifier
        .getValue(SharedPreferencesKeys.recentSearches, []);

    if (recentSearches.isNotEmpty) {
      if (recentSearches.length > 5) return;

      final isExists = recentSearches.where(
        (element) => element.toLowerCase().contains(keyword.toLowerCase()),
      );

      if (isExists.isNotEmpty) return;
    }
    recentSearches.add(keyword);
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.recentSearches, recentSearches);
  }

  FutureOr<void> onGetMapBusinessPaginateEvent(
      GetMapBusinessPaginateEvent event, Emitter<MapBusinessState> emit) async {
    final state = this.state;

    if (state is MapBusinessSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getBusinessMapList.call(
          GetBusinessMapListParams(
            longitude: state.params.longitude,
            latitude: state.params.latitude,
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
