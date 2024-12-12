// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/utils/sa_score.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';
import 'package:vill_finder/features/review/presentation/widgets/review_card.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    super.key,
    required this.totalReview,
    required this.sentimentLabel,
  });

  final int totalReview;
  final String sentimentLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final saScore = getSaScore(value: sentimentLabel, dimension: 20.0);

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
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Review',
                          style: textTheme.labelSmall
                              ?.copyWith(color: ColorName.blackFont),
                        ),
                        Text(
                          '$totalReview Review(s)',
                          style: textTheme.labelSmall?.copyWith(
                            color: ColorName.blackFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Overall Feedback',
                          style: textTheme.labelSmall
                              ?.copyWith(color: ColorName.blackFont),
                        ),
                        Row(
                          children: [
                            saScore.imageIcon,
                            Text(
                              saScore.title,
                              style: textTheme.labelSmall?.copyWith(
                                color: ColorName.blackFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ].withSpaceBetween(width: 5),
                        ),
                      ],
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
