import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({
    super.key,
    required this.controller,
    required this.hint,
  });
  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Container(
      width: double.infinity,
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 14,
        ),
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        onTapOutside: (event) {
          // This closes keyboard when user taps outside
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: appTextStyles.font14RegularSecondaryColor,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }
}
