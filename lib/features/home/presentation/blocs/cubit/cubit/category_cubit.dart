import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetHomeBusinessCategoryList getCategory;

  CategoryCubit(this.getCategory) : super(const CategoryInitial());

  Future<void> getCategoryList() async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    final response =
        await getCategory.call(GetHomeBusinessCategoryListParams());

    response.fold(
      (l) => emit(state.copyWith(viewStatus: ViewStatus.failed)),
      (r) => emit(
        state.copyWith(
          categories: r,
          viewStatus: ViewStatus.successful,
          filteredCategories: r.results,
        ),
      ),
    );
  }

  void onSelect(BusinessCategoryEntity value) {
    List<BusinessCategoryEntity> tempList = [...state.filteredCategories];
    if (tempList.contains(value)) {
      tempList.remove(value);
      emit(state.copyWith(filteredCategories: tempList));
      return;
    }
    tempList.add(value);
    emit(state.copyWith(filteredCategories: tempList));
  }

  void resetFilters() {
    emit(state.copyWith(
        filteredCategories:
            state.categories?.results ?? state.filteredCategories));
  }
}
