// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vill_finder/core/common/widgets/view_all_btn.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';

class SearchFoodList extends StatelessWidget {
  const SearchFoodList({
    super.key,
    required this.onTapViewAll,
    required this.foods,
  });

  final VoidCallback onTapViewAll;
  final List<FoodEstablishmentEntity> foods;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (foods.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food Establishments',
                  style: textTheme.labelMedium,
                ),
                if (foods.length > 3)
                  ViewAllBtn(
                    onPressed: onTapViewAll,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...foods
            .take(3)
            .map(
              (item) => FoodCard(
                foodEntity: item,
                height: 200,
              ),
            )
            .toList()
            .withSpaceBetween(height: 10),
        const SizedBox(height: 10),
      ],
    );
  }
}
