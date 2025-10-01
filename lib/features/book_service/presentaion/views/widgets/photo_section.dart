import 'dart:io';

import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../service_details/presentation/views/widget/clickable_photo_grid.dart';
import '../../cubit/book_service_cubit.dart';

class PhotoSection extends StatefulWidget {
  const PhotoSection({super.key});

  @override
  State<PhotoSection> createState() => _PhotoSectionState();
}

class _PhotoSectionState extends State<PhotoSection> {
  final ImagePicker _picker = ImagePicker();

  BookServiceCubit get cubit => context.read<BookServiceCubit>();

  Future<void> _showImageSourceBottomSheet() async {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom sheet handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Text(
                context.choosePhotos, // Add this to your translations
                style: appTextStyles.font14RegularPrimaryColor,
              ),
              20.verticalSpace,

              // Camera option
              ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                  color: appColors.primaryColor,
                  size: 24.sp,
                ),
                title: Text(
                  context.camera,
                  style: appTextStyles.font14RegularPrimaryColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),

              // Gallery option
              ListTile(
                leading: Icon(
                  Icons.photo_library_rounded,
                  color: appColors.primaryColor,
                  size: 24.sp,
                ),
                title: Text(
                  context.gallary,
                  style: appTextStyles.font14RegularPrimaryColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),

              20.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        cubit.addImage(File(image.path));
        setState(() {}); // Force rebuild to show new image
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image from camera');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (images.isNotEmpty) {
        final List<File> newImages =
            images.map((image) => File(image.path)).toList();
        cubit.updateSelectedImages([...cubit.selectedImages, ...newImages]);
        setState(() {}); // Force rebuild to show new images
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick images from gallery');
    }
  }

  void _removeImage(int index) {
    cubit.removeImage(index);
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return BlocBuilder<BookServiceCubit, BookServiceState>(
      buildWhen: (previous, current) =>
          previous.status != current.status, // Only rebuild on status changes
      builder: (context, state) {
        final selectedImages = cubit.selectedImages;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo selection button
            GestureDetector(
              onTap: _showImageSourceBottomSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.iconsPaperclip,
                        width: 20, height: 20),
                    8.horizontalSpace,
                    Text(
                      context.attachPhotos,
                      style: appTextStyles.font12RegularSecondaryColor.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.photo_rounded,
                      color: appColors.primaryColor,
                    ),
                    if (selectedImages.isNotEmpty) ...[
                      8.horizontalSpace,
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 8, vertical: 4),
                      //   decoration: BoxDecoration(
                      //     color: appColors.primaryColor,
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Text(
                      //     '${selectedImages.length}',
                      //     style: appTextStyles.font12RegularSecondaryColor
                      //         .copyWith(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ],
                ),
              ),
            ),

            // Display selected images
            if (selectedImages.isNotEmpty) ...[
              16.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedImages.asMap().entries.map((entry) {
                      int index = entry.key;
                      File image = entry.value;

                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoViewerScreen(
                                    isFromNetwork: false,
                                    initialIndex: index,
                                    photos: selectedImages
                                        .map((File image) => image.path)
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 165.w,
                              height: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                _removeImage(index);
                                // Force rebuild after image removal
                                setState(() {});
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
