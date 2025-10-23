import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/core/utils/user_cache_service.dart';
import 'package:elmohtaref/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_cache_network_image.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../generated/app_assets.dart';

class PersonalCard extends StatefulWidget {
  const PersonalCard({super.key});

  @override
  State<PersonalCard> createState() => _PersonalCardState();
}

class _PersonalCardState extends State<PersonalCard> {
  bool isAuthenticated = false;
  @override
  void initState() {
    final UserModel? user = UserCacheService().currentUser;

    if (user != null) {
      isAuthenticated = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Row(
      children: [
        InkWell(
          onTap: () {
            // context.pushNamed(Routes.loginView);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: UserCacheService().currentUser?.image != null
                ? CustomCachedImageWidget(
                    path: UserCacheService().currentUser!.image!,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(AppAssets.imagesLogo, width: 50.w, height: 50.h),
          ),
        ),
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isAuthenticated
                  ? UserCacheService().currentUser!.name!
                  : context.login,
              style: appTextStyles.font18BoldPrimaryColor.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
                isAuthenticated
                    ? UserCacheService().currentUser!.phone!
                    : context.loginToViewReports,
                style: appTextStyles.font12RegularSecondaryColor),
          ],
        ),
        const Spacer(),
        isAuthenticated
            ? InkWell(
                onTap: () => context.pushNamed(Routes.editProfileView),
                child: Icon(Icons.edit_rounded,
                    color: Theme.of(context).primaryColor))
            : const SizedBox(),
        16.horizontalSpace
      ],
    );
  }
}
