import 'package:elmohtaref/core/components/widgets/app_snack_bar.dart';
import 'package:elmohtaref/core/components/widgets/app_text_field_with_header.dart';
import 'package:elmohtaref/core/components/widgets/main_button.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _controller;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          context.phone,
          style: appTextStyles.font14RegularPrimaryColor.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        8.verticalSpace,
        AppTextFormField(
          controller: _controller,
          hintText: context.enterPhoneNumber,
          keyBoardType: TextInputType.phone,
          maxLength: 9,
          suffixWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
            child: Text(
              "+966",
              style: appTextStyles.font14RegularSecondaryColor,
            ),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) => Validator.validatePhone(value, context),
        ),
        88.verticalSpace,
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SendOtpSuccessState) {
              AppSnackBar.showSnackBar(
                context: context,
                message: state.message,
                state: SnackBarStates.success,
              );
              context.pushNamed(
                Routes.otpView,
                arguments: {"phone": _controller.text, "isFromLogin": true},
              );
            } else if (state is SendOtpErrorState) {
              AppSnackBar.showSnackBar(
                  context: context,
                  message: state.failure.message,
                  state: SnackBarStates.error);
            }
          },
          builder: (context, state) {
            return MainButton(
                title: context.continueText,
                onTap: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().sendOtp(phone: _controller.text);
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });
                  }
                });
          },
        )
      ]),
    );
  }
}
