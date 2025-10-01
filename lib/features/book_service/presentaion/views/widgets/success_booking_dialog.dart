import 'package:elmohtaref/core/components/widgets/main_button.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/routes/routes.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessBookingDialog extends StatelessWidget {
  const SuccessBookingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Dialog(
      clipBehavior: Clip.none,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      backgroundColor: Colors.transparent,
      child: Container(
        width: context.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: 380.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 0),
          child: Column(
            children: [
              Image.asset(
                AppAssets.imagesElectricCarRafiki,
                width: 176.w,
                height: 176.h,
                fit: BoxFit.cover,
              ),
              16.verticalSpace,
              Text(
                textAlign: TextAlign.center,
                context.successBookingMessage,
                style: appTextStyles.font18BoldPrimaryColor.copyWith(
                  fontSize: 21.sp,
                ),
              ),
              3.verticalSizedBox,
              Text(
                context.successAttendanceMessage,
                style: appTextStyles.font16RegularSecondaryColor.copyWith(
                  fontSize: 17.sp,
                ),
              ),
              30.verticalSpace,
              MainButton(
                  title: context.main,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(Routes.mainNavigation,
                        predicate: (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => const SuccessBookingDialog(),
    );
  }
}
