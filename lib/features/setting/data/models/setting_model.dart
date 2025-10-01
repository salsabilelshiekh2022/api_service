import 'package:elmohtaref/core/di/dependency_injection.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/utils/user_cache_service.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/data/repos/auth_repo.dart';

class SettingModel {
  final String title;
  final String imagePath;
  final void Function()? onTap;
  final bool isWorkingTimes;

  SettingModel(
      {required this.title,
      required this.imagePath,
      required this.onTap,
      this.isWorkingTimes = false});
}

List<SettingModel> settingItems(BuildContext context) => [
      SettingModel(
        title: context.language,
        imagePath: AppAssets.iconsLanguage,
        onTap: () {
          context.pushNamed(Routes.changeLanguageView);
        },
      ),
      SettingModel(
        title: context.technicalSupport,
        imagePath: AppAssets.iconsTechnicalSupport,
        onTap: () {
          context.pushNamed(Routes.ticketsListView);
        },
      ),
      SettingModel(
        title: context.notification,
        imagePath: AppAssets.iconsNotification,
        onTap: () {
          context.pushNamed(Routes.notificationView);
        },
      ),
      SettingModel(
        title: context.shareApp,
        imagePath: AppAssets.iconsShareApp,
        onTap: () {
          // AppSnackBar.showSnackBar(
          //     context: context,
          //     message: "قريبا",
          //     state: SnackBarStates.success);
        },
      ),
      SettingModel(
        title: context.aboutUs,
        imagePath: AppAssets.iconsAboutUs,
        onTap: () {
          // AppSnackBar.showSnackBar(
          //     context: context,
          //     message: "قريبا",
          //     state: SnackBarStates.success);
        },
      ),
      SettingModel(
        title: context.rateApp,
        imagePath: AppAssets.iconsRateApp,
        onTap: () {
          // AppSnackBar.showSnackBar(
          //     context: context,
          //     message: "قريبا",
          //     state: SnackBarStates.success);
        },
      ),
      SettingModel(
        title: UserCacheService().currentUser?.meta?.token == null
            ? context.login
            : context.logout,
        imagePath: AppAssets.iconsLogout,
        onTap: () {
          UserCacheService().currentUser?.meta?.token == null
              ? context.pushNamed(Routes.loginView)
              : showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext dialogContext) {
                    return BlocProvider(
                      create: (context) => AuthCubit(
                        getIt<AuthRepo>(),
                      ),
                      child: showLogoutDialog(context),
                    );
                  },
                );
        },
      ),
      SettingModel(
        title: context.workTime,
        imagePath: AppAssets.iconsWorkTime,
        isWorkingTimes: true,
        onTap: () {},
      ),
    ];

showLogoutDialog(BuildContext context) {
  final AppTextStyles appTextStyles =
      Theme.of(context).extension<AppTextStyles>()!;
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;
  return AlertDialog(
    actionsAlignment: MainAxisAlignment.start,
    backgroundColor: appColors.labelColor,
    insetPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.only(top: 34.h),
    shape: RoundedRectangleBorder(borderRadius: 16.allBorderRadius),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.iconsLogout,
          height: 55,
          width: 55,
        ),
        24.verticalSizedBox,
        Text(
          context.areYouSureToLogout,
          style: appTextStyles.font16RegularPrimaryColor.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
        24.verticalSizedBox,
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  height: 38.h,
                  padding: 8.vPadding,
                  decoration: BoxDecoration(
                    borderRadius: 8.allBorderRadius,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 90.w,
                      child: FittedBox(
                        child: Text(
                          context.back,
                          style: appTextStyles.font14BoldPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            16.horizontalSizedBox,
            Expanded(
              child: InkWell(
                onTap: () {
                  context.read<AuthCubit>().logout();
                  context.pop();
                },
                child: Container(
                  height: 38.h,
                  padding: 10.vPadding,
                  decoration: BoxDecoration(
                    borderRadius: 8.allBorderRadius,
                    border: Border.all(
                      color: Colors.red,
                    ),
                    color: const Color(0xffFEF2F2),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 80.w,
                      child: FittedBox(
                        child: Text(
                          context.logout,
                          style: appTextStyles.font14BoldPrimaryColor.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ).horizontalPadding(30),
      ],
    ).onlyPadding(bottomPadding: 47),
  );
}
