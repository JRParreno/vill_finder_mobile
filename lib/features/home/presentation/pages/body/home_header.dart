import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Assets.images.icon.appIcon.image(height: 30, width: 30),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'VillFinder',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 24,
              color: ColorName.blackFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
