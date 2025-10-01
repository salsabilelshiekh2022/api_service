import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_colors_schemes.dart';
import 'app_text_style.dart';

abstract class AppTextStylesSchemes {
  static const AppColors _appLightColors = AppColorsSchemes.light;
  static AppTextStyles light = AppTextStyles(
      font12RegularLabelColor: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _appLightColors.labelColor,
      ),
      font16RegularLabelColor: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _appLightColors.labelColor,
      ),
      font16RegularPrimaryColor: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _appLightColors.primaryColor,
      ),
      font14RegularSecondaryColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _appLightColors.secondaryColor,
      ),
      font16BoldPrimaryColor: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _appLightColors.primaryColor,
      ),
      font16BoldWhiteColor: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      font20BoldSecondaryColor: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _appLightColors.secondaryColor,
      ),
      font18RegularLabelColor: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: _appLightColors.labelColor,
      ),
      font18BoldPrimaryColor: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: _appLightColors.primaryColor,
      ),
      font16RegularSecondaryColor: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _appLightColors.secondaryColor,
      ),
      font18BoldSecondaryColor: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: _appLightColors.secondaryColor,
      ),
      font14BoldPrimaryColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _appLightColors.primaryColor,
      ),
      font16BoldSecondaryColor: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _appLightColors.secondaryColor,
      ),
      font14BoldSecondaryColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _appLightColors.secondaryColor,
      ),
      font14RegularPrimaryColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _appLightColors.primaryColor,
      ),
      font12RegularSecondaryColor: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _appLightColors.secondaryColor,
      ),
      font14SemiBoldSecondaryColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _appLightColors.secondaryColor,
      ),
      font14RegularLabelColor: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _appLightColors.labelColor,
      ),
      font12RegularPrimaryColor: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _appLightColors.primaryColor,
      ),
      font20RegularLabelColor: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: _appLightColors.labelColor),
      font14RegularGrayColor: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: _appLightColors.greyColor),
      font10SemiBoldGreenColor: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _appLightColors.greenColor));
  static AppTextStyles dark = light;
}
