import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessSubCategoryModel extends BusinessSubCategoryEntity {
  BusinessSubCategoryModel({
    required super.id,
    required super.name,
  });

  factory BusinessSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return BusinessSubCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
