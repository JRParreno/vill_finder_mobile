import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating; // The current rating (e.g., 3 stars)
  final int maxRating; // The maximum number of stars (default is 5)
  final double starSize;
  final Color filledStarColor;
  final Color unfilledStarColor;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5, // Default max rating is 5
    this.starSize = 20.0, // Default size of each star
    this.filledStarColor = Colors.yellow, // Color for filled stars
    this.unfilledStarColor = Colors.grey, // Color for unfilled stars
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Make the row fit the content
      children: List.generate(maxRating, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? filledStarColor : unfilledStarColor,
          size: starSize,
        );
      }),
    );
  }
}
