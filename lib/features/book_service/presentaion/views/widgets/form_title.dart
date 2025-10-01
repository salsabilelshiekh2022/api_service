import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_style.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
    required this.title,
    required this.imagePath,
    this.isRequired = true,
  });
  final String title;
  final String imagePath;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 16.w,
          height: 16.h,
          fit: BoxFit.contain,
        ),
        2.horizontalSpace,
        Text(title, style: appTextStyles.font14RegularPrimaryColor),
        2.horizontalSpace,
        isRequired
            ? Text(
                "*",
                style: appTextStyles.font14RegularPrimaryColor.copyWith(
                  color: Colors.red,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
