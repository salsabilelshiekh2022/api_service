import 'package:elmohtaref/core/theme/app_colors.dart';
import 'package:elmohtaref/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../home/home/presentation/cubit/home_cubit.dart';
import '../../../data/models/setting_model.dart';

class SettingItemWidget extends StatefulWidget {
  const SettingItemWidget({super.key, required this.settingModel});
  final SettingModel settingModel;

  @override
  State<SettingItemWidget> createState() => _SettingItemWidgetState();
}

class _SettingItemWidgetState extends State<SettingItemWidget> {
  @override
  void initState() {
    context.read<HomeCubit>().getWorkingTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyle = Theme.of(context).extension<AppTextStyles>()!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isLoading =
            state.isWorkingTimesLoading && widget.settingModel.isWorkingTimes;
        return InkWell(
          onTap: widget.settingModel.onTap,
          child: Row(
            children: [
              Image.asset(widget.settingModel.imagePath,
                  width: 30, height: 30, fit: BoxFit.cover),
              16.horizontalSpace,
              Text(
                widget.settingModel.title,
                style: appTextStyle.font14RegularPrimaryColor,
              ),
              Spacer(),
              widget.settingModel.isWorkingTimes
                  ? Skeletonizer(
                      enabled: isLoading,
                      child: Text(
                          isLoading
                              ? "  00:00 - 00:00  "
                              : state.workingTimes ?? "",
                          style: appTextStyle.font14RegularSecondaryColor),
                    )
                  : const SizedBox(),
              widget.settingModel.isWorkingTimes
                  ? const SizedBox()
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: appColors.secondaryColor,
                      size: 18.sp,
                    ),
            ],
          ),
        );
      },
    );
  }
}
