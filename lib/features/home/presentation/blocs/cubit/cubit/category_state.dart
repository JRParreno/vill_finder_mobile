part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final ViewStatus viewStatus;
  final BusinessCategoryListResponseEntity? categories;
  final List<BusinessCategoryEntity> filteredCategories;

  const CategoryState({
    this.viewStatus = ViewStatus.none,
    required this.categories,
    this.filteredCategories = const [],
  });

  CategoryState copyWith(
      {BusinessCategoryListResponseEntity? categories,
      ViewStatus? viewStatus,
      List<BusinessCategoryEntity>? filteredCategories}) {
    return CategoryState(
      categories: categories ?? this.categories,
      viewStatus: viewStatus ?? this.viewStatus,
      filteredCategories: filteredCategories ?? this.filteredCategories,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        viewStatus,
        filteredCategories,
      ];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial() : super(categories: null);
}
