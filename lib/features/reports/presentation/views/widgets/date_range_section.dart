import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/components/widgets/app_snack_bar.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/reports_cubit.dart';
import 'date_picker_field.dart';

class DateRangeSection extends StatefulWidget {
  const DateRangeSection({
    super.key,
    required this.isFromReports,
  });
  final bool isFromReports;

  @override
  State<DateRangeSection> createState() => _DateRangeSectionState();
}

class _DateRangeSectionState extends State<DateRangeSection> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                title: context.startDate,
                selectedDate: startDate,
                onDateSelected: (DateTime date) {
                  setState(() {
                    startDate = date;
                    widget.isFromReports
                        ? context.read<ReportsCubit>().state.fromDate =
                            DateFormat('yyyy-MM-dd').format(startDate!)
                        : context.read<VisitsCubit>().state.fromDate =
                            DateFormat('yyyy-MM-dd').format(startDate!);
                  });
                },
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: DatePickerField(
                title: context.endDate,
                selectedDate: endDate,
                onDateSelected: (DateTime date) {
                  setState(() {
                    endDate = date;
                    AppLogs.debugLog('Selected end date: $date');
                    if (startDate != null && date.isBefore(startDate!)) {
                      AppSnackBar.showSnackBar(
                          context: context,
                          message: context.endDateShouldBeAfterStartDate,
                          state: SnackBarStates.error);

                      return;
                    } else {
                      widget.isFromReports
                          ? context.read<ReportsCubit>().state.toDate =
                              DateFormat('yyyy-MM-dd').format(endDate!)
                          : context.read<VisitsCubit>().state.toDate =
                              DateFormat('yyyy-MM-dd').format(endDate!);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
