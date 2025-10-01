import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'custom_nav_bar_item.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<String> selectedPaths = [
    AppAssets.iconsHomeSe,
    AppAssets.iconsReportSe,
    AppAssets.iconsVisitSe,
    AppAssets.iconsSettingSe,
  ];

  List<String> unselectedPaths = [
    AppAssets.iconsHome,
    AppAssets.iconsReport,
    AppAssets.iconsVisit,
    AppAssets.iconsSetting,
  ];

  @override
  Widget build(BuildContext context) {
    final labels = [
      context.main,
      context.reports,
      context.visits,
      context.settings,
    ];
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appColors.secondaryColor,
            width: 0.5,
          ),
        ),
      ),
      child: BottomAppBar(
        color: Colors.white,
        height: 90.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          spacing: 16.w,
          children: [
            for (int index = 0; index < 4; index++)
              CustomNavBarItem(
                selectedpath: selectedPaths[index],
                unselectedpath: unselectedPaths[index],
                label: labels[index],
                index: index,
              ),
          ],
        ),
      ),
    );
  }
}
