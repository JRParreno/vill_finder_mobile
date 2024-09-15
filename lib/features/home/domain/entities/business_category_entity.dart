import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessCategoryEntity {
  final int id;
  final String name;
  final List<BusinessSubCategoryEntity> subCategories;

  BusinessCategoryEntity({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  BusinessCategoryEntity copyWith({
    int? id,
    String? name,
    List<BusinessSubCategoryEntity>? subCategories,
  }) {
    return BusinessCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
