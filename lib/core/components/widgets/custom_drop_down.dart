import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String title;
  final String? hint;
  final Future<void>? callFun;
  final BlocBase? bloc;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    this.items,
    required this.title,
    this.hint,
    this.callFun,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    final appColors = Theme.of(context).extension<AppColors>()!;
    return InkWell(
      onTap: () {
        callFun ?? () {};
        customBottomSheet(context, appTextStyles);
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 44),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? hint ?? '',
              style: appTextStyles.font14RegularPrimaryColor.copyWith(
                color: selectedValue == null
                    ? appColors.secondaryColor
                    : appColors.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),

        // child: DropdownButtonHideUnderline(
        //   child: DropdownButton<String>(
        //     value: selectedValue,
        //     alignment: AlignmentDirectional.centerEnd,
        //     icon: Icon(
        //       Icons.keyboard_arrow_down,
        //       color: Colors.grey,
        //       size: 20,
        //     ),
        //     items: items,
        //     isExpanded: true,
        //     borderRadius: BorderRadius.circular(20),
        //     dropdownColor: Colors.white,
        //     menuMaxHeight: 300.h,
        //     menuWidth: 200.w,
        //     onChanged: onChanged,
        //     style: TextStyle(
        //       fontSize: 14,
        //       color: Colors.black87,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Future<dynamic> customBottomSheet(
      BuildContext context, AppTextStyles appTextStyles) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.r))),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: 1.sw,
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    22.verticalSpace,
                    Text(
                      title,
                      style: appTextStyles.font18BoldPrimaryColor.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                      ),
                    ),
                    10.verticalSpace,
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => 0.verticalSpace,
                        shrinkWrap: true,
                        itemCount: items!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              onChanged(items?[index].value);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: items?[index].value == selectedValue
                                      ? Colors.grey.shade200
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "•",
                                        style: appTextStyles
                                            .font14RegularPrimaryColor
                                            .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      8.horizontalSpace,
                                      Text(
                                        items?[index].value ?? '',
                                        style: appTextStyles
                                            .font14RegularPrimaryColor
                                            .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
