import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'home_food_event.dart';
part 'home_food_state.dart';

class HomeFoodBloc extends Bloc<HomeFoodEvent, HomeFoodState> {
  final GetHomeFoodList _getHomeFoodList;

  HomeFoodBloc({
    required GetHomeFoodList getHomeFoodList,
  })  : _getHomeFoodList = getHomeFoodList,
        super(HomeFoodInitial()) {
    on<GetHomeFoodEvent>(onGetHomeFoodEvent, transformer: restartable());
    on<RefreshHomeFoodEvent>(onRefreshHomeFoodEvent,
        transformer: restartable());
  }

  FutureOr<void> onRefreshHomeFoodEvent(
      RefreshHomeFoodEvent event, Emitter<HomeFoodState> emit) async {
    emit(HomeFoodLoading());
  }

  FutureOr<void> onGetHomeFoodEvent(
      GetHomeFoodEvent event, Emitter<HomeFoodState> emit) async {
    emit(HomeFoodLoading());

    final response = await _getHomeFoodList.call(
      GetHomeFoodListParams(
        name: event.search,
      ),
    );

    response.fold(
      (l) => emit(const HomeFoodFailure("Something went wrong.")),
      (r) => emit(
        HomeFoodSuccess(
          data: r,
          categoryId: event.categoryId,
          search: event.search,
        ),
      ),
    );
  }
}
