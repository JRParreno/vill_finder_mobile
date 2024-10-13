import 'package:flutter/material.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalCondition extends StatelessWidget {
  const RentalCondition({
    super.key,
    required this.propertyCondition,
    required this.furnitureCondition,
  });

  final String propertyCondition;
  final String furnitureCondition;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Condition',
          style: textTheme.headlineSmall?.copyWith(color: ColorName.blackFont),
        ),
        Text('• Property $propertyCondition'),
        Text('• Furniture $furnitureCondition')
      ].withSpaceBetween(height: 10),
    );
  }
}
