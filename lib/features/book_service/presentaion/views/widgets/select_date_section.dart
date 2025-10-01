import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../reports/presentation/views/widgets/date_picker_field.dart';
import '../../cubit/book_service_cubit.dart';
import 'time_picker_field.dart';

class SelectDateSection extends StatefulWidget {
  const SelectDateSection({super.key});

  @override
  State<SelectDateSection> createState() => _SelectDateSectionState();
}

class _SelectDateSectionState extends State<SelectDateSection> {
  DateTime maintenanceDate = DateTime.now();
  String? maintenanceTimeText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DatePickerField(
                title: context.maintenanceDate,
                selectedDate: maintenanceDate,
                onDateSelected: (DateTime date) {
                  setState(() {
                    maintenanceDate = date;
                    maintenanceTimeText = null;
                    context.read<BookServiceCubit>().getTimeAvalibilty(
                        serviceId: context.read<BookServiceCubit>().serviceId,
                        day: DateFormat('yyyy-MM-dd').format(maintenanceDate));
                  });
                }),
          ),
          20.horizontalSpace,
          Expanded(
            child: TimePickerField(
                title: context.maintenanceTime,
                selectedTime: maintenanceTimeText,
                onTimeSelected: (String time) {
                  setState(() {
                    maintenanceTimeText = time;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
