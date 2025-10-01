import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPTextField extends StatefulWidget {
  const OTPTextField({super.key, this.onChanged});

  final void Function(String)? onChanged;
  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        keyboardType: TextInputType.number,
        textStyle:
            appTextStyles.font18BoldPrimaryColor.copyWith(fontSize: 22.sp),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12.r),
          fieldHeight: 64.h,
          fieldWidth: 53.w,
          borderWidth: 0.2,
          activeFillColor: Colors.white,
          activeColor: Colors.white,
          inactiveFillColor: Colors.white,
          inactiveColor: Colors.white,
          selectedFillColor: Colors.white,
          selectedColor: Theme.of(context).primaryColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        animationType: AnimationType.fade,
        cursorColor: Theme.of(context).primaryColor,
        cursorWidth: 0.5,
        onChanged: widget.onChanged,
        beforeTextPaste: (text) {
          return RegExp(r'^[0-9]+$').hasMatch(text ?? '');
        },
      ),
    );
  }
}
