// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business/home_business_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business_category/home_business_category_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business_category/business_category_chip.dart';

class BusinessCategoryList extends StatelessWidget {
  const BusinessCategoryList({
    super.key,
    required this.searchCtrl,
  });

  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBusinessCategoryBloc, HomeBusinessCategoryState>(
      listener: (context, state) {
        if (state is HomeBusinessCategorySuccess) {
          context.read<HomeBusinessBloc>().add(
                GetHomeBusinessEvent(
                  search: searchCtrl.value.text,
                  categoryId: state.selected > 0
                      ? state.data.results[state.selected].id
                      : null,
                ),
              );
        }
      },
      builder: (context, state) {
        if (state is HomeBusinessCategoryLoading) {
          return const ShimmerLoading(
            width: double.infinity,
            height: 50,
          );
        }

        if (state is HomeBusinessCategorySuccess) {
          return SizedBox(
            height: 40,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = state.data.results[index];
                return BusinessCategoryChip(
                  businessCategory: item,
                  selected: index == state.selected,
                  onSelected: (value) =>
                      handleOnTapCategory(context: context, index: index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemCount: state.data.results.length,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void handleOnTapCategory({
    required int index,
    required BuildContext context,
  }) {
    context
        .read<HomeBusinessCategoryBloc>()
        .add(OnTapHomeBusinessCategoryEvent(index));
  }
}
