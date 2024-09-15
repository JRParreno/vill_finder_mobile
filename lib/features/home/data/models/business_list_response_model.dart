import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessListResponseModel extends BusinessListResponseEntity {
  BusinessListResponseModel({
    required super.count,
    required super.results,
    super.next,
    super.previous,
  });

  factory BusinessListResponseModel.fromJson(Map<String, dynamic> json) {
    return BusinessListResponseModel(
      count: json['count'] as int,
      next: json['next'] != null ? json['next'] as String : null,
      previous: json['previous'] != null ? json['previous'] as String : null,
      results: List.from(
        (json['results']).map(
          (x) => BusinessModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
