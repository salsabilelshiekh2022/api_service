import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/app_assets.dart';
import '../../theme/app_text_style.dart';
import 'back_button.dart' as back_btn;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.title, this.isBack = false, this.height = 124});
  final String title;
  final bool isBack;
  final double height;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Image.asset(AppAssets.imagesHeadSm,
              width: double.infinity, height: height.h, fit: BoxFit.cover),
        ),
        // Centered title text
        Positioned(
          top: 60.h,
          left: 30.w,
          right: 30.w,
          child: Center(
            child: Text(
              title,
              style: appTextStyles.font20RegularLabelColor
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),

        // Back button positioned on the left if needed
        if (isBack)
          PositionedDirectional(
            top: 60.h,
            start: 30.w,
            child: const back_btn.BackButton(),
          )
      ],
    );
  }
}
