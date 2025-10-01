import 'package:elmohtaref/core/components/widgets/custom_modal_hub.dart';
import 'package:elmohtaref/core/di/dependency_injection.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:elmohtaref/features/setting/presentation/views/widgets/setting_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/image_header.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../core/routes/routes.dart';
import '../../../auth/data/repos/auth_repo.dart';
import 'widgets/personal_card.dart';
import 'widgets/social_media_content.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        getIt<AuthRepo>(),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.pushNamedAndRemoveUntil(Routes.mainNavigation,
                predicate: (route) => false);
            CacheServices().clear(CacheBoxes.userModelBox);
          }
        },
        builder: (context, state) {
          return CustomModelProgressIndecator(
            inAsyncCall: state is LogoutLoadingState,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        ImageHeader(),
                        SizedBox(height: 500.h),
                      ],
                    ),
                    Positioned(
                      top: 130.h,
                      left: 18.w,
                      right: 18.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 16.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Column(
                          children: [
                            PersonalCard(),
                            // 12.verticalSpace,
                            SettingList(),
                            12.verticalSpace,
                            SocialMediaContent(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
