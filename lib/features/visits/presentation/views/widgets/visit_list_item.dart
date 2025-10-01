import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/visit_model.dart';
import 'service_rating_dialog.dart';

class VisitListItem extends StatelessWidget {
  final Visit visit;
  const VisitListItem({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return InkWell(
      onTap: () {
        visit.statusToCheck == "completed"
            ? showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext dialogContext) => BlocProvider.value(
                  value: context.read<VisitsCubit>(),
                  child: ServiceRatingDialog(
                    visitId: visit.id,
                  ),
                ),
              )
            : null;
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        padding: EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: appColors.greyColor, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.asset(AppAssets.imagesLogo,
                    width: 60.w, height: 60.h, fit: BoxFit.fill)),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("${visit.service} #${visit.uid}",
                            style: appTextStyles.font16RegularPrimaryColor
                                .copyWith(
                              fontSize: 15.sp,
                            )),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                            color: visit.statusToCheck == "pending"
                                ? Color(0xfff7f0e0)
                                : visit.statusToCheck == "completed"
                                    ? Color(0xffd9f7e9)
                                    : Color(0xffffd9d9),
                            borderRadius: BorderRadiusDirectional.horizontal(
                              start: Radius.circular(25),
                            )),
                        child: Center(child: Text(visit.status)),
                      )
                    ],
                  ),
                  3.verticalSpace,
                  Text(
                      "${context.bookingDate} : ${DateTime.parse(visit.dateTime).format()}",
                      style: appTextStyles.font12RegularSecondaryColor.copyWith(
                        fontSize: 11.sp,
                      )),
                  Row(
                    children: [
                      Text(
                          "${visit.carType} - ${visit.carModel} - ${visit.carModelYear}",
                          style: appTextStyles.font12RegularSecondaryColor),
                      12.horizontalSizedBox,
                      visit.statusToCheck == "completed"
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              child: Row(
                                children: [
                                  Text(
                                    context.rate,
                                    style: appTextStyles.font12RegularLabelColor
                                        .copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  4.horizontalSpace,
                                  Icon(
                                    Icons.star,
                                    color: appColors.yellowColor,
                                    size: 14.sp,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
