import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';

class SearchMapResultsModel extends SearchMapResultsEntity {
  SearchMapResultsModel({
    required super.rentals,
    required super.foods,
  });

  factory SearchMapResultsModel.fromJson(Map<String, dynamic> map) {
    return SearchMapResultsModel(
      rentals: List<RentalModel>.from(
        (map['rentals'] as List<int>).map<RentalModel>(
          (x) => RentalModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      foods: List<FoodEstablishmentModel>.from(
        (map['foods'] as List<int>).map<FoodEstablishmentModel>(
          (x) => FoodEstablishmentModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class SearchMapResponseModel extends SearchMapResponseEntity {
  SearchMapResponseModel({
    required super.count,
    required super.results,
    super.next,
    super.previous,
  });

  factory SearchMapResponseModel.fromJson(Map<String, dynamic> map) {
    return SearchMapResponseModel(
      count: map['count'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
      results: SearchMapResultsModel.fromJson(
          map['results'] as Map<String, dynamic>),
    );
  }
}
