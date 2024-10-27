import 'package:flutter/material.dart';
import 'package:vill_finder/gen/assets.gen.dart';

class StarRating extends StatelessWidget {
  final int rating; // The current rating (e.g., 3 stars)

  const StarRating({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return getImageWidget(rating);
  }

  Widget getImageWidget(int index) {
    final reviewImages = Assets.images.review;
    const dimension = 25.0;

    switch (index) {
      case 0:
        return reviewImages.veryNegative
            .image(height: dimension, width: dimension);
      case 1:
        return reviewImages.negative.image(height: dimension, width: dimension);
      case 2:
        return reviewImages.neutral.image(height: dimension, width: dimension);

      case 3:
        return reviewImages.positive.image(height: dimension, width: dimension);
      default:
        return reviewImages.veryPositive
            .image(height: dimension, width: dimension);
    }
  }
}
