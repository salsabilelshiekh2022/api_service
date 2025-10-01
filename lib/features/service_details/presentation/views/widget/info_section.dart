import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/service_details_model.dart';
import '../../cubit/service_details_cubit.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        bool isLoading = state.status == ServiceDetailsStateStatus.loading;
        return Skeletonizer(
          enabled: isLoading,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.serviceDescription,
                  style: appTextStyles.font16BoldPrimaryColor.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                6.verticalSpace,
                Text(
                    isLoading
                        ? dummyServiceDetailData.longDesc
                        : state.serviceDetailsResponse!.data.longDesc,
                    style: appTextStyles.font12RegularSecondaryColor)
              ],
            ),
          ),
        );
      },
    );
  }
}
