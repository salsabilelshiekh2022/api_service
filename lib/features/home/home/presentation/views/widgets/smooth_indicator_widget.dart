import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../core/theme/app_colors.dart';

class SmoothWidget extends StatelessWidget {
  const SmoothWidget(
      {super.key, required this.count, required this.controller});
  final int count;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotHeight: 6.h,
        dotWidth: 6.w,
        activeDotColor: appColors.primaryColor,
        dotColor: appColors.greyColor,
      ),
    );
  }
}
