import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'rental_list_event.dart';
part 'rental_list_state.dart';

class RentalListBloc extends Bloc<RentalListEvent, RentalListState> {
  final GetHomeRentalList _getHomeRentalListList;

  RentalListBloc(GetHomeRentalList getHomeRentalListList)
      : _getHomeRentalListList = getHomeRentalListList,
        super(RentalListInitial()) {
    on<GetRentalListEvent>(onGetRentalListEvent, transformer: restartable());
    on<GetRentalListPaginateEvent>(onGetRentalListPaginateEvent,
        transformer: restartable());
    on<RefreshRentalListEvent>(onRefreshRentalListEvent,
        transformer: restartable());
    on<SetRentalListStateEvent>(onSetRentalListStateEvent,
        transformer: restartable());
  }

  FutureOr<void> onRefreshRentalListEvent(
      RefreshRentalListEvent event, Emitter<RentalListState> emit) async {
    emit(RentalListLoading());
  }

  FutureOr<void> onSetRentalListStateEvent(
      SetRentalListStateEvent event, Emitter<RentalListState> emit) async {
    emit(
      RentalListSuccess(
        data: event.data,
        search: event.search,
      ),
    );
  }

  FutureOr<void> onGetRentalListEvent(
      GetRentalListEvent event, Emitter<RentalListState> emit) async {
    emit(RentalListLoading());

    final response = await _getHomeRentalListList.call(
      GetHomeRentalListParams(
        name: event.search,
        categoryId: event.categoryId,
      ),
    );

    response.fold(
      (l) => emit(RentalListFailure(l.message)),
      (r) => emit(RentalListSuccess(
        categoryId: event.categoryId,
        search: event.search,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetRentalListPaginateEvent(
      GetRentalListPaginateEvent event, Emitter<RentalListState> emit) async {
    final state = this.state;

    if (state is RentalListSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getHomeRentalListList.call(
          GetHomeRentalListParams(
            name: state.search,
            previous: state.data.previous,
            next: state.data.next,
            categoryId: state.categoryId,
          ),
        );

        response.fold(
          (l) => emit(RentalListFailure(l.message)),
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
