import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../data/models/notification_model.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({super.key, required this.notification});
  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: REdgeInsets.symmetric(vertical: 16.w, horizontal: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.w,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: appColors.primaryColor.withValues(alpha: 0.07),
              shape: BoxShape.circle,
            ),
            child: CustomSvgBuilder(
              path: AppAssets.svgsBell,
              color: appColors.primaryColor,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: _notificationBody(
              appTextTheme,
              notification.title!,
              notification.body!,
            ),
          ),
          8.horizontalSpace,
          Text(
            DateFormat.yMMMd('ar')
                .format(DateTime.parse(notification.createdAt!)),
            style: appTextTheme.font14RegularPrimaryColor,
          ),
        ],
      ),
    );
  }

  _notificationBody(AppTextStyles appTextTheme, String title, String body) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appTextTheme.font14BoldPrimaryColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          4.verticalSpace,
          Text(body, style: appTextTheme.font12RegularSecondaryColor),
        ],
      );
}
