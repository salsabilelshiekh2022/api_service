import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../cubit/tech_support_cubit.dart';

class AddProblemButton extends StatelessWidget {
  const AddProblemButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    final appColors = Theme.of(context).extension<AppColors>()!;
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.addTicketView,
          arguments: {"cubit": context.read<TechSupportCubit>()},
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: appColors.primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: appColors.primaryColor),
            12.horizontalSpace,
            Text(
              context.addNewComplaint,
              style: appTextTheme.font16BoldPrimaryColor.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
