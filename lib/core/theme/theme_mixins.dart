import 'package:flutter/material.dart';
import 'package:vill_finder/gen/colors.gen.dart';

mixin ThemeMixin {
  OutlineInputBorder border([Color color = ColorName.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(7),
      );
}
