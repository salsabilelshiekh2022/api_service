import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/reports_model.dart';

class ReportListItem extends StatelessWidget {
  const ReportListItem({super.key, required this.report});
  final Report report;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(report.report))) {
      throw Exception('Could not launch ${report.report}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.greyColor, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(AppAssets.imagesLogo,
                  width: 80.w, height: 50.h, fit: BoxFit.fill)),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${report.carType} - ${report.carModel} -  ${report.carModelYear}",
                    style: appTextStyles.font16RegularPrimaryColor.copyWith(
                      fontSize: 15.sp,
                    )),
                3.verticalSpace,
                Text(
                    "${context.bookingDate} :${DateFormat('dd/MM/yyyy').format(DateTime.parse(report.dateTime))}",
                    style: appTextStyles.font12RegularSecondaryColor.copyWith(
                      fontSize: 15.sp,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("${context.reportNumber} : #${report.uid}",
                          style: appTextStyles.font12RegularSecondaryColor),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Text(
                          context.displayReport,
                          style: appTextStyles.font12RegularLabelColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
