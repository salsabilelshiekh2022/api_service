import 'package:elmohtaref/core/components/widgets/app_text_field_with_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text_style.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  const CustomTextFieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.focusNode,
    this.isObscured,
    this.keyboardType,
    this.validator,
    this.controller,
    this.inputFormatters,
  });

  final String label;
  final String hintText;

  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? isObscured;
  final TextInputType? keyboardType;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: appTextStyles.font14RegularPrimaryColor,
        ),
        12.0.verticalSpace,
        AppTextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          focusNode: focusNode,
          keyBoardType: keyboardType,
          hintText: hintText,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
        ),
      ],
    );
  }
}
