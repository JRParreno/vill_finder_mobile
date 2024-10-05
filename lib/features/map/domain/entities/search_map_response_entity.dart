import 'package:vill_finder/features/home/domain/entities/index.dart';

class SearchMapResultsEntity {
  final List<RentalEntity> rentals;
  final List<FoodEstablishmentEntity> foods;

  SearchMapResultsEntity({
    required this.rentals,
    required this.foods,
  });

  SearchMapResultsEntity copyWith({
    List<RentalEntity>? rentals,
    List<FoodEstablishmentEntity>? foods,
  }) {
    return SearchMapResultsEntity(
      rentals: rentals ?? this.rentals,
      foods: foods ?? this.foods,
    );
  }
}

class SearchMapResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final SearchMapResultsEntity results;

  SearchMapResponseEntity({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  SearchMapResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    SearchMapResultsEntity? results,
  }) {
    return SearchMapResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
