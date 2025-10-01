import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/routes.dart';
import '../../theme/app_text_style.dart';
import 'main_button.dart';

class ShouldLoginWidget extends StatelessWidget {
  const ShouldLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 54.h),
      child: Column(
        children: [
          Image.asset(
            AppAssets.imagesElectricCarRafiki,
            width: double.infinity,
            height: 224.h,
            fit: BoxFit.cover,
          ),
          16.verticalSpace,
          Text(
            context.shouldLogin,
            style: appTextStyles.font18BoldPrimaryColor.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          50.verticalSpace,
          MainButton(
              onTap: () {
                context.pushNamed(Routes.loginView);
              },
              title: context.login),
        ],
      ),
    );
  }
}
