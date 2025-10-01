import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/features/service_details/data/service_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../cubit/service_details_cubit.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) {
          bool isLoading = state.status == ServiceDetailsStateStatus.loading;
          return Skeletonizer(
            enabled: state.status == ServiceDetailsStateStatus.loading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoading
                          ? dummyServiceDetailData.name
                          : state.serviceDetailsResponse!.data.name,
                      style: appTextStyles.font12RegularPrimaryColor.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 20.sp),
                    ),
                    2.verticalSpace,
                    SizedBox(
                      width: context.width * 0.6,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        isLoading
                            ? dummyServiceDetailData.shortDesc
                            : state.serviceDetailsResponse!.data.shortDesc,
                        style: appTextStyles.font14SemiBoldSecondaryColor
                            .copyWith(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    6.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "${isLoading ? dummyServiceDetailData.rateAvg : state.serviceDetailsResponse!.data.rateAvg} (${isLoading ? dummyServiceDetailData.reviewsCount : state.serviceDetailsResponse!.data.reviewsCount} reviews)",
                          style: appTextStyles.font14SemiBoldSecondaryColor
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12.sp),
                        ),
                        2.horizontalSpace,
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "${isLoading ? dummyServiceDetailData.estimatePrice : state.serviceDetailsResponse!.data.estimatePrice} ريال",
                      style: appTextStyles.font14BoldSecondaryColor
                          .copyWith(fontSize: 15.sp),
                    ),
                    2.verticalSpace,
                    Text(
                      context.estimatedPrice,
                      style: appTextStyles.font14RegularSecondaryColor.copyWith(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
