import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/bottom_sheet_cubit.dart';

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.label,
    required this.index,
    required this.selectedpath,
    required this.unselectedpath,
  });

  final String label;
  final String selectedpath;
  final String unselectedpath;
  final int index;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              context.read<MainNavigationCubit>().changeIndex(index);
            },
            child: Column(
              spacing: 4.h,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 14.w,
                  ),
                  child: Image.asset(
                    isSelected(context) ? selectedpath : unselectedpath,
                    height: 20.h,
                    width: 20.w,
                  ),
                  // child: CustomSvgBuilder(
                  //   path: path,
                  //   color: isSelected(context)
                  //       ? appColors.primaryColor
                  //       : appColors.secondaryColor,
                  //   height: 20.h,
                  //   width: 20.w,
                  // ),
                ),
                Text(
                  label,
                  style: Theme.of(
                    context,
                  )
                      .extension<AppTextStyles>()!
                      .font12RegularPrimaryColor
                      .copyWith(
                        color: isSelected(context)
                            ? appColors.primaryColor
                            : appColors.secondaryColor,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isSelected(BuildContext context) {
    return context.read<MainNavigationCubit>().state.currentIndex == index;
  }
}
