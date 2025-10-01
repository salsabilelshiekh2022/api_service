import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/image_header.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'filter_box.dart';
import 'search_field.dart';

class HeaderWithSearchAndFilter extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;
  const HeaderWithSearchAndFilter(
      {super.key,
      required this.title,
      this.onSearchChanged,
      required this.isFromReports});
  final String title;
  final bool isFromReports;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Stack(
      children: [
        ImageHeader(),
        Positioned(
          top: 70.h,
          left: 30.w,
          right: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: appTextStyles.font20RegularLabelColor
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchField(onChanged: onSearchChanged),
                  FilterBox(
                    isFromReports: isFromReports,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
