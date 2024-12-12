// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vill_finder/core/utils/sa_score.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.reviewEntity,
  });

  final ReviewEntity reviewEntity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ColorName.blackFont,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviewEntity.userProfile.user.getFullName,
                style: textTheme.bodySmall?.copyWith(
                  color: ColorName.blackFont,
                ),
              ),
              getSaScoreImage(value: reviewEntity.sentimentLabel),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            reviewEntity.comment,
            style: textTheme.bodySmall?.copyWith(
              color: ColorName.blackFont,
            ),
          ),
        ],
      ),
    );
  }
}
