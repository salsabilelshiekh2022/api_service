import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/app_logs.dart';
import '../../../../../generated/app_assets.dart';

class SocialMediaContent extends StatefulWidget {
  const SocialMediaContent({super.key});

  @override
  State<SocialMediaContent> createState() => _SocialMediaContentState();
}

class _SocialMediaContentState extends State<SocialMediaContent> {
  @override
  void initState() {
    context.read<HomeCubit>().getSocialMedia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Column(
      children: [
        Text(
          context.followUsInSocialMedia,
          style: appTextStyles.font16RegularPrimaryColor.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
        12.verticalSpace,
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            bool isLoading = state.isSocialMediaLoading;
            return Skeletonizer(
              enabled: state.isSocialMediaLoading,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialImage(AppAssets.iconsFacebook,
                      isLoading ? '' : state.socialMedia?.data.facebook ?? ''),
                  _buildSocialImage(AppAssets.iconsInstagram,
                      isLoading ? '' : state.socialMedia?.data.instagram ?? ''),
                  _buildSocialImage(AppAssets.iconsTiktok,
                      isLoading ? '' : state.socialMedia?.data.tiktok ?? ''),
                  _buildSocialImage(AppAssets.iconsSocailWhatsApp,
                      isLoading ? '' : state.socialMedia?.data.whatsapp ?? '',
                      isWhatsApp: true),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildSocialImage(String path, url, {bool isWhatsApp = false}) {
    return InkWell(
      onTap: () async {
        isWhatsApp
            ? openWhatsapp(url, context)
            : (!await launchUrl(Uri.parse(url)));
      },
      child: Image.asset(
        path,
        width: 45.w,
        height: 45.h,
        fit: BoxFit.cover,
      ),
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
