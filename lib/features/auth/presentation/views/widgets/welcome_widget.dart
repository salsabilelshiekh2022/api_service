import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget(
      {super.key, required this.text, required this.decription});
  final String text;
  final String decription;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 28),
      child: Column(
        children: [
          Image.asset(
            AppAssets.imagesCar,
            width: 164.w,
            height: 128.h,
            fit: BoxFit.cover,
          ),
          30.verticalSpace,
          Text(
            text,
            style: appTextStyles.font18BoldPrimaryColor.copyWith(
              fontSize: 28,
            ),
          ),
          5.verticalSpace,
          Text(decription,
              textAlign: TextAlign.center,
              style: appTextStyles.font14RegularSecondaryColor),
        ],
      ),
    );
  }
}
