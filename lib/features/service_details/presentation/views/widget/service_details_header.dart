import 'package:elmohtaref/core/components/widgets/custom_cache_network_image.dart';
import 'package:elmohtaref/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServiceDetailsHeader extends StatelessWidget {
  const ServiceDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20.r),
            right: Radius.circular(20.r),
          ),
          child: _buildImageBackground(),
        ),
        Positioned(
            left: 30.w,
            right: 30.w,
            top: 60.h,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     width: 40.w,
                //     height: 40.h,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20.r),
                //     ),
                //     child: Center(
                //       child: Icon(
                //         Icons.ios_share_rounded,
                //         size: 24.sp,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ))
      ],
    );
  }

  Widget _buildImageBackground() {
    return BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
      builder: (context, state) {
        bool isLoading = state.status == ServiceDetailsStateStatus.loading;
        return Skeletonizer(
          enabled: state.status == ServiceDetailsStateStatus.loading,
          child: CustomCachedImageWidget(
            path: isLoading
                ? "https://mo7taref.arabapps.cloud/storage/banners/1a941526032e876fc128a63ec7dfb82c.png"
                : state.serviceDetailsResponse!.data.interiorImage,
            width: double.infinity,
            height: 310.h,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
