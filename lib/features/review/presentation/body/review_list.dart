// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';
import 'package:vill_finder/features/review/presentation/widgets/review_card.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    super.key,
    required this.totalReview,
  });

  final int totalReview;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ReviewListBloc, ReviewListState>(
        builder: (context, state) {
          if (state is ReviewListLoading) {
            return ShimmerLoading(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
            );
          }
          if (state is ReviewListSuccess) {
            if (state.responseEntity.reviews.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reviews',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: ColorName.blackFont),
                  ),
                  const SizedBox(
                    height: 75,
                    child: Center(child: Text('No Reviews yet')),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviews',
                      style: textTheme.headlineSmall
                          ?.copyWith(color: ColorName.blackFont),
                    ),
                    if (state.responseEntity.reviews.length > 3)
                      Text(
                        'See all',
                        style: textTheme.bodySmall
                            ?.copyWith(color: Colors.lightBlue),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Review',
                      style: textTheme.bodySmall
                          ?.copyWith(color: ColorName.blackFont),
                    ),
                    Text(
                      '$totalReview Review(s)',
                      style: textTheme.bodySmall
                          ?.copyWith(color: ColorName.blackFont),
                    ),
                  ],
                ),
                ...state.responseEntity.reviews.map(
                  (item) => ReviewCard(
                    reviewEntity: item,
                  ),
                )
              ].withSpaceBetween(height: 10),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
