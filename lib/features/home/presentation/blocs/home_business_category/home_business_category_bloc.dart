import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/usecase/usecase.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'home_business_category_event.dart';
part 'home_business_category_state.dart';

class HomeBusinessCategoryBloc
    extends Bloc<HomeBusinessCategoryEvent, HomeBusinessCategoryState> {
  final GetHomeBusinessCategoryList _getHomeBusinessCategoryList;

  HomeBusinessCategoryBloc(
      GetHomeBusinessCategoryList getHomeBusinessCategoryList)
      : _getHomeBusinessCategoryList = getHomeBusinessCategoryList,
        super(HomeBusinessCategoryInitial()) {
    on<GetHomeBusinessCategoryEvent>(onGetHomeBusinessEvent);
    on<GetHomeBusinessCategoryPaginateEvent>(onGetHomeBusinessPaginateEvent);
    on<OnTapHomeBusinessCategoryEvent>(onTapHomeBusinessCategoryEvent);
  }

  FutureOr<void> onTapHomeBusinessCategoryEvent(
      OnTapHomeBusinessCategoryEvent event,
      Emitter<HomeBusinessCategoryState> emit) async {
    final state = this.state;

    if (state is HomeBusinessCategorySuccess) {
      emit(state.copyWith(selected: event.index));
    }
  }

  FutureOr<void> onGetHomeBusinessEvent(GetHomeBusinessCategoryEvent event,
      Emitter<HomeBusinessCategoryState> emit) async {
    emit(HomeBusinessCategoryLoading());

    final response =
        await _getHomeBusinessCategoryList.call(PaginationParams());

    response.fold(
      (l) => emit(HomeBusinessCategoryFailure(l.message)),
      (r) => emit(
        HomeBusinessCategorySuccess(
          data: r.copyWith(
            results: [BusinessCategoryEntity.empty(), ...r.results],
          ),
        ),
      ),
    );
  }

  FutureOr<void> onGetHomeBusinessPaginateEvent(
      GetHomeBusinessCategoryPaginateEvent event,
      Emitter<HomeBusinessCategoryState> emit) async {
    final state = this.state;

    if (state is HomeBusinessCategorySuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response =
            await _getHomeBusinessCategoryList.call(PaginationParams(
          previous: state.data.previous,
          next: state.data.next,
        ));

        response.fold(
          (l) => emit(HomeBusinessCategoryFailure(l.message)),
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
