import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/theme/app_colors.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'service_grid_view.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Container(
      color: appColors.labelColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.services,
              style: appTextStyles.font18BoldPrimaryColor,
            ),
            16.verticalSpace,
            ServicesGridView(),
          ],
        ),
      ),
    );
  }
}
