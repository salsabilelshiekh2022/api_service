import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/theme/app_text_style.dart';
import '../../../data/service_details_model.dart';
import 'star_rating.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) {
          bool isLoading = state.status == ServiceDetailsStateStatus.loading;
          return ListView.separated(
              padding: const EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                return Skeletonizer(
                    enabled: isLoading,
                    child: RatingItem(
                      rate: isLoading
                          ? dummyServiceDetailData.rates[0]
                          : state.serviceDetailsResponse!.data.rates[index],
                    ));
              },
              separatorBuilder: (context, index) {
                return 8.verticalSpace;
              },
              itemCount: isLoading
                  ? 3
                  : state.serviceDetailsResponse!.data.rates.length);
        },
      ),
    );
  }
}

class RatingItem extends StatelessWidget {
  const RatingItem({super.key, required this.rate});
  final ServiceRate rate;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rate.createdAt.formatTime(),
            style: appTextStyles.font12RegularPrimaryColor),
        StarRating(rating: rate.rating ?? 0),
        8.verticalSpace,
        Text(
          rate.comment ?? "",
          style: appTextStyles.font12RegularSecondaryColor.copyWith(
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
