import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final GetHomeRentalList _getHomeRentalList;
  final GetHomeFoodList _getHomeFoodList;

  SearchBloc({
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required GetHomeRentalList getHomeRentalList,
    required GetHomeFoodList getHomeFoodList,
  })  : _sharedPreferencesNotifier = sharedPreferencesNotifier,
        _getHomeRentalList = getHomeRentalList,
        _getHomeFoodList = getHomeFoodList,
        super(SearchInitial()) {
    on<SearchGetRecentSearches>(onSearchGetRecentSearches);
    on<SearchTriggerEvent>(onSearchTriggerEvent);
    on<SearchClearRecentSearches>(onSearchClearRecentSearches);
  }

  void onSearchClearRecentSearches(
      SearchClearRecentSearches event, Emitter<SearchState> emit) {
    final List<String> recentSearches = [];
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.recentSearches, recentSearches);

    emit(const SearchRecentLoaded([]));
  }

  void onSearchGetRecentSearches(
      SearchGetRecentSearches event, Emitter<SearchState> emit) {
    final List<String> recentSearches = _sharedPreferencesNotifier
        .getValue(SharedPreferencesKeys.recentSearches, []);

    emit(SearchRecentLoaded(recentSearches));
  }

  Future<void> onSearchTriggerEvent(
      SearchTriggerEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final futureFood = _getHomeFoodList.call(
      GetHomeFoodListParams(
        name: event.keyword,
      ),
    );

    final futureRentals = _getHomeRentalList.call(
      GetHomeRentalListParams(
        name: event.keyword,
      ),
    );

    final results = await Future.wait([
      futureFood,
      futureRentals,
    ]);

    final foodResponse =
        results[0] as Either<Failure, FoodEstablishmentListResponseEntity>;
    final rentalResponse =
        results[1] as Either<Failure, RentalListResponseEntity>;

    if (foodResponse.isLeft() && rentalResponse.isLeft()) {
      emit(const SearchFailure('Something went wrong'));
      return;
    }

    saveLocalRecentSearches(event.keyword);

    if (foodResponse.foldRight(
          true,
          (acc, b) => b.results.isEmpty,
        ) &&
        rentalResponse.foldRight(
          true,
          (acc, b) => b.results.isEmpty,
        )) {
      emit(SearchEmpty());
      return;
    }

    emit(
      SearchSuccess(
        foods: foodResponse.fold((l) => null, (r) => r),
        rentals: rentalResponse.fold((l) => null, (r) => r),
      ),
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
}
