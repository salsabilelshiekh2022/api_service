import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class CustomMultiLinesTextFieldWidget extends StatelessWidget {
  const CustomMultiLinesTextFieldWidget(
      {super.key,
      required this.hint,
      this.validator,
      this.maxLines,
      this.controller,
      this.minLines = 1});

  final String hint;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: appTextStyles.font14RegularSecondaryColor,
        border: _buildBorder(appColors),
        focusedBorder: _focusedBorder(appColors),
        errorBorder: _errorBorder(appColors),
      ),
      validator: validator,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  OutlineInputBorder _buildBorder(AppColors appColors) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0.r),
      borderSide: BorderSide(
        color: appColors.labelColor.withValues(
          alpha: 0.5,
        ),
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder _focusedBorder(AppColors appColors) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.0.r),
        borderSide: BorderSide(
          color: appColors.primaryColor,
          width: 1.5,
        ),
      );

  OutlineInputBorder _errorBorder(AppColors appColors) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.0.r),
        borderSide: BorderSide(
          color: appColors.redColor,
          width: 1.5,
        ),
      );
}
