import 'package:elmohtaref/core/components/widgets/app_snack_bar.dart';
import 'package:elmohtaref/core/components/widgets/custom_modal_hub.dart';
import 'package:elmohtaref/core/components/widgets/main_button.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/routes.dart';
import '../../data/models/edit_profile_request_model.dart';
import 'widgets/otp_text_field.dart';
import 'widgets/welcome_widget.dart';

class OtpView extends StatefulWidget {
  const OtpView(
      {super.key,
      required this.phone,
      required this.isFromLogin,
      this.name,
      this.image});
  final String phone;
  final bool isFromLogin;
  final String? name;
  final String? image;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        _handleStateListener(state, context);
      },
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();
        return CustomModelProgressIndecator(
          inAsyncCall: state is VerifyOtpLoadingState,
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.login),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  WelcomeWidget(
                    text: context.activationCode,
                    decription: context.otpMessage,
                  ),
                  OTPTextField(
                    onChanged: (String value) {
                      setState(() {
                        code = value;
                      });
                    },
                  ),
                  48.verticalSpace,
                  MainButton(
                      title: context.login,
                      onTap: () {
                        if (code.length == 6) {
                          cubit.verifyOtp(
                            otp: code,
                            phone: widget.phone,
                          );
                        } else {
                          AppSnackBar.showSnackBar(
                              context: context,
                              message: context.enterThecodeOf6Numbers,
                              state: SnackBarStates.error);
                        }
                      })
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  void _handleStateListener(AuthState state, BuildContext context) {
    if (state is VerifyOtpSuccessState) {
      widget.isFromLogin
          ? AppSnackBar.showSnackBar(
              context: context,
              message: context.youLoginSuccessfully,
              state: SnackBarStates.success,
            )
          : context.read<AuthCubit>().updateProfile(
                  editProfileRequestModel: EditProfileRequestModel(
                name: widget.name ?? "",
                phoneNumber: widget.phone,
                image: widget.image,
              ));
      context.pushNamedAndRemoveUntil(Routes.mainNavigation,
          predicate: (route) => false);
    } else if (state is VerifyOtpErrorState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.failure.message,
        state: SnackBarStates.error,
      );
    }
  }
}
