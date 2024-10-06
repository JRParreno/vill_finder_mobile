import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
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

    final futureFeaturedRentals = _getHomeRentalList.call(
      GetHomeRentalListParams(
        name: event.search,
        isFeatured: true,
      ),
    );

    final featureNonFeaturedRentals = _getHomeRentalList.call(
      GetHomeRentalListParams(
        name: event.search,
        isFeatured: false,
      ),
    );

    final responses =
        await Future.wait([futureFeaturedRentals, featureNonFeaturedRentals]);

    final featuredRentalsResponse = responses[0];
    final featuredNonRentalsResponse = responses[1];

    if (featuredRentalsResponse.isLeft() ||
        featuredNonRentalsResponse.isLeft()) {
      return emit(const HomeRentalFailure("Something went wrong."));
    }

    final featureRentals = featuredRentalsResponse
        .getRight()
        .getOrElse(() => throw Exception('something went wrong'));

    final nonFeatureRentals = featuredNonRentalsResponse
        .getRight()
        .getOrElse(() => throw Exception('something went wrong'));

    emit(
      HomeRentalSuccess(
        featureRentals: featureRentals,
        nonFeatureRentals: nonFeatureRentals,
        categoryId: event.categoryId,
        search: event.search,
      ),
    );
  }
}