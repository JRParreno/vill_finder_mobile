import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessCategoryListResponseModel
    extends BusinessCategoryListResponseEntity {
  BusinessCategoryListResponseModel({
    required super.count,
    required super.results,
    super.next,
    super.previous,
  });
  factory BusinessCategoryListResponseModel.fromJson(
      Map<String, dynamic> json) {
    return BusinessCategoryListResponseModel(
      count: json['count'] as int,
      next: json['next'] != null ? json['next'] as String : null,
      previous: json['previous'] != null ? json['previous'] as String : null,
      results: List.from(
        (json['results']).map(
          (x) => BusinessCategoryModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
