import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class BusinessCategoryChip extends StatelessWidget {
  const BusinessCategoryChip({
    super.key,
    this.selected = false,
    required this.businessCategory,
    required this.onSelected,
  });

  final bool selected;
  final BusinessCategoryEntity businessCategory;
  final Function(bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      side: BorderSide(
        color: selected ? ColorName.primary : ColorName.greyFont,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.white,
      selected: selected,
      onSelected: onSelected,
      padding: EdgeInsets.zero,
      label: Text(
        businessCategory.name,
      ),
    );
  }
}
