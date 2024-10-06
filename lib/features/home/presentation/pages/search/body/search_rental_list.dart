// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vill_finder/core/common/widgets/view_all_btn.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';

class SearchRentalList extends StatelessWidget {
  const SearchRentalList({
    super.key,
    required this.onTapViewAll,
    required this.rentals,
  });

  final VoidCallback onTapViewAll;
  final List<RentalEntity> rentals;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (rentals.isEmpty) return const SizedBox.shrink();

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
                  'Rentals',
                  style: textTheme.labelMedium,
                ),
                if (rentals.length > 3)
                  ViewAllBtn(
                    onPressed: onTapViewAll,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...rentals
            .take(3)
            .map(
              (item) => RentalCard(
                rentalEntity: item,
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
