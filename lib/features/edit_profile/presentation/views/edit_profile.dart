import 'dart:io';

import 'package:elmohtaref/core/components/widgets/custom_app_bar.dart';
import 'package:elmohtaref/core/components/widgets/custom_modal_hub.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/utils/user_cache_service.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_text_style.dart';
import 'widgets/edit_profile_form.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _handleEditCubitListener,
      builder: (context, state) {
        return CustomModelProgressIndecator(
          inAsyncCall: state is EditProfileLoadingState ||
              state is SendOtpLoadingState ||
              state is CheckPhoneLoadingState,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 253,
                        child: CustomAppBar(
                          title: context.editProfile,
                          isBack: true,
                          height: 185,
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: MediaQuery.of(context).size.width / 2 - 65,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey.shade300,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: (UserCacheService()
                                                .currentUser !=
                                            null &&
                                        UserCacheService().currentUser!.image !=
                                            null &&
                                        UserCacheService()
                                            .currentUser!
                                            .image!
                                            .isNotEmpty)
                                    ? NetworkImage(
                                        UserCacheService().currentUser!.image!,
                                      )
                                    : _selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : AssetImage(AppAssets.imagesLogo)
                                            as ImageProvider,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () =>
                                    _showImagePickerBottomSheet(context),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  EditProfileForm(selectedImage: _selectedImage),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    final AppTextStyles appTextStyles =
        Theme.of(context).extension<AppTextStyles>()!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            20.verticalSpace,
            Text(
              context.choosePhotos,
              style: appTextStyles.font14BoldPrimaryColor,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  context,
                  icon: Icons.camera_alt,
                  label: context.camera,
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _buildImageSourceOption(
                  context,
                  icon: Icons.photo_library,
                  label: context.gallary,
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            8.verticalSpace,
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // Close bottom sheet

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      AppSnackBar.showSnackBar(
        context: context,
        message: 'Error selecting image: $e',
        state: SnackBarStates.error,
      );
    }
  }

  void _handleEditCubitListener(BuildContext context, state) {
    if (state is EditProfileSuccessState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.userModel.meta!.message!,
        state: SnackBarStates.success,
      );
      context.pushNamedAndRemoveUntil(Routes.mainNavigation,
          predicate: (_) => false);
    } else if (state is EditProfileErrorState) {
      AppSnackBar.showSnackBar(
        context: context,
        message: state.failure.message,
        state: SnackBarStates.error,
      );
    }
  }
}
