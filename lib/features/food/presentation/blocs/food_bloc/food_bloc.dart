import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetHomeFoodList _getHomeFoodList;

  FoodBloc(GetHomeFoodList getHomeFoodList)
      : _getHomeFoodList = getHomeFoodList,
        super(FoodInitial()) {
    on<GetFoodEvent>(onGetFoodEvent, transformer: restartable());
    on<GetFoodPaginateEvent>(onGetFoodPaginateEvent,
        transformer: restartable());
    on<RefreshFoodEvent>(onRefreshFoodEvent, transformer: restartable());
  }

  FutureOr<void> onRefreshFoodEvent(
      RefreshFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());
  }

  FutureOr<void> onGetFoodEvent(
      GetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());

    final response = await _getHomeFoodList.call(
      GetHomeFoodListParams(
        name: event.search,
        categoryId: event.categoryId,
      ),
    );

    response.fold(
      (l) => emit(FoodFailure(l.message)),
      (r) => emit(FoodSuccess(
        categoryId: event.categoryId,
        search: event.search,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetFoodPaginateEvent(
      GetFoodPaginateEvent event, Emitter<FoodState> emit) async {
    final state = this.state;

    if (state is FoodSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getHomeFoodList.call(
          GetHomeFoodListParams(
            name: state.search,
            previous: state.data.previous,
            next: state.data.next,
            categoryId: state.categoryId,
          ),
        );

        response.fold(
          (l) => emit(FoodFailure(l.message)),
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
