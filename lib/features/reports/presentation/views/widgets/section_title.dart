import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_style.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;

    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: appTextStyles.font14RegularPrimaryColor.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
