import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/book_service/presentaion/views/widgets/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/app_text_field_with_header.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    var cubit = context.read<BookServiceCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(
            title: context.fullName,
            imagePath: AppAssets.iconsProfile,
          ),
          8.verticalSpace,
          AppTextFormField(
            controller: cubit.nameController,
            hintText: context.enterFullName,
            keyBoardType: TextInputType.name,
            validator: (value) {
              return Validator.validateName(value, context);
            },
          ),
          16.verticalSpace,
          FormTitle(title: context.phone, imagePath: AppAssets.iconsProfile),
          8.verticalSpace,
          AppTextFormField(
            controller: cubit.phoneController,
            hintText: "5513599766",
            keyBoardType: TextInputType.phone,
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
        ],
      ),
    );
  }
}
