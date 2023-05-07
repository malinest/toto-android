import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';

class TotoTextStyles {
  static TextStyle? bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 42.0,
            fontWeight: FontWeight.w600,
            color: TotoColors.textColor,
            letterSpacing: 1.5,
          );

  static TextStyle? bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            color: TotoColors.textColor,
          );
}
