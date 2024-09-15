class BusinessSubCategoryEntity {
  final int id;
  final String name;
  BusinessSubCategoryEntity({
    required this.id,
    required this.name,
  });

  BusinessSubCategoryEntity copyWith({
    int? id,
    String? name,
  }) {
    return BusinessSubCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
