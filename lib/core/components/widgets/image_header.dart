import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/app_assets.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Image.asset(
          AppAssets.imagesHead,
          width: double.infinity,
          height: 185.h,
          fit: BoxFit.fill,
        ));
  }
}
