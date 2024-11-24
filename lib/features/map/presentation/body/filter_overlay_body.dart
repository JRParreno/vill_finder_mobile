import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FilterOverlayBody extends StatelessWidget {
  const FilterOverlayBody({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories = state.categories;

        if (categories == null || categories.results.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 35,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return OutlinedButton(
                onPressed: () {
                  context
                      .read<CategoryCubit>()
                      .onSelect(state.categories!.results[index]);
                  context.read<MapBusinessBloc>().add(
                        GetFilterMapBusinessEvent(
                          GetBusinessMapListParams(
                            name: text,
                          ),
                        ),
                      );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: state.filteredCategories
                          .contains(categories.results[index])
                      ? ColorName.primary
                      : ColorName.borderColor,
                  padding: const EdgeInsets.all(10),
                ),
                child: Text(
                  categories.results[index].name,
                  style: textTheme.labelSmall?.copyWith(
                      color: !state.filteredCategories
                              .contains(categories.results[index])
                          ? null
                          : ColorName.borderColor),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
              height: 10,
            ),
            itemCount: categories.results.length,
          ),
        );
      },
    );
  }
}
