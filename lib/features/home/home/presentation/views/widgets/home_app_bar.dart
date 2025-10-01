import 'package:elmohtaref/core/components/widgets/custom_svg_builder.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/theme/app_text_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildBackgroundImage(),
        _buildCenteredTitle(context, appTextStyles),
        _buildNotificationIcon(context),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      AppAssets.imagesHead,
      width: double.infinity,
      height: 185.h,
      fit: BoxFit.fill,
    );
  }

  Widget _buildCenteredTitle(
      BuildContext context, AppTextStyles appTextStyles) {
    return PositionedDirectional(
      top: 60.h,
      start: 0.0,
      end: 0.0,
      child: Center(
        child: Text(
          context.main,
          textAlign: TextAlign.center,
          style: appTextStyles.font20RegularLabelColor.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(BuildContext context) {
    return PositionedDirectional(
      top: 60.h,
      end: 30.w,
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.notificationView);
        },
        child: CustomSvgBuilder(
          path: AppAssets.svgsBell,
          width: 23.w,
          height: 25.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
