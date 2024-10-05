import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'rental_event.dart';
part 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final GetHomeRentalList _getHomeRentalList;

  RentalBloc(GetHomeRentalList getHomeRentalList)
      : _getHomeRentalList = getHomeRentalList,
        super(RentalInitial()) {
    on<GetRentalEvent>(onGetRentalEvent, transformer: restartable());
    on<GetRentalPaginateEvent>(onGetRentalPaginateEvent,
        transformer: restartable());
    on<RefreshRentalEvent>(onRefreshRentalEvent, transformer: restartable());
  }

  FutureOr<void> onRefreshRentalEvent(
      RefreshRentalEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());
  }

  FutureOr<void> onGetRentalEvent(
      GetRentalEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());

    final response = await _getHomeRentalList.call(
      GetHomeRentalListParams(
        name: event.search,
        categoryId: event.categoryId,
      ),
    );

    response.fold(
      (l) => emit(RentalFailure(l.message)),
      (r) => emit(RentalSuccess(
        categoryId: event.categoryId,
        search: event.search,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetRentalPaginateEvent(
      GetRentalPaginateEvent event, Emitter<RentalState> emit) async {
    final state = this.state;

    if (state is RentalSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getHomeRentalList.call(
          GetHomeRentalListParams(
            name: state.search,
            previous: state.data.previous,
            next: state.data.next,
            categoryId: state.categoryId,
          ),
        );

        response.fold(
          (l) => emit(RentalFailure(l.message)),
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
