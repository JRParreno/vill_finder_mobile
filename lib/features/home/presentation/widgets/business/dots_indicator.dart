import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD5F2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(itemCount, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: currentIndex == index ? 12.0 : 8.0,
            height: currentIndex == index ? 12.0 : 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }
}
