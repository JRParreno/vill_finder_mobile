import 'package:vill_finder/features/home/data/models/business_sub_category_model.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessCategoryModel extends BusinessCategoryEntity {
  BusinessCategoryModel({
    required super.id,
    required super.name,
    required super.subCategories,
  });

  factory BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      subCategories: List.from(
        (json['category']).map(
          (x) => BusinessSubCategoryModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
