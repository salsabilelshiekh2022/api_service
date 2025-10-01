import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:elmohtaref/features/home/home/presentation/views/widgets/banner_item.dart';
import 'package:elmohtaref/features/home/home/presentation/views/widgets/smooth_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/models/banner_model.dart';

class HomeBanners extends StatefulWidget {
  const HomeBanners({super.key});

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      left: 20,
      right: 20,
      child: Column(
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              bool isLoading = state.banners == null;
              bool isSuccess = state.banners != null;
              return SizedBox(
                height: 160.h,
                child: PageView.builder(
                  itemCount: isSuccess ? state.banners!.length : 1,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Skeletonizer(
                          enabled: isLoading,
                          child: BannerItem(
                            banner: isLoading
                                ? dummyBanner
                                : isSuccess
                                    ? state.banners![index]
                                    : dummyBanner,
                          )),
                    );
                  },
                ),
              );
            },
          ),
          10.verticalSpace,
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return SmoothWidget(
                count: state.banners != null ? state.banners!.length : 1,
                controller: _controller,
              );
            },
          )
        ],
      ),
    );
  }
}
