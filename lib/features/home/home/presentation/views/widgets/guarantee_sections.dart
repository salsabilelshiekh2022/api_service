import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../generated/app_assets.dart';
import '../../cubit/home_cubit.dart';

class GuaranteeSections extends StatelessWidget {
  const GuaranteeSections({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.isSocialMediaLoading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Image.asset(AppAssets.iconsGuarantee,
                        width: 30, height: 30, fit: BoxFit.cover),
                    16.horizontalSpace,
                    Expanded(
                      child: Text(
                        context.serviceGuarantee,
                        style: appTextStyles.font14RegularPrimaryColor.copyWith(
                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        openWhatsapp(
                            state.isSocialMediaLoading
                                ? ''
                                : state.socialMedia?.data.whatsapp ?? '',
                            context);
                      },
                      child: Image.asset(
                        AppAssets.iconsWhatsApp,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      context.contact,
                      style: appTextStyles.font10SemiBoldGreenColor,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void openWhatsapp(String whatsapp, BuildContext context) async {
    String url =
        "https://wa.me/$whatsapp/?text=${Uri.encodeFull("Hello World !! Hey There")}";
    final Uri whatsappURlAndroid = Uri.parse(url);

    if (await canLaunchUrl(whatsappURlAndroid)) {
      await launchUrl(whatsappURlAndroid, mode: LaunchMode.externalApplication);
    } else {
      AppLogs.errorLog("Can't open whatsapp");
    }
  }
}
