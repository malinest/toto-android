import 'package:flutter/material.dart';
import 'package:toto_android/model/colors.dart';

// TextStyles used in the App
class TotoTextStyles {
  static TextStyle? titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 42.0,
            fontWeight: FontWeight.w600,
            color: TotoColors.textColor,
            letterSpacing: 1.5,
          );

  static TextStyle? titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            color: TotoColors.textColor,
          );

  static TextStyle? bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            color: TotoColors.textColor,
          );

  static TextStyle? displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: TotoColors.contrastColor,
          );

  static TextStyle? labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          );

  static TextStyle? displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          );

  static TextStyle? displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          );

  static TextStyle? labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          );

  static TextStyle? titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 18.0,
            color: Colors.black,
          );

  static TextStyle? labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: .5,
          );
}
