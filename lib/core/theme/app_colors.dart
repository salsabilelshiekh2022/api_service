import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color greenColor;
  final Color redColor;
  final Color yellowColor;
  final Color homeBackgroundColor;
  final Color labelColor;
  final Color greyColor;

  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.greenColor,
    required this.redColor,
    required this.homeBackgroundColor,
    required this.yellowColor,
    required this.labelColor,
    required this.greyColor,
  });

  @override
  ThemeExtension<AppColors> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    } else {
      return AppColors(
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
        greenColor: Color.lerp(greenColor, other.greenColor, t)!,
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
        redColor: Color.lerp(redColor, other.redColor, t)!,
        homeBackgroundColor:
            Color.lerp(homeBackgroundColor, other.homeBackgroundColor, t)!,
        yellowColor: Color.lerp(yellowColor, other.yellowColor, t)!,
        labelColor: Color.lerp(labelColor, other.labelColor, t)!,
        greyColor: Color.lerp(greyColor, other.greyColor, t)!,
      );
    }
  }
}
