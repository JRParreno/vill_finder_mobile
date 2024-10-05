import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'home_rental_event.dart';
part 'home_rental_state.dart';

class HomeRentalBloc extends Bloc<HomeRentalEvent, HomeRentalState> {
  final GetHomeRentalList _getHomeRentalList;

  HomeRentalBloc({
    required GetHomeRentalList getHomeRentalList,
  })  : _getHomeRentalList = getHomeRentalList,
        super(HomeRentalInitial()) {
    on<GetHomeRentalEvent>(onGetHomeRentalEvent, transformer: restartable());
    on<RefreshHomeRentalEvent>(onRefreshHomeRentalEvent,
        transformer: restartable());
  }

  FutureOr<void> onRefreshHomeRentalEvent(
      RefreshHomeRentalEvent event, Emitter<HomeRentalState> emit) async {
    emit(HomeRentalLoading());
  }

  FutureOr<void> onGetHomeRentalEvent(
      GetHomeRentalEvent event, Emitter<HomeRentalState> emit) async {
    emit(HomeRentalLoading());

    final response = await _getHomeRentalList.call(
      GetHomeRentalListParams(
        name: event.search,
      ),
    );

    response.fold(
      (l) => emit(const HomeRentalFailure("Something went wrong.")),
      (r) => emit(
        HomeRentalSuccess(
          data: r,
          categoryId: event.categoryId,
          search: event.search,
        ),
      ),
    );
  }
}
