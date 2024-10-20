import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'home_rental_event.dart';
part 'home_rental_state.dart';

class HomeRentalListBloc extends Bloc<HomeRentalEvent, HomeRentalListState> {
  final GetHomeRentalList _getHomeRentalList;

  HomeRentalListBloc({
    required GetHomeRentalList getHomeRentalList,
  })  : _getHomeRentalList = getHomeRentalList,
        super(HomeRentalInitial()) {
    on<GetHomeRentalEvent>(onGetHomeRentalEvent, transformer: restartable());
    on<RefreshHomeRentalEvent>(onRefreshHomeRentalEvent,
        transformer: restartable());

    on<UpdateHomeFavoriteRentalEvent>(onUpdateHomeFavoriteRentalEvent);
  }
  void onUpdateHomeFavoriteRentalEvent(
    UpdateHomeFavoriteRentalEvent event,
    Emitter<HomeRentalListState> emit,
  ) async {
    final state = this.state;

    if (state is HomeRentalListSuccess) {
      final nonFeaturedRentals =
          List<RentalEntity>.from(state.nonFeatureRentals.results);
      final featuredRentals =
          List<RentalEntity>.from(state.featureRentals.results);

      final nonFeaturedRental = nonFeaturedRentals.firstWhereOrNull(
        (x) => x.id == event.id,
      );

      final featuredRental = featuredRentals.firstWhereOrNull(
        (x) => x.id == event.id,
      );

      if (nonFeaturedRental != null) {
        final index = nonFeaturedRentals.indexOf(nonFeaturedRental);

        RentalEntity updatedRental = nonFeaturedRentals[index];
        updatedRental = updatedRental.copyWith(
            place: updatedRental.place.copyWith(isFavorited: event.value));

        nonFeaturedRentals[index] = updatedRental;
      }

      if (featuredRental != null) {
        final index = featuredRentals.indexOf(featuredRental);

        RentalEntity updatedRental = featuredRentals[index];
        updatedRental = updatedRental.copyWith(
            place: updatedRental.place.copyWith(isFavorited: event.value));

        featuredRentals[index] = updatedRental;
      }

      emit(
        state.copyWith(
          nonFeatureRentals:
              state.nonFeatureRentals.copyWith(results: nonFeaturedRentals),
          featureRentals:
              state.featureRentals.copyWith(results: featuredRentals),
        ),
      );
    }
  }

  FutureOr<void> onRefreshHomeRentalEvent(
      RefreshHomeRentalEvent event, Emitter<HomeRentalListState> emit) async {
    emit(HomeRentalListLoading());
  }

  FutureOr<void> onGetHomeRentalEvent(
      GetHomeRentalEvent event, Emitter<HomeRentalListState> emit) async {
    emit(HomeRentalListLoading());

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
      return emit(const HomeRentalListFailure("Something went wrong."));
    }

    final featureRentals = featuredRentalsResponse
        .getRight()
        .getOrElse(() => throw Exception('something went wrong'));

    final nonFeatureRentals = featuredNonRentalsResponse
        .getRight()
        .getOrElse(() => throw Exception('something went wrong'));

    emit(
      HomeRentalListSuccess(
        featureRentals: featureRentals,
        nonFeatureRentals: nonFeatureRentals,
        categoryId: event.categoryId,
        search: event.search,
      ),
    );
  }
}
