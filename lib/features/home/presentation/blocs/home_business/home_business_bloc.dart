import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'home_business_event.dart';
part 'home_business_state.dart';

class HomeBusinessBloc extends Bloc<HomeBusinessEvent, HomeBusinessState> {
  final GetHomeBusinessList _getHomeBusinessList;

  HomeBusinessBloc(GetHomeBusinessList getHomeBusinessList)
      : _getHomeBusinessList = getHomeBusinessList,
        super(HomeBusinessInitial()) {
    on<GetHomeBusinessEvent>(onGetHomeBusinessEvent,
        transformer: restartable());
    on<GetHomeBusinessPaginateEvent>(onGetHomeBusinessPaginateEvent,
        transformer: restartable());
    on<RefreshHomeBusinessEvent>(onRefreshHomeBusinessEvent,
        transformer: restartable());
  }

  FutureOr<void> onRefreshHomeBusinessEvent(
      RefreshHomeBusinessEvent event, Emitter<HomeBusinessState> emit) async {
    emit(HomeBusinessLoading());
  }

  FutureOr<void> onGetHomeBusinessEvent(
      GetHomeBusinessEvent event, Emitter<HomeBusinessState> emit) async {
    emit(HomeBusinessLoading());

    final response = await _getHomeBusinessList.call(
      GetHomeBusinessListParams(
        businessName: event.search,
        categoryId: event.categoryId,
      ),
    );

    response.fold(
      (l) => emit(HomeBusinessFailure(l.message)),
      (r) => emit(HomeBusinessSuccess(
        categoryId: event.categoryId,
        search: event.search,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetHomeBusinessPaginateEvent(
      GetHomeBusinessPaginateEvent event,
      Emitter<HomeBusinessState> emit) async {
    final state = this.state;

    if (state is HomeBusinessSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getHomeBusinessList.call(
          GetHomeBusinessListParams(
            businessName: state.search,
            previous: state.data.previous,
            next: state.data.next,
            categoryId: state.categoryId,
          ),
        );

        response.fold(
          (l) => emit(HomeBusinessFailure(l.message)),
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
