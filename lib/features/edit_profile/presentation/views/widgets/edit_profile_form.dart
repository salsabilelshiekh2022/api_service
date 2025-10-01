import 'dart:io';

import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/app_text_field_with_header.dart';
import '../../../../../core/components/widgets/main_button.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/user_cache_service.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../auth/data/models/edit_profile_request_model.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';

class EditProfileForm extends StatefulWidget {
  final File? selectedImage;

  const EditProfileForm({super.key, this.selectedImage});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _phonecontroller;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: UserCacheService().currentUser?.name ?? "",
    );
    _phonecontroller = TextEditingController(
      text: UserCacheService().currentUser?.phone ?? "",
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    final cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _handleStateListener(state, context);
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.fullName,
                style: appTextStyles.font14RegularPrimaryColor.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              AppTextFormField(
                controller: _nameController,
                hintText: context.enterYourName,
                keyBoardType: TextInputType.name,
                validator: (value) => Validator.validateName(value, context),
              ),
              16.verticalSpace,
              Text(
                context.phone,
                style: appTextStyles.font14RegularPrimaryColor.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              AppTextFormField(
                controller: _phonecontroller,
                hintText: context.enterPhoneNumber,
                keyBoardType: TextInputType.phone,
                suffixWidget: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                  child: Text(
                    "+966",
                    style: appTextStyles.font14RegularSecondaryColor,
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => Validator.validatePhone(value, context),
              ),
              SizedBox(
                height: context.height * 0.15,
              ),
              MainButton(
                  title: context.saveData,
                  onTap: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      bool phoneChanged = _phonecontroller.text.trim() !=
                          UserCacheService().currentUser?.phone;

                      if (phoneChanged) {
                        cubit.checkPhone(phone: _phonecontroller.text.trim());
                      } else {
                        cubit.updateProfile(
                          editProfileRequestModel: EditProfileRequestModel(
                            name: _nameController.text.trim(),
                            phoneNumber: _phonecontroller.text.trim(),
                            image: widget.selectedImage?.path,
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateListener(AuthState state, BuildContext context) {
    if (state is SendOtpSuccessState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.message,
        state: SnackBarStates.success,
      );
      context.pushReplacementNamed(
        Routes.otpView,
        arguments: {
          "phone": _phonecontroller.text.trim(),
          "isFromLogin": false,
          "name": _nameController.text.trim(),
          "image": widget.selectedImage?.path,
        },
      );
    } else if (state is CheckPhoneErrorState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.failure.message,
        state: SnackBarStates.error,
      );
    } else if (state is SendOtpErrorState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.failure.message,
        state: SnackBarStates.error,
      );
    }
  }
}
