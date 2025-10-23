import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const SearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return SizedBox(
      height: 42.h,
      width: MediaQuery.of(context).size.width * 0.65,
      child: TextFormField(
        cursorColor: appColors.primaryColor,
        style: appTextStyles.font16RegularPrimaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: appColors.secondaryColor,
          ),
          hintText: context.searchWithCarName,
          hintStyle: appTextStyles.font16RegularSecondaryColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
