// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class Amenities extends StatelessWidget {
  const Amenities({
    super.key,
    required this.rental,
  });

  final RentalEntity rental;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities to offer',
          style: textTheme.headlineSmall?.copyWith(color: ColorName.blackFont),
        ),
        iconWithText(
          isHave: rental.airConditioning,
          textTheme: textTheme,
          icon: Icons.ac_unit,
          title: 'Air conditioning',
        ),
        iconWithText(
          isHave: rental.wifi,
          textTheme: textTheme,
          icon: Icons.wifi,
          title: 'WiFi',
        ),
        iconWithText(
          isHave: rental.kitchen,
          textTheme: textTheme,
          icon: Icons.microwave,
          title: 'Kitchen',
        ),
        iconWithText(
          isHave: rental.refrigerator,
          textTheme: textTheme,
          icon: Icons.kitchen,
          title: 'Refrigerator',
        ),
        iconWithText(
          isHave: rental.petsAllowed,
          textTheme: textTheme,
          icon: Icons.pets,
          title: '${rental.petsAllowed ? '' : 'No'} Pets Allowed',
        ),
        iconWithText(
          isHave: rental.emergencyExit,
          textTheme: textTheme,
          icon: Icons.emergency,
          title: 'Emergency Exit',
        ),
      ].withSpaceBetween(height: 10),
    );
  }

  Widget iconWithText({
    required String title,
    required IconData icon,
    required TextTheme textTheme,
    required bool isHave,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: ColorName.blackFont,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            decoration: !isHave ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}
