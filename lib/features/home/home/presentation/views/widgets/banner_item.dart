import 'package:elmohtaref/core/components/widgets/custom_cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/banner_model.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    required this.banner,
  });
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        try {
          launchUrl(Uri.parse(banner.action ?? ''));
        } catch (e) {}
      },
      child: SizedBox(
        width: double.infinity,
        height: 180.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: CustomCachedImageWidget(
            path: banner.image,
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
