import 'package:elmohtaref/core/theme/app_colors.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppTextFormField extends StatefulWidget {
  final bool secure;

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final TextInputType? keyBoardType;
  final String? prefixIcon;
  final Widget? suffixWidget;
  final bool? suffixIcon;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final Color borderColor;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const AppTextFormField(
      {super.key,
      this.secure = false,
      required this.hintText,
      this.borderColor = const Color(0xffeaebec),
      this.validator,
      this.onChange,
      this.keyBoardType,
      this.prefixIcon,
      this.suffixIcon = false,
      this.controller,
      this.initialValue,
      this.focusNode,
      this.onEditingComplete,
      this.textInputAction,
      this.suffixWidget,
      this.maxLength,
      this.inputFormatters});

  @override
  // ignore: library_private_types_in_public_api
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool? _showPassword;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    return Focus(
      focusNode: _focusNode,
      child: TextFormField(
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        initialValue: widget.initialValue,
        controller: widget.controller,
        keyboardType: widget.keyBoardType,
        obscureText: _showPassword!,
        cursorColor: appColors.primaryColor,
        onChanged: widget.onChange,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w400),
        validator: widget.validator,
        onTapOutside: (c) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          errorMaxLines: 3,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
          hintText: widget.hintText,
          errorStyle: const TextStyle(height: 1.5),
          hintStyle: appTextStyles.font14RegularSecondaryColor,
          prefixIcon: widget.prefixIcon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.prefixIcon!,
                      height: 20.h,
                      width: 20.h,
                      colorFilter: ColorFilter.mode(
                        _isFocused
                            ? appColors.primaryColor
                            : appColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      width: 1,
                      height: 24.h,
                      color: _isFocused
                          ? appColors.primaryColor
                          : appColors.greyColor,
                    )
                  ],
                )
              : null,
          suffixIcon: widget.suffixIcon == true && widget.suffixWidget == null
              ? IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: _showPassword!
                      ? SvgPicture.asset(
                          "assets/icons/eye_slash.svg",
                          colorFilter: ColorFilter.mode(
                              appColors.primaryColor, BlendMode.srcIn),
                        )
                      : SvgPicture.asset(
                          AppAssets.iconsWhatsApp,
                          colorFilter: ColorFilter.mode(
                              appColors.primaryColor, BlendMode.srcIn),
                        ),
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword!),
                )
              : widget.suffixWidget,
          enabledBorder: inputBorder(widget.borderColor),
          focusedBorder: inputBorder(appColors.primaryColor),
          errorBorder: inputBorder(Colors.red[600]!),
          focusedErrorBorder: inputBorder(Colors.red[600]!),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    // widget.controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _showPassword = widget.secure;
  }

  InputBorder inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
}
