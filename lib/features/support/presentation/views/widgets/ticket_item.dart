import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../data/models/tickets_model.dart';
import '../../cubit/tech_support_cubit.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    final appColors = Theme.of(context).extension<AppColors>()!;
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.reportProblemView,
          arguments: {
            'id': ticket.id,
            'cubit': context.read<TechSupportCubit>()
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ticket.subject!,
                  style: appTextTheme.font14BoldPrimaryColor.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: ticket.status! == "open"
                        ? Colors.green.withValues(alpha: 0.04)
                        : appColors.redColor.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    ticket.status! == "open" ? context.open : context.close,
                    style: appTextTheme.font14RegularPrimaryColor.copyWith(
                      color: ticket.status! == "open"
                          ? Colors.green
                          : appColors.redColor,
                    ),
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            Text(
              DateFormat.yMMMd("ar").format(DateTime.parse(ticket.createdAt!)),
              style: appTextTheme.font14RegularSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
