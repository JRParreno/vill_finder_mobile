// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vill_finder/gen/assets.gen.dart';

class SaScore {
  final String title;
  final Image imageIcon;

  SaScore({
    required this.imageIcon,
    required this.title,
  });
}

SaScore getSaScore({
  required String value,
  double? dimension = 25.0,
}) {
  final reviewImages = Assets.images.review;

  // Validate input value: must be equal or greater than zero and less than or equal to 5
  if (value.isEmpty) {
    return SaScore(
        imageIcon: Assets.images.placeholder.imagePlaceholder.image(),
        title: "Invalid input, must be between 0 and 5");
  }

  // Define the ranges and corresponding string values
  if (value.toLowerCase() == "positive") {
    return SaScore(
        imageIcon: reviewImages.positive.image(
          height: dimension,
          width: dimension,
        ),
        title: "Positive");
  } else if (value.toLowerCase() == "neutral") {
    return SaScore(
        imageIcon: reviewImages.neutral.image(
          height: dimension,
          width: dimension,
        ),
        title: "Neutral");
  } else {
    return SaScore(
        imageIcon: reviewImages.negative.image(
          height: dimension,
          width: dimension,
        ),
        title: "Negative");
  }
}
