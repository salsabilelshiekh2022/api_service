import 'dart:ui';

import 'app_colors.dart';

abstract class AppColorsSchemes {
  static const AppColors light = AppColors(
    primaryColor: Color(0xff09131b),
    secondaryColor: Color(0xff6a717b),
    greenColor: Color(0xff66e066),
    redColor: Color.fromARGB(255, 216, 72, 72),
    homeBackgroundColor: Color(0xffFBFBFB),
    yellowColor: Color(0xfff6c039),
    labelColor: Color(0xffffffff),
    greyColor: Color(0xffcacaca),
  );

  static const AppColors dark = light;
}
