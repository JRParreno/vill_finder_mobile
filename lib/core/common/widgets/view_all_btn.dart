// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ViewAllBtn extends StatelessWidget {
  const ViewAllBtn({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxHeight: 25, minHeight: 22, maxWidth: 75, minWidth: 55),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(2),
          backgroundColor: ColorName.placeholder,
        ),
        onPressed: onPressed,
        child: Text(
          'View All',
          style: textTheme.labelSmall?.copyWith(color: ColorName.primary),
        ),
      ),
    );
  }
}
